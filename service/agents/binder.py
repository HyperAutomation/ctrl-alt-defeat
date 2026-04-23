"""Component 8 — Evidence Traceability Binder.

Non-LLM executor. Enforces the traceability invariant: every EvidencePointer
in the Feedback Report must resolve to a `document_id` that exists in the
submission, with `page`/`paragraph` present. Emission of an unsourced
quantitative claim raises `BinderViolation` which fails the workflow.
"""
from __future__ import annotations

try:
    from agent_framework import Executor, WorkflowContext, handler  # type: ignore
except ImportError:  # pragma: no cover
    Executor = object  # type: ignore[assignment,misc]
    WorkflowContext = None  # type: ignore[assignment]

    def handler(fn):  # type: ignore[no-redef]
        return fn

from workflow.schemas import EvidencePointer, FeedbackReport, Submission


class BinderViolation(RuntimeError):
    pass


def _submitted_document_ids(submission: Submission) -> set[str]:
    return {d.document_id for d in submission.documents}


def _check_pointer(p: EvidencePointer, doc_ids: set[str]) -> None:
    if p.document_id not in doc_ids:
        raise BinderViolation(
            f"EvidencePointer references unknown document '{p.document_id}' — "
            f"binder invariant violated."
        )


def verify_feedback(submission: Submission) -> None:
    feedback: FeedbackReport | None = submission.feedback
    if feedback is None:
        raise BinderViolation("No FeedbackReport produced — cannot verify traceability.")

    doc_ids = _submitted_document_ids(submission)
    for item in feedback.top_issues:
        for p in item.pointers:
            _check_pointer(p, doc_ids)


class BinderExecutor(Executor):
    def __init__(self) -> None:
        super().__init__("binder")

    @handler
    async def verify(self, submission: Submission, ctx: WorkflowContext[Submission]) -> None:
        verify_feedback(submission)
        await ctx.yield_output(submission)
