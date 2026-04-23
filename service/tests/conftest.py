"""Shared fixtures — the two reference samples from plan.md §3 as Submissions."""
from __future__ import annotations

import uuid
from pathlib import Path

import pytest

from agents.ingest import parse_file
from workflow.schemas import Submission


_REPO_ROOT = Path(__file__).resolve().parents[2]
_SCOTLAND = _REPO_ROOT / "context" / "scotland-sample-case" / "scotland-sample-case.md"
_SORA = _REPO_ROOT / "context" / "sora-safety-case" / "sora-safety-case.txt"


def _make_submission(path: Path, operation_type: str, regulator: str = "JOINT") -> Submission:
    return Submission(
        submission_id=uuid.uuid4().hex[:12],
        workspace_id="test",
        operation_type=operation_type,
        airspace="mixed",
        regulator=regulator,  # type: ignore[arg-type]
        documents=[parse_file(path)],
    )


@pytest.fixture
def scotland_submission() -> Submission:
    return _make_submission(
        _SCOTLAND,
        operation_type="vlos_pdra01",
        regulator="CAA",
    )


@pytest.fixture
def sora_submission() -> Submission:
    return _make_submission(
        _SORA,
        operation_type="bvlos_autonomous_swarm",
        regulator="JOINT",
    )
