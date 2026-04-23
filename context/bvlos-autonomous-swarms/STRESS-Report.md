# AI Stress-Test Report — CAA BVLOS UAS Swarm — Operational Authorisation
*Generated 2026-04-22 16:04 · OpenRequirements.AI · DTFEA methodology*

## Overall Decision: ❌ **Not suitable (yet)**

_≥20% of requirements unsuitable OR critical failure-mode gap present_

## Executive Summary

- **Requirements stress-tested:** 20
- **Total findings:** 100
- **Methodology:** 5-question stress test — Data (Dana), Trust (Trevor), Failure (Fiona), Evidence (Evan), Authority (Aria)
- **Working assumption:** the AI will sometimes be wrong

## Scorecard by Pillar

| Pillar | Analyst | Maturity | Critical | Major | Minor |
|---|---|---|---|---|---|
| **D — Data** | Dana | **35%** | 3 | 7 | 10 |
| **T — Trust** | Trevor | **40%** | 7 | 12 | 0 |
| **F — Failure** | Fiona | **32%** | 6 | 10 | 4 |
| **E — Evidence** | Evan | **21%** | 7 | 13 | 0 |
| **A — Authority** | Aria | **45%** | 5 | 8 | 6 |

## Per-Requirement Decision Matrix

| REQ | Name | Verdict | Value | Risk | Gap | Score | Reason |
|---|---|---|---|---|---|---|---|
| REQ001 | Application Intake & Completeness Check | ❌ Not suitable (yet) | 2.2 | 2 | 2.4 | -2.8 | Moderate assurance gap (score -2.8) |
| REQ002 | SORA 2.0 Assessment for Swarm | ❌ Not suitable (yet) | 3.6 | 3 | 3.4 | -3.9 | One critical finding in pillar E |
| REQ003 | ConOps & ODD Review | ❌ Not suitable (yet) | 3 | 3.2 | 3.4 | -4.5 | Critical failure-mode gap (Fiona) |
| REQ004 | Airspace Change & TDA Coordination | ❌ Not suitable (yet) | 2.2 | 2.4 | 2.4 | -3.2 | Moderate assurance gap (score -3.2) |
| REQ005 | Geofence / Containment Enforcement | ❌ Not suitable (yet) | 4.4 | 4.6 | 4.4 | -6.5 | Critical failure-mode gap (Fiona) |
| REQ006 | C2 Link and Spectrum Assurance | ❌ Not suitable (yet) | 3.4 | 3.4 | 3 | -4.0 | Moderate assurance gap (score -4.0) |
| REQ007 | Detect-and-Avoid Performance | ❌ Not suitable (yet) | 4.8 | 4.6 | 4.4 | -6.4 | Critical failure-mode gap (Fiona) |
| REQ008 | Swarm Decision-Making Architecture Review | ❌ Not suitable (yet) | 4.8 | 5 | 4.8 | -7.5 | Critical failure-mode gap (Fiona) |
| REQ009 | ML Assurance Case | ❌ Not suitable (yet) | 5 | 4.8 | 4.4 | -6.1 | Critical failure-mode gap (Fiona) |
| REQ010 | Human Oversight and Crew Fitness | ❌ Not suitable (yet) | 3.6 | 3.8 | 3.8 | -5.1 | One critical finding in pillar T |
| REQ011 | Contingency and Flight Termination | ❌ Not suitable (yet) | 4 | 4 | 4 | -5.4 | Critical failure-mode gap (Fiona) |
| REQ012 | Data MOR & DPIA Obligations | ❌ Not suitable (yet) | 4.2 | 3.2 | 3.4 | -3.8 | 2 critical findings across pillars |
| REQ013 | Insurance & Ground-Environment Survey | ❌ Not suitable (yet) | 2.2 | 2.4 | 2 | -2.8 | Moderate assurance gap (score -2.8) |
| REQ014 | Crew Training & Competency | ❌ Not suitable (yet) | 2.6 | 2.4 | 3 | -3.4 | Moderate assurance gap (score -3.4) |
| REQ015 | CAA/MAA Interface Management | ❌ Not suitable (yet) | 2.6 | 3.2 | 2.8 | -4.3 | Critical accountability gap (Aria) |
| REQ016 | Phased Trial Build-Up | ❌ Not suitable (yet) | 3.4 | 3.2 | 3.4 | -4.3 | One critical finding in pillar E |
| REQ017 | Public and Stakeholder Engagement | ❌ Not suitable (yet) | 3 | 3.6 | 4.2 | -6.2 | 2 critical findings across pillars |
| REQ018 | Security Classification Handling | ❌ Not suitable (yet) | 2.6 | 3.6 | 3.8 | -6.2 | Critical accountability gap (Aria) |
| REQ019 | Environmental Impact | ❌ Not suitable (yet) | 1.6 | 2.8 | 3.4 | -5.2 | Moderate assurance gap (score -5.2) |
| REQ020 | Post-Trial Assurance & Close-out | ❌ Not suitable (yet) | 2.6 | 2.2 | 3.6 | -4.0 | Moderate assurance gap (score -4.0) |

