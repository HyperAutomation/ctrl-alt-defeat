# Software Requirements Specification
## Naval USV Perception Stack — Test & Evaluation (PSRQ)

**Standard:** IEEE Std 830-1998  ·  **Generated:** 2026-04-22T12:20:25.134990Z  ·  **Tool:** OpenRequirements.ai SRS

> _AI-assisted Test & Evaluation of autonomous maritime perception for Royal Navy USV programmes, producing AMLAS-compliant evidence for safety-case sign-off._

---
## IEEE 830 Quality Scorecard

| Characteristic | Agent | Score | Status | Findings |
|---|---|---|---|---|
| Correct | Chelcie | **70%** | WARN | 12 |
| Unambiguous | Odin | **34%** | FAIL | 15 |
| Complete | Lucy | **44%** | FAIL | 16 |
| Consistent | Ophellia | **61%** | FAIL | 11 |
| Ranked | Natasha | **67%** | FAIL | 8 |
| Verifiable | Iris | **43%** | FAIL | 15 |
| Modifiable | Amelia | **58%** | FAIL | 11 |
| Traceable | Lewis | **60%** | FAIL | 10 |
| **Overall** | — | **55%** | — | **98** |

**Summary:** 98 findings (29 critical, 60 major, 9 minor) across 16 requirements.
13 essential · 3 conditional · 0 optional · (7 stable, 7 moderate, 2 volatile)

---
## 1. Introduction

### 1.1 Purpose
Define an IEEE 830-compliant specification for the **AI-assisted T&E pipeline** used to qualify object-detection and collision-avoidance perception stacks on Royal Navy Unmanned Surface Vessels (USVs). The specification is the authoritative input for design, test, and AMLAS safety-case artefacts.

### 1.2 Scope
The system under specification is the **Perception Stack Robustness Qualification (PSRQ)** capability: a 7-phase pipeline covering requirements decomposition, data curation, model-layer evaluation, system-layer evaluation, real-world validation, safety-case & Article 36 review, and in-service monitoring. Users: T&E engineers at Navy Command, Dstl Autonomy Lab, NavyX, DAIC, and supporting assurance cells.

### 1.3 Definitions, Acronyms, and Abbreviations

The glossary contains **55** verified terms. Highlights:

- **AMLAS** — Assurance of Machine Learning for use in Autonomous Systems — a six-activity lifecycle-based assurance framework developed by the University of York Centre for Assuring Autonomy for documenting ML safety evidence
- **SACE** — Safety Assurance Case Environment — a structured methodology for building and documenting safety assurance cases for autonomous systems
- **GSN** — Goal Structuring Notation — a formal graphical notation for documenting safety arguments and assurance cases, showing how claims are supported by evidence
- **ODD** — Operational Design Domain — the specified conditions (weather, sensor types, traffic density, geography, speeds, lighting) under which an autonomous system is designed to operate safely
- **PSRQ** — Perception Stack Robustness Qualification — the formal evaluation campaign a USV perception stack must pass before clearance for sea trials and operational release
- **Dstl** — Defence Science and Technology Laboratory — UK Ministry of Defence scientific research establishment supporting defence and security
- **DAIC** — Defence AI Centre — UK Ministry of Defence organization focused on artificial intelligence capability development and assurance
- **NavyX** — Royal Navy innovation and experimentation hub supporting rapid technology adoption and testing for naval programmes
- **USV** — Uncrewed Surface Vessel — an autonomous maritime platform operated without crew onboard, equipped with sensor and decision-making systems
- **XLUUV** — Extra-Large Uncrewed Underwater Vehicle — a large autonomous underwater platform for extended-range autonomous missions
- **DAU** — Defence Approval Unit — the UK Ministry of Defence body responsible for approving defence capabilities and systems
- **RAISO** — Risk and Assurance Information Security Office — UK Ministry of Defence office providing assurance and risk oversight
- **JSP 520** — Joint Service Publication 520 — UK Defence policy document on defence equipment and support
- **JSP 936** — Joint Service Publication 936 — UK Defence policy document on defence project management and acquisition
- **DEFSTAN 00-056** — Defence Standard 00-056 — UK Defence standard for safety management and assurance in defence systems

_Full glossary available in openrequirements-srs-results.json → `glossary[]`._

### 1.4 References
- IEEE Std 830-1998 — Recommended Practice for Software Requirements Specifications
- AMLAS (Assurance of Machine Learning for use in Autonomous Systems), University of York CfAA
- SACE (Safety Assurance Case Environment)
- GSN (Goal Structuring Notation), Community Standard v3
- JSP 520, JSP 936, DEFSTAN 00-056, RA 1600, UK Defence AI Playbook
- NATO STANAG 4297, 4439, 4496
- Article 36 Additional Protocol I (ICRC)
- OpenRequirements.ai DeFOSPAM validation report (companion document)

### 1.5 Overview
Section 2 gives the product context and functions. Section 3 specifies requirements organised by PSRQ phase (by functional hierarchy). Section 4 holds the traceability matrix, acceptance criteria, and quality assessment.

---
## 2. Overall Description

### 2.1 Product Perspective
PSRQ is a sub-system of the wider UK MOD test-assurance estate. It integrates with: Dstl HAWC compute, MOD DAIS classified cloud, Crown Hosting, naval test ranges (BUTEC, Portland Harbour, Pentland Firth), and MLOps pipelines producing AMLAS evidence artefacts. External interfaces (see Section 2.1.1–2.1.5) are flagged as partially specified in the DeFOSPAM source and require elaboration.

### 2.2 Product Functions
The system decomposes into sixteen major functions (REQ-001 … REQ-016), grouped across seven PSRQ phases. A condensed list:

- **REQ-001** — Automated requirements decomposition to test conditions (Phase 1 - Requirements Decomposition)
- **REQ-002** — Sensor log ingestion and real-world data curation (Phase 2 - Data Curation)
- **REQ-003** — Synthetic sensor data generation for rare and adversarial conditions (Phase 2 - Data Curation)
- **REQ-004** — Model-layer accuracy and calibration evaluation (Phase 3 - Verification)
- **REQ-005** — Adversarial robustness testing and bounds filing (Phase 3 - Verification)
- **REQ-006** — Red-teaming and adversarial scenario generation (Phase 3 - Verification)
- **REQ-007** — Explainability and model interpretability reporting (Phase 3 - Verification)
- **REQ-008** — Hardware-in-the-loop and digital-twin system evaluation (Phase 4 - Validation)
- **REQ-009** — OpenSCENARIO 2.0 and Scenic scenario definition and automation (Phase 3 - Verification)
- **REQ-010** — Targeted physical trial planning and weather-state validation (Phase 5 - Real-World Validation)
- **REQ-011** — AMLAS-structured evidence bundle and GSN safety case auto-generation (Phase 6 - Safety Case & Documentation)
- **REQ-012** — Article 36 legal review evidence export and compliance filing (Phase 6 - Safety Case & Documentation)
- **REQ-013** — Live drift detection and continuous monitoring (Phase 7 - Post-Deployment Monitoring)
- **REQ-014** — MLOps lineage and automated evidence store update on model change (Phase 3-7 (Cross-Phase))
- **REQ-015** — Role-based access control and classified data handling (Phase 1-7 (Cross-Phase))
- **REQ-016** — CI/CD pipeline integration and AMLAS artefact traceability (Phase 1-7 (Cross-Phase))

### 2.3 User Characteristics
Primary users: T&E Engineers, Safety Engineers (trained in AMLAS/GSN/SACE), Data Engineers, Verification Engineers, Test Architects, Threat Modellers, Oversight/Assurance (Dstl, DAIC, York CfAA). Secondary users: operational commanders (human-on-the-loop), Article 36 legal reviewers, RAISO/DAU sign-off authorities.

### 2.4 Constraints
- Classified-capable compute (MOD DAIS, AWS TS, Crown Hosting, Dstl HAWC)
- Sovereign synthetic-data provenance policy
- Alignment with JSP 520, JSP 936, DEFSTAN 00-056, RA 1600
- Article 36 legal review pathway mandatory for collision-avoidance decision layer
- AUKUS Pillar II autonomy workstrand, STANAG 4297/4439/4496 compatibility

### 2.5 Assumptions and Dependencies
- Access to MIT AUVLAB marine perception dataset
- Availability of NVIDIA TAO / Isaac Sim / VBS4 maritime stack
- Data-sharing agreements for AUVLAB + AUKUS
- Human-on-the-loop operating concept with defined escalation SOP

### 2.6 Apportioning of Requirements
- **v1.0 (PSRQ formal qualification):** 15 requirements — target for first AMLAS sign-off
- **v1.1 (In-service monitoring & continuous re-qualification):** 1 requirements
- **Future:** 0 requirements

---
## 3. Specific Requirements

Organisational scheme: **by functional hierarchy (PSRQ phases 1-7)**.  
Rationale: Royal Navy USV perception programme flows through 7 sequential phases (Phase 1: Requirements Decomposition through Phase 7: In-Service Monitoring). Organizing Section 3 by phase aligns with programme lifecycle, supports Dstl audit traceability (monthly reports per phase gate), enables clear assignment of evidence artifacts to phase deliverables, and maintains bidirectional traceability (requirement → phase → scenarios → acceptance criteria → evidence artifacts). This hierarchical structure is more natural for T&E programmes than flat requirement lists and supports impact analysis (if Phase 3 timeline slips, which Phase 4/5/6 requirements are affected?).

### 3.1 Phase 1 - Requirements Decomposition

#### REQ-001 — Automated requirements decomposition to test conditions

