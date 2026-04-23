"""DTFEA 5-pillar stress-test (plan §15).

One tool per pillar (Dana/Trevor/Fiona/Evan/Aria). Each returns a list of
findings; the composite `run_dtfea` aggregates into `DTFEAResult` and applies
the two gates:

- Gate 1: minimum 60% maturity per pillar for approval.
- Gate 2: no unmitigated critical finding with confidence >= 9.
"""
from __future__ import annotations

from collections.abc import Callable

from workflow.schemas import DTFEAFinding, DTFEAResult, Submission


def _finding(pillar, severity, confidence, summary) -> DTFEAFinding:
    return DTFEAFinding(
        pillar=pillar,
        severity=severity,
        confidence=confidence,
        summary=summary,
    )


def _hay(submission: Submission) -> str:
    return " ".join(
        (s.text or "").lower()
        for d in submission.documents
        for s in d.sections
    )


def _ml_load_bearing(submission: Submission) -> bool:
    """DTFEA's D/T/F pillars are about AI/ML assurance. They only apply when
    AI/ML is load-bearing in the operation. A PDRA-01 teleoperated VLOS
    single-vehicle flight has no AI surface and should not be penalised on
    dataset sheets, model cards, or OOD monitoring — only the Authority
    (Aria) and Evidence (Evan) pillars apply.
    """
    c = submission.classification
    if c is None:
        return False
    return c.autonomy_posture in {"supervised_autonomy", "full_autonomy", "swarm"}


def dana_data_check(submission: Submission) -> list[DTFEAFinding]:
    """D — Data: provenance, bias, drift, sensor coverage.

    Gated on AI/ML being load-bearing; a teleoperated VLOS flight does not
    engage this pillar.
    """
    if not _ml_load_bearing(submission):
        return []
    findings: list[DTFEAFinding] = []
    hay = _hay(submission)
    if "training dataset" not in hay and "dataset sheet" not in hay:
        findings.append(_finding("D", "critical", 9, "No training dataset sheet or provenance documented."))
    if "class imbalance" not in hay and "distributional shift" not in hay:
        findings.append(_finding("D", "major", 7, "Class imbalance / distributional shift not addressed."))
    if "sensor coverage" not in hay:
        findings.append(_finding("D", "minor", 5, "Sensor coverage boundaries not mapped to operational envelope."))
    return findings


def trevor_trust_check(submission: Submission) -> list[DTFEAFinding]:
    """T — Trust: model cards, uncertainty bounds, MHC triggers. Gated on AI/ML."""
    if not _ml_load_bearing(submission):
        return []
    findings: list[DTFEAFinding] = []
    hay = _hay(submission)
    if "model card" not in hay:
        findings.append(_finding("T", "critical", 9, "No model cards produced for load-bearing AI components."))
    if "uncertainty" not in hay:
        findings.append(_finding("T", "major", 7, "Uncertainty bounds not stated for AI outputs."))
    if "meaningful human control" not in hay and "mhc" not in hay:
        findings.append(_finding("T", "critical", 10, "Meaningful Human Control triggers and thresholds not defined."))
    return findings


def fiona_failure_check(submission: Submission) -> list[DTFEAFinding]:
    """F — Failure: redundancy, independent containment, OOD detection, forensic audit.

    Redundancy applies to all operations; OOD and canary are AI-specific.
    """
    findings: list[DTFEAFinding] = []
    hay = _hay(submission)
    # Redundancy: for ML-load-bearing operations, look for explicit redundancy
    # design. For non-ML operations, CAP 722A emergency-procedures evidence
    # (loss of link, loss of power, rogue RPA, RTH, emergency response) is
    # the operating-level equivalent.
    redundancy_signals = [
        "redundant", "redundancy",
        "emergency procedures", "emergency response",
        "loss of link", "loss of power", "rogue rpa",
        "return to home", "rth", "fail-safe", "failsafe",
    ]
    has_redundancy_signal = any(sig in hay for sig in redundancy_signals)
    if not has_redundancy_signal:
        findings.append(_finding("F", "critical", 10, "No redundancy or emergency-procedures evidence for safety-critical failure modes."))
    if _ml_load_bearing(submission):
        if "out-of-distribution" not in hay and "ood" not in hay:
            findings.append(_finding("F", "major", 8, "Out-of-distribution detection runtime not evidenced."))
        if "canary" not in hay and "sandbox" not in hay:
            findings.append(_finding("F", "minor", 5, "No canary/sandbox rollout path for AI updates."))
    return findings


