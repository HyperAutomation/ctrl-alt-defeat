"""Component 5 — SORA Evaluator.

LLM narrates; the `sora_calculator` tool performs the GRC × ARC → SAIL math
and the OSO-by-OSO walk. Hard invariant: if `declared_sail < derived_sail`,
`sail_coherent` is False and the decision-drafter cannot emit approve.
"""
from __future__ import annotations

import re

try:
    from agent_framework import Executor, WorkflowContext, handler  # type: ignore
except ImportError:  # pragma: no cover
    Executor = object  # type: ignore[assignment,misc]
    WorkflowContext = None  # type: ignore[assignment]

    def handler(fn):  # type: ignore[no-redef]
        return fn

from tools.sora_calculator import derive_sail, walk_osos
from workflow.schemas import Submission


INSTRUCTIONS = """\
You are the SORA Evaluator, applying JARUS SORA v2.5.

Workflow:

  1. Pull declared SAIL, declared iGRC, declared ARC from the submission.
  2. Call `derive_sail(classification, declared_sail, igrc, arc)`.
  3. For each OSO present in the submission, classify as
     met / enhanced / high / partial / absent / na and attach evidence
     pointers.
  4. Call `walk_osos(sail, evidenced_osos)` to fill the 24-OSO table.
  5. Produce a narrative in engineering English explaining the SAIL
     derivation and any asymmetry between declared and derived values.

Invariant: never emit `sail_coherent=True` when declared < derived. This is
a mathematical check the calculator performs for you — do not override.
"""


_SAIL_RE = re.compile(r"SAIL[\s:]*([IVX]+)", re.IGNORECASE)
_GRC_RE = re.compile(r"iGRC\s*=\s*(\d+)|final\s+GRC\s*=\s*(\d+)", re.IGNORECASE)
_ARC_RE = re.compile(r"ARC\s*=\s*([A-D])|final\s+ARC\s*=\s*([A-D])", re.IGNORECASE)
_OSO_RE = re.compile(r"OSO\s*(\d{1,2})\s.*?(met|partial|compliant|absent|enhanced|high)", re.IGNORECASE)


def _extract_declared(submission: Submission) -> tuple[str | None, int, str]:
    text = "\n".join(s.text or "" for d in submission.documents for s in d.sections)
    sail_m = _SAIL_RE.search(text)
    grc_m = _GRC_RE.search(text)
    arc_m = _ARC_RE.search(text)

    declared_sail = sail_m.group(1).upper() if sail_m else None
    igrc = int(next(g for g in grc_m.groups() if g)) if grc_m else 2
    arc = next(g for g in arc_m.groups() if g).upper() if arc_m else "A"
    return declared_sail, igrc, arc


def _extract_evidenced_osos(submission: Submission) -> dict[str, str]:
    text = "\n".join(s.text or "" for d in submission.documents for s in d.sections)
    out: dict[str, str] = {}
    for m in _OSO_RE.finditer(text):
        oso_num = int(m.group(1))
        verdict_raw = m.group(2).lower()
        verdict = {
            "met": "met", "compliant": "met",
            "partial": "partial",
            "absent": "absent",
            "enhanced": "enhanced",
            "high": "high",
        }.get(verdict_raw, "absent")
        out[f"OSO-{oso_num:02d}"] = verdict
    return out


class SORAEvaluator(Executor):
    def __init__(self) -> None:
        super().__init__("sora_evaluator")

    @handler
    async def evaluate(self, submission: Submission, ctx: WorkflowContext[Submission]) -> None:
        declared_sail, igrc, arc = _extract_declared(submission)
        sora = derive_sail(submission.classification, declared_sail, igrc=igrc, arc=arc)
        evidenced = _extract_evidenced_osos(submission)
        sora.osos = walk_osos(sora.derived_sail or "V", evidenced)

        # Narrative — short, engineering-English. No LLM in the scaffold.
        if not sora.sail_coherent:
            sora.narrative = (
                f"Declared SAIL {sora.declared_sail} is lower than the derived SAIL "
                f"{sora.derived_sail} under JARUS v2.5 (final GRC={sora.derived_grc}, "
                f"ARC={sora.derived_arc}). Autonomy/BVLOS/swarm complexity raises the "
                f"SAIL irrespective of airspace segregation. The submission is incoherent "
                f"and is not curable by panel deliberation."
            )
        else:
            sora.narrative = (
                f"Declared SAIL {sora.declared_sail or 'N/A'} consistent with derived "
                f"SAIL {sora.derived_sail}. OSO coverage to be read alongside the "
                f"artefact detector verdicts."
            )
        submission.sora = sora
        await ctx.send_message(submission)