## Top 20 Findings (severity × confidence)

| # | REQ | Pillar | Analyst | Severity | Conf | Title | Recommendation |
|---|---|---|---|---|---|---|---|
| 1 | REQ007 | D | Dana | **critical** | 10 | CRITICAL: DAA ML training data provenance, sensor-coverage gaps, and bias vector | Add REQ007.1: 'DAA assurance case must include: (a) training dataset sheet (source, size, encounter types, sensor platforms, label accuracy metrics); (b) test-s |
| 2 | REQ008 | D | Dana | **critical** | 10 | CRITICAL: Swarm ML training data, class imbalance, emergent-behaviour labelling  | Add REQ008.1: 'Swarm decision-making assurance must include: (a) training data composition (simulation platform, real-world data sources, synthetic data generat |
| 3 | REQ012 | D | Dana | **critical** | 10 | CRITICAL: MOR obligations name recording but do not specify data classification, | Expand REQ012: '(a) MOR must record: all sensor feeds, AI model decisions/confidence, crew inputs, system state snapshots. Each recording must carry timestamp,  |
| 4 | REQ009 | T | Trevor | **critical** | 10 | AMLAS Explainability Module Missing Consumer-Specific Explanation Strategies | AMLAS case must be supplemented with: (1) Explainability module mapping each model component (swarm consensus, DAA, geofence, etc.) to consumer + explanation st |
| 5 | REQ010 | T | Trevor | **critical** | 10 | Meaningful Human Control Not Operationalised: Override Latency and Workload Thre | Human-oversight case must include: (1) Decision-responsibility matrix: which decisions are AI-sole, human-supervised, or human-sole? (2) Measurable override lat |
| 6 | REQ017 | T | Trevor | **critical** | 10 | Public Trust Completely Absent: No CAP 1616 Community Consultation or Prior Noti | Public engagement case (to be created) must include: (1) CAP 1616 consultation report showing community engagement and response handling, (2) Prior-notification |
| 7 | REQ005 | F | Fiona | **critical** | 10 | CRITICAL: Geofence enforcement lacks independence; single-point failure unmitiga | Dual-independent geofence: (1) Airborne L2: swarm-coordinator software (as-is), (2) Airborne L3: separate safety-critical module (hardened against corruption, G |
| 8 | REQ007 | F | Fiona | **critical** | 10 | CRITICAL: DAA ML lacks distributional-shift detection and post-incident forensic | Mandatory: (1) Calibration study: measure true-positive, false-negative rate at 10 confidence thresholds, plot empirical ROC, ensure selected threshold matches  |
| 9 | REQ009 | F | Fiona | **critical** | 10 | CRITICAL: ML assurance lacks forensic explainability and post-incident audit tra | ML assurance case must include forensic audit trail design: (1) Onboard logging: every input to DAA, swarm-decision, geofence module; every intermediate confide |
| 10 | REQ011 | F | Fiona | **critical** | 10 | CRITICAL: Flight termination not independently assured; contingency matrix incom | Flight termination is last line of defence; must be independent and assured: (1) Redundant termination channels: (a) RC receiver + software relay (pilot manual) |
| 11 | REQ002 | E | Evan | **critical** | 10 | SORA 2.0 framework named but swarm-specific evidence thresholds absent | Produce swarm-specific SORA evidence artefacts: (a) per-aircraft operational risks (as conventional SORA), (b) inter-aircraft coordinated-manoeuvre risks, (c) s |
| 12 | REQ007 | E | Evan | **critical** | 10 | DO-365 / F3442 alignment claimed; swarm de-confliction test plan and acceptance  | DAA/swarm de-confliction assurance: (a) DO-365 mapping matrix (each DO-365 obj → test case ID, test report section), (b) acceptance criteria table (detection ra |
| 13 | REQ009 | E | Evan | **critical** | 10 | AMLAS/SACE container named; governance, re-evidencing, and deployment monitoring | AMLAS assurance case covering: (a) model inventory (each ML component, training dataset provenance, validation metrics AUROC/Precision/Recall), (b) data governa |
| 14 | REQ017 | E | Evan | **critical** | 10 | Requirement entirely absent from pack; community consultation and media manageme | Stakeholder engagement plan: (a) community impact assessment (identify nearby residents, businesses, schools, hospitals affected by trial), (b) consultation str |
| 15 | REQ018 | E | Evan | **critical** | 10 | Requirement entirely absent; classified MOD evidence cannot be integrated withou | Security classification protocol: (a) joint CAA/MOD/Applicant classification review (which evidence is classified? at what level?), (b) redaction procedure (doe |
| 16 | REQ008 | A | Aria | **critical** | 10 | CRITICAL: Architecture reviewed; no human accountable role named for emergent sw | CRITICAL: Add: '(a) Supplier is accountable for swarm architecture design and emergent-behaviour modelling limits; (b) Operator is accountable for real-time swa |
| 17 | REQ015 | A | Aria | **critical** | 10 | CRITICAL: Apportionment deferred; regulatory accountability gap unresolved | CRITICAL: Rewrite REQ015 as mandatory gate: 'GATE: Signed CAA/MAA Apportionment Agreement must be executed before trial authorisation, specifying: (a) Regulator |
| 18 | REQ018 | A | Aria | **critical** | 10 | CRITICAL: Classified MOD evidence accountability custodian undefìned; CAP 722H/J | CRITICAL: Add REQ018 enforcement: 'Named role: Security Classification Custodian (MOD and CAA jointly). Pre-trial mandatory: (a) Classification guide produced s |
| 19 | REQ005 | T | Trevor | **critical** | 9 | Geofence Enforcement Not Paired with AI Override Capability | Geofence architecture must specify: (1) hardware/firmware geofence layer independent of AI, (2) operator override latency (<1s target), (3) test evidence showin |
| 20 | REQ007 | T | Trevor | **critical** | 9 | DAA Evidence Does Not Address Multi-Agent Deconfliction Confidence | DAA submission must include: (1) per-aircraft DO-365 evidence (single-vehicle), (2) multi-agent coordination model card (swarm consensus confidence, latency), ( |

## Agent Cross-Cutting Summaries

### D — Data (by Dana)
- **Overall risk:** 4 / 5
- **Overall maturity:** 2 / 5
- The operational authorisation programme has significant data governance gaps. Five requirements explicitly reference AI/ML components (DAA, swarm decision-making, ML assurance, completeness classifiers implied in SORA/ODD), yet only REQ009 nominally addresses model provenance and explainability. Training data sources, bias vectors, and sensor-fusion quality for live detect-and-avoid remain unspecified across REQ007-REQ008. REQ012 (MOR/DPIA) names privacy obligations but does not define what sensor/telemetry data will be recorded, how bias in labelling will be audited, or how data drift during the trial lifetime will be managed. The programme assumes data will be 'complete' and 'right' without explicit governance for incomplete feeds, adversarial inputs, or class imbalance in swarm coordination models.
- **Top gaps:** DAA training data: source, label accuracy, sensor-coverage gaps in ODD not specified; Swarm ML bias: no discussion of data class imbalance, emergent-behaviour labelling, or adversarial swarm inputs; Data freshness & drift: no lifetime monitoring plan for detection model decay or swarm-behaviour distribution shift; Graceful degradation: no requirement that AI failures degrade safely when sensor data is incomplete or contradictory; MOR releasability: no plan for AI model IP, training dataset licensing, or test-reproducibility data classification

### T — Trust (by Trevor)
- **Overall risk:** 4 / 5
- **Overall maturity:** 2 / 5
- The pack has significant trust gaps in AI-heavy components. REQ009 (ML Assurance) lacks explainability specifics; REQ010 (Human Oversight) does not detail meaningful control triggers or override capability; REQ008 (Swarm Architecture) provides no uncertainty quantification. Trust consumers—CAA assessors, operators, investigators, DAA de-confliction counterparties—are identified but trust transfer mechanisms are absent. REQ017 (Public Engagement) is completely unaddressed. Cross-cutting: no model cards, no uncertainty bounds on AI outputs, no explainability matched to consumer roles, and no post-hoc forensic reconstruction plan for swarm decisions. REQ015 (CAA/MAA interface) assumes regulatory trust transfer without signed apportionment mechanism visible.
- **Top gaps:** No model cards or uncertainty quantification for ML models; Explainability not mapped to consumer needs (post-hoc for operators, causal for investigators); Meaningful human control triggers undefined—override not guaranteed; Public trust (REQ017) completely absent; Forensic reconstruction of swarm decisions not addressed

### F — Failure (by Fiona)
- **Overall risk:** 4 / 5
- **Overall maturity:** 2 / 5
- The BVLOS swarm trial exhibits critical gaps in AI failure detection, forensic explainability, and contingency enforcement. Three keystones—geofence enforcement (REQ005), detect-and-avoid (REQ007), and flight termination (REQ011)—have weak or absent containment. ML assurance (REQ009) lacks forensic post-incident explainability. Swarm emergent behaviour (REQ008) is unmonitored at runtime. No requirement explicitly addresses distributional shift, sensor spoofing, or misuse-by-scope-creep. The trial should not proceed without: mandatory out-of-distribution detection on DAA, independent geofence enforcement below airspace ceiling, redundant flight termination with human oversight, and forensic ML audit trails. Current posture is NOT_SUITABLE for BVLOS uncontrolled release.
- **Top gaps:** No runtime detection of ML distributional shift or high-confidence-wrong events in DAA; Geofence containment lacks independence from main flight stack; single-point failure; Flight termination and human take-over not separately assured; emergency procedures undefined; ML explainability requirement lacks forensic audit trail mandate post-incident; Swarm emergent behaviour unmonitored; no canary/sandbox before full autonomy gate; No adversarial robustness or sensor-spoofing resilience specified for DAA; Operator misuse (scope creep, overconfidence) not in ConOps risk register

### E — Evidence (by Evan)
- **Overall risk:** 4 / 5
- **Overall maturity:** 2 / 5
- The 20 requirements span case-officer intake, SORA, autonomy, ML assurance, and trial governance. Critical gaps: REQ002 (SORA 2.0) and REQ007 (DAA/DO-365) lack swarm-specific evidence thresholds; REQ009 (AMLAS/SACE) names the container but no model-governance or re-evidencing cycle; REQ008 (emergent swarm behaviour) has no acceptance criteria or test methodology; REQ012 (forensic data) is incomplete on failure-mode linkage; REQ016 (phased gates) references gates but no success/go-no-go criteria. REQ017–020 are missing entirely: no stakeholder/community evidence, no security-classification procedure, no environmental impact assessment, no post-trial closeout. The pack assumes AI will work but defers evidence rigour to the trial itself — unacceptable for CAA T&E.
- **Top gaps:** SORA 2.0 swarm evidence framework absent; SAIL/OSO defensibility undemonstrated; DAA/DO-365 acceptance criteria unmeasurable; no swarm de-confliction test plan; ML Assurance governance silent on re-evidencing post-model-update or deployment monitoring; Emergent behaviour unbounded; no state-space coverage or failure-mode test design; Phased gates lack go/no-go decision thresholds; gate criteria undefined; Environmental, security, community, and post-trial evidence wholly absent

### A — Authority (by Aria)
- **Overall risk:** 4 / 5
- **Overall maturity:** 2 / 5
- Accountability for AI-informed decisions is fragmented across requirements. REQ008, REQ009, REQ010 establish governance foundations but lack named human accountable roles when AI recommends actions. REQ011 (termination) has ambiguous authority—no explicit statement that a human, not AI, makes the final call. REQ015 (CAA/MAA boundary) defers inter-regulatory apportionment but does not prevent gaps. REQ018 (classified information handling) has zero accountability framework for information segregation under CAP 722H. REQ012 (investigability) is the strongest finding—forensic reconstruction is required. Cross-cutting risk: swarm emergent behaviour is architecturally bounded (REQ008) but unaccountable for unintended collective outcomes. No requirement names the duty-holder answerable if an AI-informed decision fails; most defer to 'evidence' or 'assurance cases' without naming roles.
- **Top gaps:** No named human accountable role for AI-informed swarm decisions (REQ008 assures architecture, not accountability); Termination authority unclear—is final override human-exclusive or can AI initiate? (REQ011); CAA/MAA apportionment unsigned, enabling regulatory accountability gap (REQ015); ML forensic accountability chain incomplete—no post-incident model-state reconstruction mandate (REQ009); Classified information handling (REQ018) has no security classification accountable role; Inter-organisational seams (supplier→operator, operator→CAA, CAA→MAA) lack explicit accountability maps

---
*OpenRequirements.AI · AI Stress-Test (DTFEA) · 2026-04-22 16:04*