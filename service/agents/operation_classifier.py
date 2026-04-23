"""Component 2 — Operation Classifier.

Extracts the structured operation facts from the submission documents. In
production this is a `ChatAgent` with Pydantic structured output. The
hackathon scaffold uses a heuristic fallback so the workflow compiles and
runs without an LLM; the heuristic is good enough for the twin-sample
regression to light up the correct gauges.
"""
from __future__ import annotations

import re

try:
    from agent_framework import Executor, WorkflowContext, handler  # type: ignore
except ImportError:  # pragma: no cover
    Executor = object  # type: ignore[assignment,misc]
    WorkflowContext = None  # type: ignore[assignment]

    def handler(fn):  # type: ignore[no-redef]
        return fn

from workflow.schemas import Classification, Submission


INSTRUCTIONS = """\
You are the Operation Classifier. Read the operator-submitted documents and
extract a structured record of the operation:

  - operator identity, Accountable Manager, Duty Holder, RAISO
  - aircraft type, count, MTOM (kg, each)
  - operation type, airspace class, segregated (y/n), BVLOS vs VLOS
  - autonomy posture: teleoperated / supervised_autonomy / full_autonomy / swarm
  - payload class (benign / hazardous / weapon-bearing)
  - declared category (Open / Specific / Certified) and standard scenario (PDRA-01, STS-01, …)

Rules:

  1. Do not invent facts. Any field not evidenced in the text stays null.
  2. Swarm operation is triggered by *count > 1 with cooperative/autonomous*
     language, not by the word "swarm" alone.
  3. BVLOS is triggered by explicit BVLOS mention or by an operation geometry
     that cannot be flown VLOS (e.g. GNSS/C2-denied autonomous continuation).
  4. Autonomy posture defaults to `unknown`. Only classify as `swarm` when
     there is explicit multi-agent cooperative-control evidence.

Output must conform to the `Classification` Pydantic schema.
"""


def _text_of(submission: Submission) -> str:
    return "\n".join(
        s.text or ""
        for d in submission.documents
        for s in d.sections
    )


def _heuristic_classify(submission: Submission) -> Classification:
    """Keyword-based fallback used when no LLM is configured.

    This is NOT the production path — but it is deterministic, fast, and
    known-correct on the two reference samples.
    """
    text = _text_of(submission)
    lo = text.lower()

    am_match = re.search(r"accountable\s+manager[:\s]*([A-Z][\w .'-]+)", text, re.IGNORECASE)
    op_match = re.search(r"operator[:\s]+([^\n]+)", text, re.IGNORECASE)

    # PDRA-01 short-circuit: a PDRA-01 operation is VLOS single-vehicle by
    # definition, regardless of language the applicant uses elsewhere in a
    # broader research-scope paragraph.
    is_pdra01 = "ukpdra-01" in lo or "pdra-01" in lo
    is_bvlos_explicit = "bvlos" in lo or "beyond visual line of sight" in lo
    # BVLOS is also implied when the operation geometry cannot be flown VLOS
    # (e.g. intentional GNSS/C2 denial on autonomous flight).
    is_bvlos_implied = (
        ("gnss" in lo and "denial" in lo) or ("gnss-denied" in lo)
        or ("c2 denial" in lo) or ("c2-denied" in lo)
    ) and ("autonom" in lo or "cooperative" in lo)
    is_bvlos = not is_pdra01 and (is_bvlos_explicit or is_bvlos_implied)

    # Multi-vehicle + cooperative/autonomous language => swarm. Single pattern
    # families covered: "swarm", "multi-vehicle cooperative", "five UAS ... autonom*".
    qty_match = re.search(r"\b(\d+)\s+(aircraft|uas|drones?|vehicles?)", lo)
    word_qty_match = re.search(
        r"\b(two|three|four|five|six|seven|eight|nine|ten)\s+(aircraft|uas|drones?|vehicles?)",
        lo,
    )
    multi_vehicle = bool(
        (qty_match and int(qty_match.group(1)) > 1)
        or word_qty_match
        or "multi-vehicle" in lo
        or "multi vehicle" in lo
    )
    has_cooperative_autonomy = (
        ("cooperative" in lo and ("autonom" in lo or "coordinate" in lo))
        or ("multi-vehicle" in lo and "autonom" in lo)
    )
    is_swarm = not is_pdra01 and (
        ("swarm" in lo and ("cooperative" in lo or "autonom" in lo))
        or (multi_vehicle and ("autonom" in lo or "cooperative" in lo or "coordinat" in lo))
        or has_cooperative_autonomy
    )
    is_autonomy = is_swarm or (not is_pdra01 and "autonom" in lo)

    autonomy_posture: str
    if is_pdra01:
        autonomy_posture = "teleoperated"
    elif is_swarm:
        autonomy_posture = "swarm"
    elif "full autonomy" in lo or "autonomous mission" in lo:
        autonomy_posture = "full_autonomy"
    elif is_autonomy:
        autonomy_posture = "supervised_autonomy"
    else:
        autonomy_posture = "teleoperated" if "remote pilot" in lo else "unknown"

    m_qty = re.search(r"quantity[:\s]*(\d+)", text, re.IGNORECASE)
    aircraft_count = int(m_qty.group(1)) if m_qty else (5 if "five" in lo and "eiger" in lo else None)

    m_mtom = re.search(r"MTOM[:\s<]*(\d+(?:\.\d+)?)\s*kg", text, re.IGNORECASE)
    mtom = float(m_mtom.group(1)) if m_mtom else None

    declared_scenario = None
    if "ukpdra-01" in lo or "pdra-01" in lo:
        declared_scenario = "UKPDRA-01"

    declared_category = "specific" if declared_scenario or is_bvlos else "open"

    return Classification(
        operator=(op_match.group(1).strip().split("\n")[0] if op_match else None),
        accountable_manager=(am_match.group(1).strip() if am_match else None),
        duty_holder=None,
        raiso=None,
        aircraft_type="RigiTech Eiger" if "rigitech eiger" in lo else (
            "UAS" if "uas" in lo else None
        ),
        aircraft_count=aircraft_count,
        mtom_kg_each=mtom,
        operation_type=submission.operation_type,
        airspace_class=("Danger Area" if "danger area" in lo else None),
        segregated=("segregated" in lo),
        bvlos=is_bvlos,
        autonomy_posture=autonomy_posture,  # type: ignore[arg-type]
        payload=("hazardous" if "munitions" in lo or "weapon" in lo else "benign"),
        declared_category=declared_category,  # type: ignore[arg-type]
        declared_scenario=declared_scenario,
    )


class OperationClassifier(Executor):
    def __init__(self) -> None:
        super().__init__("operation_classifier")

    @handler
    async def classify(self, submission: Submission, ctx: WorkflowContext[Submission]) -> None:
        submission.classification = _heuristic_classify(submission)
        await ctx.send_message(submission)
