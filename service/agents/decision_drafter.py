"""Component 7 — Decision Drafter (Applicant mode).

In the hackathon cut this emits the **Operator Feedback Report** (§21.2),
not the full Regulator-mode Decision Record. Tone is coaching; findings are
paraphrased as revise-next hints; every pointer resolves to a submitted
artefact (binder invariant, enforced by the downstream Binder executor).
"""
from __future__ import annotations

from datetime import datetime, timezone

try:
    from agent_framework import Executor, WorkflowContext, handler  # type: ignore
except ImportError:  # pragma: no cover
    Executor = object  # type: ignore[assignment,misc]
    WorkflowContext = None  # type: ignore[assignment]

    def handler(fn):  # type: ignore[no-redef]
        return fn

from workflow.schemas import (
    ACID,
    DTFEAPillar,
    FeedbackItem,
    FeedbackReport,
    KeystoneID,
    ReadinessGauges,
    Submission,
    Verdict,
)


INSTRUCTIONS = """\
You are the Decision Drafter running in Applicant mode.

Your output is the Operator Feedback Report (§21.2). It is private, non-
punitive, and invisible to the regulator. Structure:

  1. Readiness gauges — one verdict per AC (AC1–AC8), one maturity per
     DTFEA pillar (D/T/F/E/A), one per REQ (REQ001–REQ020), one per
     keystone (K1–K8 — fired yes/no).
  2. Top issues — highest-severity gaps, paraphrased in coaching tone:
       "OSO 10 partially met — loss-of-link behaviour depends on swarm
        consensus"
       "DAA tested envelope does not cover proposed operational geometry"
     Each top issue points to the artefact(s) the operator should revise.
  3. Suggested evidence — for every red/amber item, the artefact CLASS that
     would clear it. Never fabricate content. Only a pointer to what's
     missing.
  4. Duty Holder checklist — the acknowledgements the operator must capture
     before the Submission Readiness Check will pass.

Every quantitative claim must carry an EvidencePointer or the Binder will
refuse emission.
"""


def _ac_verdicts(submission: Submission) -> dict[ACID, Verdict]:
    """Map the coverage / gap / SORA state to the AC1–AC8 axis.

    Rules from plan §6.1 walkthrough:
      - PDRA-01 scenarios: AC3–AC5, AC7 are N/A.
      - Swarm-BVLOS-autonomy scenarios: every AC is in play.
    """
    c = submission.classification
    pdra = bool(c and c.declared_scenario and c.declared_scenario.upper().startswith("UKPDRA"))
    coverage = submission.coverage
    artefacts = {a.artefact: a.verdict for a in coverage.artefacts} if coverage else {}

    def ac_from_artefacts(required: list[str]) -> Verdict:
        if not required:
            return "na"
        verdicts = [artefacts.get(r, "red") for r in required]
        if "red" in verdicts:
            return "red"
        if "amber" in verdicts:
            return "amber"
        if all(v == "green" for v in verdicts):
            return "green"
        return "amber"

    ac1 = ac_from_artefacts(["operating_safety_case", "conops"])
    ac2 = "na" if pdra else ("red" if submission.sora and not submission.sora.sail_coherent else ac_from_artefacts(["sora_package"]))
    ac3 = "na" if pdra else ac_from_artefacts(["daa_report"])
    ac4 = "na" if pdra else ac_from_artefacts(["c2_link_analysis"])
    ac5 = "na" if pdra else ac_from_artefacts(["swarm_behaviour_envelope"])
    ac6 = ac_from_artefacts(["cap1616_airspace_change"])
    ac7 = "na" if pdra else ac_from_artefacts(["amlas_case", "sace_case"])

    approval_blocked = submission.gaps.approval_blocked if submission.gaps else False
    ac8: Verdict = "red" if approval_blocked else "green"

    return {  # type: ignore[return-value]
        "AC1": ac1, "AC2": ac2, "AC3": ac3, "AC4": ac4,
        "AC5": ac5, "AC6": ac6, "AC7": ac7, "AC8": ac8,
    }


def _readiness(submission: Submission) -> ReadinessGauges:
    gaps = submission.gaps
    dtfea_maturity: dict[DTFEAPillar, int] = (
        gaps.dtfea.maturity if gaps else {"D": 0, "T": 0, "F": 0, "E": 0, "A": 0}
    )
    keystones: dict[KeystoneID, bool] = (
        {k.keystone_id: k.fired for k in gaps.keystones} if gaps
        else {f"K{i}": False for i in range(1, 9)}  # type: ignore[misc]
    )
    reqs: dict[str, Verdict] = {r.req_id: r.verdict for r in submission.reqs}

    return ReadinessGauges(
        ac=_ac_verdicts(submission),
        dtfea=dtfea_maturity,
        reqs=reqs,
        keystones=keystones,
    )


