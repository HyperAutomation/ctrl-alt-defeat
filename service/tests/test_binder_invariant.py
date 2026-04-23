"""Binder invariant — no quantitative claim without an Appendix B pointer.

The binder executor rejects a FeedbackReport whose pointers reference
document_ids not in the submitted pack. This test exercises the negative
path directly against `verify_feedback`.
"""
from __future__ import annotations

import uuid
from datetime import datetime, timezone

import pytest

from agents.binder import BinderViolation, verify_feedback
from workflow.schemas import (
    Document,
    EvidencePointer,
    FeedbackItem,
    FeedbackReport,
    ReadinessGauges,
    Submission,
)


def _submission_with_docs(doc_ids: list[str]) -> Submission:
    return Submission(
        submission_id=uuid.uuid4().hex[:12],
        workspace_id="test",
        operation_type="vlos_pdra01",
        airspace="Class G",
        regulator="CAA",
        documents=[
            Document(document_id=d, filename=d, mime_type="text/plain", sections=[])
            for d in doc_ids
        ],
    )


def _feedback_with_pointer(submission_id: str, doc_id: str) -> FeedbackReport:
    return FeedbackReport(
        submission_id=submission_id,
        generated_at=datetime.now(tz=timezone.utc),
        headline="test",
        readiness=ReadinessGauges(
            ac={"AC1": "green", "AC2": "na", "AC3": "na", "AC4": "na",
                "AC5": "na", "AC6": "green", "AC7": "na", "AC8": "green"},
            dtfea={"D": 80, "T": 80, "F": 80, "E": 80, "A": 80},
            reqs={},
            keystones={f"K{i}": False for i in range(1, 9)},
        ),
        top_issues=[
            FeedbackItem(
                title="cited missing doc",
                paraphrase="test",
                pointers=[EvidencePointer(document_id=doc_id, page=1, paragraph=1)],
            )
        ],
        approval_blocked=False,
    )


def test_binder_accepts_valid_pointers():
    sub = _submission_with_docs(["a.md", "b.md"])
    sub.feedback = _feedback_with_pointer(sub.submission_id, "a.md")
    verify_feedback(sub)  # must not raise


def test_binder_rejects_unknown_document_id():
    sub = _submission_with_docs(["a.md"])
    sub.feedback = _feedback_with_pointer(sub.submission_id, "phantom.md")
    with pytest.raises(BinderViolation):
        verify_feedback(sub)


def test_binder_rejects_missing_feedback():
    sub = _submission_with_docs(["a.md"])
    sub.feedback = None
    with pytest.raises(BinderViolation):
        verify_feedback(sub)
