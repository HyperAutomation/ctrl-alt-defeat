"""Applicant-mode workflow (plan §3 ADOEOR → MAF Workflow topology).

    [submission] -> baseline_configurator   (Analysis)
                 -> ingest                  (Data normalisation)
                 -> operation_classifier    (Decomposition)
                 -> [artefact_detector ∥ regulatory_mapper ∥ sora_evaluator]
                                            (Orchestration: concurrent fan-out)
                 -> gap_analyser            (Execution: DTFEA + K1..K8 fan-in)
                 -> decision_drafter        (Optimisation: Feedback Report)
                 -> binder                  (Recursion: traceability invariant)
                 -> [FeedbackReport out]

The concurrent block uses MAF fan-out/fan-in. Because the three downstream
executors all mutate different fields of the same `Submission`, we funnel
them through a small `ConcurrentMerge` executor that reconciles the three
partial updates before handing the merged `Submission` to the gap analyser.
"""
from __future__ import annotations

from agent_framework import Executor, WorkflowBuilder, WorkflowContext, handler

from agents import (
    ArtefactDetector,
    BaselineConfigurator,
    BinderExecutor,
    DecisionDrafter,
    GapAnalyser,
    IngestExecutor,
    OperationClassifier,
    RegulatoryMapper,
    SORAEvaluator,
)
from workflow.schemas import Submission


class ConcurrentMerge(Executor):
    """Fan-in node for the concurrent [Artefact ∥ Mapper ∥ SORA] block.

    Receives three `Submission` messages (one per upstream branch), merges
    the fields each branch owns into a single `Submission`, and forwards.
    """

    def __init__(self, *, required: int = 3) -> None:
        super().__init__("concurrent_merge")
        self._required = required
        self._seen: dict[str, int] = {}
        self._buffer: dict[str, Submission] = {}

    @handler
    async def merge(self, submission: Submission, ctx: WorkflowContext[Submission]) -> None:
        sid = submission.submission_id
        self._seen[sid] = self._seen.get(sid, 0) + 1
        current = self._buffer.get(sid)
        if current is None:
            self._buffer[sid] = submission
            current = submission
        else:
            if submission.coverage and not current.coverage:
                current.coverage = submission.coverage
            elif submission.coverage and current.coverage:
                if submission.coverage.artefacts and not current.coverage.artefacts:
                    current.coverage.artefacts = submission.coverage.artefacts
                if submission.coverage.clauses and not current.coverage.clauses:
                    current.coverage.clauses = submission.coverage.clauses
            if submission.sora and not current.sora:
                current.sora = submission.sora
            if submission.classification and not current.classification:
                current.classification = submission.classification

        if self._seen[sid] >= self._required:
            merged = self._buffer.pop(sid)
            self._seen.pop(sid, None)
            await ctx.send_message(merged)


def build_applicant_workflow():
    """Compile the applicant-mode workflow graph."""
    baseline = BaselineConfigurator()
    ingest = IngestExecutor()
    classifier = OperationClassifier()
    artefact = ArtefactDetector()
    mapper = RegulatoryMapper()
    sora = SORAEvaluator()
    merge = ConcurrentMerge(required=3)
    gap = GapAnalyser()
    drafter = DecisionDrafter()
    binder = BinderExecutor()

    return (
        WorkflowBuilder(start_executor=baseline)
        .add_edge(baseline, ingest)
        .add_edge(ingest, classifier)
        .add_fan_out_edges(classifier, [artefact, mapper, sora])
        # Three independent edges into the merge — MAF's `add_fan_in_edges`
        # expects the target to accept `list[T]`, but we need the merge to
        # accumulate one `Submission` at a time and track branch arrivals.
        .add_edge(artefact, merge)
        .add_edge(mapper, merge)
        .add_edge(sora, merge)
        .add_edge(merge, gap)
        .add_edge(gap, drafter)
        .add_edge(drafter, binder)
        .build()
    )