def evan_evidence_check(submission: Submission) -> list[DTFEAFinding]:
    """E — Evidence: acceptance criteria, test plans, re-evidencing.

    ML-specific checks (re-evidencing, go/no-go on models) gated on autonomy.
    """
    findings: list[DTFEAFinding] = []
    hay = _hay(submission)
    if "acceptance criteria" not in hay and _ml_load_bearing(submission):
        findings.append(_finding("E", "critical", 9, "Acceptance criteria not tabulated per AI artefact."))
    if "test plan" not in hay and _ml_load_bearing(submission):
        findings.append(_finding("E", "major", 8, "Structured test plan not provided for AI components."))
    if _ml_load_bearing(submission):
        if "re-evidencing" not in hay and "re-assurance" not in hay:
            findings.append(_finding("E", "major", 7, "Re-evidencing cycle not defined for model updates."))
        if "go/no-go" not in hay and "go no go" not in hay:
            findings.append(_finding("E", "minor", 5, "Go/no-go thresholds not declared."))
    return findings


def aria_authority_check(submission: Submission) -> list[DTFEAFinding]:
    """A — Authority: named accountability, apportionment."""
    findings: list[DTFEAFinding] = []
    c = submission.classification
    if c is None or not c.accountable_manager:
        findings.append(_finding("A", "critical", 10, "No named Accountable Manager for the operation."))
    # Duty Holder / RAISO only required where AI/ML is load-bearing.
    if _ml_load_bearing(submission):
        if c is None or not c.duty_holder:
            findings.append(_finding("A", "critical", 9, "No named Duty Holder (DDH/ODH)."))
        if c is None or not c.raiso:
            findings.append(_finding("A", "major", 8, "No RAISO sign-off where AI is load-bearing."))
    hay = _hay(submission)
    if "apportionment" not in hay and submission.regulator == "JOINT":
        findings.append(_finding("A", "critical", 10, "CAA/MAA apportionment not signed for civil/military operation."))
    return findings


ALL_PILLAR_TOOLS: dict[str, Callable[[Submission], list[DTFEAFinding]]] = {
    "D": dana_data_check,
    "T": trevor_trust_check,
    "F": fiona_failure_check,
    "E": evan_evidence_check,
    "A": aria_authority_check,
}


# Expected-question counts per pillar. Maturity = (expected - #findings-weighted) / expected.
_EXPECTED_CHECKS = {"D": 5, "T": 5, "F": 5, "E": 5, "A": 5}
_SEVERITY_WEIGHT = {"critical": 1.0, "major": 0.6, "minor": 0.3}


def _pillar_maturity(findings: list[DTFEAFinding], pillar: str) -> int:
    expected = _EXPECTED_CHECKS[pillar]
    weighted = sum(_SEVERITY_WEIGHT[f.severity] for f in findings if f.pillar == pillar)
    score = max(0.0, 1.0 - (weighted / expected))
    return int(round(score * 100))


def run_dtfea(submission: Submission) -> DTFEAResult:
    findings: list[DTFEAFinding] = []
    for tool in ALL_PILLAR_TOOLS.values():
        findings.extend(tool(submission))

    maturity = {p: _pillar_maturity(findings, p) for p in "DTFEA"}
    gate1 = all(v >= 60 for v in maturity.values())
    gate2 = not any(f.severity == "critical" and f.confidence >= 9 for f in findings)

    return DTFEAResult(
        maturity=maturity,
        findings=findings,
        gate1_pass=gate1,
        gate2_pass=gate2,
    )
