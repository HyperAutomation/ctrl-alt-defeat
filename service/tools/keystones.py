"""Keystone failure-mode detectors K1–K8.

These are invariants, not pattern matches (plan §16, §18). Each Kn takes a
structured submission snapshot and returns a `KeystoneVerdict`. The Gap
analyser is instructed to call every detector explicitly; refusal to call one
is a workflow failure caught by the binder.

On the Scotland sample (PDRA-01 VLOS single-vehicle) the autonomy/swarm/
classification surface is not engaged, so detectors return `fired=False` with
rationale 'operation does not engage failure mode'. On the SORA sample
(autonomous swarm, BVLOS, GNSS/C2-denied, military range), K1/K2/K3/K7/K8
fire with confidence 10.
"""
from __future__ import annotations

from collections.abc import Callable

from workflow.schemas import Classification, KeystoneVerdict, Submission


# -----------------------------------------------------------------------------
# helpers -- pure functions, no LLM. Kept narrow so unit tests are trivial.
# -----------------------------------------------------------------------------

def _engages_autonomy(c: Classification | None) -> bool:
    if c is None:
        return False
    return c.autonomy_posture in {"supervised_autonomy", "full_autonomy", "swarm"}


def _engages_swarm(c: Classification | None) -> bool:
    if c is None:
        return False
    return c.autonomy_posture == "swarm" or (c.aircraft_count or 1) > 1


def _engages_bvlos(c: Classification | None) -> bool:
    return bool(c and c.bvlos)


def _engages_classification_surface(c: Classification | None) -> bool:
    # Proxy: military-range or joint regulator.
    return bool(c and ("range" in (c.operation_type or "").lower() or False))


def _has_text(submission: Submission, *keywords: str) -> bool:
    hay = " ".join(
        s.text.lower()
        for d in submission.documents
        for s in d.sections
    )
    return any(kw.lower() in hay for kw in keywords)


def _first_pointer(submission: Submission) -> list:
    for d in submission.documents:
        for s in d.sections:
            return [
                {
                    "document_id": d.document_id,
                    "page": s.page,
                    "paragraph": s.paragraph,
                    "quote": (s.text[:200] if s.text else None),
                }
            ]
    return []


# -----------------------------------------------------------------------------
# K1 — Geofence / containment independence
# -----------------------------------------------------------------------------

def k1_geofence_independence(submission: Submission) -> KeystoneVerdict:
    """Does the geofence run on the same compute/software stack as the autonomy?

    Refuse if dual-independent geofence not evidenced (plan §16 K1).
    """
    c = submission.classification
    if not _engages_autonomy(c):
        return KeystoneVerdict(
            keystone_id="K1",
            fired=False,
            confidence=10,
            rationale="Operation does not engage autonomy surface; geofence independence not a blocker.",
            remedy="N/A",
        )
    has_independence = _has_text(
        submission,
        "dual-independent geofence",
        "independent geofence",
        "redundant geofence",
        "hardware geofence",
        "safety-critical geofence module",
        "independent containment",
    )
    # K1 fires whenever autonomy is engaged and independence is not evidenced.
    # The presence or absence of a geofence *claim* doesn't change the invariant —
    # claiming a geofence without independence is a single-point failure, and
    # omitting any containment story entirely is worse.
    fired = not has_independence
    return KeystoneVerdict(
        keystone_id="K1",
        fired=fired,
        confidence=10 if fired else 7,
        rationale=(
            "Autonomous operation without evidenced independent containment: either no "
            "geofence/containment story at all, or a claim with no architectural evidence "
            "of independence from the primary autonomy stack. Single-point failure."
            if fired
            else "Independent containment evidenced."
        ),
        evidence=_first_pointer(submission) if fired else [],
        remedy="Provide dual-independent geofence evidence (e.g. L2 swarm coordinator + L3 safety-critical module) with test evidence under degraded states.",
    )


# -----------------------------------------------------------------------------
# K2 — DAA ML provenance and calibration
# -----------------------------------------------------------------------------

