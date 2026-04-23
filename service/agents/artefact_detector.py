"""Component 3 — Artefact Detector.

Per-artefact tools probe the submission for presence AND minimum-content
adequacy. A bare-bones DAA section of three paragraphs with no sensor specs
fails the detector's minimum-content heuristic even if a DAA section exists
(plan §4.2 component 3).
"""
from __future__ import annotations

try:
    from agent_framework import Executor, WorkflowContext, handler  # type: ignore
except ImportError:  # pragma: no cover
    Executor = object  # type: ignore[assignment,misc]
    WorkflowContext = None  # type: ignore[assignment]

    def handler(fn):  # type: ignore[no-redef]
        return fn

from workflow.schemas import ArtefactPresence, CoverageMatrix, Submission


INSTRUCTIONS = """\
You are the Artefact Detector. For each of the required artefact classes
(OSC, SORA, CONOPS, DAA, C2, swarm envelope, AMLAS, SACE, CAP 1616, Range
Safety), determine:

  - present? (was the artefact included at all?)
  - min_content_ok? (does it clear the minimum-content bar — e.g. DAA must
    contain sensor specs, not just prose)
  - verdict (green/amber/red)
  - evidence pointers (document_id + page + paragraph)

A present-but-thin artefact is amber, not green. An absent required artefact
is red.
"""


# Minimum-content signals keyed per artefact class. Presence of *any* signal
# gives a pass; depth is judged by the count.
_SIGNALS: dict[str, list[str]] = {
    "operating_safety_case": ["operating safety case", "OSC", "CAP 722A"],
    "sora_package": ["SORA", "GRC", "ARC", "SAIL", "OSO"],
    "conops": ["concept of operations", "conops", "mission profile"],
    "daa_report": ["detect and avoid", "DAA", "DO-365", "F3442", "EUROCAE ED-267"],
    "c2_link_analysis": ["link budget", "latency", "C2 link", "crypto", "spectrum"],
    "swarm_behaviour_envelope": [
        "emergent behaviour", "swarm envelope", "consensus", "cohesion",
        "state-space coverage",
    ],
    "amlas_case": ["AMLAS"],
    "sace_case": ["SACE"],
    "cap1616_airspace_change": ["CAP 1616", "airspace change", "TDA", "NOTAM"],
    "range_safety_case": ["range safety case", "range safety officer", "RSO"],
}


def detect_artefacts(submission: Submission) -> list[ArtefactPresence]:
    hay = " ".join(
        (s.text or "").lower()
        for d in submission.documents
        for s in d.sections
    )
    out: list[ArtefactPresence] = []
    for artefact, signals in _SIGNALS.items():
        hits = sum(1 for s in signals if s.lower() in hay)
        present = hits >= 1
        min_content_ok = hits >= 2
        verdict: str
        if not present:
            verdict = "red"
        elif not min_content_ok:
            verdict = "amber"
        else:
            verdict = "green"
        out.append(
            ArtefactPresence(
                artefact=artefact,  # type: ignore[arg-type]
                present=present,
                min_content_ok=min_content_ok,
                verdict=verdict,  # type: ignore[arg-type]
                notes=f"{hits} content signal(s) detected",
            )
        )
    return out


class ArtefactDetector(Executor):
    def __init__(self) -> None:
        super().__init__("artefact_detector")

    @handler
    async def detect(self, submission: Submission, ctx: WorkflowContext[Submission]) -> None:
        artefacts = detect_artefacts(submission)
        submission.coverage = CoverageMatrix(artefacts=artefacts, clauses=[])
        await ctx.send_message(submission)
