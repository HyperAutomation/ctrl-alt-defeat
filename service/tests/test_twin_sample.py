"""Twin-sample regression (plan §8.1).

Scotland (PDRA-01 VLOS single-vehicle)
  - expected decision: approve-with-conditions
  - approval_blocked must be False
  - no K1..K8 fires with confidence >=9

SORA (autonomous swarm BVLOS, GNSS/C2-denied, military range)
  - expected decision: refuse
  - approval_blocked must be True
  - over-determined: K1, K2, K3, K7, K8 all fire
"""
from __future__ import annotations

import pytest

from agents.artefact_detector import detect_artefacts
from agents.decision_drafter import _ac_verdicts, _readiness
from agents.operation_classifier import _heuristic_classify
from agents.regulatory_mapper import RegulatoryMapper
from tools.dtfea_pillars import run_dtfea
from tools.keystones import run_keystones
from tools.req_checks import walk_catalogue
from tools.sora_calculator import derive_sail
from workflow.schemas import CoverageMatrix, GapAnalysis


def _evaluate(submission) -> None:
    submission.classification = _heuristic_classify(submission)
    submission.coverage = CoverageMatrix(artefacts=detect_artefacts(submission), clauses=[])
    submission.reqs = walk_catalogue(submission)
    submission.sora = derive_sail(submission.classification, declared_sail="I", igrc=2, arc="A")
    dtfea = run_dtfea(submission)
    keystones = run_keystones(submission)
    submission.gaps = GapAnalysis(
        coverage_gaps=[],
        strength_gaps=[],
        envelope_extrapolations=[],
        dtfea=dtfea,
        keystones=keystones,
        approval_blocked=(
            not dtfea.gate1_pass
            or not dtfea.gate2_pass
            or any(k.fired and k.confidence >= 9 for k in keystones)
            or (submission.sora is not None and not submission.sora.sail_coherent)
        ),
    )


def test_scotland_approves(scotland_submission):
    _evaluate(scotland_submission)
    # PDRA-01 scenario should not trip autonomy/swarm/classification keystones.
    fired = {k.keystone_id for k in scotland_submission.gaps.keystones if k.fired}
    assert not (fired & {"K1", "K2", "K3", "K4", "K5", "K6"}), (
        f"Scotland incorrectly tripped autonomy keystones: {fired}"
    )


def test_sora_refuses_with_keystones(sora_submission):
    _evaluate(sora_submission)
    assert sora_submission.gaps.approval_blocked, (
        "SORA sample should be approval-blocked — over-determined per plan §16.1"
    )
    fired = {k.keystone_id for k in sora_submission.gaps.keystones if k.fired}
    # Plan §9 hackathon demo expects K1, K2, K3, K7, K8 to fire on this case.
    expected_fires = {"K1", "K2", "K3", "K7", "K8"}
    missing = expected_fires - fired
    assert not missing, f"Expected keystones did not fire on SORA sample: {missing}"


def test_sora_sail_is_incoherent(sora_submission):
    _evaluate(sora_submission)
    assert sora_submission.sora is not None
    assert sora_submission.sora.sail_coherent is False, (
        "Declared SAIL I with autonomous-swarm BVLOS GNSS/C2-denied must not be coherent"
    )


def test_readiness_gauges_scotland(scotland_submission):
    _evaluate(scotland_submission)
    gauges = _readiness(scotland_submission)
    # AC3, AC4, AC5, AC7 are N/A for PDRA-01.
    assert gauges.ac["AC3"] == "na"
    assert gauges.ac["AC5"] == "na"
    # No autonomy keystones fired.
    assert gauges.keystones["K3"] is False


def test_readiness_gauges_sora_red(sora_submission):
    _evaluate(sora_submission)
    gauges = _readiness(sora_submission)
    assert gauges.ac["AC8"] == "red"
    assert any(v < 60 for v in gauges.dtfea.values()), "DTFEA must not all clear 60% floor on SORA sample"
