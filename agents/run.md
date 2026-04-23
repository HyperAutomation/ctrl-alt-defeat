workflow/schemas.py — Pydantic contract between executors (type-level inter-agent validation)
tools/keystones.py — K1–K8 as invariant functions; paraphrase-robust across 5 adversarial variants
tools/dtfea_pillars.py — Dana/Trevor/Fiona/Evan/Aria with gate1 (60% floor) + gate2 (no unmitigated critical conf≥9); ML pillars gated on autonomy posture so PDRA-01 isn't spuriously penalised
tools/sora_calculator.py — deterministic JARUS v2.5 GRC×ARC→SAIL with complexity bump; declared<derived ⇒ sail_coherent=False
workflow/applicant_graph.py — MAF WorkflowBuilder graph, fan-out to [artefact ∥ mapper ∥ sora], fan-in via ConcurrentMerge, sequential tail to gap→drafter→binder
agents/binder.py — enforces the traceability invariant (rejects pointers to unknown doc IDs)
app.py — FastAPI with /workspace, /evidence, /review, /events (SSE), /feedback, /readiness
knowledge/req_catalogue.json normalised from the existing CSV, knowledge/dtfea_rubric.yaml from STRESS-Report