def _paraphrase_keystone(k) -> str:
    hint_by_id = {
        "K1": "Geofence independence not demonstrated — panel will challenge single-point-failure risk.",
        "K2": "DAA calibration + provenance missing — panel will challenge sensor envelope coverage.",
        "K3": "Swarm emergent-behaviour bounds not evidenced — panel will challenge sim + flight coverage.",
        "K4": "ML forensic logging not evidenced — post-incident reconstruction not possible.",
        "K5": "Meaningful Human Control is narrative-only — panel will ask for quantified override latency.",
        "K6": "Flight termination independence not evidenced — panel will refuse without redundant kill.",
        "K7": "CAA/MAA apportionment not signed — operation crosses civil/military boundary.",
        "K8": "Classification custodian not named — classified-adjacent evidence handling unclear.",
    }
    return hint_by_id.get(k.keystone_id, k.rationale)


def _top_issues(submission: Submission) -> list[FeedbackItem]:
    items: list[FeedbackItem] = []
    if submission.sora and not submission.sora.sail_coherent:
        items.append(FeedbackItem(
            title="SAIL asymmetry",
            tone="challenge",
            paraphrase=submission.sora.narrative or "SAIL declaration incoherent with operation.",
            suggested_evidence="Re-derive SAIL per JARUS v2.5 with complexity factors, then re-pack OSO coverage to the new robustness floor.",
        ))
    if submission.gaps:
        for k in submission.gaps.keystones:
            if k.fired and k.confidence >= 9:
                items.append(FeedbackItem(
                    title=f"{k.keystone_id} fired",
                    tone="challenge",
                    paraphrase=_paraphrase_keystone(k),
                    suggested_evidence=k.remedy,
                    pointers=k.evidence,
                ))
        for f in submission.gaps.dtfea.findings:
            if f.severity == "critical" and f.confidence >= 9:
                items.append(FeedbackItem(
                    title=f"DTFEA {f.pillar}-pillar critical",
                    tone="challenge",
                    paraphrase=f.summary,
                ))
    if submission.coverage:
        for a in submission.coverage.artefacts:
            if a.verdict == "red":
                items.append(FeedbackItem(
                    title=f"{a.artefact} missing",
                    tone="coaching",
                    paraphrase=f"{a.artefact.replace('_', ' ').title()} not detected in pack.",
                    suggested_evidence=f"Add a dedicated {a.artefact.replace('_', ' ')} artefact.",
                ))
    return items[:20]  # cap to keep report scannable


def _headline(submission: Submission) -> str:
    if submission.gaps and submission.gaps.approval_blocked:
        fired = [k.keystone_id for k in submission.gaps.keystones if k.fired and k.confidence >= 9]
        if fired:
            return f"Likely to be refused — keystone(s) fired: {', '.join(fired)}."
        return "Likely to be refused — approval is blocked by one or more gates."
    if submission.classification and submission.classification.declared_scenario:
        return "Looks good — PDRA scenario with the expected artefacts present."
    return "On track — refine amber items and re-run before submit."


def _duty_holder_checklist(submission: Submission) -> list[str]:
    c = submission.classification
    checklist = [
        "Accountable Manager acknowledgement",
    ]
    if c and c.autonomy_posture in {"supervised_autonomy", "full_autonomy", "swarm"}:
        checklist.append("RAISO acknowledgement (AI is load-bearing)")
    if submission.regulator == "JOINT":
        checklist.append("Signed CAA/MAA apportionment")
        checklist.append("Range Safety Officer acknowledgement")
    checklist.append("Classification marking confirmed on every artefact")
    return checklist


class DecisionDrafter(Executor):
    def __init__(self) -> None:
        super().__init__("decision_drafter")

    @handler
    async def draft(self, submission: Submission, ctx: WorkflowContext[Submission]) -> None:
        approval_blocked = submission.gaps.approval_blocked if submission.gaps else False
        submission.feedback = FeedbackReport(
            submission_id=submission.submission_id,
            generated_at=datetime.now(tz=timezone.utc),
            headline=_headline(submission),
            readiness=_readiness(submission),
            top_issues=_top_issues(submission),
            duty_holder_checklist=_duty_holder_checklist(submission),
            approval_blocked=approval_blocked,
        )
        await ctx.send_message(submission)