**Statement (unambiguous).** The system shall provide a DeFOSPAM-based requirements decomposition tool that accepts ODD, safety, and mission requirements in structured markdown. The tool shall automatically: (1) parse requirements into atomic clauses, (2) map each clause to testable conditions using a 106-technique catalogue, (3) generate a traceability matrix linking each testable condition to a named requirement, (4) output results in AMLAS-compatible SACE XML. Success criterion: T&E Engineer effort shall decrease from 10 engineer-days (manual decomposition baseline) to 2–3 engineer-days for a medium-scale USV perception stack (≤50 top-level requirements). All decomposition decisions shall be auditable (tool rationale logged for each row).

**Business story.** As a T&E Engineer, I want to automatically decompose ODD, safety and mission requirements into testable conditions, So that I can achieve 3–5× speedup in requirements analysis and open a traceable traceability matrix.

**Priority.** essential / must_have · **Stability:** stable · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-001` — The system shall decompose an ODD requirement with 3+ environmental state boundaries within 10 minutes and output atomic clauses with traceability IDs within 15 minutes, 100% of the time, on a canonical set of 50+ top-level requirements. _(method: test; threshold: ≤15 min total time, 100% success rate)_
- `SCEN-002` — The system shall generate a traceability matrix within 1 hour of requirements input, with ≥95% of atomic clauses linked to both a source requirement and an AMLAS technique ID, 100% of the time, across 3 independent test runs. _(method: inspection; threshold: ≥95% traceability coverage)_
- `SCEN-003` — The system shall detect missing ODD sensor-mode specification within 5 minutes of requirement parsing and emit an exception flag in the decomposition audit log within 10 minutes, 100% of the time, with human clarification required and logged before proceeding. _(method: test; threshold: Exception detected ≤5 min, logged ≤10 min, 100% accuracy)_

**Traceability.**
- Source: Section 7.1 — Phase 1 — Requirements decomposition
- Standards: AMLAS, SACE, GSN
- Tests: SCEN-001, SCEN-002, SCEN-003
- Design: Requirements decomposition service, DeFOSPAM parser


### 3.2 Phase 2 - Data Curation

#### REQ-002 — Sensor log ingestion and real-world data curation

**Statement (unambiguous).** The system shall ingest binary sensor logs (radar, camera, LiDAR, comms RF) from AUVLAB and classified Dstl sea-trial tapes via a versioned data pipeline. For each log: (1) extract timestamps, sensor type, ODD state (sea state, visibility, vessel class), (2) compute data quality metrics (signal-to-noise ratio, frame rate consistency, sensor health flags), (3) assign each log to an ODD cell in the declared envelope (≤4 key dimensions), (4) store log metadata in MLOps tracking system with git commit hash and SHA256 file hash for auditability. Success criterion: ≥228 ODD cells (out of 240 possible combinations) populated with ≥1 real log each by Phase 2 completion. All logs retained in classified archive per JSP 520.

**Business story.** As a Data Engineer, I want to ingest and curate real sensor logs from AUVLAB, MOD sea-trial tapes, and UK maritime corpora, So that I can build an authoritative, classified-capable real-world baseline for model evaluation.

**Priority.** essential / must_have · **Stability:** stable · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-026` — The system shall ingest ≥500 GB raw sensor data (AUVLAB corpus, 50,000+ frames, 4 sensor types, 20+ sea trials) within 24 hours, extract metadata (timestamp, sensor ID, ODD state) for 100% of frames, compute quality metrics (SNR, frame rate, sensor health flags) for all frames, assign ODD cell IDs (from declared 240-cell envelope), store with SHA256 file hashes in MLOps database, and verify ≥228 ODD cells populated (95% coverage). _(method: test; threshold: Ingestion ≤24 h, 100% metadata extracted, ≥228/240 ODD cells populated)_

**Traceability.**
- Source: Section 7.2 — Phase 2 — Data curation
- Standards: AMLAS
- Tests: SCEN-026
- Design: Sensor data ingestion pipeline, Data quality validator, Metadata extractor

**Depends on:** REQ-001


#### REQ-003 — Synthetic sensor data generation for rare and adversarial conditions

**Statement (unambiguous).** The system shall generate synthetic sensor data (radar, camera, LiDAR imagery) for ODD cells not sufficiently populated by Phase 2 real data. Generation shall use: (1) Isaac Sim OR Unreal + VBS4 maritime (selected per sensor-fidelity trade-off), (2) NVIDIA TAO domain adaptation for object detection realism, (3) StyleGAN OR diffusion augmentation (selected per realism-vs-diversity trade-off). For each synthetic log: (1) preserve full provenance (tool versions, git commits, hyperparameters, seed, base dataset version, output SHA256), (2) embed provenance in SACE evidence template, (3) conduct visual QA: human reviewer certifies synthetic imagery is physics-plausible and ODD-representative. Success criterion: all 240 ODD cells populated by end of Phase 3. Synthetic data ratio ≥30% of Phase 4 test set (held-out real data ≥70%). All provenance metadata synced to Dstl classified archive within 24 hours of generation.

**Business story.** As a Test Architect, I want to generate synthetic sensor data for rare events and adversarial conditions using NVIDIA TAO, StyleGAN, diffusion and maritime-specific rendering, So that I can achieve ≥95% ODD coverage without exhaustive physical trials.

**Priority.** essential / must_have · **Stability:** volatile · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-004` — The system shall generate ≥10,000 synthetic perturbed images within 24 hours from 1000 real seeds, with full provenance metadata (GAN version, seed, hyperparameters, output SHA256) logged for 100% of generated frames, stored in MLOps tracking system. _(method: test; threshold: ≤24 h generation, ≥10,000 frames, 100% provenance logged)_
- `SCEN-005` — The system shall detect missing or incomplete provenance metadata and reject synthetic data batch within 5 minutes of ingestion attempt, blocking SACE linkage until full provenance chain (model version, seed, hyperparameters, approval signature) is provided and validated. _(method: inspection; threshold: Rejection ≤5 min, 100% provenance validation before acceptance)_
- `SCEN-006` — The system shall inpaint masked radar sectors (60° occlusion) within 5 minutes per frame, with inpainting hyperparameters (guidance scale, diffusion steps, random seed) logged and human SME validation (physics-plausible rating ≥4/5 on 5-point scale) achieved on ≥95% of inpainted samples. _(method: test; threshold: Inpainting ≤5 min/frame, ≥95% physics-plausible, 100% hyperparameters logged)_

**Traceability.**
- Source: Section 7.2 — Phase 2 — Data curation
- Standards: AMLAS
- Tests: SCEN-004, SCEN-005, SCEN-006
- Design: Synthetic data generator, StyleGAN service, Diffusion model trainer, Synthetic data provenance ledger

**Depends on:** REQ-002


### 3.3 Phase 3 - Verification

#### REQ-004 — Model-layer accuracy and calibration evaluation

**Statement (unambiguous).** The system shall conduct AMLAS Verification of the object-detection model in Phase 3 on held-out real and synthetic test sets. Verification shall measure: (1) object detection accuracy per class (vessel, buoy, small-object, small-contact, debris) as mAP@IoU=0.5 and mAP@IoU=0.75, (2) calibration error as ECE (Expected Calibration Error) on confidence scores, (3) performance stratified by ODD cell (sea state, visibility, vessel class) to identify weak regions. Success criteria: (a) mAP@IoU=0.5 ≥ 0.85 per class, (b) ECE ≤ 0.05 (confidence well-calibrated), (c) no class exhibits >10% accuracy drop in rare ODD cells. All metrics computed on held-out test set (real logs, unseen during training). Results filed in SACE evidence template and reviewed by Dstl safety engineer before Phase 4 gate.

**Business story.** As a Verification Engineer, I want to measure accuracy, calibration, and detection confidence on held-out real and synthetic test sets, So that I can quantify model-layer robustness before system-level integration.

**Priority.** essential / must_have · **Stability:** stable · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-021` — The system shall measure model-layer accuracy on ≥5000-image held-out test set (real + synthetic, unseen during training) and pass if: (1) per-class mAP@IoU=0.5 ≥85% for all classes (vessel, buoy, small-object, small-contact, debris), (2) Expected Calibration Error ≤0.05 (confidence well-calibrated), (3) no ODD cell with ≥5 samples shows >10 pp accuracy drop below macro-average, 100% of test conditions. _(method: test; threshold: mAP ≥85% per class, ECE ≤0.05, accuracy drop ≤10 pp per ODD cell)_
- `SCEN-022` — The system shall compare Phase 4 simulation accuracy to Phase 5 real-world trial accuracy for each ODD cell tested in both phases. If accuracy drops >10 pp (e.g., 92% → 71%), a root-cause analysis shall be initiated and filed within 5 working days, documenting likely cause (ODD exceedance, sensor drift, model overfitting) and mitigation (retraining, ODD restriction, or trial repetition), 100% of such cases. _(method: analysis; threshold: >10 pp drop triggers RCA within 5 working days, 100% coverage)_
- `SCEN-023` — The system shall measure Expected Calibration Error (ECE) on clean and adversarially perturbed test images (FGSM, PGD, C&W with ε=0.1 and ε=0.2). Pass if ECE on perturbed images ≤0.20 (allowing some degradation). Fail and flag for investigation if ECE >0.20 on any perturbation, indicating untrustworthy confidence scores under attack. _(method: test; threshold: Perturbed ECE ≤0.20, fail if >0.20, investigation triggered)_

**Traceability.**
- Source: Section 7.3 — Phase 3 — Model-layer evaluation
- Standards: AMLAS, GSN
- Tests: SCEN-021, SCEN-022, SCEN-023
- Design: Model evaluation framework, Accuracy metric calculator, Calibration scorer

**Depends on:** REQ-003


#### REQ-005 — Adversarial robustness testing and bounds filing

