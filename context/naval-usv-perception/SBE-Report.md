# Specification by Example — Living Documentation Report
*Generated 2026-04-22 13:48 — OpenRequirements.AI*

## Executive Summary

- **Source**: Royal Navy USV Perception T&E (DeFOSPAM output)
- **Overall SBE Maturity Score**: **61%**
- **Total findings**: 83  (critical 16 · major 54 · minor 13)
- **Business goals mapped**: 16
- **Ubiquitous-language terms**: 30  (collaboration workshops: 16)
- **Key examples**: 40  (refined specs: 28)
- **Gherkin feature files**: 7  (43 scenarios, 25 traceability entries)
- **Validation suites**: smoke/regression/full  —  assigned: 50
- **Living-docs tooling**: MkDocs + Pickles + Custom Gherkin-to-HTML publisher

## SBE Scorecard (per pattern)

| Pattern | Analyst | Score | Findings | Critical | Major | Minor |
|---|---|---|---|---|---|---|
| **G — Goals** | Grace | **74%** | 12 | 0 | 7 | 5 |
| **S — Specify** | Chris | **49%** | 12 | 5 | 7 | 0 |
| **I — Illustrate** | Isabel | **68%** | 10 | 2 | 6 | 2 |
| **R — Refine** | Rex | **58%** | 15 | 1 | 11 | 3 |
| **A — Automate** | angie | **58%** | 12 | 2 | 10 | 0 |
| **V — Validate** | Victoria | **46%** | 12 | 6 | 6 | 0 |
| **L — Living Docs** | Laveena | **76%** | 10 | 0 | 7 | 3 |

## G — Business Goals (Grace)

