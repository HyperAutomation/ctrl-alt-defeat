"""Component 4 — Regulatory Mapper.

Links each artefact section to the clause(s) it purports to satisfy, and
vice versa. Produces the clause-to-evidence trace that feeds the AC1
coverage matrix.

In production this is a `ChatAgent` with the `search_clauses` tool bound.
The hackathon scaffold uses the clause library's keyword search directly.
"""
from __future__ import annotations

try:
    from agent_framework import Executor, WorkflowContext, handler  # type: ignore
except ImportError:  # pragma: no cover
    Executor = object  # type: ignore[assignment,misc]
    WorkflowContext = None  # type: ignore[assignment]

    def handler(fn):  # type: ignore[no-redef]
        return fn

from tools.clause_search import _default_library
from workflow.schemas import ClauseHit, EvidencePointer, Submission


INSTRUCTIONS = """\
You are the Regulatory Mapper. For each clause in the applicable clause
sub-library, search the submission for evidence that supports the clause
and produce a `ClauseHit`:

  - clause_id, source, revision
  - matched_by: list of EvidencePointer (document_id + page + paragraph)
  - verdict: green (well-evidenced), amber (thin), red (no evidence found)

Use the `search_clauses` tool to pull the correct clause list for the
declared operation type. Do not invent pointers — if no section matches,
emit an empty matched_by and verdict=red.
"""


def _match_clause_to_submission(clause, submission) -> list[EvidencePointer]:
    """For the hackathon demo: score each section by overlap with the clause
    text's distinctive words (longer than 4 chars).
    """
    distinctive = {
        w.lower().strip(".,;:()")
        for w in clause.text.split()
        if len(w) > 4
    }
    if not distinctive:
        return []

    hits: list[EvidencePointer] = []
    for d in submission.documents:
        for s in d.sections:
            text = (s.text or "").lower()
            overlap = sum(1 for w in distinctive if w in text)
            if overlap >= 3:
                hits.append(
                    EvidencePointer(
                        document_id=d.document_id,
                        page=s.page,
                        paragraph=s.paragraph,
                        quote=((s.text or "")[:200]),
                    )
                )
    return hits[:5]


class RegulatoryMapper(Executor):
    def __init__(self) -> None:
        super().__init__("regulatory_mapper")

    @handler
    async def map(self, submission: Submission, ctx: WorkflowContext[Submission]) -> None:
        coverage = submission.coverage
        if coverage is None:
            # If the artefact detector hasn't run, produce an empty coverage shell.
            from workflow.schemas import CoverageMatrix
            coverage = CoverageMatrix(artefacts=[], clauses=[])
            submission.coverage = coverage

        clause_hits: list[ClauseHit] = []
        for clause in _default_library._clauses:  # direct access for scaffold
            pointers = _match_clause_to_submission(clause, submission)
            verdict = "green" if len(pointers) >= 2 else "amber" if pointers else "red"
            clause_hits.append(
                ClauseHit(
                    clause_id=clause.clause_id,
                    source=clause.source,
                    revision=clause.revision,
                    matched_by=pointers,
                    verdict=verdict,  # type: ignore[arg-type]
                )
            )
        coverage.clauses = clause_hits
        await ctx.send_message(submission)
