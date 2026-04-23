# Graph Report - .  (2026-04-23)

## Corpus Check
- Large corpus: 285 files · ~1,034,825 words. Semantic extraction will be expensive (many Claude tokens). Consider running on a subfolder, or use --no-semantic to run AST-only.

## Summary
- 1810 nodes · 4923 edges · 112 communities detected
- Extraction: 38% EXTRACTED · 62% INFERRED · 0% AMBIGUOUS · INFERRED: 3061 edges (avg confidence: 0.5)
- Token cost: 0 input · 0 output

## God Nodes (most connected - your core abstractions)
1. `g()` - 165 edges
2. `A()` - 132 edges
3. `T()` - 107 edges
4. `C()` - 76 edges
5. `E()` - 65 edges
6. `st()` - 58 edges
7. `ot()` - 57 edges
8. `re()` - 57 edges
9. `et()` - 53 edges
10. `Submission` - 47 edges

## Surprising Connections (you probably didn't know these)
- `ADOEOR Cycle` --semantically_similar_to--> `Component 0 Baseline Configurator`  [INFERRED] [semantically similar]
  apk/JonathonAi.chatmode.md → agents/plan.md
- `Validation Agents (Quality Assurance)` --semantically_similar_to--> `Gate 2 — No unmitigated critical (conf ≥ 9)`  [INFERRED] [semantically similar]
  apk/JonathonAi.chatmode.md → agents/plan.md
- `Meta-Agents (Orchestration)` --semantically_similar_to--> `MAA Lead Inspector (Primary persona)`  [INFERRED] [semantically similar]
  apk/JonathonAi.chatmode.md → context/bvlos-autonomous-swarms/USER_STORY_CAA_MAA_SWARM.md
- `Overall Decision: Not suitable (yet)` --applies_to--> `SORA sample (refuse — CTRL-ALT-DEFEAT Spadeadam)`  [INFERRED]
  context/bvlos-autonomous-swarms/STRESS-Report.md → agents/plan.md
- `FastAPI entrypoint — Applicant-mode REST + SSE surface.  Endpoints mirror the ha` --uses--> `Document`  [INFERRED]
  service/app.py → service/workflow/schemas.py

## Hyperedges (group relationships)
- **SORA refuse — over-determined keystones (K1,K2,K3,K7,K8)** — plan_k1_geofence_independence, plan_k2_daa_ml_provenance, plan_k3_swarm_emergent_bounds, plan_k7_caa_maa_apportionment, plan_k8_classification_custodian, plan_sora_sample [EXTRACTED 1.00]
- **DTFEA pillars D/T/F/E/A feed maturity gate** — stress_pillar_d, stress_pillar_t, stress_pillar_f, stress_pillar_e, stress_pillar_a, plan_gate1_pillar_floor [EXTRACTED 1.00]
- **PDRA-01 exemption set — Scotland sample skips keystones by exemption** — plan_scotland_sample, plan_k1_geofence_independence, plan_k2_daa_ml_provenance, plan_k3_swarm_emergent_bounds, user_story_ac3, user_story_ac5, user_story_ac7 [EXTRACTED 1.00]
- **Testing Levels L1-L6 (Unit to UAT)** — testing_level_l1_unit, testing_level_l2_component, testing_level_l3_integration, testing_level_l4_system, testing_level_l5_sit, testing_level_l6_uat [INFERRED 0.99]
- **TMMi Maturity Levels 1-5** — tmmi_level_1_initial, tmmi_level_2_managed, tmmi_level_3_defined, tmmi_level_4_measured, tmmi_level_5_optimization [INFERRED 0.99]
- **Keystone-gated release blocker** — keystones_k1_k8, quality_gates_12, twin_sample_regression, release_readiness_verdict, sora_workbench [INFERRED 0.94]
- **Coverage adequacy (TMap + ISO 25010)** — coverage_stage_covered, tmap_methodology, iso_25010, adequacy_score, test_cases_194, requirements_req001_req020 [INFERRED 0.93]

## Communities

### Community 0 - "Vis.js Network Internals"
Cohesion: 0.04
Nodes (290): A(), Ab(), AC(), ah(), ap(), Ar(), As(), at() (+282 more)