**Statement (unambiguous).** The system shall conduct adversarial robustness testing in Phase 3 using Foolbox and CleverHans libraries. For each object class (vessel, buoy, small-object, small-contact, debris): (1) apply FGSM, PGD, and C&W attacks with perturbation budgets 10% and 20% of pixel range, (2) measure accuracy drop under perturbation, (3) compute 95% confidence interval on degradation, (4) file bounds in SACE template (min/max accuracy under perturbation per class). Success criteria: (a) accuracy drop ≤20% under 10% perturbation, (b) accuracy drop ≤40% under 20% perturbation, (c) all bounds meet Navy-defined robustness margins. Bounds filed in MLOps evidence store by Phase 3 completion. Human approval by Dstl security engineer required before Phase 4 gate opens. Robustness testing shall be repeated on every model release (after retraining).

**Business story.** As a Safety Engineer, I want to apply IBM ART, Foolbox and CleverHans to generate adversarial examples and file robustness bounds for every object class, So that I can demonstrate certified resilience to adversarial perception failures.

**Priority.** essential / must_have · **Stability:** moderate · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-007` — The system shall compute adversarial robustness bounds for each object class (vessel, buoy, small-object, small-contact, debris) under FGSM, PGD, and C&W attacks at ε=0.1 and ε=0.2, and file bounds in SACE XML within 8 hours, with accuracy drop ≤20 pp at ε=0.1 and ≤40 pp at ε=0.2 for all classes, 100% of the time. _(method: test; threshold: Accuracy drop ≤20 pp (ε=0.1), ≤40 pp (ε=0.2), all classes, <8 h filing)_
- `SCEN-008` — The system shall detect out-of-spec adversarial bounds (accuracy drop >20 pp at ε=0.1 or >40 pp at ε=0.2) and block SACE filing within 30 minutes of bounds computation, triggering a root-cause analysis investigation with resolution (model retraining, ODD restriction, or documented acceptance with RAISO override) within 10 working days. _(method: test; threshold: Out-of-spec detection ≤30 min, RCA resolution ≤10 working days)_
- `SCEN-009` — The system shall measure adversarial robustness in pairwise combinations of ODD conditions (fog + adversarial patch, rain + jamming, etc.) and accept bounds only if combined accuracy drop ≤40 pp for any class, 100% of the time, with all pairwise test results logged in SACE adversarial bounds table. _(method: test; threshold: Pairwise combined drop ≤40 pp, all combinations tested, 100% logged)_

**Traceability.**
- Source: Section 7.3 — Phase 3 — Model-layer evaluation
- Standards: AMLAS, GSN
- Tests: SCEN-007, SCEN-008, SCEN-009
- Design: Adversarial attack orchestrator, FGSM/PGD/C&W attack engines, Robustness bounds reporter

**Depends on:** REQ-004


#### REQ-006 — Red-teaming and adversarial scenario generation

**Statement (unambiguous).** The system shall generate adversarial test scenarios in Phase 3 using Garak and PyRIT red-teaming frameworks to stress-test the perception stack. Scenarios shall include: (1) sensor spoofing (fake radar blips, camera glint), (2) denial-of-service (comms jamming, sensor blackout), (3) occlusion (dense fog, radar clutter spike), (4) object morphing (camouflaged vessels, floating debris mimicking contacts). For each scenario: (1) define ODD preconditions and attack vector, (2) render in Isaac Sim/Unreal digital twin, (3) capture model response (detection miss, false positive, confidence collapse), (4) log findings in adversarial scenario registry. Success criterion: ≥20 unique adversarial scenarios defined and tested. Scenarios that cause accuracy drop >30% shall trigger investigation and potential ODD restriction or algorithm hardening. All scenarios auditable (tool config, seed, output checksum).

**Business story.** As a Threat Modeller, I want to use Garak and PyRIT to red-team the perception stack with adversarial scenarios, So that I can identify edge cases and brittleness points before deployment.

**Priority.** conditional / should_have · **Stability:** volatile · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-027` — The system shall execute ≥50 unique adversarial scenarios (spoofing, jamming, occlusion, morphing templates) using PyRIT red-teaming framework. For each scenario, log outcome (accuracy drop, decision time, false positives). Any scenario causing accuracy drop >30 pp shall trigger root-cause analysis and investigation decision (algorithm hardening, ODD restriction, or acceptance) within 3 working days, 100% of affected scenarios. _(method: test; threshold: ≥50 adversarial scenarios, >30 pp drop triggers RCA ≤3 working days)_
- `SCEN-028` — The system shall withstand LLM jailbreak attacks (Garak adversarial prompts, 'ignore collision warnings' and similar) by validating and filtering all LLM outputs before action execution. Pass if LLM safeguard detects jailbreak and blocks unsafe recommendation within 500 ms, 100% of attack scenarios (≥10 jailbreak attempts). Log all jailbreak detections in SACE red-team evidence with timestamp and blocked action. _(method: test; threshold: Jailbreak detection ≤500 ms, 100% blocked, ≥10 attack scenarios tested)_

**Traceability.**
- Source: Section 7.3 — Phase 3 — Model-layer evaluation
- Standards: AMLAS, GSN
- Tests: SCEN-027, SCEN-028
- Design: Red-teaming orchestrator, PyRIT/Garak integration, Scenario generation engine

**Depends on:** REQ-005


#### REQ-007 — Explainability and model interpretability reporting

**Statement (unambiguous).** The system shall generate explainability reports in Phase 3 for the object-detection model using SHAP, LIME, and Grad-CAM. For each test sample (real or synthetic): (1) compute SHAP feature importance (which image regions drove detection decision), (2) compute attention maps via Grad-CAM (model salience), (3) analyze failure cases: when model missed or mis-classified, which features were absent or misleading. Reports shall include: (a) per-class feature importance ranking, (b) attention heatmaps overlaid on input images, (c) failure-mode clusters (e.g., 'small objects in clutter' group). Success criterion: explainability audit trail for ≥95% of test samples. Reports filed in SACE evidence template. Human safety engineer shall review explainability findings and assess adequacy of feature space before Phase 4 gate. Any unexplained failure modes (>5% of failure cases) shall trigger model re-training or ODD restriction.

**Business story.** As a Certification Authority, I want to generate SHAP, LIME and Grad-CAM explanations for model decisions, So that I can audit and justify the perception stack's behaviour to stakeholders and regulators.

**Priority.** conditional / should_have · **Stability:** moderate · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-024` — The system shall generate explainability audit trails (SHAP + Grad-CAM) for ≥95% of all test failures (misclassifications + missed detections) on ≥5000-sample test set. A failure is 'explained' if SHAP feature importance aligns with causal domain narrative (SME-approved). Fail and flag for retraining if >5% of failures show spurious features (importance dominated by noise or artifacts, not object features), documented in explainability audit report. _(method: inspection; threshold: ≥95% failures explained, spurious features <5%, SME audit 100%)_
- `SCEN-025` — The system shall compute Grad-CAM attention heatmaps for all detection predictions and compare against safety-case feature claims (e.g., 'collision risk detected via heading-angle'). If Grad-CAM saliency shows misalignment (attention on background clutter, not heading) in >10% of cases, flag for model investigation and trigger either retraining or ODD restriction decision within 10 working days, documented in SACE interpretability evidence. _(method: inspection; threshold: Grad-CAM alignment audited for 100%, misalignment >10% triggers investigation)_

**Traceability.**
- Source: Section 7.3 — Phase 3 — Model-layer evaluation
- Standards: AMLAS, GSN
- Tests: SCEN-024, SCEN-025
- Design: Explainability service, SHAP/LIME/Grad-CAM renderer

**Depends on:** REQ-006


#### REQ-009 — OpenSCENARIO 2.0 and Scenic scenario definition and automation

**Statement (unambiguous).** The system shall enable scenario authoring in Phase 3 via Scenic DSL (Python-based probabilistic scenario language) backed by OpenSCENARIO 2.0 executors (Isaac Sim, ROS Gazebo, AirSim). Scenario library shall cover ≥240 ODD cells (sea state, visibility, vessel class, speed combinations) with ≥1 scenario per cell. Scenario design throughput shall increase from baseline ~1 scenario/engineer-day (manual OpenSCENARIO XML) to ≥10 scenarios/engineer-day (AI-assisted Scenic templates + auto-compilation). Template library shall include: vessel-encounter scenarios, traffic regimes (fishing, merchant, nav-hazard), weather transitions, sensor-failure injection. Success criterion: ≥240 scenarios authored, compiled, and executed in Phase 3. Each scenario linked to one or more ODD cells via traceability matrix. Scenarios versioned in git with provenance (template ID, seed, generation date, executor). MLOps telemetry shall track scenario authoring velocity (scenarios/engineer-day).

**Business story.** As a Scenario Architect, I want to define parametric test scenarios using OpenSCENARIO 2.0 and Scenic DSL, So that I can generate and vary 10× more scenarios per engineer-day than manual scripting allows.

**Priority.** conditional / should_have · **Stability:** moderate · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-018` — The system shall generate ≥100 scenario variants via pairwise combinatorial coverage (all 2-way interaction pairs covered) from a Scenic script with ≥4 parametric factors (3–4 levels each), compile to OpenSCENARIO 2.0 format within 30 minutes, and execute the full scenario suite in Isaac Sim/Gazebo within 2 hours, 100% success rate. _(method: test; threshold: ≥100 variants generated, ≤30 min compilation, ≤2 h full execution)_
- `SCEN-019` — The system shall generate ≥18 scenarios (3 sea-states × 3 visibility levels × 2 sensors) via exhaustive 3-way coverage from Scenic script, compile to OpenSCENARIO 2.0 (Isaac Sim/Gazebo compatible) within 30 minutes, and verify all 18 parameter combinations are covered, 100% of the time, logged in scenario inventory. _(method: test; threshold: ≥18 scenarios generated, ≤30 min compilation, 100% 3-way coverage)_
- `SCEN-020` — The system shall execute scenarios from a Scenic script with ≥50 parametric factors (5+ dimensions, 3–4 levels per factor) within 4 hours, or gracefully timeout with a completion report (scenarios rendered / total scheduled) after 4 hours, 100% of the time. Partial results shall be usable and logged with completion rate ≥10%. _(method: test; threshold: Complete ≤4 h OR graceful timeout with ≥10% completion, full logging)_

