"""`workflow` package — shared schemas plus workflow-graph builder.

The builder is imported lazily so the schemas module can be used in
environments without `agent_framework` installed (unit tests for pure-Python
tools).
"""
from .schemas import (
    Submission,
    Document,
    EvidencePointer,
    Classification,
    CoverageMatrix,
    KeystoneVerdict,
    DTFEAResult,
    REQVerdict,
    FeedbackReport,
    ReadinessGauges,
)


def build_applicant_workflow():
    from .applicant_graph import build_applicant_workflow as _build
    return _build()


__all__ = [
    "Submission",
    "Document",
    "EvidencePointer",
    "Classification",
    "CoverageMatrix",
    "KeystoneVerdict",
    "DTFEAResult",
    "REQVerdict",
    "FeedbackReport",
    "ReadinessGauges",
    "build_applicant_workflow",
]
