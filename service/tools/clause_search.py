"""Clause-library RAG tool (plan §5).

A very small, version-pinned clause index for the hackathon cut. Real
implementation swaps the in-memory store for Chroma/LanceDB with persistence.
The interface is stable — consumers shouldn't need to change when we upgrade.
"""
from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class Clause:
    clause_id: str  # e.g. "SORA-v2.5-OSO-10"
    source: str     # e.g. "JARUS SORA v2.5"
    revision: str   # e.g. "2.5"
    text: str


# Seed clauses — only the ones the hackathon demo actually needs to hit.
_SEED_CLAUSES: list[Clause] = [
    Clause("CAP722-v9-AC1", "CAP 722", "v9 (Dec 2022)",
           "Applicants must provide an Operating Safety Case (OSC) per CAP 722A for operations in the Specific Category."),
    Clause("CAP722A-s3", "CAP 722A", "2nd Ed (Dec 2022)",
           "The OSC must include document control, named Accountable Manager, safety policy, SMS aligned to CAP 1059, and roles & responsibilities."),
    Clause("SORA-v2.5-OSO-10", "JARUS SORA", "v2.5",
           "OSO 10 — C2 link robustness: the link must be engineered and monitored; loss-of-link behaviour must be bounded and not depend on swarm consensus at high SAIL."),
    Clause("SORA-v2.5-OSO-18", "JARUS SORA", "v2.5",
           "OSO 18 — Human Factors: operator workload, take-over ability, and decision support must be assessed and evidenced."),
    Clause("SORA-v2.5-OSO-24", "JARUS SORA", "v2.5",
           "OSO 24 — External services: where the operation relies on third-party services (e.g. GNSS), loss and integrity postures must be analysed."),
    Clause("SORA-v2.5-SAIL", "JARUS SORA", "v2.5",
           "Declared SAIL must not be lower than the SAIL derived from final GRC × ARC. Autonomous swarm BVLOS with deliberate loss-of-reference testing raises the complexity beyond airspace segregation alone."),
    Clause("RA-1600-swarm", "MAA RA 1600 series", "as at 31 Mar 2026",
           "Autonomous and swarm operations on MoD ranges require RAISO sign-off and an AMLAS/SACE-aligned assurance case."),
    Clause("CAP722H", "CAP 722H", "current",
           "Classified evidence presented to CAA must be handled by a named Security Classification Custodian with CAP 722H / JSP 440 procedures."),
    Clause("AMLAS-stage1", "York AMLAS", "6-stage",
           "AMLAS Stage 1 requires ML assurance scoping with explicit ODD, residual-risk claims, and re-evidencing triggers."),
    Clause("CAP1616-trigger", "CAP 1616", "current",
           "Any sponsored airspace change (TDA/DA) requires the Airspace Change Process with community consultation unless a standing exemption applies."),
]


class ClauseLibrary:
    def __init__(self, clauses: list[Clause] | None = None):
        self._clauses = clauses or list(_SEED_CLAUSES)

    def search(self, query: str, top_k: int = 5) -> list[Clause]:
        """Ultra-simple TF-IDF-free keyword match for the hackathon demo.

        Scores by number of query-term hits in clause text + source; ties
        broken by clause_id for deterministic test output.
        """
        q = query.lower().split()
        if not q:
            return []
        scored = []
        for c in self._clauses:
            hay = (c.text + " " + c.source + " " + c.clause_id).lower()
            score = sum(1 for term in q if term in hay)
            if score > 0:
                scored.append((score, c))
        scored.sort(key=lambda x: (-x[0], x[1].clause_id))
        return [c for _, c in scored[:top_k]]

    def all_sources(self) -> list[str]:
        return sorted({c.source for c in self._clauses})


_default_library = ClauseLibrary()


def search_clauses(query: str, top_k: int = 5) -> list[dict]:
    """MAF-tool-friendly wrapper — returns plain dicts."""
    return [
        {"clause_id": c.clause_id, "source": c.source, "revision": c.revision, "text": c.text}
        for c in _default_library.search(query, top_k=top_k)
    ]