def k2_daa_provenance(submission: Submission) -> KeystoneVerdict:
    c = submission.classification
    if not _engages_bvlos(c):
        return KeystoneVerdict(
            keystone_id="K2",
            fired=False,
            confidence=10,
            rationale="VLOS operation; DAA provenance not a blocker for this SAIL.",
            remedy="N/A",
        )
    has_daa = _has_text(submission, "DO-365", "F3442", "detect and avoid", "DAA", "calibration study", "ROC")
    has_dataset_sheet = _has_text(submission, "training dataset", "dataset sheet", "datasheet", "label accuracy")
    fired = not (has_daa and has_dataset_sheet)
    return KeystoneVerdict(
        keystone_id="K2",
        fired=fired,
        confidence=10 if fired else 6,
        rationale=(
            "DAA assurance pack missing (a) training dataset sheet with label accuracy, "
            "(b) calibration study at 10 confidence thresholds with empirical ROC, and/or "
            "(c) distributional-shift detection runtime."
            if fired
            else "DAA provenance and calibration artefacts present."
        ),
        evidence=_first_pointer(submission) if fired else [],
        remedy="Produce DO-365 / F3442 mapping matrix, acceptance criteria table, multi-agent deconfliction confidence model, out-of-distribution monitor.",
    )


# -----------------------------------------------------------------------------
# K3 — Swarm emergent behaviour bounds
# -----------------------------------------------------------------------------

def k3_swarm_emergent_bounds(submission: Submission) -> KeystoneVerdict:
    c = submission.classification
    if not _engages_swarm(c):
        return KeystoneVerdict(
            keystone_id="K3",
            fired=False,
            confidence=10,
            rationale="Single-vehicle operation; swarm emergent behaviour not engaged.",
            remedy="N/A",
        )
    has_sim_matrix = _has_text(submission, "simulation", "state-space coverage", "flight-test matrix")
    has_runtime_monitor = _has_text(submission, "runtime monitor", "consensus monitor", "cohesion monitor", "emergent-behaviour monitor")
    fired = not (has_sim_matrix and has_runtime_monitor)
    return KeystoneVerdict(
        keystone_id="K3",
        fired=fired,
        confidence=10 if fired else 6,
        rationale=(
            "Swarm emergent-behaviour envelope is not bounded: either simulation + live "
            "flight state-space coverage is missing, or a runtime monitor for inter-agent "
            "consensus/cohesion is absent."
            if fired
            else "Swarm envelope evidenced with sim + flight matrix and runtime monitors."
        ),
        evidence=_first_pointer(submission) if fired else [],
        remedy="Provide state-space coverage report, sim + flight-test matrix, runtime monitor, and named human accountable for the emergent-behaviour envelope.",
    )


# -----------------------------------------------------------------------------
# K4 — ML forensic explainability
# -----------------------------------------------------------------------------

def k4_ml_forensic_explainability(submission: Submission) -> KeystoneVerdict:
    c = submission.classification
    if not _engages_autonomy(c):
        return KeystoneVerdict(
            keystone_id="K4",
            fired=False,
            confidence=10,
            rationale="No ML-load-bearing autonomy; forensic explainability not engaged.",
            remedy="N/A",
        )
    has_amlas = _has_text(submission, "AMLAS", "assurance of machine learning", "SACE")
    has_onboard_log = _has_text(submission, "onboard log", "forensic log", "reconstruction playbook")
    fired = not (has_amlas and has_onboard_log)
    return KeystoneVerdict(
        keystone_id="K4",
        fired=fired,
        confidence=10 if fired else 6,
        rationale=(
            "No AMLAS/SACE explainability mapping or post-incident reconstruction log schema."
            if fired
            else "AMLAS explainability + onboard forensic log evidenced."
        ),
        evidence=_first_pointer(submission) if fired else [],
        remedy="Produce AMLAS explainability module mapping + onboard-log schema + post-incident reconstruction playbook.",
    )


# -----------------------------------------------------------------------------
# K5 — Meaningful Human Control operationalisation
# -----------------------------------------------------------------------------

def k5_meaningful_human_control(submission: Submission) -> KeystoneVerdict:
    c = submission.classification
    if not _engages_autonomy(c):
        return KeystoneVerdict(
            keystone_id="K5",
            fired=False,
            confidence=10,
            rationale="No autonomy; MHC operationalisation not engaged.",
            remedy="N/A",
        )
    has_mhc = _has_text(submission, "meaningful human control", "MHC", "override latency", "decision-responsibility matrix")
    fired = not has_mhc
    return KeystoneVerdict(
        keystone_id="K5",
        fired=fired,
        confidence=10 if fired else 6,
        rationale=(
            "MHC not operationalised: no decision-responsibility matrix, no quantified "
            "override latency, no workload thresholds. Narrative-only or absent."
            if fired
            else "MHC operationalised with quantified override latency and workload plan."
        ),
        evidence=_first_pointer(submission) if fired else [],
        remedy="Produce quantified override latency (<1 s target), workload instrumentation plan, take-over simulator runs.",
    )


# -----------------------------------------------------------------------------
# K6 — Independent flight termination
# -----------------------------------------------------------------------------

