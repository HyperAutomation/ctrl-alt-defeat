"""`agents` package — MAF executors.

Executor classes import `agent_framework` at module level. To keep the
pure-Python unit tests (tools, binder, keystones) runnable without
installing the framework, class re-exports here are lazy.
"""
from __future__ import annotations

__all__ = [
    "BaselineConfigurator",
    "IngestExecutor",
    "OperationClassifier",
    "ArtefactDetector",
    "RegulatoryMapper",
    "SORAEvaluator",
    "GapAnalyser",
    "DecisionDrafter",
    "BinderExecutor",
]


def __getattr__(name: str):  # PEP 562 lazy module attrs
    if name == "BaselineConfigurator":
        from .baseline_configurator import BaselineConfigurator
        return BaselineConfigurator
    if name == "IngestExecutor":
        from .ingest import IngestExecutor
        return IngestExecutor
    if name == "OperationClassifier":
        from .operation_classifier import OperationClassifier
        return OperationClassifier
    if name == "ArtefactDetector":
        from .artefact_detector import ArtefactDetector
        return ArtefactDetector
    if name == "RegulatoryMapper":
        from .regulatory_mapper import RegulatoryMapper
        return RegulatoryMapper
    if name == "SORAEvaluator":
        from .sora_evaluator import SORAEvaluator
        return SORAEvaluator
    if name == "GapAnalyser":
        from .gap_analyser import GapAnalyser
        return GapAnalyser
    if name == "DecisionDrafter":
        from .decision_drafter import DecisionDrafter
        return DecisionDrafter
    if name == "BinderExecutor":
        from .binder import BinderExecutor
        return BinderExecutor
    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")
