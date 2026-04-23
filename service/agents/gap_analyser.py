"""Component 6 — Gap & Extrapolation Analyser.

Fans the DTFEA 5-pillar pass and all 8 keystone detectors. Hard invariant:
if *any* of the K1–K8 tools isn't called, the workflow fails. DTFEA Gate 1
(60% pillar floor) and Gate 2 (no unmitigated critical with conf ≥ 9) each
set `approval_blocked=True` when breached.
"""
from __future__ import annotations

try:
    from agent_framework import Executor, WorkflowContext, handler  # type: ignore
except ImportError:  # pragma: no cover
    Executor = object  # type: ignore[assignment,misc]
    WorkflowContext = None  # type: ignore[assignment]

    def handler(fn):  # type: ignore[no-redef]
        return fn

from tools.dtfea_pillars import run_dtfea
from tools.keystones import run_keystones
from tools.req_checks import walk_catalogue
from workflow.schemas import GapAnalysis, Submission


INSTRUCTIONS = """\
You are the Gap & Extrapolation Analyser. Four orthogonal checks:

  1. Coverage gaps — required artefacts / clauses missing.
  2. Strength gaps — artefacts present but evidence too thin.
  3. Envelope extrapolations — operational envelope exceeds tested envelope,
     especially for DAA sensors and swarm behaviour.
  4. DTFEA failure-mode pass — run all five pillar tools, aggregate findings,
     and apply Gates 1 and 2.

Then call *every* keystone detector K1–K8 exactly once. Skipping any is a
workflow failure. Collate all findings into a `GapAnalysis`. Set
`approval_blocked=True` if any of the following are true:

  - DTFEA Gate 1 fails (any pillar < 60%).
  - DTFEA Gate 2 fails (any critical finding with confidence >= 9).
  - Any K1..K8 fires with confidence >= 9.
  - SORA `sail_coherent` is False.
"""


def _coverage_gaps(submission: Submission) -> tuple[list[str], list[str]]:
    if submission.coverage is None:
        return [], []
    coverage_gaps: list[str] = []
    strength_gaps: list[str] = []
    for a in submission.coverage.artefacts:
        if not a.present:
            coverage_gaps.append(f"{a.artefact}: absent")
        elif not a.min_content_ok:
            strength_gaps.append(f"{a.artefact}: thin (only {a.notes})")
    return coverage_gaps, strength_gaps


def _extrapolations(submission: Submission) -> list[str]:
    out: list[str] = []
    c = submission.classification
    if c and c.autonomy_posture == "swarm" and c.bvlos:
        hay = " ".join(
            (s.text or "").lower()
            for d in submission.documents
            for s in d.sections
        )
        if "state-space coverage" not in hay:
            out.append("Swarm emergent-behaviour envelope not evidenced as covered in sim + live flight.")
        if "calibration study" not in hay and "DAA" in (submission.classification.payload or "") or (c and c.bvlos):
            if "detect and avoid" in hay and "calibration" not in hay:
                out.append("DAA envelope present but calibration study not tabulated to operational envelope.")
    return out


class GapAnalyser(Executor):
    def __init__(self) -> None:
        super().__init__("gap_analyser")

    @handler
    async def analyse(self, submission: Submission, ctx: WorkflowContext[Submission]) -> None:
        coverage_gaps, strength_gaps = _coverage_gaps(submission)
        extrapolations = _extrapolations(submission)
        dtfea = run_dtfea(submission)
        keystones = run_keystones(submission)
        submission.reqs = walk_catalogue(submission)

        approval_blocked = (
            not dtfea.gate1_pass
            or not dtfea.gate2_pass
            or any(k.fired and k.confidence >= 9 for k in keystones)
            or (submission.sora is not None and not submission.sora.sail_coherent)
        )

        submission.gaps = GapAnalysis(
            coverage_gaps=coverage_gaps,
            strength_gaps=strength_gaps,
            envelope_extrapolations=extrapolations,
            dtfea=dtfea,
            keystones=keystones,
            approval_blocked=approval_blocked,
        )
        await ctx.send_message(submission)