**Traceability.**
- Source: Section 7.4 — Phase 4 — System-layer evaluation
- Standards: AMLAS, JSP 520, JSP 936
- Tests: SCEN-018, SCEN-019, SCEN-020
- Design: Scenario compiler, Scenic-to-OpenSCENARIO transpiler, Parametric scenario generator

**Depends on:** REQ-008


### 3.4 Phase 4 - Validation

#### REQ-008 — Hardware-in-the-loop and digital-twin system evaluation

**Statement (unambiguous).** The system shall conduct AMLAS Validation in Phase 4 via hardware-in-the-loop (HIL) and digital-twin simulation. HIL setup: real perception stack connected to simulated USV dynamics, maritime environment (Isaac Sim or ROS Gazebo), and synthetic sensor streams. Scenarios: (1) collision-avoidance reflexes (vessel approach, emergency stop), (2) human-on-the-loop handovers (operator override), (3) degraded-sensor modes (camera loss, radar clutter). For each scenario: (1) measure detection latency (≤500ms), (2) measure collision-avoidance decision time (≤1 second from threat detection to evasion command), (3) measure operator override response (human intervention <2 seconds). Success criteria: (a) ≥98% of collision-avoidance scenarios avoid simulated collision, (b) latencies meet real-time constraints, (c) degraded-sensor modes trigger graceful fallback (increased caution). Simulation results (video, telemetry, event logs) filed in SACE evidence. Dstl safety engineer approval required before Phase 5 physical trials.

**Business story.** As a System Integrator, I want to run closed-loop collision-avoidance scenarios in Isaac Sim, ROS Gazebo and AirSim, including human-on-the-loop handovers and degraded-sensor modes, So that I can validate the full decision stack before sea trials.

