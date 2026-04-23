"""Paraphrase-robustness of the keystone detectors (plan §18).

The SORA sample under 5 rewording variants must still trip K1/K2/K3/K7/K8.
Keystones are invariants — presence of the word 'independent' should not
clear K1 if there is no architectural evidence of independence.
"""
from __future__ import annotations

import uuid

import pytest

from agents.operation_classifier import _heuristic_classify
from tools.keystones import run_keystones
from workflow.schemas import Document, DocumentSection, Submission


def _mk(text: str) -> Submission:
    s = Submission(
        submission_id=uuid.uuid4().hex[:12],
        workspace_id="test",
        operation_type="bvlos_autonomous_swarm",
        airspace="mixed",
        regulator="JOINT",
        documents=[
            Document(
                document_id="adv.txt",
                filename="adv.txt",
                mime_type="text/plain",
                sections=[DocumentSection(
                    section_id="adv.txt#1",
                    heading=None,
                    page=1,
                    paragraph=1,
                    text=text,
                )],
            )
        ],
    )
    s.classification = _heuristic_classify(s)
    return s


_VARIANTS = [
    # baseline — thin autonomous-swarm BVLOS prose with no evidence
    "BVLOS autonomous swarm operation of five RigiTech Eiger UAS at Spadeadam military range under CAA and MAA. Hard geofencing. SORA v2.0.",
    # mentions 'independent' loosely but no architectural evidence
    "Autonomous swarm BVLOS trial with independent safety governance at the military range. Hard geofencing applied.",
    # reordered and slightly reworded
    "Swarm flight trial of 5 autonomous BVLOS vehicles. Spadeadam range. Geofence is hard-coded.",
    # uses synonyms (denial-of-service, coordinated flight)
    "Coordinated autonomous flight of five UAS in denial-of-service GNSS and C2 conditions at a military range.",
    # dense jargon
    "Multi-vehicle cooperative autonomy BVLOS operation; GNSS-denied and C2-denied regimes; Spadeadam DA; hard-geofence-only containment.",
]


@pytest.mark.parametrize("variant", _VARIANTS)
def test_sora_variants_fire_expected_keystones(variant: str) -> None:
    submission = _mk(variant)
    verdicts = {k.keystone_id: k for k in run_keystones(submission)}
    for kid in ("K1", "K2", "K3", "K7", "K8"):
        assert verdicts[kid].fired, (
            f"Variant did not fire {kid}: {variant[:120]}..."
        )
        assert verdicts[kid].confidence >= 9, (
            f"{kid} fired with low confidence ({verdicts[kid].confidence}) on variant: {variant[:120]}..."
        )
