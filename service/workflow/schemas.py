"""Shared Pydantic schemas — the type-level contract between executors.

Every edge in the MAF workflow graph has an input and output type drawn from
this module. A parsing failure on any of them is a workflow error, not a
silent empty field (plan §6 layer 1).
"""
from __future__ import annotations

from datetime import datetime
from typing import Literal

from pydantic import BaseModel, Field


Verdict = Literal["green", "amber", "red", "na"]
KeystoneID = Literal["K1", "K2", "K3", "K4", "K5", "K6", "K7", "K8"]
DTFEAPillar = Literal["D", "T", "F", "E", "A"]
ACID = Literal["AC1", "AC2", "AC3", "AC4", "AC5", "AC6", "AC7", "AC8"]


class EvidencePointer(BaseModel):
    """Invariant: every quantitative claim in the decision record resolves to one of these.

    Binder refuses to emit a claim without a pointer; binder refuses a pointer
    without a claim (plan §4.2 component 8).
    """
    document_id: str
    page: int | None = None
    paragraph: int | None = None
    quote: str | None = Field(default=None, description="Short snippet (<=240 chars) for panel sanity check")


class Document(BaseModel):
    document_id: str
    filename: str
    mime_type: str
    sections: list["DocumentSection"] = Field(default_factory=list)


class DocumentSection(BaseModel):
    section_id: str
    heading: str | None
    page: int | None
    paragraph: int | None
    text: str


Document.model_rebuild()


class Classification(BaseModel):
    """Output of the Operation Classifier (component 2)."""
    operator: str | None = None
    accountable_manager: str | None = None
    duty_holder: str | None = None
    raiso: str | None = None
    aircraft_type: str | None = None
    aircraft_count: int | None = None
    mtom_kg_each: float | None = None
    operation_type: str | None = None
    airspace_class: str | None = None
    segregated: bool | None = None
    bvlos: bool | None = None
    autonomy_posture: Literal[
        "teleoperated", "supervised_autonomy", "full_autonomy", "swarm", "unknown"
    ] = "unknown"
    payload: str | None = None
    declared_category: Literal["open", "specific", "certified", "unknown"] = "unknown"
    declared_scenario: str | None = Field(default=None, description="e.g. UKPDRA-01, STS-01")


class ArtefactPresence(BaseModel):
    artefact: Literal[
        "operating_safety_case",
        "sora_package",
        "conops",
        "daa_report",
        "c2_link_analysis",
        "swarm_behaviour_envelope",
        "amlas_case",
        "sace_case",
        "cap1616_airspace_change",
        "range_safety_case",
    ]
    present: bool
    min_content_ok: bool
    verdict: Verdict
    evidence: list[EvidencePointer] = Field(default_factory=list)
    notes: str | None = None


class ClauseHit(BaseModel):
    clause_id: str
    source: str = Field(description="e.g. CAP722A, SORA-v2.5-OSO-10, RA-2305")
    revision: str
    matched_by: list[EvidencePointer] = Field(default_factory=list)
    verdict: Verdict


class CoverageMatrix(BaseModel):
    """AC1 output — artefact-presence table and clause-to-evidence trace (plan §4.2 component 4)."""
    artefacts: list[ArtefactPresence]
    clauses: list[ClauseHit]


class SORAResult(BaseModel):
    """Output of the SORA evaluator (component 5). Deterministic math, LLM narrates."""
    declared_sail: str | None = None
    derived_grc: int | None = None
    derived_arc: Literal["A", "B", "C", "D"] | None = None
    derived_sail: str | None = None
    sail_coherent: bool
    osos: list["OSOVerdict"] = Field(default_factory=list)
    narrative: str | None = None


class OSOVerdict(BaseModel):
    oso_id: str  # "OSO-01" .. "OSO-24"
    verdict: Literal["met", "enhanced", "high", "partial", "absent", "na"]
    required_robustness: Literal["low", "medium", "high", "na"] = "na"
    evidence: list[EvidencePointer] = Field(default_factory=list)
    rationale: str | None = None


SORAResult.model_rebuild()


class REQVerdict(BaseModel):
    req_id: str  # REQ001..REQ020
    name: str
    verdict: Verdict
    evidence: list[EvidencePointer] = Field(default_factory=list)
    rationale: str | None = None


class DTFEAFinding(BaseModel):
    pillar: DTFEAPillar
    severity: Literal["critical", "major", "minor"]
    confidence: int = Field(ge=0, le=10)
    summary: str
    evidence: list[EvidencePointer] = Field(default_factory=list)


class DTFEAResult(BaseModel):
    maturity: dict[DTFEAPillar, int] = Field(
        description="Percentage 0-100 per pillar (plan §15.2)"
    )
    findings: list[DTFEAFinding]
    gate1_pass: bool  # floor of 60% per pillar
    gate2_pass: bool  # no unmitigated critical with confidence >=9


class KeystoneVerdict(BaseModel):
    """Output contract for K1..K8 — invariant, not pattern match (plan §5)."""
    keystone_id: KeystoneID
    fired: bool
    severity: Literal["critical"] = "critical"
    confidence: int = Field(ge=0, le=10)
    rationale: str
    evidence: list[EvidencePointer] = Field(default_factory=list)
    remedy: str


class GapAnalysis(BaseModel):
    """Output of the Gap & Extrapolation analyser (component 6)."""
    coverage_gaps: list[str] = Field(default_factory=list)
    strength_gaps: list[str] = Field(default_factory=list)
    envelope_extrapolations: list[str] = Field(default_factory=list)
    dtfea: DTFEAResult
    keystones: list[KeystoneVerdict]
    approval_blocked: bool


class ReadinessGauges(BaseModel):
    """§21.2 Readiness Dashboard panel set."""
    ac: dict[ACID, Verdict]
    dtfea: dict[DTFEAPillar, int]  # 0-100
    reqs: dict[str, Verdict]  # REQ001..REQ020 -> verdict
    keystones: dict[KeystoneID, bool]  # fired?


class FeedbackItem(BaseModel):
    """One line in the Operator Feedback Report."""
    title: str
    tone: Literal["coaching", "challenge", "neutral"] = "coaching"
    paraphrase: str = Field(description="Plain-English 'likely to be challenged because …' form")
    suggested_evidence: str | None = None
    pointers: list[EvidencePointer] = Field(default_factory=list)


class FeedbackReport(BaseModel):
    """§21.2 Applicant-mode output."""
    submission_id: str
    generated_at: datetime
    headline: str = Field(description="One-line summary for the operator")
    readiness: ReadinessGauges
    top_issues: list[FeedbackItem]
    duty_holder_checklist: list[str] = Field(default_factory=list)
    approval_blocked: bool


class Submission(BaseModel):
    submission_id: str
    workspace_id: str
    operation_type: str
    airspace: str
    regulator: Literal["CAA", "MAA", "JOINT"]
    documents: list[Document] = Field(default_factory=list)
    classification: Classification | None = None
    coverage: CoverageMatrix | None = None
    sora: SORAResult | None = None
    reqs: list[REQVerdict] = Field(default_factory=list)
    gaps: GapAnalysis | None = None
    feedback: FeedbackReport | None = None
