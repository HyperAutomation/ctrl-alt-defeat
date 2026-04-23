"""Deterministic JARUS SORA v2.5 math (plan §4.2 component 5).

The LLM narrates; this calculator computes. Hard invariant: declared SAIL <
derived SAIL → `sail_coherent=False`, which blocks approval irrespective of
any other signal.
"""
from __future__ import annotations

from workflow.schemas import Classification, OSOVerdict, SORAResult


# JARUS v2.5 simplified GRC × ARC → SAIL table (plan §4.2).
# This is a reduced scaffold — the real table has many more cells.
_SAIL_TABLE: dict[tuple[int, str], str] = {
    # (final_GRC, final_ARC) -> SAIL roman numeral
    (1, "A"): "I", (2, "A"): "II", (3, "A"): "II", (4, "A"): "III",
    (1, "B"): "II", (2, "B"): "II", (3, "B"): "III", (4, "B"): "IV",
    (1, "C"): "III", (2, "C"): "III", (3, "C"): "IV", (4, "C"): "V",
    (1, "D"): "IV", (2, "D"): "IV", (3, "D"): "V", (4, "D"): "VI",
    (5, "A"): "IV", (6, "A"): "V", (7, "A"): "VI",
    (5, "B"): "V", (6, "B"): "VI",
}


# Swarm + BVLOS + loss-of-reference testing lifts SAIL irrespective of
# segregation (plan §3.2). This is the asymmetry the SORA sample triggers.
def _complexity_bump(c: Classification | None) -> int:
    if c is None:
        return 0
    bump = 0
    if c.autonomy_posture == "swarm":
        bump += 2
    elif c.autonomy_posture == "full_autonomy":
        bump += 1
    if c.bvlos:
        bump += 1
    return bump


def derive_sail(
    classification: Classification | None,
    declared_sail: str | None = None,
    igrc: int = 2,
    arc: str = "A",
) -> SORAResult:
    """Derive SAIL from GRC × ARC with complexity bump; compare to declared."""
    bumped_grc = min(7, igrc + _complexity_bump(classification))
    derived_sail = _SAIL_TABLE.get((bumped_grc, arc), "V")

    coherent = True
    if declared_sail:
        roman_order = ["I", "II", "III", "IV", "V", "VI"]
        try:
            coherent = roman_order.index(declared_sail) >= roman_order.index(derived_sail)
        except ValueError:
            coherent = False

    return SORAResult(
        declared_sail=declared_sail,
        derived_grc=bumped_grc,
        derived_arc=arc,  # type: ignore[arg-type]
        derived_sail=derived_sail,
        sail_coherent=coherent,
        osos=[],
        narrative=None,
    )


# OSO list for JARUS v2.5 (24 objectives). Required robustness is a function
# of SAIL; this mapping is the simplified v2.5 schedule.
_OSO_SCHEDULE = {
    "I": "low",
    "II": "low",
    "III": "medium",
    "IV": "medium",
    "V": "high",
    "VI": "high",
}


def walk_osos(sail: str, evidenced_osos: dict[str, str] | None = None) -> list[OSOVerdict]:
    """Produce per-OSO verdicts.

    `evidenced_osos`: maps e.g. "OSO-01" -> "met"/"partial"/"absent" if the
    artefact detector has already found evidence. Anything absent from the
    map is flagged `absent`.
    """
    evidenced_osos = evidenced_osos or {}
    required = _OSO_SCHEDULE.get(sail, "high")
    out: list[OSOVerdict] = []
    for i in range(1, 25):
        oso_id = f"OSO-{i:02d}"
        verdict = evidenced_osos.get(oso_id, "absent")
        out.append(
            OSOVerdict(
                oso_id=oso_id,
                verdict=verdict,  # type: ignore[arg-type]
                required_robustness=required,  # type: ignore[arg-type]
            )
        )
    return out
