"""DevUI launcher — visualise + interact with the SORA workflow.

Microsoft Agent Framework ships a DevUI (`agent-framework-devui`) that
renders workflows as graphs and lets you drive them interactively via a
browser. This launcher:

  1. Builds the Applicant-mode workflow (plan §3 topology).
  2. Registers it as a DevUI entity under a friendly name.
  3. If an LLM is configured (OPENAI_API_KEY or AZURE_OPENAI_*), also
     registers individual "inspector" ChatAgents for every pipeline step,
     each pre-loaded with the instruction string from the design. These
     let you chat with a single agent in isolation.
  4. Starts the DevUI server at http://localhost:8090.

Usage:

    cd service
    .venv/bin/python devui.py                   # graph-only (stub LLM)
    OPENAI_API_KEY=sk-... .venv/bin/python devui.py    # full interactive mode

Environment:

    DEVUI_PORT (default 8090)
    DEVUI_HOST (default 127.0.0.1)
    DEVUI_OPEN (default 1)        — open browser on start
    SORA_SERVICE_STUB_LLM=1       — force stub client
"""
from __future__ import annotations

import os
import sys
from pathlib import Path

# Make the service/ directory importable when this file is run directly.
sys.path.insert(0, str(Path(__file__).resolve().parent))

from agent_framework_devui import serve

from workflow.applicant_graph import build_applicant_workflow

# Instruction strings from the design — imported directly so the DevUI always
# shows the same system prompt each executor will use when wired to an LLM.
from agents.baseline_configurator import INSTRUCTIONS as BASELINE_INSTRUCTIONS
from agents.operation_classifier import INSTRUCTIONS as CLASSIFIER_INSTRUCTIONS
from agents.artefact_detector import INSTRUCTIONS as ARTEFACT_INSTRUCTIONS
from agents.regulatory_mapper import INSTRUCTIONS as MAPPER_INSTRUCTIONS
from agents.sora_evaluator import INSTRUCTIONS as SORA_INSTRUCTIONS
from agents.gap_analyser import INSTRUCTIONS as GAP_INSTRUCTIONS
from agents.decision_drafter import INSTRUCTIONS as DRAFTER_INSTRUCTIONS

from tools.clause_search import search_clauses
from tools.keystones import run_keystones  # noqa: F401 -- available for chat tool use
from tools.sora_calculator import derive_sail  # noqa: F401


_INSTRUCTION_MAP = {
    "baseline_configurator": ("Baseline Configurator (plan §20, §24)", BASELINE_INSTRUCTIONS),
    "operation_classifier": ("Operation Classifier (plan §4.2 component 2)", CLASSIFIER_INSTRUCTIONS),
    "artefact_detector": ("Artefact Detector (plan §4.2 component 3)", ARTEFACT_INSTRUCTIONS),
    "regulatory_mapper": ("Regulatory Mapper (plan §4.2 component 4)", MAPPER_INSTRUCTIONS),
    "sora_evaluator": ("SORA Evaluator (plan §4.2 component 5)", SORA_INSTRUCTIONS),
    "gap_analyser": ("Gap & Extrapolation Analyser (plan §4.2 component 6)", GAP_INSTRUCTIONS),
    "decision_drafter": ("Decision Drafter — Applicant mode (plan §21.2)", DRAFTER_INSTRUCTIONS),
}


def _build_inspector_agents() -> list:
    """Build standalone ChatAgent instances for each pipeline step.

    Only runs when a real chat client is configured. These agents share the
    instruction string from the workflow executor and are bound with any
    tools that executor uses — so a DevUI user can prompt the Artefact
    Detector in isolation ("what does a CAP 722A-compliant OSC need?")
    without running the full workflow.
    """
    try:
        from agents._llm import get_chat_client
        from agent_framework import ChatAgent
    except ImportError:
        return []

    if os.getenv("SORA_SERVICE_STUB_LLM") == "1":
        return []
    if not (os.getenv("OPENAI_API_KEY") or os.getenv("AZURE_OPENAI_API_KEY")):
        return []

    client = get_chat_client()
    agents = []

    # Tool bindings per agent. Simple mapping: agents that need clause lookup
    # get `search_clauses`; agents that need SORA math get `derive_sail`.
    from tools.clause_search import search_clauses as _sc
    from tools.sora_calculator import derive_sail as _ds, walk_osos as _wo

    per_agent_tools = {
        "baseline_configurator": [_sc],
        "regulatory_mapper": [_sc],
        "sora_evaluator": [_ds, _wo],
        "artefact_detector": [_sc],
    }

    for executor_id, (label, instructions) in _INSTRUCTION_MAP.items():
        tools = per_agent_tools.get(executor_id, [])
        try:
            agents.append(
                ChatAgent(
                    chat_client=client,
                    name=label,
                    instructions=instructions,
                    tools=tools,
                )
            )
        except Exception as exc:  # pragma: no cover — best-effort registration
            print(f"[devui] skipped inspector for {executor_id}: {exc}", file=sys.stderr)
    return agents


def main() -> None:
    port = int(os.getenv("DEVUI_PORT", "8090"))
    host = os.getenv("DEVUI_HOST", "127.0.0.1")
    auto_open = os.getenv("DEVUI_OPEN", "1") == "1"

    workflow = build_applicant_workflow()
    # Give DevUI something readable in its sidebar.
    try:
        workflow.name = "SORA Approval — Applicant Workflow"  # type: ignore[attr-defined]
    except Exception:
        pass

    entities: list = [workflow]
    entities.extend(_build_inspector_agents())

    print(f"[devui] registered {len(entities)} entities")
    print(f"[devui] starting server at http://{host}:{port}")
    print(f"[devui] point your browser there to visualise the Applicant workflow")
    serve(
        entities=entities,
        port=port,
        host=host,
        auto_open=auto_open,
        cors_origins=["*"],
        ui_enabled=True,
    )


if __name__ == "__main__":
    main()