def k6_independent_termination(submission: Submission) -> KeystoneVerdict:
    c = submission.classification
    if not _engages_autonomy(c):
        return KeystoneVerdict(
            keystone_id="K6",
            fired=False,
            confidence=10,
            rationale="No autonomy; independent termination not a blocker at this SAIL.",
            remedy="N/A",
        )
    has_redundant = _has_text(submission, "redundant termination", "independent RF kill", "RC kill", "software relay kill")
    fired = not has_redundant
    return KeystoneVerdict(
        keystone_id="K6",
        fired=fired,
        confidence=10 if fired else 6,
        rationale=(
            "Termination independence not evidenced: no redundant channels, no independent "
            "power/compute paths, no explicit human-exclusive final-authority statement."
            if fired
            else "Redundant independent termination channels evidenced."
        ),
        evidence=_first_pointer(submission) if fired else [],
        remedy="Provide redundant termination channels, independent power/compute paths, explicit human-exclusive final-authority statement.",
    )


# -----------------------------------------------------------------------------
# K7 — CAA/MAA apportionment as a mandatory gate
# -----------------------------------------------------------------------------

def k7_caa_maa_apportionment(submission: Submission) -> KeystoneVerdict:
    c = submission.classification
    crosses_boundary = submission.regulator == "JOINT" or _has_text(
        submission,
        "military range",
        "MoD range",
        "Spadeadam",
        "civil-military",
        "MAA authorisation",
        "military permit to fly",
    )
    if not crosses_boundary:
        return KeystoneVerdict(
            keystone_id="K7",
            fired=False,
            confidence=10,
            rationale="Operation does not cross civil/military regulatory boundary; K7 skipped per §18.",
            remedy="N/A",
        )
    has_apportionment = _has_text(submission, "apportionment agreement", "CAA/MAA apportionment", "apportionment signed")
    fired = not has_apportionment
    return KeystoneVerdict(
        keystone_id="K7",
        fired=fired,
        confidence=10 if fired else 6,
        rationale=(
            "Operation crosses CAA/MAA boundary (military range / civil-military) but no "
            "signed apportionment agreement produced before trial authorisation."
            if fired
            else "Signed CAA/MAA apportionment evidenced."
        ),
        evidence=_first_pointer(submission) if fired else [],
        remedy="Produce signed CAA/MAA Apportionment Agreement naming regulatory ownership per leg, event class, payload class.",
    )


# -----------------------------------------------------------------------------
# K8 — Classification custodian & handling
# -----------------------------------------------------------------------------

def k8_classification_custodian(submission: Submission) -> KeystoneVerdict:
    classified_adjacent = _has_text(
        submission,
        "classified",
        "OFFICIAL-SENSITIVE",
        "STRAP",
        "military range",
        "MoD range",
        "Spadeadam",
    ) or submission.regulator == "JOINT"
    if not classified_adjacent:
        return KeystoneVerdict(
            keystone_id="K8",
            fired=False,
            confidence=10,
            rationale="No classified or classified-adjacent evidence; custodian not required.",
            remedy="N/A",
        )
    has_custodian = _has_text(submission, "security classification custodian", "classification custodian", "CAP 722H", "JSP 440")
    fired = not has_custodian
    return KeystoneVerdict(
        keystone_id="K8",
        fired=fired,
        confidence=10 if fired else 6,
        rationale=(
            "Classified-adjacent operation but no named Security Classification Custodian, "
            "no CAP 722H / JSP 440 handling procedures, no two-person downgrade rule."
            if fired
            else "Classification custodian and handling procedures evidenced."
        ),
        evidence=_first_pointer(submission) if fired else [],
        remedy="Name joint MOD/CAA Security Classification Custodian; produce classification guide and redaction protocol; enforce two-person downgrade.",
    )


# -----------------------------------------------------------------------------
# Registry
# -----------------------------------------------------------------------------

ALL_KEYSTONES: dict[str, Callable[[Submission], KeystoneVerdict]] = {
    "K1": k1_geofence_independence,
    "K2": k2_daa_provenance,
    "K3": k3_swarm_emergent_bounds,
    "K4": k4_ml_forensic_explainability,
    "K5": k5_meaningful_human_control,
    "K6": k6_independent_termination,
    "K7": k7_caa_maa_apportionment,
    "K8": k8_classification_custodian,
}


def run_keystones(submission: Submission) -> list[KeystoneVerdict]:
    """Run every keystone. Skipping one is not allowed — that is the §18 invariant."""
    return [fn(submission) for fn in ALL_KEYSTONES.values()]