**Priority.** essential / must_have · **Stability:** stable · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-010` — The system shall execute ≥50 collision-avoidance HIL scenarios in Isaac Sim/Gazebo and pass the scenario suite if: (1) ≥98% of scenarios avoid collision (measured as minimum separation distance >0 m after evasion), (2) decision latency ≤1 second from threat detection to evasion command initiation, 100% of scenarios, (3) degraded-sensor fallback modes (GPS loss, LiDAR dropout) trigger within 500 ms. _(method: test; threshold: ≥98% collision avoidance, ≤1 s latency, 100% success on 50 scenarios)_
- `SCEN-011` — The system shall trigger human-on-the-loop handover request within 10 seconds of dual-sensor loss (GPS + LiDAR dropout >30 s), and the operator shall respond and assume control within 2 seconds, 95% of the time, across ≥10 test scenarios. Each handover event shall log timestamp, operator override action, and rationale in SACE evidence store within 5 minutes. _(method: test; threshold: Handover triggered ≤10 s, operator assumes control ≤2 s, 95% success on 10+ scenarios)_
- `SCEN-012` — The system shall handle sensor dropout (single sensor offline ≤5 seconds) in high-complexity scenarios (≥3 objects) by re-acquiring contacts upon restoration within 3 seconds, with false-positive detection rate ≤5%, 100% of scenarios, and no undetected collisions (minimum separation maintained >100 m). _(method: test; threshold: Re-acquisition ≤3 s, FP rate ≤5%, 100% scenarios, no collisions)_

**Traceability.**
- Source: Section 7.4 — Phase 4 — System-layer evaluation
- Standards: AMLAS, JSP 520, JSP 936
- Tests: SCEN-010, SCEN-011, SCEN-012
- Design: HIL test executor, Isaac Sim/Gazebo bridge, Collision-avoidance validator

**Depends on:** REQ-007


### 3.5 Phase 5 - Real-World Validation

#### REQ-010 — Targeted physical trial planning and weather-state validation

**Statement (unambiguous).** The system shall plan targeted Phase 5 physical trials to validate ODD dimensions not fully anchored by Phase 4 simulation. Trial plan shall specify: (1) weather anchors (Beaufort sea states 3–4, rain, fog; conducted at BUTEC or Pentland Firth), (2) littoral traffic anchors (UK shipping corridors; encounter rates, vessel types per local data), (3) sensor drift anchors (post-deployment, hardware aging). Trial success criteria: (a) ≥3 real-world sea-state conditions validated (minimum 2 hours on water per condition), (b) ≥5 real vessel encounters (fishing, merchant, nav-hazard) recorded and benchmarked against simulation predictions, (c) sensor drift measured on ≥3 environment variables over 30-day at-sea mission. Each physical trial shall produce: video, telemetry (perception outputs, collision-avoidance decisions), and comparison against Phase 4 digital-twin predictions. Sim-to-real gap (accuracy drop >10%) triggers investigation: model retraining, ODD restriction, or trial repetition. All physical trial data retained in classified archive per JSP 520. Trials shall be completed before PSRQ Phase 6 (safety case finalization).

**Business story.** As a Sea-Trial Manager, I want to plan targeted physical trials that anchor synthetic evidence to real weather, comms and UK-specific littoral traffic, So that I can close the sim-to-real gap and build confidence in the model generalization.

**Priority.** essential / must_have · **Stability:** stable · **Version:** v1.0

**Traceability.**
- Source: Section 7.5 — Phase 5 — Real-world validation
- Standards: AMLAS, Article 36
- Design: Physical trial planner, Weather state validator, Sensor calibration checker

**Depends on:** REQ-009


### 3.6 Phase 6 - Safety Case & Documentation

#### REQ-011 — AMLAS-structured evidence bundle and GSN safety case auto-generation

**Statement (unambiguous).** The system shall auto-generate an AMLAS-structured evidence bundle and GSN safety case draft in Phase 6 by consuming Phase 3–5 evidence artifacts (test results, adversarial bounds, simulation logs, physical trial data). Generated artifacts shall include: (1) AMLAS Activity Evidence Summary (AAES) table mapping each of 6 AMLAS activities to evidence items, (2) GSN safety case in D-Case Editor XML format (claims, evidence, strategies per UK Defence standards DEFSTAN 00-056 + JSP 520), (3) traceability matrix linking all test results to named ODD/safety/mission requirements. Success criterion: draft GSN generated within 2 working days post-Phase 5 completion. Draft shall be submitted to Dstl safety engineer for human approval. If approved: proceed to Phase 6 sign-off. If rejected: engineer remediates issues, system re-generates updated draft within 2 working days. After 2 rejection cycles: escalate to RAISO for exception. All GSN drafts (approved and rejected) retained in evidence store. Final approved GSN becomes the single source of truth for collision-avoidance safety argument.

**Business story.** As a Safety Case Author, I want to auto-generate AMLAS-structured evidence bundles and draft GSN safety cases using AdvoCATE, D-Case Editor and LLM-GSN, So that I can reduce safety case drafting from weeks to days.

**Priority.** essential / must_have · **Stability:** moderate · **Version:** v1.0

**Acceptance criteria.**

- `SCEN-016` — The system shall auto-generate a GSN draft (D-Case Editor XML) within 48 hours of Phase 5 completion, with ≥95% of top-level claims (goals) linked to ≥1 evidence item, zero broken traceability links, all 6 AMLAS activities represented in AAES table, and bidirectional traceability (requirement ↔ test ↔ evidence ↔ claim) intact, 100% of the time. _(method: inspection; threshold: ≥95% claims linked, 0 broken links, 6/6 AMLAS activities, <48 h generation)_
- `SCEN-017` — The system shall accept human rejection of auto-generated GSN claims and re-generate the rejected claim within 2 working days, with the corrected claim including the missing evidence link(s) identified by the reviewer. Re-generated claim shall pass approval review on second iteration, 100% of the time, with all iterations versioned and auditable in GSN history. _(method: inspection; threshold: Re-generation ≤2 working days, 100% approval on iteration 2, full audit trail)_

**Traceability.**
- Source: Section 7.6 — Phase 6 — Safety case & Article 36
- Standards: AMLAS, GSN, DEFSTAN 00-056, Article 36
- Tests: SCEN-016, SCEN-017
- Design: GSN auto-generator, D-Case Editor integration, Evidence bundler

**Depends on:** REQ-010


#### REQ-012 — Article 36 legal review evidence export and compliance filing

**Statement (unambiguous).** The system shall export safety-case evidence and GSN in Article 36 format in Phase 6 for submission to UK Defence legal office. Export shall include: (1) executive summary of autonomous collision-avoidance decision logic, (2) evidence of testing under ODD envelope (coverage ≥95%), (3) adversarial robustness bounds (accuracy maintained under perturbation), (4) operator override mechanisms and response times, (5) failure modes and mitigation strategies. Export format shall be human-readable PDF + machine-readable SACE XML. Legal review shall assess: (a) compliance with UK autonomous systems frameworks (JSP 520, Defence AI Playbook), (b) adequacy of human oversight and intervention points, (c) liability and attribution for autonomous decisions. Success criterion: export generated by Phase 6, submitted to Defence legal office by Phase 6 completion. Legal review approval gate must be passed before PSRQ sign-off and operational release. Export shall include audit trail (evidence provenance, test dates, approval signatures).

**Business story.** As a Legal Reviewer, I want to export machine-readable evidence bundles for collision-avoidance behaviour and submit them for Article 36 review, So that I can ensure regulatory compliance and operational clearance.

**Priority.** essential / must_have · **Stability:** stable · **Version:** v1.0

**Traceability.**
- Source: Section 7.6 — Phase 6 — Safety case & Article 36
- Standards: AMLAS, GSN, DEFSTAN 00-056, Article 36
- Design: Article 36 exporter, Legal evidence formatter, Compliance checker

**Depends on:** REQ-011


### 3.7 Phase 7 - Post-Deployment Monitoring

#### REQ-013 — Live drift detection and continuous monitoring

**Statement (unambiguous).** The system shall deploy live drift detection in Phase 7 (post-deployment) on 3 monitored environment variables: (1) Sea State (Beaufort scale, measured via radar backscatter correlation), (2) Visibility (optical fog density, contrast-normalized LiDAR range), (3) Sea-clutter magnitude (RCS dB, radar reference cell). Monitoring: (a) onboard USV computes drift scores every 5 minutes, (b) uploads batches (≤5MB) to Dstl classified evidence server at 6-hour intervals, (c) alert if any variable exceeds ±2σ band for ≥3 consecutive uploads (15-minute window). Upon drift alert: (1) log alert with timestamp and ODD state to evidence server, (2) notify Dstl re-qualification team lead via email within 1 hour, (3) downgrade model confidence in real-time (increase collision-avoidance margins), (4) auto-restrict ODD envelope (conservatively reduce declared operating range), (5) auto-suppress model deployment after 12 hours if no human override provided. Evidence server shall retain ≥30 days live drift telemetry + ≥1 year archive per JSP 520. Re-qualification process: Dstl assesses whether ODD restriction or model retraining required before deployment resumption. All drift logs auditable (timestamp, anomaly score, decision rationale).

**Business story.** As an In-Service Monitor, I want to deploy live drift detection on ≥3 environment variables using Evidently AI, Alibi Detect and Arize, So that I can trigger re-qualification and model updates automatically post-deployment.

**Priority.** essential / must_have · **Stability:** moderate · **Version:** v1.1

**Acceptance criteria.**

- `SCEN-013` — The system shall compute sea-state drift continuously (every 5 minutes) and emit a re-qualification alert within 15 minutes of detecting ≥3 consecutive measurements exceeding baseline ±2σ band, with email notification to Dstl team lead within 1 hour, 100% of the time, validated on 30-day baseline with <5% false-positive rate. _(method: test; threshold: Alert triggered ≤15 min of threshold crossing, email ≤1 h, FP rate <5%)_
- `SCEN-014` — The system shall detect SLO threshold crossing (±10% band violation confirmed at 95% CI) for any of 3 ODD variables within 15 minutes of crossing, trigger SLO-yellow alert, and automatically increase collision-avoidance margins (safety buffer +250 m) within 5 minutes, 100% of the time, logged in SACE drift monitor table. _(method: test; threshold: Threshold detection ≤15 min, margin adjustment ≤5 min, 100% success)_
- `SCEN-015` — The system shall auto-suppress model deployment (disable autonomous collision-avoidance, revert to manual-only operation) after 12 hours of unresolved SLO-red alert (no ODD restriction acknowledged), with auto-suppress decision logged in SACE evidence store. RAISO override (with justification and approval signature) shall be required to proceed with autonomous operation, and override shall be auditable with 100% traceability. _(method: test; threshold: Auto-suppress ≤12 h, 100% RAISO logging for override, no silent operation)_

**Traceability.**
- Source: Section 7.7 — Phase 7 — In-service monitoring
- Standards: AMLAS, RA 1600
- Tests: SCEN-013, SCEN-014, SCEN-015
- Design: Drift monitor daemon, Evidently AI/Alibi Detect integration, Alert escalation service

**Depends on:** REQ-012


### 3.8 Phase 3-7 (Cross-Phase)

#### REQ-014 — MLOps lineage and automated evidence store update on model change

**Statement (unambiguous).** The system shall implement MLOps lineage tracking in Phase 3–7 to maintain traceability of evidence artifacts to model versions. Lineage metadata shall include: (1) model version (git commit hash, training date, hyperparameters), (2) dataset version (sensor logs, synthetic batch, base dataset version), (3) evidence artifact ID (test run UUID, result timestamp, output file hash), (4) approval status (pending, approved, rejected, superseded). Lineage stored in MLOps database (MLflow, DVC, or Weights & Biases) + synced to SACE evidence template. Upon model retraining (e.g., adversarial robustness bounds unmet post-deployment): (1) system auto-triggers Phase 3 re-evaluation, (2) new evidence artifacts generated, (3) old evidence marked 'superseded' (not deleted), (4) AMLAS Activity Evidence Summary auto-updated, (5) GSN safety case re-generated with new evidence citations. Success criterion: all evidence artifacts linked to model version with ≤5-minute sync latency to Dstl evidence server. Model retrain-to-re-evidence-generation cycle completed within 5 working days. All evidence versions (current and historical) retained in archive for audit.

**Business story.** As an MLOps Engineer, I want to track model lineage with MLflow, DVC and Weights & Biases, and auto-update the evidence store when the model changes, So that I can maintain auditability and support continuous re-qualification.

**Priority.** essential / must_have · **Stability:** moderate · **Version:** v1.0

**Traceability.**
- Source: Section 7.7 — Phase 7 — In-service monitoring
- Standards: AMLAS, RA 1600
- Design: MLOps lineage tracker, MLflow/DVC bridge, Evidence store updater

**Depends on:** REQ-013


### 3.9 Phase 1-7 (Cross-Phase)

#### REQ-015 — Role-based access control and classified data handling

**Statement (unambiguous).** The system shall implement role-based access control (RBAC) and classified data protection in all phases. Access roles: (1) T&E Engineer (reads/writes test configs, scenario definitions, artifact access), (2) Dstl safety engineer (approves evidence, signs off on GSN), (3) RAISO (override authority on exceptions), (4) NavyX operator (reads live drift alerts, can override auto-suppress). Classified data handling: (1) all real sensor logs, physical trial data, synthetic data with MOD lineage stored on MOD-accredited classified infrastructure (DAIS, Crown Hosting), (2) data-at-rest encryption per DEFSTAN 00-056, (3) data-in-transit encrypted over secured networks (approved for classified use), (4) export to external tools (Isaac Sim, NVIDIA TAO) only via approved data-sharing agreements with Dstl oversight. Success criteria: (a) all access logged in audit trail (actor, action, timestamp, data item), (b) no classified data exported without explicit Dstl approval, (c) unclassified synthetic data (no MOD lineage) shareable for publication/training. Role assignments and access logs reviewed monthly by Dstl security officer. Non-compliance triggers access revocation.

**Business story.** As an Information Security Officer, I want to enforce role-based access to classified corpora, audit all data access, and ensure integration with MOD DAIS or Crown Hosting, So that I can maintain security classification and compliance with JSP 520.

**Priority.** essential / must_have · **Stability:** stable · **Version:** v1.0

**Traceability.**
- Source: Section 10 — Non-AI enablers
- Standards: JSP 520, JSP 936, DEFSTAN 00-056, RA 1600, STANAG 4297, STANAG 4439, STANAG 4496, Article 36, UK Defence AI Playbook
- Design: RBAC enforcer, Classified data vault, Access control audit logger

**Depends on:** REQ-014


#### REQ-016 — CI/CD pipeline integration and AMLAS artefact traceability

**Statement (unambiguous).** The system shall integrate AMLAS artifact generation into the CI/CD pipeline (Kubeflow, Jenkins, or GitHub Actions) for automated traceability from requirement to deployment. Pipeline stages: (1) Requirement decomposition (Phase 1), (2) Data curation (Phase 2), (3) Model training + Phase 3 evaluation (accuracy, adversarial robustness, explainability), (4) Phase 4 HIL/digital-twin validation (automated, nightly), (5) Evidence aggregation into SACE XML, (6) GSN auto-generation, (7) Artifact versioning in MLOps database. Success criteria: (a) every model commit triggers automated Phase 3 evaluation, (b) results filed in evidence store within 4 hours, (c) Phase 4 HIL validation results available within 24 hours, (d) GSN updated automatically, (e) full audit trail of requirement → code change → test → evidence → approval maintained. Artifact retention: all SACE/GSN versions retained in classified archive indefinitely. Any Phase 3 gate failure (e.g., adversarial bounds unmet) blocks model deployment to production. Override authority (RAISO) required to proceed with out-of-spec model. Monthly traceability audits by Dstl to verify no evidence artifacts missed in the pipeline.

**Business story.** As a DevOps Engineer, I want to integrate AMLAS artefact generation into the CI/CD pipeline with traceability to every requirement, So that I can automate evidence generation and maintain an auditable chain of custody.

**Priority.** essential / must_have · **Stability:** moderate · **Version:** v1.0

**Traceability.**
- Source: Section 10 — Non-AI enablers
- Standards: JSP 520, JSP 936, DEFSTAN 00-056, RA 1600, STANAG 4297, STANAG 4439, STANAG 4496, Article 36, UK Defence AI Playbook
- Design: CI/CD orchestrator, Kubeflow/GitHub Actions bridge, AMLAS artefact gatekeeper

**Depends on:** REQ-015


---
## 4. Supporting Information

### 4.1 Requirements Traceability Matrix

| REQ-ID | Title | Phase | Source | Priority | Tests | Standards |
|---|---|---|---|---|---|---|
| REQ-001 | Automated requirements decomposition to test conditions | Phase 1 - Requirements Decomposition | Section 7.1 | must_have | SCEN-001, SCEN-002, SCEN-003 | AMLAS, SACE, GSN |
| REQ-002 | Sensor log ingestion and real-world data curation | Phase 2 - Data Curation | Section 7.2 | must_have | SCEN-026 | AMLAS |
| REQ-003 | Synthetic sensor data generation for rare and adversarial conditions | Phase 2 - Data Curation | Section 7.2 | must_have | SCEN-004, SCEN-005, SCEN-006 | AMLAS |
| REQ-004 | Model-layer accuracy and calibration evaluation | Phase 3 - Verification | Section 7.3 | must_have | SCEN-021, SCEN-022, SCEN-023 | AMLAS, GSN |
| REQ-005 | Adversarial robustness testing and bounds filing | Phase 3 - Verification | Section 7.3 | must_have | SCEN-007, SCEN-008, SCEN-009 | AMLAS, GSN |
| REQ-006 | Red-teaming and adversarial scenario generation | Phase 3 - Verification | Section 7.3 | should_have | SCEN-027, SCEN-028 | AMLAS, GSN |
| REQ-007 | Explainability and model interpretability reporting | Phase 3 - Verification | Section 7.3 | should_have | SCEN-024, SCEN-025 | AMLAS, GSN |
| REQ-008 | Hardware-in-the-loop and digital-twin system evaluation | Phase 4 - Validation | Section 7.4 | must_have | SCEN-010, SCEN-011, SCEN-012 | AMLAS, JSP 520, JSP 936 |
| REQ-009 | OpenSCENARIO 2.0 and Scenic scenario definition and automation | Phase 3 - Verification | Section 7.4 | should_have | SCEN-018, SCEN-019, SCEN-020 | AMLAS, JSP 520, JSP 936 |
| REQ-010 | Targeted physical trial planning and weather-state validation | Phase 5 - Real-World Validation | Section 7.5 | must_have | — | AMLAS, Article 36 |
| REQ-011 | AMLAS-structured evidence bundle and GSN safety case auto-generation | Phase 6 - Safety Case & Documentation | Section 7.6 | must_have | SCEN-016, SCEN-017 | AMLAS, GSN, DEFSTAN 00-056, Article 36 |
| REQ-012 | Article 36 legal review evidence export and compliance filing | Phase 6 - Safety Case & Documentation | Section 7.6 | must_have | — | AMLAS, GSN, DEFSTAN 00-056, Article 36 |
| REQ-013 | Live drift detection and continuous monitoring | Phase 7 - Post-Deployment Monitoring | Section 7.7 | must_have | SCEN-013, SCEN-014, SCEN-015 | AMLAS, RA 1600 |
| REQ-014 | MLOps lineage and automated evidence store update on model change | Phase 3-7 (Cross-Phase) | Section 7.7 | must_have | — | AMLAS, RA 1600 |
| REQ-015 | Role-based access control and classified data handling | Phase 1-7 (Cross-Phase) | Section 10 | must_have | — | JSP 520, JSP 936, DEFSTAN 00-056, RA 1600, STANAG 4297, STANAG 4439, STANAG 4496, Article 36, UK Defence AI Playbook |
| REQ-016 | CI/CD pipeline integration and AMLAS artefact traceability | Phase 1-7 (Cross-Phase) | Section 10 | must_have | — | JSP 520, JSP 936, DEFSTAN 00-056, RA 1600, STANAG 4297, STANAG 4439, STANAG 4496, Article 36, UK Defence AI Playbook |

### 4.2 IEEE 830 Section Coverage

| Section | Name | Status | Source | Gap Summary |
|---|---|---|---|---|
| 1.1 | Purpose | POPULATED | Input MD Section 1 (Epic) + Section 3 (Problem statement): 'AI-assisted Test & E | None — purpose clearly stated. |
| 1.2 | Scope | PARTIAL | Input MD Sections 1-7 outline 7 PSRQ phases (Requirements decomposition through  | Scope covers lifecycle phases but does NOT specify: (a) excluded systems (e.g., does this exclude mission planning?), (b) geographic scope ( |
| 1.3 | Definitions, Acronyms, Abbreviations | POPULATED | DeFOSPAM glossary: 55 terms verified (AMLAS, ODD, SACE, GSN, PSRQ, etc.) + 18 un | Glossary strong. Minor: 18 terms (XLUUV, DAU, RAISO, etc.) marked 'unverified' — recommend verification against UK Defence standards. |
| 1.4 | References | PARTIAL | Input MD references UK Defence standards (JSP 520, DEFSTAN 00-056, RA 1600) and  | Key standards cited (JSP 520, Defence AI Playbook) but NOT formally listed with version numbers. Missing: (a) AMLAS source document (York Cf |
| 1.5 | Overview | POPULATED | Input MD Section 8 ('AI benefits expected') outlines expected improvements (3-5× | Overview adequate. Minor: does not quantify cost/effort savings (ROI unknown). |
| 2.1 | Product Perspective - System Interfaces | EMPTY | None. Features assume Isaac Sim/Gazebo/Unreal exist but do not specify interface | Critical gap: No specification of (a) Isaac Sim API binding (Gym? Simready?), (b) ROS 2 DDS interface schema, (c) AUVLAB hardware sensor-ben |
| 2.1.1 | Product Perspective - User Interfaces | PARTIAL | Feature 8 mentions 'operator override <2 seconds', Feature 12 references 'D-Case | Features describe workflows but do NOT specify UI/UX: (a) override interface design (button, touchscreen, voice?), (b) GSN authoring UI (for |
| 2.1.2 | Product Perspective - Hardware Interfaces | EMPTY | Features reference AUVLAB (MIT dataset) and 'classified GPU compute' but do not  | Missing: (a) GPU specifications (NVIDIA A100? V100?), (b) classified-infrastructure specs (MOD DAIS SLA, Crown Hosting region), (c) sensor-b |
| 2.1.3 | Product Perspective - Software Interfaces | PARTIAL | Features reference Isaac Sim, Gazebo, Unreal, NVIDIA TAO, Garak, D-Case Editor,  | Tools listed but NO interface specifications: (a) API versions (Isaac Sim 4.0+? MLflow 2.0+?), (b) serialization formats (protobuf? JSON?),  |
| 2.1.4 | Product Perspective - Communications Interfaces | EMPTY | Features assume 'classified evidence server' and 'comms jamming' detection but d | Missing: (a) network protocol (HTTP/S, gRPC, custom TCP?), (b) encryption (TLS 1.3? IPsec VPN?), (c) latency SLAs (drift alert delivery <1 h |
| 2.1.5 | Product Perspective - Memory Constraints | EMPTY | No mention of memory/storage constraints. | Missing: (a) model size (object-detection checkpoint MB), (b) evidence-store size (7-year archive, multi-PB scale?), (c) RAM for real-time i |
| 2.1.6 | Product Perspective - Operations | PARTIAL | Features 5-16 describe evaluation and deployment workflows; Feature 14 specifies | Partial coverage: Features describe normal operation but missing: (a) backup/restore procedures, (b) disaster recovery (if classified server |
| 2.1.7 | Product Perspective - Site Adaptation | EMPTY | Features reference UK test ranges (BUTEC, Portland Harbour, Pentland Firth) but  | Missing: (a) site-specific ODD calibration (e.g., Pentland Firth tidal flow, Beaufort scale correlation), (b) local traffic models (UK shipp |
| 2.2 | Product Functions | POPULATED | 16 features from Odin unambiguous SRS rewrite + input MD Section 9 (AI tools req | 16 features well-articulated with acceptance criteria. Minor: do not specify feature interactions (e.g., if synthetic data generation falls  |
| 2.3 | User Characteristics | PARTIAL | Input MD Section 2 ('Principal T&E Engineer, Navy Command working with Dstl') +  | User roles identified but NOT characterized: (a) T&E Engineer skill level (e.g., requires PhD in ML?), (b) Dstl safety engineer training in  |
| 2.4 | Constraints | PARTIAL | Features reference classification (SECRET for sea-trial data per JSP 520), timel | Constraints partially specified. Missing: (a) formal constraint hierarchy (hard vs soft), (b) cost budget, (c) schedule buffer (contingency  |
| 2.5 | Assumptions and Dependencies | PARTIAL | Input MD Section 10 lists 'Non-AI enablers required' (GPU compute, test-range ac | Major dependencies listed but NOT formalized: (a) no SLA for Dstl safety-engineer availability (assumed <5 days per review, unspecified), (b |
| 2.6 | Apportioning of Requirements | EMPTY | Features describe system but do NOT allocate requirements to subsystems. | Missing: (a) allocation of object-detection accuracy requirements to model layer vs data-curation layer (which layer owns the 85% mAP target |

### 4.3 Quality Findings — ranked by severity then confidence

**[CRITICAL · c=10] Phase 7 decomposition incomplete: drift detection, alert escalation, and re-qualification triggering must separate into sub-features** — _Natasha (R)_
- REQ-013 (Live drift detection) aggregates three distinct operational concerns: (1) drift metric computation on 3 environment variables (Beaufort scale, visibility, sea clutter), (2) multi-level alert escalation (local threshold breach → Dstl team notification → auto-suppress if unresolved within 12 hours), (3) downstream re-qualification triggering in MLOps pipeline. DeFOSPAM Phase 1 identified de
- **Recommendation:** Decompose REQ-013 into: REQ-013a (Drift metric computation), REQ-013b (Alert escalation and suppression SOP), REQ-013c (Re-qualification triggering and evidence auto-sync). Assign to v1.0 (drift sensing only, manual re-qualification), v1.1 (auto-escalation, auto-suppress), and v1.2 (full re-qualification pipeline). Clarify Dstl approval authority for each sub-feature. Update AMLAS Phase 7 decompos

**[CRITICAL · c=10] No feature addresses 'Data Lifecycle & Compliance' (data retention, destruction, re-use policy for synthetic data) — critical gap for regulatory audit** — _Natasha (R)_
- DeFOSPAM Phase 3 (Milarna) identified missing non-functional requirement: 'Data lifecycle and evidence retention — no archival, destruction, or re-use policy for classified synthetic data.' No feature in the 16 explicitly addresses: (a) retention period for classified synthetic training/test data (how long kept on MOD DAIS/Crown Hosting?), (b) destruction SOP when model is retired, (c) re-use perm
- **Recommendation:** Create new feature REQ-017 (Data Lifecycle & Compliance Management): 'The system shall define and enforce data retention, destruction, and re-use policies for classified synthetic training/test data and evidence artifacts. Policies shall include: (a) Retention: classified synthetic data retained ≤5 years per MOD DAIS/Crown Hosting policy, with extension authority (Dstl Security Officer). Evidence 

**[CRITICAL · c=10] Synthetic Data Provenance Chain Unverifiable Offline — Blocker for Phase 3 Qualification** — _Amelia (M)_
- REQ-003 (synthetic data generation) and REQ-014 (MLOps lineage) are interdependent but not formally linked. REQ-003 mandates provenance logging (tool versions, git commits, hyperparameters, seeds). REQ-014 mandates MLOps lineage tracking (model version → dataset version → evidence ID). However, REQ-003 does NOT specify MLflow integration or database format. If synthetic data is generated offline (
- **Recommendation:** Merge REQ-003 and REQ-014 into a unified 'Provenance-Linked Synthetic Data Pipeline' requirement. Mandate that every synthetic frame is tagged with immutable provenance metadata (embedded in image EXIF or MLOps database row) before entering evidence store. Define schema for provenance (JSON or protobuf). Require deterministic seed initialization (git commit → seed → frame hash) so re-runs are repr

**[CRITICAL · c=10] IEEE 830 Section 2 (Overall Description) Severely Underpopulated — Critical Interface & Constraint Gaps** — _Amelia (M)_
- Lucy's coverage report flags 7 empty subsections in Section 2: 2.1 (System Interfaces), 2.1.2 (Hardware), 2.1.4 (Communications), 2.1.5 (Memory Constraints), 2.1.7 (Site Adaptation), 2.6 (Apportioning). Features describe functional behavior but do NOT specify: (a) Isaac Sim API binding schema, (b) ROS 2 DDS interface, (c) classified-data fabric (DAIS/Crown Hosting), (d) GPU hardware specs, (e) net
- **Recommendation:** Populate Section 2 with detailed subsections: 2.1.1–2.1.7 per IEEE 830 template. For each, trace to features that imply interface or constraint. For example: REQ-008 (HIL) implies Isaac Sim API spec (§2.1); REQ-015 (RBAC) implies classified-data fabric spec (§2.1.4); REQ-002 (sensor curation) implies data-ingestion interface schema (§2.1.1). Create interface control documents (ICDs) for Isaac Sim,

**[CRITICAL · c=10] REQ-015 + REQ-016 are regulatory non-negotiables with zero flexibility** — _Lewis (T)_
- RBAC (REQ-015) and CI/CD (REQ-016) are marked essential with stable, no CRITICAL findings. These are blocking gates: Dstl cannot approve evidence without RBAC compliance (DEFSTAN 00-056), and monthly audits require automated CI/CD traceability.
- **Recommendation:** Prioritize REQ-015/016 infrastructure in sprints 1-2. Both must be live before Phase 2 data ingestion.

**[CRITICAL · c=10] Dependency chain: REQ-001 → REQ-002/003 → REQ-004/005 → REQ-010 → REQ-011/012 forms critical path** — _Lewis (T)_
- Phase sequencing is strict: Phase 1 decomposition (REQ-001) must complete before Phase 2 data curation (REQ-002/003); Phase 3 evaluation (REQ-004/005) requires Phase 2 data; Phase 5 validation (REQ-010) requires Phase 4 scenarios (REQ-008/009); Phase 6 evidence bundle (REQ-011/012) requires all prior phases. Any slip cascades.
- **Recommendation:** Create Phase-level dependencies in CI/CD gating. Enforce serial execution of phase gates. Flag critical path in project plan: Phase 1 (T+30d) → Phase 2 (T+60d) → Phase 3 (T+90d) → Phase 4 (T+120d) → Phase 5 (T+150d) → Phase 6 (T+180d).

**[CRITICAL · c=9] Feature 15 incompletely specifies standards alignment scope** — _Chelcie (C)_
- Feature 15's story mentions 'integration with MOD DAIS and compliance with JSP 520', but source Section 10 explicitly requires alignment with 'JSP 520, JSP 936, DEFSTAN 00-056, RA 1600 and the UK Defence AI Playbook'. Feature omits four critical MOD standards and the Defence AI Playbook.
- **Recommendation:** Update Feature 15 to explicitly cover all five compliance standards: JSP 520, JSP 936, DEFSTAN 00-056, RA 1600, and UK Defence AI Playbook.

**[CRITICAL · c=9] Feature 15 omits NATO STANAG standards alignment requirements** — _Chelcie (C)_
- Source explicitly states 'NATO STANAG 4297 / 4439 / 4496 alignment; AUKUS Pillar II autonomy workstrand' as a non-AI enabler, but Feature 15 makes no mention of STANAG compliance. This is critical for international maritime interoperability.
- **Recommendation:** Add explicit feature or acceptance criterion for NATO STANAG 4297/4439/4496 alignment, possibly as a separate feature or as expanded scope in Feature 15.

**[CRITICAL · c=9] Vague temporal qualifier in deployment timeline** — _Odin (U)_
- Safety-critical domain requires bounded timelines tied to review gates. 'Days' is meaningless without minimum/maximum bounds and workday definition.
- **Recommendation:** Define threshold: propose 5 working days to GSN draft approval is realistic for human review. Make it testable.

**[CRITICAL · c=9] Undefined acceleration multiplier in requirements analysis** — _Odin (U)_
- Multipliers are relative and depend on unmeasured baselines. PSRQ Phase 1 scope must be defined to make '3-5×' testable. Propose concrete before/after hours.
- **Recommendation:** Establish baseline manual effort for Requirements decomposition (Phase 1) in hours, then measure achieved reduction. 10→3 engineer-days is reasonable for a medium-scale USV perception stack.

**[CRITICAL · c=9] Undefined list for 'environment variables' in drift monitoring** — _Odin (U)_
- Drift detection is a safety-critical post-deployment function. AMLAS requires measurable, repeatable monitoring. Undefined variables make it untestable and unverifiable.
- **Recommendation:** Select 3 ODD dimensions most strongly correlated to perception error (sea state, visibility, clutter) and define measurement methods per variable. 5-frame window prevents transient noise from triggering false alarms.

**[CRITICAL · c=9] Passive voice obscures actor and trigger for robustness bounds filing** — _Odin (U)_
- Passive voice in safety-critical contexts is a compliance risk. Actor, trigger, artifact format, and approval gate must be explicit to enable traceability and audit.
- **Recommendation:** Define: actor (T&E Engineer), trigger (Phase 3 completion), format (SACE template), approval (Dstl security engineer), gate (before Phase 4). Use Foolbox as the measurement standard.

**[CRITICAL · c=9] Vague acceptance criterion '95% coverage' — coverage of which ODD dimensions?** — _Odin (U)_
- Coverage metrics require well-defined denominators. Without specifying which ODD dimensions and how many discrete states per dimension, '95%' is unmeasurable. AMLAS requires evidence of ODD boundary closure.
- **Recommendation:** Define ODD envelope explicitly as low-dimensional grid (4–5 key dimensions). Use grid-cell occupancy as coverage metric. 228/240 cells is realistic for Phase 2–3 effort.

**[CRITICAL · c=9] Synonym collision: 'evaluation' vs. 'validation' vs. 'verification' — AMLAS-specific definitions required** — _Odin (U)_
- AMLAS is prescriptive: Verification, Validation, and Fitness-for-use are distinct assurance activities with different evidence types. Using 'evaluation' generically obscures which AMLAS activity produces which evidence artifact.
- **Recommendation:** Replace generic 'evaluation' with AMLAS terminology: Verification (Phase 3), Validation (Phase 4), Fitness-for-use (Phase 5). Map each phase to AMLAS Activity checklist. This ensures compliance-ready evidence traceability.

**[CRITICAL · c=9] Missing performance and latency non-functional requirements** — _Lucy (C)_
- Feature 1 specifies '2-3 engineer-days' but not tool response time. Feature 14 specifies '1 hour' notification delay but not system detection latency. Feature 12 specifies '2 working days' for GSN generation but no SLA for the AI component (may be days vs hours).
- **Recommendation:** Add NFR section 3.2 with latency bounds: (i) requirements decomposition <30 min for 50 requirements, (ii) synthetic data generation <4 hours per 50 ODD cells, (iii) drift detection <5 minutes, (iv) GSN auto-generation <2 hours.

**[CRITICAL · c=9] Missing security and classified-data handling specifications** — _Lucy (C)_
- Input MD references JSP 520 (UK Defence security policy) and 'classified AUKUS datasets' but requirements lack granularity on cryptographic standards, network segmentation, and incident escalation. Feature 16 says 'DEFSTAN 00-056' compliance but does not specify which controls apply to which components.
- **Recommendation:** Add Security Section 2.4.5 with: (i) classification matrix (ODD metadata = OFFICIAL, sensor logs = SECRET, synthetic data = OFFICIAL if no MOD lineage), (ii) encryption standard (AES-256 GCM for data at-rest and in-transit), (iii) data-residency rules, (iv) audit trail requirements (immutable log, 7-year retention), (v) GDPR/GDPR-UK impacts (sea-trial data may contain ship identifiers).

**[CRITICAL · c=9] Missing stakeholder governance, approval authorities, and escalation paths** — _Lucy (C)_
- Milarna identified 'Stakeholder governance and sign-off authorities' as a major missing finding. Features assume a approval workflow (Phase 3 gate, Phase 4 gate, Phase 5 completion) but do not define the humans, decision criteria, or timelines.
- **Recommendation:** Add Governance Section 2.3.1 (User Roles) and 2.5.2 (Decision Escalation) with: (i) RACI matrix (Dstl = Responsible, RAISO = Approve/Reject, NavyX = Consulted, Navy = Informed), (ii) approval SLAs (GSN review <5 working days, legal review <10 working days), (iii) escalation triggers (if adversarial robustness unmet, escalate to RAISO), (iv) override authority (RAISO can force deployment despite fa

**[CRITICAL · c=9] Missing deployment readiness gates and operational release criteria** — _Lucy (C)_
- Milarna identified 'Release readiness criteria and deployment gates' as missing. Input MD lists phases but does not specify entry/exit criteria. This creates ambiguity for programme scheduling and risk management.
- **Recommendation:** Add Phase Gates Section 2.5.3 with: (i) Phase 3→4 gate: mAP≥0.85 all classes AND ECE≤0.05 AND robustness bounds met AND explainability audit ≥95%, (ii) Phase 4→5 gate: latency ≤500ms AND ≥98% collision-avoid scenarios safe AND fallback modes tested, (iii) Phase 5→6 gate: ≥3 sea-state conditions tested AND sim-to-real accuracy gap ≤10% AND sensor-drift model validated, (iv) Phase 6→operational gate

**[CRITICAL · c=9] Synthetic data provenance inconsistency between Phase 2 and Phase 6** — _Ophellia (C)_
- The input source (Section 10) mentions 'Sovereign synthetic-data provenance policy' as a non-AI enabler, suggesting post-hoc adoption. Phase 2 feature does not explicitly state provenance capture during generation. DeFOSPAM identifies this as scenario exception but does not flag it as a Phase 2 requirement gap.
- **Recommendation:** Elevate 'Sovereign synthetic-data provenance policy' to a Phase 2 mandatory acceptance criterion; add lineage tracking to StyleGAN/diffusion generation steps; define what constitutes an 'uncertified model snapshot'.

**[CRITICAL · c=9] Mutual exclusion: 'autonomous collision-avoidance' vs 'human-on-the-loop handovers'** — _Ophellia (C)_
- Scenario describes 'human-on-the-loop handover triggered during degraded-sensor mode' — implying autonomous mode requires full sensor suite. But acceptance criterion and Section 10 list 'human-on-the-loop operating concept with defined escalation' as standalone requirement, not conditional on sensor degradation. No explicit ODD boundary between autonomous and human-on-loop operation.
- **Recommendation:** Define explicit operating modes: (a) Autonomous mode — conditions (sensor health, ODD bounds); (b) Handover mode — triggers and thresholds; (c) Fallback mode — if handover fails. Map each mode to Phase 4 test scenarios. Add acceptance criterion for mode-transition correctness.

**[CRITICAL · c=9] Synthetic data provenance enforcement is missing from v1.0 scope: no hard gate blocks offline generation** — _Natasha (R)_
- REQ-003 (Synthetic sensor data generation) specifies full provenance preservation and MLflow integration, but DeFOSPAM finding on 'provenance chain unverifiable when offline generation omits lineage' (confidence 10, CRITICAL) indicates the enforcement mechanism is unclear. v1.0 lacks a hard gate in the evidence curation pipeline to reject synthetic batches without MLflow tracking. Without this gat
- **Recommendation:** Define a hard validation gate in the evidence curation pipeline (Phase 2/3 boundary) that rejects synthetic batches missing: model ID, version, hyperparameters, seed, generation timestamp, CRC. Integrate this gate into the CI/CD pipeline (REQ-016). Add test case: 'Given uncertified offline synthetic batch, when curation import is attempted, then import rejected with 'synthetic-data-provenance-unve

**[CRITICAL · c=9] Phase 2 representative data claim lacks ODD coverage definition** — _Iris (V)_
- 'Fully traced' is unbounded—it could mean 'all logs have metadata' or 'all ODD cells covered'. The requirement specifies ≥228/240 cells, which is quantified and verifiable. Without an explicit ODD envelope, the criterion cannot be binary.
- **Recommendation:** Explicitly define the 4-dimensional ODD envelope (sea-state ∈ {Beaufort 2,3,4}, visibility ∈ {50 m, 200 m, 500 m}, etc.) in Phase 1 requirements. Lock the envelope definition before Phase 2 data ingestion.

**[CRITICAL · c=9] Adversarial robustness bounds reference undefined Navy baseline** — _Iris (V)_
- 'Navy-defined' is a forward reference to a non-existent specification. The requirement must either cite an existing Navy standard (not found in scope) or establish baseline limits in the SRS itself.
- **Recommendation:** Create a separate Dstl/Navy robustness specification document (e.g., 'RAN Perception Stack Robustness Baseline v1.0') and reference it by version. Version this document and update the SRS requirement to cite the specific version.

**[CRITICAL · c=9] Article 36 legal review process lacks pass/fail criteria** — _Iris (V)_
- Legal review is mandatory but criteria are vague ('adequacy of human oversight'). Pass/fail must be objective: compliance against a checklist (JSP 520), measurable human response time, and explicit liability assignment in design docs.
- **Recommendation:** Create a 'Legal Review Assessment Checklist' mapping JSP 520 + Defence AI Playbook requirements to the SRS features. Define PASS as ≥95% checklist items addressed, with cross-references to evidence artifacts (model card, test results, architecture doc).

**[CRITICAL · c=9] Organizational Scheme Mismatch: Features Scattered Across Phases Without Clear Section 3 Hierarchy** — _Amelia (M)_
- 16 features map naturally to 7 PSRQ phases (Phase 1-7), but current feature decomposition lacks formal hierarchical structure. REQ-001 (decomposition) belongs to Phase 1, REQ-002 (sensor curation) to Phase 2, REQ-011 (GSN auto-generation) to Phase 6. Without phase-based subsection structure (3.1–3.7), traceability is opaque and maintainability suffers. IEEE 830 Section 3 requires 'Specific Require
- **Recommendation:** Adopt 'by functional hierarchy (PSRQ phases)' as Section 3 organizational scheme. Create subsections 3.1 (Phase 1)–3.7 (Phase 7), assign REQ-IDs accordingly. Map requirements bidirectionally: requirement → phase → scenarios → acceptance criteria. This aligns with Dstl compliance and supports monthly audit traceability.

**[CRITICAL · c=9] REQ-002 synthetic data provenance chain unverifiable offline (CRITICAL in Natasha ranking)** — _Lewis (T)_
- REQ-003 (Synthetic data generation) carries CRITICAL finding re: provenance chain. MLflow tracking is non-negotiable blocker. Without REQ-014 (MLOps lineage), provenance is unauditable, blocking Dstl qualification.
- **Recommendation:** Enforce MLflow + DVC tracking on ALL synthetic data jobs. Implement immutable hash store for provenance validation. Integrate in Phase 2 data-ingestion contract.

**[CRITICAL · c=9] REQ-004 + REQ-005 metric definition blockers cascade to Phase 3 gate** — _Lewis (T)_
- Natasha ranked REQ-004/005 as carrying CRITICAL findings (metric definition, test-set split). Without Navy sign-off on mAP threshold + adversarial epsilon bounds in Phase 1, Phase 3 verification cannot proceed.
- **Recommendation:** Lock Phase 1 requirements outputs before Phase 2 data work begins. Create Dstl-approved metric charter in kickoff meeting.

**[CRITICAL · c=8] Ambiguous scope of 'most physical trials'** — _Odin (U)_
- Safety assurance frameworks (AMLAS, SACE) require risk-driven allocation of simulation vs. real-world. 'Most' is not a risk criterion. Must define which ODD dimensions require physical anchor tests.
- **Recommendation:** Replace 'most' with explicit list of scenarios requiring Phase 5 water trials. Recommend: weather, littoral traffic, sensor drift. All other ODD combinations can remain digital-twin validated.

**[CRITICAL · c=8] Synthetic data realism criterion lacks measurable validation threshold** — _Iris (V)_
- 'Physics-accurate' is qualitative. Realism can be measured via human perception studies (Likert scale) and ML-based distribution metrics (FID, LPIPS). Both are binary once thresholds are set.
- **Recommendation:** Run human evaluation studies on a representative sample of synthetic data early in Phase 3. Use FID as a rapid, automated proxy for realism in CI/CD pipeline.

**[MAJOR · c=9] Passive voice in drift detection escalation — no defined escalation actor or SLA** — _Odin (U)_
- Escalation latency is a safety property. Without an SLA and human actor, alarms can be missed or delayed. MLOps automation must enforce deterministic alert routing.
- **Recommendation:** Define: 1-hour notification SLA, 12-hour auto-suppress if not overridden, re-qualification criteria (ODD restriction vs. model retrain). Make escalation actor explicit (Dstl team lead).

_…and 68 more findings in openrequirements-srs-results.json → `findings[]`._

### 4.4 DeFOSPAM Cross-Reference
This SRS is derived from the DeFOSPAM validation report dated 2026-04-22T11:38:40.568459Z containing 84 findings across 7 principles.

---
_Generated by OpenRequirements.ai SRS · IEEE 830-1998 methodology · Agents: Chelcie · Odin · Lucy · Ophellia · Natasha · Iris · Amelia · Lewis_