| REQ | Feature | Business goal | Beneficiary | Success metric |
|---|---|---|---|---|
| REQ-001 | Automated requirements decomposition to test conditions | Reduce requirements analysis effort by 3-5× and establish traceable ODD-to-test-condition mapping | T&E Engineer | Requirements decomposition completes in <2 engineer-days per system release (baseline: 5-10 days); traceability matrix a |
| REQ-002 | Sensor log ingestion and real-world data curation | Establish authoritative, classified-capable real-world baseline for model evaluation | Data Engineer, Verification Engineer | >500 hours of labelled real sensor logs ingested and catalogued per PSRQ cycle; data provenance and classification metad |
| REQ-003 | Synthetic sensor data generation for rare and adversarial conditions | Achieve ≥95% ODD coverage without exhaustive physical trials using physics-plausible synthetic augmentation | Test Architect, Verification Engineer | ODD coverage reaches ≥95%; synthetic-to-real gap in model accuracy <3% on held-out validation; all synthetic data tracea |
| REQ-004 | Model-layer accuracy and calibration evaluation | Quantify model-layer robustness before system-level integration using held-out and synthetic test sets | Verification Engineer, Safety Engineer | Model evaluation report generated per release with accuracy, calibration (ECE), confidence histograms and per-class conf |
| REQ-005 | Adversarial robustness testing and bounds filing | Demonstrate certified resilience to adversarial perception failures with filed robustness bounds for every object class | Safety Engineer, Certification Authority | Robustness bounds (L-infinity ε, robust accuracy, interaction terms) filed and linked to AMLAS activity 3.2 for ≥95% of  |
| REQ-006 | Red-teaming and adversarial scenario generation | Identify edge cases and brittleness points before deployment through systematic red-teaming | Threat Modeller, Safety Engineer | Red-team report identifies ≥10 credible edge cases per model release; brittleness points logged with remediation or ODD  |
| REQ-007 | Explainability and model interpretability reporting | Enable audit and regulatory justification of perception-stack decisions to stakeholders and regulators | Certification Authority, Legal Reviewer | Explainability report generated per release with SHAP values, LIME explanations, and Grad-CAM heatmaps for ≥50 represent |
| REQ-008 | Hardware-in-the-loop and digital-twin system evaluation | Validate full decision stack (perception + collision-avoidance + human handover) before sea trials via closed-loop simulation | System Integrator, Sea-Trial Manager | HIL suite of ≥50 scenarios executes with zero collisions, emergency stops or unexpected human overrides in nominal condi |
| REQ-009 | OpenSCENARIO 2.0 and Scenic scenario definition and automation | Generate 10× more test scenarios per engineer-day via parametric scenario design and combinatorial coverage | Scenario Architect, Test Architect | Scenario count per release ≥100; pairwise coverage of sea-state × visibility × sensor-mode achieved with <20 core scenar |
| REQ-010 | Targeted physical trial planning and weather-state validation | Close sim-to-real gap by anchoring synthetic evidence to real weather, comms and littoral traffic | Sea-Trial Manager, Verification Engineer | ≥3 targeted sea trials executed; model accuracy on real-world ODD-boundary conditions within 5% of synthetic validation; |
| REQ-011 | AMLAS-structured evidence bundle and GSN safety case auto-generation | Reduce safety case drafting from weeks to days via auto-generation of AMLAS-structured evidence bundles and GSN claims | Safety Case Author, Safety Engineer | GSN safety case draft generated in <1 engineer-day per system release (baseline: 3-7 days); ≥95% of sub-goals supported  |
| REQ-012 | Article 36 legal review evidence export and compliance filing | Enable Article 36 legal review of collision-avoidance behaviour via machine-readable, auditable evidence export | Legal Reviewer, Certification Authority | Article 36 evidence bundle exported per release; contains collision-avoidance perception bounds, decision-layer traceabi |
| REQ-013 | Live drift detection and continuous monitoring | Trigger automatic re-qualification and model updates post-deployment by detecting drift on ≥3 environment variables | In-Service Monitor, Safety Engineer | Drift monitor live within 2 weeks post-deployment; detects SLO breach (±10% from baseline) with <5% false-alarm rate; au |
| REQ-014 | MLOps lineage and automated evidence store update on model change | Maintain auditability and support continuous re-qualification by auto-updating evidence store on model lineage changes | MLOps Engineer, Safety Engineer | Model lineage tracked end-to-end with 100% traceability; evidence store automatically updated within 1 hour of model pro |
| REQ-015 | Role-based access control and classified data handling | Maintain security classification and regulatory compliance (JSP 520) while enabling collaborative T&E workflows | Information Security Officer, Dstl Autonomy Lab | RBAC policies deployed for ≥3 classified-data tiers (Secret, Confidential, Unclassified); 100% of data access audited; n |
| REQ-016 | CI/CD pipeline integration and AMLAS artefact traceability | Automate evidence generation and maintain auditable chain of custody via CI/CD integration of AMLAS artefact pipeline | DevOps Engineer, Safety Engineer | CI/CD pipeline generates AMLAS artefacts on every model commit; traceability chain (requirement → test case → artefact → |

## S — Ubiquitous Language (Chris)

30 agreed terms; 16 workshop recommendations.

| Term | Status | Agreed definition |
|---|---|---|
| **AMLAS** | agreed | Six-activity lifecycle-based assurance framework for documenting ML safety evidence and qualifying autonomous systems. |
| **ODD** | proposed | Explicitly declared set of conditions (weather, sensor types, traffic density, geography, speeds, lighting) under which the USV perception stack is qualified to operate safely. Mus |
| **PSRQ** | agreed | Formal seven-phase evaluation campaign (requirements decomposition, data curation, model-layer evaluation, system-layer evaluation, physical validation, safety case, in-service mon |
| **GSN** | agreed | Formal graphical notation for documenting safety arguments: claims are supported by evidence and sub-claims form a tree structure. Acceptance deliverable for AMLAS compliance in th |
| **Article 36** | agreed | Mandatory UK Defence legal review ensuring collision-avoidance decision logic complies with international humanitarian law and weapons law. Triggers blocking gate for operational r |
| **coverage** | proposed | Quantified measure of test case exercise across declared ODD states. Acceptance metric: >= 95% of partitioned ODD space exercised in synthetic + real data combined. Partition metho |
| **adversarial robustness** | proposed | Quantified bounds on model degradation under adversarial perturbations. For each object class (vehicle, buoy, etc.) and sensor modality, specify certified ε (L∞ or perceptual metri |
| **drift detection** | proposed | Automated production monitoring of >= 3 declared environment variables (sea state, visibility, illumination, etc.) for statistical divergence from training distribution. Triggers c |
| **declared ODD states** | proposed | Explicit enumeration or parameterization of ODD (finite set or continuous ranges) that partitions the problem space into testable, measurable conditions. Input to Phase 1, success  |
| **environment variables** | proposed | Measurable parameters (sea state, wind, visibility, illumination, sensor gain/noise, traffic density) that define ODD conditions and are monitored for drift in production. Subset d |
| **synthetic data** | agreed | Artificially generated sensor data (images, LiDAR, radar, IMU) from simulators (Isaac Sim, VBS4, CARLA-maritime) or generative models (StyleGAN, diffusion) augmenting real AUVLAB/M |
| **rare events** | proposed | Low-frequency ODD conditions (e.g., heavy fog, maritime piracy, sensor failure) requiring synthetic augmentation to meet coverage targets. Frequency threshold and augmentation rati |
| **digital twin** | agreed | Physics-accurate computational model of USV perception and collision-avoidance stack used for closed-loop scenario testing. Replaces majority of Phase 5 physical trials where synth |
| **HIL** | agreed | Testing methodology combining simulated environment with real or semi-real perception hardware/firmware. Phase 4 digital-twin scenarios run over HSI hardware under controlled condi |
| **explainability** | agreed | Capability to interpret and understand why the perception stack makes classification and collision-avoidance decisions. Required for safety case claims and regulatory approval. Tec |
| **safety case** | agreed | Structured argument and supporting evidence demonstrating that USV perception is acceptably safe under declared ODD, using GSN notation. Delivered as GSN diagram + traceability mat |
| **evidence bundle** | proposed | Comprehensive AMLAS-compliant deliverable including: safety case (GSN), traceability matrix, test results, adversarial robustness bounds, drift-monitor configuration, Article 36 le |
| **traceability matrix** | agreed | Bidirectional mapping from requirements (ODD, safety, mission acceptance criteria) to test cases, evidence artefacts, GSN claims, and acceptance sign-off. Maintained in version con |
| **MLOps** | agreed | Automated practices for model versioning, training pipeline, testing, deployment, and post-deployment monitoring. Integrates AMLAS artefact pipeline (lineage, evidence store sync o |
| **CI/CD** | agreed | Automated pipeline: code commit triggers model training, evaluation tests, evidence bundle generation, traceability validation, and artefact versioning. Release gate enforces safet |
| **Dstl** | verified | UK Ministry of Defence scientific research establishment providing autonomy assurance expertise, infrastructure (Autonomy Lab), and classified data access for Royal Navy USV T&E pr |
| **DAIC** | verified | UK Ministry of Defence organisation for AI capability development and assurance. Co-leads AI Test Assurance Cell with York CfAA and Dstl; provides governance oversight and AMLAS co |
| **York CfAA** | verified | Academic research centre developing AMLAS assurance methodology. Provides framework governance, training, and independent assurance cell participation for Royal Navy programmes. |
| **SACE** | agreed | Structured methodology for building and documenting safety assurance cases. Harmonises with AMLAS six-activity framework; GSN is the notation; this tool is the process framework. |
| **human-on-the-loop handovers** | proposed | Scenario where USV autonomously detects operational limit (e.g., ODD boundary, high uncertainty) and safely transitions control to remote human operator within defined latency and  |
| … | | _(5 more terms in full glossary)_ |

## I — Key Examples (Isabel)

40 concrete, maritime-domain examples illustrating 14 features.

| ID | Feature | Type | Given → When → Then |
|---|---|---|---|
| EX-001 | Automated requirements decomposition to  | boundary | Given ODD window: visibility 50–500 m (Beaufort 2–4, daylight only) · When decomposition engine processes visibility boundaries · Then engine extracts 3 testable atoms: visibility {50, 200, 500} m linked to REQ-001 |
| EX-002 | Automated requirements decomposition to  | happy_path | Given ODD and safety requirements fully specified: 16 ODD atoms across visibility, sea-state, illumination · When decomposition pipeline processes SRS document · Then traceability matrix generated: 100% ODD states mapped to test condition atoms |
| EX-003 | Automated requirements decomposition to  | error | Given ODD silent on LiDAR vs. radar vs. fused sensor selection · When decomposition engine attempts to partition sensor-mode variants · Then pipeline raises flag: 'incomplete sensor-mode coverage detected' |
| EX-004 | Synthetic sensor data generation for rar | happy_path | Given 1000 real AUVLAB visual frames: merchant vessels, RIBs, buoys in daylight, sea state 3 · When StyleGAN applies 10× augmentation with fog (visibility 200 m), rain, night (illumination <50 lux) · Then 10,000 synthetic frames generated with provenance lineage preserved |
| EX-005 | Synthetic sensor data generation for rar | error | Given 5000 synthetic frames generated offline from uncertified model snapshot (v1.2-beta, no audit log) · When evidence curator imports batch into qualification dataset · Then pipeline rejects batch: 'synthetic-data-provenance-unverified' |
| EX-006 | Synthetic sensor data generation for rar | edge_case | Given real Hensoldt Sharpeye radar frame: 60° antenna null, vessel target at 85° bearing (occluded) · When diffusion model inpaints occluded sector preserving Doppler consistency · Then inpainted sector maintains range-Doppler coherence with surrounding pixels |
| EX-007 | Adversarial robustness testing and bound | happy_path | Given detection model on merchant vessel class (>50m): 94% clean accuracy on 500-image test set · When IBM ART applies L-infinity perturbation ε=8/255 (adversarial patch ~2% pixel budget) · Then robust accuracy measured 87%; robustness certificate filed linking to AMLAS activity 3.2 |
| EX-008 | Adversarial robustness testing and bound | error | Given small-boat detection model (<5 m RIBs, fishing vessels): 78% clean accuracy · When IBM ART applies L-infinity ε=8/255 under realistic maritime perturbations (spray, hull reflection) · Then robust accuracy measured 62%, below SIL-2 safety threshold (≥75%) |
| EX-009 | Adversarial robustness testing and bound | edge_case | Given small-craft model: 72% robust vs. fog alone (visibility 200m), 81% vs. 50-pixel adversarial patch alone · When red-teamer applies simultaneous fog + patch (white square on superstructure, 50×50 px @ 255 brightness) · Then measured robust accuracy 58% (non-linear degradation: 72% × 81% = 58.3% expected, interaction term observed) |
| EX-010 | Hardware-in-the-loop and digital-twin sy | happy_path | Given collision-avoidance stack in Isaac Sim HIL: Velodyne VLP-16 LiDAR + FLIR Boson IR simulated feedback · When system integrator executes 50 scripted encounter scenarios (head-on, crossing, overtake, mixed traffic) · Then all 50 scenarios complete: zero collisions, zero emergency stops, zero unexpected human overrides |
| EX-011 | Hardware-in-the-loop and digital-twin sy | error | Given HIL scenario: GPS signal loss + LiDAR dropout simultaneously, visual + radar only available · When USV autonomy stack detects confidence falling below handover threshold (70%) · Then safe-state transition fires: speed reduced to 2 knots, human-control alert raised |
| EX-012 | Hardware-in-the-loop and digital-twin sy | edge_case | Given 3-vessel encounter (crossing traffic + stationary buoy at BUTEC range), radar signal lost for 2 seconds · When radar dropout occurs during 60–65 s critical window (closest approach phase) · Then collision-avoidance algorithm reverts to visual + IR detection; safe separation maintained (CPA 52 m) |
| EX-013 | Live drift detection and continuous moni | happy_path | Given live deployment at Portland Harbour: Beaufort scale inferred from radar spectral moments; training envelope Beaufort 2–4 · When observed sea state drifts from Beaufort 3.2 (baseline) to Beaufort 5.1 for >1 hour · Then Kolmogorov–Smirnov test computes p-value < 0.05; drift alert issued |
| EX-014 | Live drift detection and continuous moni | boundary | Given deployment monitoring visibility (SLO ±10% from baseline 300 m), measured mean 310 m at 95% CI boundary · When drift detector evaluates visibility distribution change · Then SLO-yellow alert issued: marginal breach at confidence boundary |
| EX-015 | Live drift detection and continuous moni | error | Given drift monitor issued SLO-red alert: sea state measured Beaufort 5 (ODD limit: Beaufort 4) · When on-watch engineer acknowledges alert but continues USV operation for 45 minutes without retrain/rollback · Then system logs human override; Article 36 compliance exception raised |
| EX-016 | AMLAS-structured evidence bundle and GSN | happy_path | Given complete AMLAS activities evidence: Phase 1 (REQ-001), Phase 2 (REQ-002, REQ-003), Phase 3 (REQ-004, REQ-005, REQ-006, R · When safety case author invokes AdvoCATE LLM-GSN auto-generation · Then draft GSN tree generated: 1 top-level safety goal → 6 AMLAS activity claims → 28 sub-goals |
| EX-017 | AMLAS-structured evidence bundle and GSN | error | Given auto-generated claim: 'Model robust under fog (activity 3.2)' lacks collision-avoidance system context · When safety case author (human) reviews claim and finds no link to Phase 4 HIL outcomes · Then human rejects claim: 'Model robustness ≠ system-level avoidance under fog' |
| EX-018 | OpenSCENARIO 2.0 and Scenic scenario def | happy_path | Given Scenic script: vessel-distance ∈ {400m, 800m, 1200m}, approach-angle ∈ {45°, 90°, 135°, 180°}, sea-state ∈ {Beaufort 2,3 · When scenario architect invokes pairwise (2-way) coverage generation · Then tool generates 15 minimal scenario variants covering all sea-state–visibility–sensor pairs |
| EX-019 | OpenSCENARIO 2.0 and Scenic scenario def | data_driven | Given Scenic defines sea-state ∈ {Beaufort 2,3,4}, visibility ∈ {50m, 200m, 500m}, sensor ∈ {radar, lidar, visual_fused} · When scenario generator applies pairwise (2-factor) coverage design-of-experiments · Then 9 minimum scenarios generated, each covering unique 2-way factor pairs |
| EX-020 | OpenSCENARIO 2.0 and Scenic scenario def | boundary | Given Scenic script with 50 parameters: wind_direction (8 values), wind_speed (4), sea_state (5), visibility (4), illumination · When scenario generator attempts combinatorial expansion (full 2^50 factorial) · Then generator warns: 'combinatorial explosion detected: 1.1E+15 variants' |
| … | | | _(20 more examples)_ |

## R — Refined Specifications (Rex)

28 specifications stripped of implementation detail and realigned to domain language.

| ID | Feature | Passes quality? | Changes |
|---|---|---|---|
| REF-001 | Automated requirements decomposition to  | 6/6 | Applied ubiquitous language to Then |
| REF-002 | Automated requirements decomposition to  | 6/6 | Applied ubiquitous language to When |
| REF-003 | Automated requirements decomposition to  | 6/6 | Applied ubiquitous language to Then |
| REF-004 | Synthetic sensor data generation for rar | 6/6 | Removed tool-specific names from Given clause |
| REF-005 | Synthetic sensor data generation for rar | 6/6 | Applied ubiquitous language to Then |
| REF-006 | Synthetic sensor data generation for rar | 6/6 | Removed tool-specific names from When clause |
| REF-007 | Adversarial robustness testing and bound | 5/6 | Removed tool-specific names from When clause |
| REF-008 | Adversarial robustness testing and bound | 6/6 | Framed outcomes in safety/compliance terms |
| REF-009 | Adversarial robustness testing and bound | 6/6 |  |
| REF-010 | Hardware-in-the-loop and digital-twin sy | 5/6 | Removed tool-specific names from Given clause |
| REF-011 | Hardware-in-the-loop and digital-twin sy | 6/6 |  |
| REF-012 | Hardware-in-the-loop and digital-twin sy | 6/6 |  |
| REF-013 | Live drift detection and continuous moni | 5/6 |  |
| REF-014 | Live drift detection and continuous moni | 5/6 |  |
| REF-015 | Live drift detection and continuous moni | 6/6 | Framed outcomes in safety/compliance terms |
| … | | | _(13 more)_ |

## A — Automation & Feature Files (angie)

**Recommended framework:** Cucumber-JVM (BDD orchestration) + pytest-bdd (ML/signal-processing layer) + Selenium WebDriver (UI steps) + Robot Framework (system integration) + custom Python harnesses for AMLAS artefact validation

**Step definitions authored:** 33  ·  **Shared steps:** 10

### Gherkin feature files

| File | Scenarios | Lines | Sample tags |
|---|---|---|---|
| `01-requirements-decomposition.feature` | 4 | 48 | @PSRQ, @REQ-001, @REQ-002, @SCEN-001, @SCEN-002, @SCEN-003, @critical, @major, @phase-1, @smoke |
| `02-data-curation.feature` | 5 | 55 | @PSRQ, @REQ-002, @REQ-003, @SCEN-004, @SCEN-005, @SCEN-006, @SCEN-026, @critical, @major, @phase-2, @smoke |
| `03-model-layer-evaluation.feature` | 7 | 78 | @PSRQ, @REQ-004, @REQ-005, @REQ-006, @REQ-007, @REQ-011, @SCEN-007, @SCEN-008, @SCEN-009, @SCEN-021, @SCEN-022, @SCEN-024 |
| `04-system-layer-evaluation.feature` | 7 | 78 | @PSRQ, @REQ-006, @REQ-008, @REQ-009, @REQ-010, @SCEN-010, @SCEN-011, @SCEN-012, @SCEN-018, @SCEN-019, @SCEN-020, @critical |
| `05-real-world-validation.feature` | 6 | 70 | @PSRQ, @REQ-010, @SCEN-010, @critical, @major, @phase-5, @smoke |
| `06-safety-case-article-36.feature` | 7 | 75 | @PSRQ, @REQ-011, @REQ-012, @REQ-XXX, @SCEN-016, @SCEN-017, @SCEN-YYY, @critical, @major, @phase-6, @smoke |
| `07-in-service-monitoring.feature` | 7 | 86 | @PSRQ, @REQ-013, @REQ-014, @SCEN-013, @SCEN-014, @SCEN-015, @critical, @major, @phase-7, @smoke |

## V — Validation Strategy (Victoria)

| Suite | Target duration | Trigger | Scenarios | Purpose |
|---|---|---|---|---|
| **smoke** | 5 min | every commit | 12 | Critical model-layer accuracy sanity, ODD gate, drift-monitor heartbeat |
| **regression** | 30 min | merge to main | 18 | Phase 3-4 model robustness, system-layer HIL basics, scenario coverage |
| **full** | 120 min | nightly / release | 38 | Comprehensive Phase 4-7: real-world validation, adversarial robustness bounds, drift-monitor live validation, evidence store freshness |

**DeFOSPAM mapping:** 31 critical findings → smoke (7 scenarios) + regression (5 scenarios), 50 major findings → regression (13 scenarios) + full (20 scenarios), 3 minor findings → full (3 scenarios)

**Estimated execution:** Smoke: 5 min, Regression: 25-30 min, Full: 100-120 min (sequential) or 60-90 min (parallel HIL + model)

## L — Living Documentation (Laveena)

**Tooling:** MkDocs + Pickles + Custom Gherkin-to-HTML publisher

**Accessibility score:** high/100

**Folder hierarchy:** 15 top-level paths  ·  **Tag categories:** 6

### Folder hierarchy

| Path | Description |
|---|---|
| `features/` | Feature files grouped by PSRQ phase and AMLAS activity |
| `features/01-requirements-decomposition/` | Phase 1: ODD and requirement decomposition; AMLAS activity 1 evidence |
| `features/02-data-curation/` | Phase 2: Real-world and synthetic data curation; AMLAS activity 2 evidence |
| `features/03-model-evaluation/` | Phase 3: Model-layer accuracy, robustness, red-teaming, explainability; AMLAS activity 3 evidence |
| `features/04-system-evaluation/` | Phase 4: Hardware-in-the-loop, scenario generation, human-on-loop; AMLAS activity 4 evidence |
| `features/05-physical-validation/` | Phase 5: Targeted sea trials and real-world validation; AMLAS activity 5 evidence |
| `features/06-safety-case/` | Phase 6: AMLAS evidence bundle, GSN safety case, Article 36 compliance; AMLAS activity 6 evidence |
| `features/07-in-service-monitoring/` | Phase 7: Live drift detection, MLOps lineage, continuous re-qualification |
| `features/15-cross-cutting/` | Cross-cutting concerns: role-based access, CI/CD integration, classified data handling |
| `docs/glossary/` | Living glossary of ubiquitous language (55 agreed terms from chris-language.json) |
| `docs/role-guides/` | Role-specific navigation guides (T&E engineer, Safety engineer, Legal reviewer, etc.) |
| `docs/amlas-activity-index/` | Cross-reference index mapping each AMLAS activity to relevant features and evidence artifacts |
| `docs/odd-coverage-heatmap/` | Interactive ODD state coverage matrix (visibility x sea-state x illumination x sensor-mode) |
| `docs/scenario-search/` | Searchable scenario registry with tag-based filtering |
| `.gherkin/` | Cucumber/Gherkin BDD syntax validation and step definitions (if using Cucumber runner) |

## Top Findings (sorted by severity × confidence)

| # | Pattern | Analyst | Severity | Conf | Title | Recommendation |
|---|---|---|---|---|---|---|
| 1 | S — Specify | Chris | **critical** | 9 | ODD partition and coverage metric are undefined — isolation signal from Alexa (ambiguity a | Run three-amigos workshop with T&E Engineer, Data Engineer, and Tester. Agree on ODD partition method (discrete, continuous, mixed), partition examples (3 per method), coverage computation rule, and t |
| 2 | S — Specify | Chris | **critical** | 9 | Adversarial robustness bounds lack type, attack, and class definitions — isolation from Al | Hold all-team workshop (Developer, Safety Engineer, Tester, Threat Modeller) to define robustness-bound type, threat-model enumeration, class matrix (object × sensor × environment), and validation met |
| 3 | S — Specify | Chris | **critical** | 9 | Article 36 scope conflict: perception-only vs. full closed-loop — Alexa ambiguity signal | All-team workshop (T&E Engineer, Safety Engineer, Legal Reviewer, Developer) to define Article 36 scope (perception? planning? both?), success criteria (which IHL principles?), evidence export format, |
| 4 | I — Illustrate | Isabel | **critical** | 9 | Missing latency performance non-functional requirement | Add NFR example to EX-029 demonstrating latency measurement at each inference stage (LiDAR ingestion, segmentation, detection, decision) and GPU thermal margin. Define SLA target <200 ms and escalatio |
| 5 | I — Illustrate | Isabel | **critical** | 9 | Missing security & compliance non-functional requirement for classified data | Expand EX-030 to include: (1) permission matrix across 3 classified-data tiers (RESTRICTED, CONFIDENTIAL, UNCLASSIFIED), (2) failed access attempt with reason code, (3) quarterly compliance audit chec |
| 6 | R — Refine | Rex | **critical** | 9 | SCEN-028 LLM collision-avoidance vulnerability reveals Article 36 risk | Escalate to requirements: "LLM-based collision-avoidance subsystems are subject to mandatory Article 36 review. Safety case must document that decision logic remains compliant under adversarial prompt |
| 7 | A — Automate | angie | **critical** | 9 | GSN claim coverage metric (95% goal-evidence) not automatically validated; Phase 6 gate re | Implement automated GSN claim-coverage validator: (1) Parse GSN tree (XML/JSON export from auto-generation tool), (2) Traverse graph structure; count total claims (nodes with type='claim'), (3) For ea |
| 8 | V — Validate | Victoria | **critical** | 9 | Critical Path: ODD Decomposition Traceability Smoke Gate | Prioritize SCEN-001,002 as non-negotiable smoke gates. Add per-requirement traceability report (JSON) to CI/CD dashboard showing atom count and versioning status. Fail merge if any requirement.id lack |
| 9 | V — Validate | Victoria | **critical** | 9 | Synthetic Data Provenance Integrity: Critical for Evidence Store Audit | Add synthetic-data provenance audit as a regression gate (sub-30s check). Require MLflow + DVC hashes on every synthetic-frame import. Maintain 'provenance-failure' counter in dashboard; escalate to S |
| 10 | V — Validate | Victoria | **critical** | 9 | Adversarial Robustness Bounds Coverage: SIL 2 Threshold Escalation | Add 'robustness-bounds-per-class' report to regression dashboard. Plot robust accuracy for each class (radar: merchant vessels, RIBs, small craft, buoys; visual: same classes). Highlight classes <75%  |
| 11 | V — Validate | Victoria | **critical** | 9 | Evidence Store Freshness Critical: Model Version Delta SLA | Add 'Evidence Store Freshness' widget to main dashboard (not just full suite). Display: time since last evidence regen (red if >24h), model version delta (red if >3 commits), synthetic data audit stat |
| 12 | V — Validate | Victoria | **critical** | 9 | Classified Data Handling Rigor: MOD DAIS Integration Critical Gate | Tag SCEN-026 as 'mandatory for classified-capability release'. Add 'Data Provenance Audit' to full-suite dashboard: display AUVLAB + MOD sea-trial dataset versions, ingestion timestamps, DVC hash chai |
| 13 | V — Validate | Victoria | **critical** | 9 | Article 36 Compliance Logging: Human-Override Audit Trail Non-Optional | Add 'Article 36 Audit Trail' to full-suite dashboard: display # of SLO-red events, % with logged overrides, override reasons, post-mission review status. Require Legal Reviewer sign-off before operati |
| 14 | S — Specify | Chris | **critical** | 8 | Data lifecycle and evidence retention policy missing — missing perspective gap from Milarn | Host all-team workshop with T&E Engineer, Safety Engineer, Data Engineer, and Legal Reviewer. Define data-lifecycle policy: retention period, archival rules, DPIA templates, backup SLOs, cross-program |
| 15 | S — Specify | Chris | **critical** | 8 | Stakeholder governance structure and sign-off authorities undefined — Milarna systemic gap | Convene governance workshop with T&E Engineer (business), Safety Engineer, Legal Reviewer, and representatives from RAISO/DAU. Define decision authorities, approval levels, escalation paths, and timel |
| 16 | A — Automate | angie | **critical** | 8 | Drift-detection SLO escalation workflow not automatable; manual operator judgment required | Reframe SCEN-015 as a specification of system behaviour rather than scenario test: 'When a human operator overrides a SLO-red alert (operator choice outside system scope), the system shall log the ove |
| 17 | L — Living Docs | Laveena | **major** | 10 | Missing ODD Coverage Heatmap for 'Does System Handle Sea State 5 Fog' | Create interactive ODD coverage heatmap (HTML/CSV table) showing: (1) visibility ranges (50–500 m, etc.); (2) sea state (Beaufort 2–5); (3) illumination (daylight/dusk/night/fog); (4) sensor modalitie |
| 18 | G — Goals | Grace | **major** | 9 | REQ-009: Scenario volume target vague—'10× more' lacks measurable baseline | Establish baseline: query T&E team on current scenario-authoring velocity; restate success metric as 'from X manual scenarios/engineer-day to ≥5X parametric scenarios/engineer-day' |
| 19 | G — Goals | Grace | **major** | 9 | REQ-011: GSN auto-generation success metric '95% goal coverage' vague on coverage definiti | Refine success metric: 'Draft GSN generated in <2 hours (tool time). Human review + refinement + approval completes in <2 engineer-days (baseline: 3-7 days). Measure end-to-end time savings, not tool  |
| 20 | S — Specify | Chris | **major** | 9 | Acceptance baseline for speedup claims (3-5×, 10×) undefined — Alexa/Milarna gap | Three-amigos workshop (T&E Engineer, Developer, Data Engineer) to baseline current manual effort (requirements decomposition time, scenario design time, test-case generation time) and define measureme |
| 21 | R — Refine | Rex | **major** | 9 | StyleGAN invocation leaks implementation detail into spec | Rephrase as: "Given curated real logs, When 10x augmentation is requested for rare conditions, Then synthetic frames are produced with full provenance tracking" |
| 22 | R — Refine | Rex | **major** | 9 | SCEN-001/002 describe decomposition workflow, not specification outcome | Strip actor/action sequence; focus on input → output contract |
| 23 | R — Refine | Rex | **major** | 9 | Robustness bounds lack stratification by object class and modality | Refine: "robustness bounds are filed per object class (merchant vessel, fishing vessel, buoy) and sensor modality (radar, visual, fused)" |
| 24 | R — Refine | Rex | **major** | 9 | SCEN-011 handover threshold (70%) assumed but not derived | Declare: "confidence threshold determined from [SIL target] and [ODD coverage]. Handover triggered when model confidence or environmental fit score < threshold" |
| 25 | R — Refine | Rex | **major** | 9 | SCEN-016-017 describe GSN tooling, not specification outcome | Reframe as: "Given AMLAS evidence (activities 1-6), When safety case assembly is triggered, Then GSN structure links each claim to supporting evidence artifact in traceability matrix" |
| 26 | A — Automate | angie | **major** | 9 | Scenario Outline Examples tables require real maritime data values for validation | Replace all placeholder values in Scenario Outline Examples with concrete maritime data from Isabel's examples.json. For each phase, extract 2–3 representative ODD scenarios covering: (1) nominal cond |
| 27 | A — Automate | angie | **major** | 9 | Model metric thresholds (mAP, ECE, robust accuracy) hardcoded in scenarios; SLO not parame | Parameterize metric thresholds via external SLO configuration file or environment variables. Create SLO profile per object class and sensor modality: {object_class: 'small_boat', sensor: 'radar', min_ |
| 28 | A — Automate | angie | **major** | 9 | Framework recommendation: Multi-language test automation harness for domain-specific layer | Implement composite test harness: (1) Cucumber-JVM as orchestration layer (parses Gherkin, drives phase-gated execution, manages CI/CD gates), (2) pytest-bdd with Python plugins for Phases 1–3 (requir |
| 29 | L — Living Docs | Laveena | **major** | 9 | Terminology Precision Gap: ODD States vs. Environment Variables | Add clarifying section to glossary: 'declared ODD states' = discrete or continuous parameterization defining testable bounds; 'environment variables' = specific measurable attributes monitored during  |
| 30 | L — Living Docs | Laveena | **major** | 9 | Missing AMLAS Activity Cross-Reference Index for Quick Navigation | Create AMLAS activity index page (docs/amlas-activity-index/index.md) with table: Activity # \| Requirements \| Features \| Scenarios \| Refined Specs \| Examples \| Evidence Artifacts. Link each cell |

---
*OpenRequirements.AI  ·  Specification by Example (Gojko Adzic, 2011)  ·  2026-04-22 13:48*