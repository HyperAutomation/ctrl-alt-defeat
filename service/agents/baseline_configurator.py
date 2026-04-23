"""Component 0 — Baseline Configurator (plan §20, §24).

Given operation type / airspace / regulator, pull the relevant clause
sub-library. Deterministic; LLM only consulted for fuzzy operator-intent
disambiguation which this hackathon cut doesn't need.
"""
from __future__ import annotations

try:
    from agent_framework import Executor, WorkflowContext, handler  # type: ignore
except ImportError:  # pragma: no cover
    Executor = object  # type: ignore[assignment,misc]
    WorkflowContext = None  # type: ignore[assignment]

    def handler(fn):  # type: ignore[no-redef]
        return fn

from tools.clause_search import ClauseLibrary, _default_library
from workflow.schemas import Submission


# Operation-type → clause-source applicability.
_APPLICABILITY = {
    "bvlos_autonomous_swarm": {
        "CAP 722", "CAP 722A", "JARUS SORA", "MAA RA 1600 series", "CAP 722H",
        "York AMLAS", "CAP 1616",
    },
    "vlos_pdra01": {"CAP 722", "CAP 722A"},
}


INSTRUCTIONS = """\
You are the Baseline Configurator. Given the operator's declared
operation-type / airspace / regulator at workspace creation, your job is to
emit the list of applicable clause sources the rest of the pipeline will
evaluate against.

You are deterministic — no novel reasoning. Consult the clause-source map
and return the narrowest applicable set. If the operator-declared type is
not in the map, return the superset and mark the selection as `uncertain`.
"""


def resolve_applicable_sources(operation_type: str) -> list[str]:
    key = operation_type.lower().replace(" ", "_").replace("-", "_")
    return sorted(_APPLICABILITY.get(key, set(_default_library.all_sources())))


class BaselineConfigurator(Executor):
    def __init__(self) -> None:
        super().__init__("baseline_configurator")

    @handler
    async def configure(self, submission: Submission, ctx: WorkflowContext[Submission]) -> None:
        # Scope: this executor just annotates the workspace context; the
        # applicable-source list is then picked up by the Regulatory Mapper.
        sources = resolve_applicable_sources(submission.operation_type)
        if hasattr(ctx, "set_state"):
            ctx.set_state("applicable_clause_sources", sources)
        await ctx.send_message(submission)