### Community 1 - "MAF Applicant Workflow"
Cohesion: 0.02
Nodes (143): CreateWorkspaceRequest, build_applicant_workflow(), ConcurrentMerge, Applicant-mode workflow (plan §3 ADOEOR → MAF Workflow topology).      [submissi, Fan-in node for the concurrent [Artefact ∥ Mapper ∥ SORA] block.      Receives t, Compile the applicant-mode workflow graph., ArtefactDetector, detect() (+135 more)

### Community 2 - "Vis.js Utilities"
Cohesion: 0.02
Nodes (22): Ax(), Cx, dO, ex, gx(), ib(), Ix(), jh() (+14 more)

### Community 3 - "Vis.js Physics Simulation"
Cohesion: 0.02
Nodes (19): ao(), BE, fE, gO, jE, ke(), LC(), LE (+11 more)

### Community 4 - "Vis.js Canvas Rendering"
Cohesion: 0.04
Nodes (7): et(), iC(), _l(), Ml(), nO, oO, TT

### Community 5 - "AAIB Incident Investigations"
Cohesion: 0.03
Nodes (93): Air Accidents Investigation Branch (AAIB), AAIB Safety Recommendations 2021-001 through 2021-005 (Alauda Airspeeder Mk II), FMEA + Fault Tree Analysis on Airspeeder Mk3 powertrain, Alauda post-incident aviation SMS + AVCRM reporting, SR 2021-001 - Riotplan/Alauda design/build/test standards, SR 2021-002 - CAP 722 to require detailed evaluation of onboard risk mitigation systems, SR 2021-003 - CAP 722 guidance on RF surveys, SR 2021-004 - RF survey reports to CAA for review (+85 more)

### Community 6 - "Regulatory Anchor Corpus"
Cohesion: 0.03
Nodes (92): AMLAS 6-stage assurance, Article 36 (Additional Protocol I Geneva), ASTM F3442 / EUROCAE ED-267 (DAA), CAP 1616 Airspace Change Process, CAP 722 (UK UAS operations), CAP 722A Operating Safety Cases, CAP 722B BVLOS, DEFSTAN 00-970 Part 9 (+84 more)

### Community 7 - "Vis.js Hierarchical Layout"
Cohesion: 0.05
Nodes (7): bc(), IO, lt(), nt(), ot(), ro(), ul()

### Community 8 - "Vis.js Edge Rendering"
Cohesion: 0.04
Nodes (19): AE(), CC(), CE, Dc(), dE, eC(), he(), jx() (+11 more)

### Community 9 - "Vis.js Clustering"
Cohesion: 0.05
Nodes (11): gT, hO, it(), JO(), Ko(), Qx, so(), tp (+3 more)

### Community 10 - "Vis.js Controllers"
Cohesion: 0.05
Nodes (6): CO, Hx, jT(), lO, Rl(), zl()

### Community 11 - "Opentesting Templates + AC Coverage"
Cohesion: 0.03
Nodes (74): Acceptance Criteria AC1-AC8, anomaly-administration (IEEE 1044.1), ARCI Matrix, bidirectional-traceability, classification-tree-submission-pack, compliance-traceability, coverage-matrix, decision-table-pack-completeness (+66 more)

### Community 12 - "Test Coverage Framework"
Cohesion: 0.07
Nodes (50): Coverage Adequacy Score 62.7%, Boundary Coverage, Branch Coverage, Keystone Coverage, Path Coverage, Functional Requirement Coverage, State Coverage, Statement Coverage (+42 more)

### Community 13 - "Cross-Domain Autonomy Bridge (Air ↔ Naval)"
Cohesion: 0.06
Nodes (48): Cross-Domain Autonomy Assurance, Autonomous Perception Stack, SORA-equivalent risk assessments, Windows ARM64 workerd Limitation, Arena Fragmentation Test (AFT), Fragmentation Digital Twin, Flash X-Ray (Scandiflash), Photonic Doppler Velocimetry (PDV) (+40 more)

### Community 14 - "Vis.js User Interaction"
Cohesion: 0.09
Nodes (7): cl(), dl(), el(), eO, Ol(), Tl(), Uo()

### Community 15 - "Keystone Detectors K1-K8"
Cohesion: 0.31
Nodes (14): _engages_autonomy(), _engages_bvlos(), _engages_swarm(), _first_pointer(), _has_text(), k1_geofence_independence(), k2_daa_provenance(), k3_swarm_emergent_bounds() (+6 more)

### Community 16 - "FastAPI Applicant Service"
Cohesion: 0.22
Nodes (13): _build_submission(), create_workspace(), _emit(), _get(), get_feedback(), get_readiness(), FastAPI entrypoint — Applicant-mode REST + SSE surface.  Endpoints mirror the ha, In-memory workspace record. For the hackathon cut only — a real build     persis (+5 more)

### Community 17 - "DevUI Launcher"
Cohesion: 0.31
Nodes (8): _build_app(), _build_inspector_agents(), _load_and_patch_index(), main(), DevUI launcher — visualise + interact with the SORA workflow.  Microsoft Agent F, Read the packaged DevUI index.html and rewrite its <title> and any     visible ', Build the DevUI FastAPI app with a /-override for the patched index., Build standalone ChatAgent instances for each pipeline step.      Only runs when

### Community 18 - "LLM Client Wiring"
Cohesion: 0.32
Nodes (5): get_chat_client(), Shared LLM wiring.  The hackathon cut uses Azure OpenAI / OpenAI via the Microso, Return an MAF ChatClient. Falls back to a stub in test mode.      Env vars:, Returns deterministic empty responses. Used by tests + dry-run demos., _StubClient

### Community 19 - "Twin-Sample Regression Tests"
Cohesion: 0.52
Nodes (6): _evaluate(), test_readiness_gauges_scotland(), test_readiness_gauges_sora_red(), test_scotland_approves(), test_sora_refuses_with_keystones(), test_sora_sail_is_incoherent()

### Community 20 - "Binder Invariant Tests"
Cohesion: 0.67
Nodes (5): _feedback_with_pointer(), _submission_with_docs(), test_binder_accepts_valid_pointers(), test_binder_rejects_missing_feedback(), test_binder_rejects_unknown_document_id()

### Community 21 - "Defence Safety Governance"
Cohesion: 0.5
Nodes (4): DOSG, DOSR, JSP 520, Safety and Suitability for Service (S3)

### Community 22 - "Meta-Agent Orchestration"
Cohesion: 0.67
Nodes (3): Meta-Agents (Orchestration), Orchestrator of Orchestrators, MAA Lead Inspector (Primary persona)

### Community 23 - "SORA Refuse State"
Cohesion: 0.67
Nodes (3): All 20 REQs red + approval_blocked=True, Sample submission run (id=1, empty pack), app.py (FastAPI endpoints)

### Community 24 - "Absent-by-Default REQs"
Cohesion: 0.67
Nodes (3): Absent-by-default quartet (REQ017–REQ020), Requirements catalogue REQ001–REQ020, knowledge/req_catalogue.json + dtfea_rubric.yaml

### Community 25 - "Small Cluster 25"
Cohesion: 1.0
Nodes (0): 

### Community 26 - "Small Cluster 26"
Cohesion: 1.0
Nodes (0): 

### Community 27 - "Small Cluster 27"
Cohesion: 1.0
Nodes (0): 

### Community 28 - "Small Cluster 28"
Cohesion: 1.0
Nodes (0): 

### Community 29 - "Small Cluster 29"
Cohesion: 1.0
Nodes (0): 

### Community 30 - "Small Cluster 30"
Cohesion: 1.0
Nodes (0): 

### Community 31 - "Small Cluster 31"
Cohesion: 1.0
Nodes (1): Foundation Agents (Infrastructure)

### Community 32 - "Small Cluster 32"
Cohesion: 1.0
Nodes (1): Integration Agents (Connectivity)

### Community 33 - "Small Cluster 33"
Cohesion: 1.0
Nodes (1): CAA Inspector (AAA + FOI)

### Community 34 - "Small Cluster 34"
Cohesion: 1.0
Nodes (1): Duty Holder (DDH/ODH)

### Community 35 - "Small Cluster 35"
Cohesion: 1.0
Nodes (1): RAISO (JSP 936 accountable officer)

### Community 36 - "Small Cluster 36"
Cohesion: 1.0
Nodes (1): Commission Delegated Regulation (EU) 2019/945

### Community 37 - "Small Cluster 37"
Cohesion: 1.0
Nodes (1): OpenRequirements Pipeline

### Community 38 - "Small Cluster 38"
Cohesion: 1.0
Nodes (1): DeFOSPAM Stage

### Community 39 - "Small Cluster 39"
Cohesion: 1.0
Nodes (1): Vibe Requirements Stage

### Community 40 - "Small Cluster 40"
Cohesion: 1.0
Nodes (1): Performance Engineering Stage

### Community 41 - "Small Cluster 41"
Cohesion: 1.0
Nodes (1): Specification by Example Stage

### Community 42 - "Small Cluster 42"
Cohesion: 1.0
Nodes (1): IEEE 830 SRS Stage

### Community 43 - "Small Cluster 43"
Cohesion: 1.0
Nodes (1): openrequirements-report.md

### Community 44 - "Small Cluster 44"
Cohesion: 1.0
Nodes (1): openrequirements-vibe-report.md

### Community 45 - "Small Cluster 45"
Cohesion: 1.0
Nodes (1): openperformance-report.md

### Community 46 - "Small Cluster 46"
Cohesion: 1.0
Nodes (1): sbe-report.md

### Community 47 - "Small Cluster 47"
Cohesion: 1.0
Nodes (1): openrequirements-srs-report.md

### Community 48 - "Small Cluster 48"
Cohesion: 1.0
Nodes (1): INDEX.txt

### Community 49 - "Small Cluster 49"
Cohesion: 1.0
Nodes (1): README.txt

### Community 50 - "Small Cluster 50"
Cohesion: 1.0
Nodes (1): CHRIS-SUMMARY.txt

### Community 51 - "Small Cluster 51"
Cohesion: 1.0
Nodes (1): ANALYSIS-VALIDATION.txt

### Community 52 - "Small Cluster 52"
Cohesion: 1.0
Nodes (1): ODIN-ANALYSIS-SUMMARY.txt

### Community 53 - "Small Cluster 53"
Cohesion: 1.0
Nodes (1): features/README.md

### Community 54 - "Small Cluster 54"
Cohesion: 1.0
Nodes (1): Dorothy (Definitions)

### Community 55 - "Small Cluster 55"
Cohesion: 1.0
Nodes (1): Flo (Features)

### Community 56 - "Small Cluster 56"
Cohesion: 1.0
Nodes (1): Olivia (Outcomes)

### Community 57 - "Small Cluster 57"
Cohesion: 1.0
Nodes (1): Sophia (Scenarios)

### Community 58 - "Small Cluster 58"
Cohesion: 1.0
Nodes (1): Paul (Prediction/Precision)

### Community 59 - "Small Cluster 59"
Cohesion: 1.0
Nodes (1): Alexa (Ambiguity/Scales)

### Community 60 - "Small Cluster 60"
Cohesion: 1.0
Nodes (1): Milarna (Missing)

### Community 61 - "Small Cluster 61"
Cohesion: 1.0
Nodes (1): Ray (Meters)

### Community 62 - "Small Cluster 62"
Cohesion: 1.0
Nodes (1): Brook (Benchmarks)

### Community 63 - "Small Cluster 63"
Cohesion: 1.0
Nodes (1): Alan (Availability/Stakeholders)

### Community 64 - "Small Cluster 64"
Cohesion: 1.0
Nodes (1): Isaac (Constraints)

### Community 65 - "Small Cluster 65"
Cohesion: 1.0
Nodes (1): Tom (Targets)

### Community 66 - "Small Cluster 66"
Cohesion: 1.0
Nodes (1): Raj (Background)

### Community 67 - "Small Cluster 67"
Cohesion: 1.0
Nodes (1): Lovelace (QC)

### Community 68 - "Small Cluster 68"
Cohesion: 1.0
Nodes (1): Ada (Capacity)

### Community 69 - "Small Cluster 69"
Cohesion: 1.0
Nodes (1): Noyce (Latency)

### Community 70 - "Small Cluster 70"
Cohesion: 1.0
Nodes (1): Liskov (Scalability)

### Community 71 - "Small Cluster 71"
Cohesion: 1.0
Nodes (1): Yao (Security)

### Community 72 - "Small Cluster 72"
Cohesion: 1.0
Nodes (1): Turing (Usability)

### Community 73 - "Small Cluster 73"
Cohesion: 1.0
Nodes (1): Iverson (Monitoring)

### Community 74 - "Small Cluster 74"
Cohesion: 1.0
Nodes (1): Cerf (Endurance/Test)

### Community 75 - "Small Cluster 75"
Cohesion: 1.0
Nodes (1): Grace (Goals)

### Community 76 - "Small Cluster 76"
Cohesion: 1.0
Nodes (1): Chris (Collaboration/Language)

### Community 77 - "Small Cluster 77"
Cohesion: 1.0
Nodes (1): Isabel (Examples)

### Community 78 - "Small Cluster 78"
Cohesion: 1.0
Nodes (1): Rex (Refinement)

### Community 79 - "Small Cluster 79"
Cohesion: 1.0
Nodes (1): Angie (Automation/Gherkin)

### Community 80 - "Small Cluster 80"
Cohesion: 1.0
Nodes (1): Victoria (Validation)

### Community 81 - "Small Cluster 81"
Cohesion: 1.0
Nodes (1): Laveena (Living Docs)

### Community 82 - "Small Cluster 82"
Cohesion: 1.0
Nodes (1): Odin (Ambiguity/IEEE 830)

### Community 83 - "Small Cluster 83"
Cohesion: 1.0
Nodes (1): Chelcie (Correct)

### Community 84 - "Small Cluster 84"
Cohesion: 1.0
Nodes (1): Lucy (Complete)

### Community 85 - "Small Cluster 85"
Cohesion: 1.0
Nodes (1): Ophellia (Consistent)

### Community 86 - "Small Cluster 86"
Cohesion: 1.0
Nodes (1): Natasha (Ranked)

### Community 87 - "Small Cluster 87"
Cohesion: 1.0
Nodes (1): Iris (Verifiable)

### Community 88 - "Small Cluster 88"
Cohesion: 1.0
Nodes (1): Amelia (Modifiable)

### Community 89 - "Small Cluster 89"
Cohesion: 1.0
Nodes (1): Lewis (Traceable)

### Community 90 - "Small Cluster 90"
Cohesion: 1.0
Nodes (1): IEEE 830 Quality Scorecard

### Community 91 - "Small Cluster 91"
Cohesion: 1.0
Nodes (1): Requirements Traceability Matrix

### Community 92 - "Small Cluster 92"
Cohesion: 1.0
Nodes (1): Keystones K1-K8

### Community 93 - "Small Cluster 93"
Cohesion: 1.0
Nodes (1): 15 Business Goals

### Community 94 - "Small Cluster 94"
Cohesion: 1.0
Nodes (1): Finding: 'complete' ambiguity

### Community 95 - "Small Cluster 95"
Cohesion: 1.0
Nodes (1): Finding: REQ017-REQ020 missing user stories

### Community 96 - "Small Cluster 96"
Cohesion: 1.0
Nodes (1): Finding: Safety outcomes undefined

### Community 97 - "Small Cluster 97"
Cohesion: 1.0
Nodes (1): 10 Workshops (WS-001..WS-010)

### Community 98 - "Small Cluster 98"
Cohesion: 1.0
Nodes (1): 42 Canonical Terms

### Community 99 - "Small Cluster 99"
Cohesion: 1.0
Nodes (1): Gherkin Feature Files

### Community 100 - "Small Cluster 100"
Cohesion: 1.0
Nodes (1): Behave + Cypress BDD

### Community 101 - "Small Cluster 101"
Cohesion: 1.0
Nodes (1): REQ001 Application Intake

### Community 102 - "Small Cluster 102"
Cohesion: 1.0
Nodes (1): REQ002 Swarm-Aware SORA

### Community 103 - "Small Cluster 103"
Cohesion: 1.0
Nodes (1): REQ005 Geofence Containment

### Community 104 - "Small Cluster 104"
Cohesion: 1.0
Nodes (1): REQ009 ML Assurance

### Community 105 - "Small Cluster 105"
Cohesion: 1.0
Nodes (1): REQ010 Meaningful Human Control

### Community 106 - "Small Cluster 106"
Cohesion: 1.0
Nodes (1): REQ017-REQ020 (missing)

### Community 107 - "Small Cluster 107"
Cohesion: 1.0
Nodes (1): Design Stage

### Community 108 - "Small Cluster 108"
Cohesion: 1.0
Nodes (1): Coverage Stage

### Community 109 - "Small Cluster 109"
Cohesion: 1.0
Nodes (1): Create Stage

### Community 110 - "Small Cluster 110"
Cohesion: 1.0
Nodes (1): Reporting Stage

### Community 111 - "Small Cluster 111"
Cohesion: 1.0
Nodes (1): UAV

## Knowledge Gaps
- **63 isolated node(s):** `DevUI launcher — visualise + interact with the SORA workflow.  Microsoft Agent F`, `Build standalone ChatAgent instances for each pipeline step.      Only runs when`, `Read the packaged DevUI index.html and rewrite its <title> and any     visible '`, `Build the DevUI FastAPI app with a /-override for the patched index.`, `Clause` (+58 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Small Cluster 25`** (2 nodes): `ingest-graph.ts`, `run()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 26`** (1 nodes): `playwright.config.ts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 27`** (1 nodes): `eslint.config.js`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 28`** (1 nodes): `vite.config.ts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 29`** (1 nodes): `smoke.spec.ts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 30`** (1 nodes): `install-smoke.spec.ts`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 31`** (1 nodes): `Foundation Agents (Infrastructure)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 32`** (1 nodes): `Integration Agents (Connectivity)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 33`** (1 nodes): `CAA Inspector (AAA + FOI)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 34`** (1 nodes): `Duty Holder (DDH/ODH)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 35`** (1 nodes): `RAISO (JSP 936 accountable officer)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 36`** (1 nodes): `Commission Delegated Regulation (EU) 2019/945`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 37`** (1 nodes): `OpenRequirements Pipeline`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 38`** (1 nodes): `DeFOSPAM Stage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 39`** (1 nodes): `Vibe Requirements Stage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 40`** (1 nodes): `Performance Engineering Stage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 41`** (1 nodes): `Specification by Example Stage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 42`** (1 nodes): `IEEE 830 SRS Stage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 43`** (1 nodes): `openrequirements-report.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 44`** (1 nodes): `openrequirements-vibe-report.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 45`** (1 nodes): `openperformance-report.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 46`** (1 nodes): `sbe-report.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 47`** (1 nodes): `openrequirements-srs-report.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 48`** (1 nodes): `INDEX.txt`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 49`** (1 nodes): `README.txt`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 50`** (1 nodes): `CHRIS-SUMMARY.txt`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 51`** (1 nodes): `ANALYSIS-VALIDATION.txt`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 52`** (1 nodes): `ODIN-ANALYSIS-SUMMARY.txt`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 53`** (1 nodes): `features/README.md`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 54`** (1 nodes): `Dorothy (Definitions)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 55`** (1 nodes): `Flo (Features)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 56`** (1 nodes): `Olivia (Outcomes)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 57`** (1 nodes): `Sophia (Scenarios)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 58`** (1 nodes): `Paul (Prediction/Precision)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 59`** (1 nodes): `Alexa (Ambiguity/Scales)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 60`** (1 nodes): `Milarna (Missing)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 61`** (1 nodes): `Ray (Meters)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 62`** (1 nodes): `Brook (Benchmarks)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 63`** (1 nodes): `Alan (Availability/Stakeholders)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 64`** (1 nodes): `Isaac (Constraints)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 65`** (1 nodes): `Tom (Targets)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 66`** (1 nodes): `Raj (Background)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 67`** (1 nodes): `Lovelace (QC)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 68`** (1 nodes): `Ada (Capacity)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 69`** (1 nodes): `Noyce (Latency)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 70`** (1 nodes): `Liskov (Scalability)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 71`** (1 nodes): `Yao (Security)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 72`** (1 nodes): `Turing (Usability)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 73`** (1 nodes): `Iverson (Monitoring)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 74`** (1 nodes): `Cerf (Endurance/Test)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 75`** (1 nodes): `Grace (Goals)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 76`** (1 nodes): `Chris (Collaboration/Language)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 77`** (1 nodes): `Isabel (Examples)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 78`** (1 nodes): `Rex (Refinement)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 79`** (1 nodes): `Angie (Automation/Gherkin)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 80`** (1 nodes): `Victoria (Validation)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 81`** (1 nodes): `Laveena (Living Docs)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 82`** (1 nodes): `Odin (Ambiguity/IEEE 830)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 83`** (1 nodes): `Chelcie (Correct)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 84`** (1 nodes): `Lucy (Complete)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 85`** (1 nodes): `Ophellia (Consistent)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 86`** (1 nodes): `Natasha (Ranked)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 87`** (1 nodes): `Iris (Verifiable)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 88`** (1 nodes): `Amelia (Modifiable)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 89`** (1 nodes): `Lewis (Traceable)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 90`** (1 nodes): `IEEE 830 Quality Scorecard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 91`** (1 nodes): `Requirements Traceability Matrix`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 92`** (1 nodes): `Keystones K1-K8`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 93`** (1 nodes): `15 Business Goals`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 94`** (1 nodes): `Finding: 'complete' ambiguity`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 95`** (1 nodes): `Finding: REQ017-REQ020 missing user stories`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 96`** (1 nodes): `Finding: Safety outcomes undefined`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 97`** (1 nodes): `10 Workshops (WS-001..WS-010)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 98`** (1 nodes): `42 Canonical Terms`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 99`** (1 nodes): `Gherkin Feature Files`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 100`** (1 nodes): `Behave + Cypress BDD`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 101`** (1 nodes): `REQ001 Application Intake`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 102`** (1 nodes): `REQ002 Swarm-Aware SORA`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 103`** (1 nodes): `REQ005 Geofence Containment`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 104`** (1 nodes): `REQ009 ML Assurance`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 105`** (1 nodes): `REQ010 Meaningful Human Control`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 106`** (1 nodes): `REQ017-REQ020 (missing)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 107`** (1 nodes): `Design Stage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 108`** (1 nodes): `Coverage Stage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 109`** (1 nodes): `Create Stage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 110`** (1 nodes): `Reporting Stage`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Small Cluster 111`** (1 nodes): `UAV`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `et()` connect `Vis.js Canvas Rendering` to `Vis.js Network Internals`, `Vis.js Hierarchical Layout`?**
  _High betweenness centrality (0.027) - this node is a cross-community bridge._
- **Why does `ot()` connect `Vis.js Hierarchical Layout` to `Vis.js Network Internals`, `Vis.js Clustering`, `Vis.js Canvas Rendering`?**
  _High betweenness centrality (0.020) - this node is a cross-community bridge._
- **Why does `dO` connect `Vis.js Utilities` to `Vis.js Network Internals`?**
  _High betweenness centrality (0.019) - this node is a cross-community bridge._
- **Are the 164 inferred relationships involving `g()` (e.g. with `m()` and `y()`) actually correct?**
  _`g()` has 164 INFERRED edges - model-reasoned connections that need verification._
- **Are the 131 inferred relationships involving `A()` (e.g. with `O()` and `T()`) actually correct?**
  _`A()` has 131 INFERRED edges - model-reasoned connections that need verification._
- **Are the 106 inferred relationships involving `T()` (e.g. with `O()` and `E()`) actually correct?**
  _`T()` has 106 INFERRED edges - model-reasoned connections that need verification._
- **Are the 75 inferred relationships involving `C()` (e.g. with `yg()` and `Dg()`) actually correct?**
  _`C()` has 75 INFERRED edges - model-reasoned connections that need verification._