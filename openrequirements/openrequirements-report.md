# DeFOSPAM Requirements Validation Report

![OpenRequirements.ai](https://openrequirements.ai/img/or-logo.png)

**Powered by [OpenRequirements.ai](https://openrequirements.ai)** | Based on the Business Story Method by Paul Gerrard & Susan Windsor

![Findings](https://img.shields.io/badge/findings-125-blue) ![Critical](https://img.shields.io/badge/critical-68-red) ![Major](https://img.shields.io/badge/major-56-yellow) ![Minor](https://img.shields.io/badge/minor-1-green) ![Analysts](https://img.shields.io/badge/analysts-7-purple)

**Source:** `requirements-221fbff5.csv` — 20 requirements for a UK CAA BVLOS UAS Swarm Operational Authorisation pack
**Analysis date:** 2026-04-23 10:14 UTC

---

## Executive Summary

Found **125** findings across **7** DeFOSPAM analysts, working on **88** glossary terms, **30** features, and **69** scenarios.

- **68 critical** findings — requirements cannot be implemented correctly without resolution
- **56 major** findings — significant risk of misunderstanding or incomplete implementation
- **1 minor** findings — improvement opportunities

| Principle | Analyst | Findings | Critical | Major | Minor |
|---|---|---:|---:|---:|---:|
| D — Definitions | Dorothy | 23 | 10 | 12 | 1 |
| F — Features | Flo | 11 | 4 | 7 | 0 |
| O — Outcomes | Olivia | 24 | 16 | 8 | 0 |
| S — Scenarios | Sophia | 16 | 9 | 7 | 0 |
| P — Prediction | Paul | 20 | 17 | 3 | 0 |
| A — Ambiguity | Alexa | 21 | 8 | 13 | 0 |
| M — Missing | Milarna | 10 | 4 | 6 | 0 |

### Headline conclusions

1. **REQ017–REQ020 are not user stories** — four requirements are explicitly absent (public engagement, security classification, environmental impact, post-trial close-out). They cannot be implemented until they are authored.
2. **"Meaningful human control", "swarm-aware", "containment", "forensically explainable", "defensibly", "worst-credible"** — load-bearing terms used as success criteria but not defined. Two assessors applying the same requirement will reach different conclusions.
3. **Safety-critical outcomes are unspecified** — REQ005 (geofence breach action), REQ007 (DAA encounter resolution), REQ011 (independent termination) state goals but not behaviours. Two developers could ship incompatible systems.
4. **No authentication, role-based access control, or audit logging** is called out as a requirement, despite the system spanning applicant, regulator, panel, RAISO, RSO, and AAIB/inquiry roles with classification-sensitive evidence.
5. **The Workbench's own assurance** is not in the requirements set — the meta-problem (assuring the assurance tool) is silent.

---

## Proposed Glossary

*Dorothy extracted **88** significant terms from the 20 requirements. Top 30 by criticality shown; full glossary in `dorothy-glossary.json`.*

| Term | Proposed Definition | Status |
|---|---|---|
| Operational Authorisation pack | A complete submission to the CAA containing all regulatory evidence, safety cases, operational procedures, and technical documentation required for a BVLOS UAS trial to proceed | verified |
| SORA | Specific Operational Risk Assessment - a regulatory framework for assessing UAS operational risks. Version 2.5 is referenced in requirements (JARUS SORA v2.5) | verified |
| swarm-aware SORA evidence | Risk assessment documentation demonstrating how a swarm of UAS operating collectively (rather than individually) presents different operational risks, with evidence specific to coordinated multi-aircr | unverified |
| SAIL | Specific Assurance and Integrity Level - a risk classification level determined by SORA assessment, used to set operational and design requirements | unverified |
| OSO | Operational Safety Objectives - specific safety goals derived from SORA assessment that the operational design and procedures must satisfy | unverified |
| defensibly | In a manner that can be justified and substantiated through evidence and logical argument to regulatory scrutiny | unverified |
| ConOps | Concept of Operations - a narrative description of how the trial will be conducted operationally, including flight profiles, crew roles, decision points, and normal procedures | verified |
| ODD | Operational Design Domain - the operating conditions (environmental, technical, geographical, temporal) for which the UAS and its autonomy systems have been validated and are approved to operate | verified |
| nominal behaviour | Expected, planned system performance under normal operating conditions as described in ConOps | verified |
| worst-credible behaviour | The most severe adverse system performance or failure mode that is reasonably foreseeable and must be survived by containment, backup systems, or crew intervention | unverified |
| TDA | Temporary Danger Area - a designated airspace volume and time window reserved for the UAS trial, excluding other civilian traffic and within which certain rules apply | unverified |
| segregate | To separate the trial airspace and operations from other legitimate airspace users through procedural, technical, or physical means to prevent conflicts | verified |
| containment | Technical and procedural systems that prevent a UAS from leaving its authorized operational area due to control loss, autonomy failure, or link loss | unverified |
| fly-away | Loss of control of a UAS such that it exits its authorized airspace and cannot be recovered by the operator | verified |
| BVLOS | Beyond Visual Line of Sight - operating an aircraft without direct visual contact by the pilot, relying on instrumentation, cameras, or other remote monitoring | verified |
| C2 link | Command and Control link - the communication pathway between the ground crew and the UAS for transmitting commands and receiving status/telemetry data | verified |
| authorised monitored C2 | Command-and-control communications that have been approved by spectrum authorities and are continuously observed to confirm link health, integrity, and absence of interference | unverified |
| inter-vehicle links | Communication pathways between individual UAS aircraft within the swarm, used for coordination, de-confliction, or status exchange | verified |
| link loss survivable | The UAS and swarm have procedures and design such that loss of either C2 or inter-vehicle communication can be managed without loss of separation, collision, or uncontrolled flight | unverified |
| non-interfering | Electromagnetic emissions from the UAS communication systems do not cause harmful interference to other authorized spectrum users | unverified |
| DO-365 | RTCA DO-365 - a standard for performance of Detect-and-Avoid systems for unmanned aircraft systems | verified |
| F3442 | ASTM F3442 - standard for design and performance of detect-and-avoid systems for small unmanned aircraft systems in beyond visual line of sight operations | verified |
| DAA | Detect-and-Avoid - a system that senses other aircraft and airspace hazards and automatically or advisorily initiates avoidance maneuvers to maintain safe separation | verified |
| DAA assessor | A CAA subject matter expert responsible for evaluating Detect-and-Avoid system design, testing, and performance against applicable standards | verified |
| cooperative encounter | An airspace encounter between the UAS and another aircraft that is cooperative (e.g., within a segregated zone with known participants, or with aircraft equipped with transponders and ADS-B) | unverified |
| non-cooperative encounter | An airspace encounter with another aircraft that has not coordinated with the UAS trial and may not be aware of the UAS presence or transmit position information | unverified |
| resolved predictably | Avoidance outcomes are consistent, safe, and align with regulatory requirements regardless of encounter geometry, aircraft performance differences, or weather conditions | unverified |
| coordinated swarm de-confliction | Multi-aircraft separation assurance logic in which the swarm members coordinate their avoidance maneuvers to resolve potential conflicts between each other and external aircraft | unverified |
| swarm | Multiple UAS operating in coordinated flight, sharing a common mission objective, with decision-making authority distributed or centralized across the fleet | unverified |
| decision-making architecture | The design of how operational and safety decisions are made within the swarm, including whether decisions are made autonomously, by distributed consensus, by a lead aircraft, or by ground crew | verified |

---

## Business Stories

*Flo identified **30** distinct features. First 10 shown.*

### Feature: Application Intake

*Source: REQ001 · Granularity: feature · Hidden: False*

> As a CAA case officer 
> I want to receive an Operational Authorisation pack so that I can open and manage a valid case.

### Feature: Completeness Check

*Source: REQ001 · Granularity: sub-feature · Hidden: False*

> As a CAA case officer 
> I want automated validation of pack completeness so that I can identify missing artefacts before case initiation.

### Feature: SORA 2.0 Assessment (Swarm-Aware)

*Source: REQ002 · Granularity: epic · Hidden: False*

> As a CAA SORA assessor 
> I want swarm-aware SORA evidence and guidance so that I can set SAIL and OSO requirements defensibly for multi-agent operations.

### Feature: ConOps & ODD Review

*Source: REQ003 · Granularity: feature · Hidden: False*

> As a CAA safety-case reviewer 
> I want a clear Concept of Operations and Operational Design Domain so that I can judge nominal and worst-credible swarm behaviour.

### Feature: Airspace Change & TDA Coordination

*Source: REQ004 · Granularity: feature · Hidden: False*

> As a CAA airspace regulator 
> I want a TDA and formal consultation package so that I can segregate the trial from other airspace users.

### Feature: Geofence & Containment Enforcement

*Source: REQ005 · Granularity: sub-feature · Hidden: False*

> As a CAA airspace regulator 
> I want automatic geofence enforcement so that a fly-away cannot escape into uncontrolled BVLOS.

### Feature: C2 Link & Spectrum Assurance

*Source: REQ006 · Granularity: feature · Hidden: False*

> As a CAA spectrum specialist 
> I want authorised monitored C2 and inter-vehicle links so that link loss is survivable and non-interfering.

### Feature: Detect-and-Avoid (DAA) Performance Assurance

*Source: REQ007 · Granularity: feature · Hidden: False*

> As a CAA DAA assessor 
> I want DO-365 / F3442-aligned evidence for each aircraft and coordinated swarm de-confliction so that cooperative and non-cooperative encounters are resolved predictably.

### Feature: Swarm Decision-Making Architecture Review

*Source: REQ008 · Granularity: feature · Hidden: False*

> As a CAA autonomy reviewer 
> I want the swarm decision-making architecture, airborne limits, and emergent-behaviour evidence so that I can assure collective behaviour.

### Feature: ML/AI Assurance Case & Model Manifest

*Source: REQ009 · Granularity: feature · Hidden: False*

> As a CAA AI/ML assurance specialist 
> I want an AMLAS / SACE case with a frozen-model manifest and explainability evidence so that ML components are assurable and forensically explainable.

---

## Sample Scenarios

*Sophia produced **69** scenarios across the 20 REQs. First 10 shown; full scenarios in `sophia-scenarios.json`.*

**SCN-001 — Complete operational authorisation pack submitted** · happy_path · REQ001

- **Given** An applicant has assembled a complete Operational Authorisation pack with all required artefacts (ConOps, ODD, SORA evidence, insurance, crew credentials, etc.)
- **When** The applicant submits the pack to the CAA case officer intake system
- **Then** The system accepts the submission, opens a valid case, and transitions to Completeness Check (F02)
- **And** A unique case ID is generated, submitted timestamp is recorded, and case officer receives notification

**SCN-002 — Pack passes automated completeness validation** · happy_path · REQ001

- **Given** A submitted pack undergoes automated validation against the completeness checklist
- **When** All required artefacts (ConOps, ODD, DAA evidence, insurance, crew training, etc.) are present
- **Then** System flags pack as COMPLETE and notifies case officer that case can proceed to SORA assessment
- **And** Case status becomes INTAKE_COMPLETE; timestamp recorded

**SCN-003 — Pack missing critical artefact detected** · exception · REQ001

- **Given** A submitted pack is missing a critical artefact (e.g., SORA evidence or crew credentials)
- **When** Automated completeness check runs
- **Then** System flags the specific missing artefact, sets case to RETURN_FOR_CLARIFICATION status, and generates coaching feedback
- **And** Applicant receives structured feedback identifying exactly what is missing and deadline for resubmission

**SCN-004 — Pack partially submitted, applicant in coaching mode** · exception · REQ001

- **Given** An applicant in Applicant Intake Mode has submitted partial artefacts (e.g., ConOps draft, incomplete SORA evidence)
- **When** Applicant requests coaching feedback before formal submission
- **Then** System provides targeted coaching on what is missing and quality issues without rejecting the case
- **And** Applicant retains ability to revise and resubmit before formal INTAKE_COMPLETE flag

**SCN-005 — Pack re-submitted after return-for-clarification** · exception · REQ001

- **Given** A pack was returned for clarification due to missing artefacts; applicant has resubmitted revised pack
- **When** Second completeness check runs on resubmitted pack
- **Then** System validates all previously flagged items are now present and case transitions to INTAKE_COMPLETE
- **And** Case officer is notified of successful re-submission; version history shows both original and revised submissions

**SCN-006 — Swarm-aware SORA evidence present, defensible SAIL derived** · happy_path · REQ002

- **Given** Pack contains swarm-aware SORA evidence demonstrating coordinated multi-aircraft behaviour, inter-vehicle link robustness, and collective decision-making limits
- **When** SORA assessor reviews evidence and applies SORA 2.0 methodology with swarm context
- **Then** SAIL (Specific Assurance and Integrity Level) and OSO (Operational Safety Objectives) are derived defensibly
- **And** Assessment record is created with clear traceability to swarm-specific evidence; SAIL/OSO documented in case file

**SCN-007 — Swarm evidence sparse, SAIL cannot be auto-derived** · exception · REQ002

- **Given** Pack contains standard single-aircraft SORA evidence but lacks swarm-specific evidence on coordinated de-confliction and collective behaviour limits
- **When** SORA assessor attempts to derive SAIL using swarm context
- **Then** System flags insufficient swarm-aware evidence; case marked for expert panel review rather than auto-green
- **And** SORA assessor documents reason for manual escalation; applicant is notified of evidence gap

**SCN-008 — SORA assessment requires re-assessment after ConOps revision** · exception · REQ002

- **Given** Initial SORA/SAIL derived; ConOps subsequently revised during phased trial (e.g., increased swarm size or autonomy scope)
- **When** Case gates to next phase with new operational envelope
- **Then** System triggers re-assessment of SORA with updated ConOps; previous SAIL may become invalid
- **And** Assessment history captures both original and revised SAIL determinations

**SCN-009 — Clear ConOps and ODD reviewed, nominal and worst-credible behaviour judged** · happy_path · REQ003

- **Given** Pack contains detailed ConOps (flight profiles, crew roles, decision procedures) and ODD (environmental limits, GNSS availability, airspace constraints)
- **When** Safety-case reviewer assesses ConOps and ODD clarity
- **Then** Reviewer confirms understanding of nominal swarm behaviour and identifies credible worst-case scenarios (link loss, geofence breach, non-cooperative encounter)
- **And** ConOps/ODD marked APPROVED; documented in case file with reviewer sign-off

**SCN-010 — ConOps ambiguous or missing failure mode procedures** · exception · REQ003

- **Given** ConOps submitted is vague on crew takeover procedures or contingency triggers
- **When** Safety-case reviewer reads ConOps
- **Then** Reviewer cannot confidently judge worst-credible behaviour; flags ConOps as INCOMPLETE
- **And** Applicant is requested to provide detailed failure mode procedures (e.g., link-loss response, geofence-trigger RTL) before proceeding

---

## Findings by Principle

### D — Definitions · Dorothy

*23 findings*

#### [CRITICAL · C10] Critical term 'swarm-aware' is undefined

*Type: undefined_term*

**Detail:** This is a foundational requirement (REQ002) for SORA assessment of swarm operations. Without defining what 'swarm-aware' means, SORA assessors lack clear criteria for what evidence to demand and what distinguishes a swarm SORA from a standard single-aircraft SORA. The distinction carries regulatory weight in setting SAIL and OSO requirements.

**Recommendation:** Define 'swarm-aware' explicitly to cover: (1) interdependencies between aircraft (e.g., coordinated de-confliction, communication dependencies), (2) failure modes of the swarm formation logic, (3) emergent behaviors not present in single-aircraft operations, (4) decision-making authority distribution. Reference JARUS SORA v2.5 guidance on multi-UAS operations if applicable.

---

#### [CRITICAL · C10] 'Meaningful human control' lacks measurable definition

*Type: undefined_term*

**Detail:** This is a high-stakes regulatory term used to justify autonomous operations. REQ010 implies it must be 'demonstrated' but provides no criteria: What time response is acceptable for takeover? What authority must crew retain? What happens if workload saturates? The term 'meaningful' is inherently subjective and contested in AI safety literature. Without operational thresholds, assessors cannot evaluate whether evidence is sufficient.

**Recommendation:** Define 'meaningful human control' with measurable criteria: (1) Crew situational awareness thresholds (update frequency, comprehensiveness of displayed state), (2) Authority preservation (irreversible decisions require explicit crew authorization; reversible decisions are permitted autonomously), (3) Takeover time requirements (e.g., crew must regain control within X seconds for off-nominal events), (4) Workload limits (max number of concurrent events, max duty cycle per hour), (5) Failure modes where control is lost and recovery strategy. Reference CAA human factors standards or EASA Special 

---

#### [CRITICAL · C10] 'Containment' lacks design and verification criteria

*Type: undefined_term*

**Detail:** REQ005 uses 'automatic containment' as a safety critical mechanism but does not specify: (1) What is the physical tolerance of the geofence boundary (e.g., +/- 50m, +/- 100m)? (2) What is the fail-safe mechanism if onboard geofence logic fails (e.g., barometric altimeter fails)? (3) What is the design standard (DO-254, DO-178C, DEFSTAN)? (4) What environmental factors affect containment (GPS drift, multipath, wind models for compliance prediction)? (5) What is the test and verification approach (simulation, flight test, Monte Carlo analysis)?

**Recommendation:** Define 'automatic containment' with: (1) Design standard reference (e.g., 'DO-254 DAL B for geofence logic'), (2) Boundary definition (e.g., 'geofence boundary with +/- X meters tolerance in horizontal and +/- Y meters in vertical'), (3) Failure modes covered (C2 loss, GPS loss, autonomy failure, pilot override attempt), (4) Test approach (e.g., 'Monte Carlo analysis of 100 failure scenarios across environmental ODD bounds; no boundary exceedance in any test'), (5) Relationship to DEFSTAN 00-970 Part 9 or analogous autonomy safety standard.

---

#### [CRITICAL · C10] 'Forensically explainable' undefined; unrealistic standard may result

*Type: undefined_term*

**Detail:** This term sets an unusually high bar for ML transparency in safety-critical systems. 'Forensically' suggests investigative/legal standards. But for neural networks and deep learning, perfect post-hoc explainability is mathematically infeasible (black-box problem). REQ009 does not clarify: (1) What level of explainability is required (layer-wise analysis, feature importance, decision boundary mapping)? (2) Does it apply to all ML models or only safety-critical ones? (3) What is the fallback if a model cannot be fully explained (reject it, accept with lower SAIL level)? (4) Are approved explaina

**Recommendation:** Define 'forensically explainable' relative to ML model type and safety role: (1) For traditional ML (decision trees, linear models, SVMs): require full model transparency including feature importance and decision boundaries. (2) For neural networks: define acceptable explainability techniques (LIME, saliency maps, concept activation vectors) and require demonstration that these methods can reconstruct the model's decision for test cases. (3) Require 'frozen-model manifest' including training data provenance, hyperparameters, and validation performance on hold-out test sets. (4) Require post-de

---

#### [CRITICAL · C10] 'Frozen-model manifest' vague on retention and reconstruction

*Type: undefined_term*

**Detail:** 'Frozen' suggests immutable, but the requirement does not specify: (1) What data must be retained (model weights, architecture, training dataset, validation dataset, hyperparameters)? (2) For how long (indefinitely? until trial closure? per incident investigation)? (3) How is it secured (access control, integrity verification)? (4) What constitutes a 'manifest' (structured format, what fields, version control)? (5) Can proprietary training data be redacted or must all data be disclosed? (6) Who owns and maintains the manifest? (7) Is reconstruction required immediately post-flight or only upon

**Recommendation:** Define 'frozen-model manifest' to include: (1) **Model Definition**: trained weights, architecture (layers, activation functions, regularization), version number with Git hash or equivalent. (2) **Training Data**: dataset size, distribution statistics, any sensitive data handling, reproducible random seed. (3) **Validation Performance**: accuracy/precision/recall on hold-out test set, performance across ODD subdomains. (4) **Hyperparameters**: learning rate, batch size, regularization, stopping criteria. (5) **Deployment**: model serialization format, inference framework/version, hardware depe

---

### F — Features · Flo

*11 findings*

#### [CRITICAL · C10] Four Critical Features Have No User Story (REQ017-020)

*Type: missing_feature*

**Detail:** REQ017-020 explicitly state 'No user story covers...' and instead describe what is 'strongly implied' or 'absent'. These are critical regulatory requirements (CAP 1616, CAP 722H/JSP 440, environmental regulations, institutional audit trails) but have no stakeholder perspective or acceptance criteria. This creates ambiguity about system behaviour, scope, and success metrics.

**Recommendation:** Immediately author user stories for REQ017-020 by consulting: (1) CAP 1616 consultation requirements, (2) CAP 722H/JSP 440 classification handling rules, (3) environmental impact assessment standards, (4) post-trial audit and closeout procedures. Engage stakeholders (community liaisons, security officers, environmental assessors, programme managers) to define acceptance criteria.

---

#### [CRITICAL · C9] Operator-Private Feedback vs Regulator Decision Record Not Addressed

*Type: missing_feature*

**Detail:** The context describes two user journeys: (1) operator-facing pre-submission preparation and (2) regulator-facing decision mode. No REQ explicitly addresses how these modes remain segregated. If feedback from mode (1) leaks into mode (2), the system violates applicant privacy and may compromise regulator independence. This is a critical architectural feature, not a functional nicety.

**Recommendation:** Define F25 (Operator-Private Feedback vs Regulator Decision Record Segregation) explicitly. Clarify: (1) which artefacts/annotations are operator-private, (2) which are visible to regulators, (3) how the system prevents accidental cross-contamination, (4) what audit trail exists for segregation enforcement. This may require dual-channel record management or role-based view filtering.

---

#### [CRITICAL · C9] Classified Evidence Access Control Not Detailed

*Type: hidden_feature*

**Detail:** REQ018 notes that 'classified MOD evidence is presented to the CAA under CAP 722H / JSP 440 without compromise'. This requires: (1) classification tagging on ingest, (2) role-based view filtering, (3) redaction rules, (4) compartmentalization enforcement. No REQ specifies these mechanisms, yet they are non-negotiable for MOD involvement.

**Recommendation:** Define F24 (Classification-Aware Evidence Segregation) as a hidden sub-feature. Clarify: (1) classification tags (UK caveat, MOD-only, releasable, etc.), (2) role-to-clearance mapping, (3) automatic redaction rules, (4) audit trail for access. Work with MOD security and CAA to define compartmentalization rules.

---

#### [CRITICAL · C9] Environmental Impact Assessment Lacks Specificity

*Type: missing_feature*

**Detail:** REQ019 notes that 'no user story covers noise, species disturbance at dusk/night, or battery-fire environmental risk on ground'. These are distinct regulatory concerns (noise pollution, wildlife protection, fire safety) with different evidence types, assessment methodologies, and stakeholders. REQ019 lumps all three together without acceptance criteria or role clarity.

**Recommendation:** Decompose REQ019 into three features: (1) Noise Impact Assessment (dB levels, mitigation), (2) Wildlife Disturbance Assessment (species, timing, mitigation), (3) Battery Fire Risk Assessment (ground fire hazard, containment). Define stakeholder roles (environmental officer, wildlife assessor, fire safety officer) and acceptance criteria for each.

---

### O — Outcomes · Olivia

*24 findings*

#### [CRITICAL · C10] REQ001: Incomplete pack rejection outcome undefined

*Type: missing_outcome*

**Detail:** REQ001 specifies happy path (complete pack received -> case opened) but omits failure path. A developer must guess whether to reject silently, send feedback, block case opening, or loop back for revision. This is a gate condition that determines trial lifecycle.

**Recommendation:** Define explicit outcomes for each incompleteness scenario: (a) missing document type -> automated return with list; (b) document present but non-conformant format -> feedback loop; (c) assessment of completeness fails -> escalation. Link to F02 completeness-check feature.

---

#### [CRITICAL · C10] REQ005: Geofence breach action outcome is unspecified (CRITICAL SAFETY)

*Type: missing_outcome*

**Detail:** REQ005 states the outcome NEED ('cannot become uncontrolled BVLOS') but NOT the mechanism (what the swarm does when boundary is crossed). Safety-critical systems require explicit action specifications. A developer cannot implement containment without knowing the exact response. This is a collision between requirement (prevent escape) and mechanism (how?). Different mechanisms have different hazards: hard kill = rapid descent hazard; RTL = extended uncontrolled flight during return; soft stop = swarm hanging in restricted airspace.

**Recommendation:** Specify concrete geofence actions per aircraft state: (1) boundary approach warning (crew alert) 30 seconds before breach; (2) boundary hard entry (aircraft position exceeds limit) -> immediate motor soft-stop (reduce thrust to hover level, not zero); (3) after stop, remain on station and notify crew/ATSU; (4) crew initiates RTL or abort. Define margin between warning boundary and hard stop boundary. Define timeout for crew response.

---

#### [CRITICAL · C10] REQ006: Link loss outcome undefined (failover vs. crew takeover vs. RTL)

*Type: missing_outcome*

**Detail:** Link loss is the primary failure mode in BVLOS swarm operations. 'Survivable' is passive (something survives) but not a design specification (what action is taken?). A developer cannot build link-loss logic without knowing the intended behavior. Each outcome has different risk profiles: autonomous RTL = continued flight control but loss of crew override; manual takeover = crew control but dependency on crew response time; hold = maintains separation but no progress toward landing.

**Recommendation:** Define link-loss action hierarchy: (1) link loss detected -> swarm transitions to autonomous mode; (2) if inter-vehicle links intact, swarm executes pre-planned contingency route (if available) or holds current position and hovers at current altitude; (3) if inter-vehicle links also lost (dual-link loss), each aircraft executes independent RTL to pre-designated recovery point; (4) crew is notified but cannot override during autonomous phase (link loss = crew command unavailable). Define link-loss timeout threshold and automatic transition point.

---

#### [CRITICAL · C10] REQ007: Detect-and-avoid resolution action undefined (evasion strategy unspecified)

*Type: missing_outcome*

**Detail:** DAA is safety-critical for BVLOS swarm ops, especially for non-cooperative encounters (unknown aircraft, no coordination). 'Resolved predictably' is a requirement statement but not a behavior specification. Predictable to whom? A developer cannot implement DAA without knowing which avoidance maneuver is preferred, in what priority order (climb vs. turn), and who decides (crew vs. autonomy). Different maneuvers create different hazards: climb = altitude loss recovery time; turn = swarm fragmentation risk; hold = potential mid-air collision if intruder is also holding.

**Recommendation:** Define DAA resolution hierarchy per encounter type: (1) cooperative encounter (known aircraft, ADS-B equipped, coordination possible) -> crew-directed, advisory avoidance with crew approval; (2) non-cooperative encounter -> autonomous escalating response: first alert crew (X seconds to decide), if no crew response within timeout, execute pre-planned horizontal turn (right by default) to heading that maximizes separation. Define separation thresholds triggering each action, time-to-decision windows, and crew override capability.

---

#### [CRITICAL · C10] REQ008: Swarm decision-making deviation outcome undefined (fallback action missing)

*Type: missing_outcome*

**Detail:** Swarm autonomy in a BVLOS trial implies some level of distributed decision-making. The requirement to 'assure what the swarm will do' is an assurance goal (pre-flight) but does not address runtime deviation. In real operations, emergent behavior can occur due to noise in sensor inputs, timing delays, or coordina failure. A developer must know: is deviation acceptable within bounds? Is there a fallback behavior? Is crew override always available?

**Recommendation:** Define swarm deviation outcomes: (1) establish bounds of acceptable deviation (e.g., formation drift <X meters, timing skew <Y seconds); (2) if deviation exceeds bounds, crew is alerted with deviation magnitude and expected recovery time; (3) crew has override capability (force all aircraft to hold position and await new commands); (4) if crew does not respond within timeout or override fails, flight is automatically terminated (independent termination system activates). Define deviation detection method and thresholds.

---

### S — Scenarios · Sophia

*16 findings*

#### [CRITICAL · C10] REQ017 Public & Stakeholder Engagement absent - CAP 1616 compliance undefined

*Type: missing_scenario*

**Detail:** REQ017 is marked as absent (no user story); however CAP 1616 (public engagement guidance) and GDPR (prior notification obligations) strongly imply consultation is mandatory. Without explicit requirement, system cannot enforce consultation, risking regulatory non-compliance and community backlash.

**Recommendation:** Create explicit REQ017 user story: 'As a CAA community liaison I want to manage stakeholder consultation and prior notification (CAP 1616 compliant) so that community engagement is documented and GDPR obligations are met.' Define system behaviors for consultation triggers, documentation, and approval gate.

---

#### [CRITICAL · C10] REQ018 Security Classification Handling absent - MOD evidence custody undefined

*Type: missing_scenario*

**Detail:** REQ018 is marked absent (no user story); however CAP 722H and JSP 440 clearly mandate secure handling of classified evidence. Without explicit requirement, system cannot enforce classification-aware access control, redaction, or secure custody, exposing security compromise risk.

**Recommendation:** Create explicit REQ018 user story: 'As a CAA security officer I want to manage classified MOD evidence securely (CAP 722H / JSP 440 compliant) so that regulatory assurance is achieved without security breach.' Define system features: classification tagging, compartmented access, secure storage, redaction on export.

---

#### [CRITICAL · C10] REQ019 Environmental Impact Assessment absent - noise and species disturbance undefined

*Type: missing_scenario*

**Detail:** REQ019 is marked absent (no user story); however environmental obligations are implicit in CAA policy (noise, species protection, battery fire risk). Without explicit requirement, environmental assessment is deferred, risking ecological harm and post-trial regulatory action.

**Recommendation:** Create explicit REQ019 user story: 'As a CAA environmental assessor I want to review environmental impact documentation (noise, species disturbance, battery-fire risk) so that ecological compliance is assured.' Define assessment scope, required studies, and approval thresholds.

---

#### [CRITICAL · C10] REQ020 Post-Trial Close-out absent - evidence preservation and lessons-learned framework undefined

*Type: missing_scenario*

**Detail:** REQ020 is marked absent (no user story); however institutional learning and forensic audit trail are critical for regulatory defensibility and future-trial improvement. Without explicit requirement, post-trial closure is informal, risking loss of evidence and knowledge.

**Recommendation:** Create explicit REQ020 user story: 'As a CAA programme manager I want to formally close authorization with post-trial lessons-learned capture and evidence archival so that institutional learning is preserved.' Define close-out checklist, lessons-learned mandatory sections, evidence retention policy (minimum 7 years).

---

#### [CRITICAL · C9] REQ001 'Complete' pack is undefined - no artefact enumeration in requirements

*Type: negative*

**Detail:** REQ001 uses 'complete Operational Authorisation pack' but does not enumerate what 'complete' means. Dorothy's glossary flags this as unverified. Without explicit artefact list (ConOps, ODD, SORA, insurance, crew credentials, etc.), system cannot validate completeness; cases may be opened prematurely or rejected incorrectly.

**Recommendation:** Define explicit completeness checklist: minimum required artefacts and acceptance criteria for each. Example: '(a) ConOps narrative ≥ 10 pages describing nominal and contingency procedures; (b) ODD specification with quantitative boundaries; (c) SORA evidence addressing swarm-specific risks; (d) Insurance certificate (£10M+ coverage); (e) Crew credentials with type rating.' Embed checklist in F02.

---

### P — Prediction · Paul

*20 findings*

#### [CRITICAL · C10] REQ005: Geofence breach outcome completely unpredictable

*Type: unpredictable_outcome*

**Detail:** REQ005 states outcome NEED ('cannot become uncontrolled BVLOS') but not mechanism ('what the aircraft does'). A developer faces three conflicting design choices: (1) graceful containment (soft stop, hover, crew takeover) - takes time but recoverable; (2) hard termination (cut motors, rapid descent) - stops escape but risks ground impact; (3) autonomous RTL (return to launch) - maintains control but extends flight duration beyond geofence. Each has different hazard profiles. Without explicit mechanism, two developers could implement incompatible behaviors.

**Recommendation:** Specify geofence response hierarchy per aircraft state: (1) boundary APPROACH (aircraft position within 50m of limit) -> crew alert + reduced autonomy; (2) boundary ENTRY (aircraft exceeds limit) -> immediate motor soft-stop to hover thrust, crew notified, containment engaged; (3) boundary BREACH PERSISTENCE (aircraft remains outside >5 seconds after soft-stop) -> escalate to independent termination system. Define warning distance, timeout thresholds, and fallback chain.

---

#### [CRITICAL · C10] REQ005: Geofence system failure - no specification of what happens when geofence itself fails

*Type: unpredictable_outcome*

**Detail:** SCN-017 exists in Sophia's scenarios: 'Geofence system itself fails - no containment available.' It proposes that system detects failure and initiates contingency. But REQ005 does not specify this. Two developers might: (1) fail-safe (abort immediately); (2) fail-operate (continue with backup logic); (3) fail-dangerous (continue without enforcement). Scenario is defined but outcome is not linked to requirement.

**Recommendation:** Add explicit requirement: 'As a CAA airspace regulator, I want geofence system failure to be detected and responded to immediately so that loss of containment enforcement does not result in uncontrolled flight. On geofence unavailability detection: (1) onboard health monitor flags geofence as UNAVAILABLE; (2) if failure occurs pre-flight, system blocks launch; (3) if failure occurs in-flight, immediate crew alert with geofence loss icon and timer; (4) swarm initiates 30-second RTL countdown; crew can extend mission once (30 more seconds) to find safe landing zone or abort. Pre-flight health ch

---

#### [CRITICAL · C10] REQ006: Link loss outcome is the core unpredictable gap - no specification of what swarm does when C2 is lost

*Type: unpredictable_outcome*

**Detail:** REQ006 uses passive language: 'link loss is survivable' (something survives). This is a property requirement, not a behavior specification. A developer must guess the mechanism: (1) autonomous RTL (swarm navigates home, crew has no control); (2) manual takeover (crew resumes command via backup link or direct); (3) pre-planned waypoints (swarm executes backup navigation plan); (4) hold-in-place (swarm hovers and waits for link recovery). Each has different recovery time, crew involvement, and risk profile. SCN-020 and SCN-039 describe link loss contingency but are not mandatory from REQ006.

**Recommendation:** Specify link loss response as sequence: (1) C2 link loss detected by onboard monitor (<1 second detection latency); (2) swarm members broadcast link-loss event to each other via inter-vehicle RF link; (3) crew receives alert ('C2 LINK LOST - SWITCHING TO AUTONOMOUS') with countdown timer (30 seconds for crew response); (4) if crew can re-establish link within timeout, manual control resumes; (5) if timeout expires or link remains lost, swarm executes autonomous contingency: all members navigate to nearest pre-planned SAFE_LANDING_WAYPOINT using GPS + inter-vehicle consensus; (6) crew monitorin

---

#### [CRITICAL · C10] REQ007: DAA non-cooperative encounter resolution action completely unspecified

*Type: unpredictable_outcome*

**Detail:** REQ007 requires encounters 'are resolved predictably' but does not define which avoidance action (climb, turn, descend, hold) is used, who decides (crew vs autonomy), or timing. 'Predictable resolution' is an outcome property, not a behavior spec. A developer cannot implement DAA without choosing an evasion strategy. Non-cooperative encounters (no radar transponder) are safety-critical; different strategies have different hazards: climb = extended flight time, fuel consumption; turn = formation fragmentation; descend = proximity to ground/obstacles.

**Recommendation:** Define DAA resolution logic per encounter type: (1) COOPERATIVE (known aircraft, ADS-B transponder): DAA system provides crew with recommended avoidance (e.g., 'Climb to 500ft', 'Turn 30deg right'); crew has 5 seconds to approve/reject; if crew doesn't respond, maneuver executes automatically; (2) NON-COOPERATIVE (unknown aircraft, no transponder): DAA system detects intruder via radar/vision only; system defaults to conservative ALTITUDE CLIMB (change altitude by +200ft or -200ft away from intruder estimate); maneuver executes immediately; crew is alerted post-maneuver. Define avoidance hiera

---

#### [CRITICAL · C10] REQ008: Emergent swarm behavior deviation - no specification of what happens when behavior deviates from assurance case

*Type: unpredictable_outcome*

**Detail:** REQ008 requires assurance of 'what the swarm will do' but does not address runtime deviation. The assurance case (pre-flight analysis) predicts behavior bounds. But real operations introduce noise, sensor delays, communication skew. If actual behavior deviates, is this a failure? Must crew be alerted? Is there a fallback? Scenario SCN-030 proposes undesired emergent behavior detection but is not mandatory from REQ008. Without specification, deviation handling is unpredictable.

**Recommendation:** Add requirement: 'System shall monitor swarm decision-making against assurance bounds. (1) Bounds are defined per ConOps phase: Phase 1 formation bounds = all aircraft within 50m cube; Phase 2 bounds = all aircraft within 200m envelope. (2) During flight, system continuously calculates deviation from bounds (actual formation size vs. predicted maximum). (3) If deviation approaches yellow threshold (90% of bound), crew receives advisory alert with deviation magnitude and 'Monitor' status. (4) If deviation exceeds red threshold (100% of bound), crew receives critical alert with 'DEVIATION EXCEED

---

### A — Ambiguity · Alexa

*21 findings*

#### [CRITICAL · C10] Undefined completeness criteria for Operational Authorisation pack

*Type: vague_quantifier*

**Detail:** The entire regulatory intake process hinges on this undefined threshold. If completeness is subjective, different case officers may accept different submissions. If objective, the checklist is not provided. Dorothy glossary confirms 'complete' is unverified with no criteria given. This is the foundation requirement—failure cascades.

**Recommendation:** Define 'complete Operational Authorisation pack' with an explicit enumerated checklist of required documents, each with specified format, version, and submission rules. Reference a normative document (e.g., CAP 722 Section X) or create a dedicated submission template.

---

#### [CRITICAL · C10] 'Meaningful human control'—borrowed from LAWS debate; no civil aviation definition exists

*Type: undefined_reference*

**Detail:** Dorothy glossary notes 'meaningful human control' is 'heavily debated term. No aviation standard in civil aviation.' The phrase originates in international humanitarian law (LAWS treaty debate on autonomous weapons) and has no consensus definition in civil aviation. Different CAA inspectors could interpret this radically differently. The vague timing 'throughout' compounds the ambiguity: does this mean continuous direct control, periodic review, or exception-based intervention?

**Recommendation:** Replace 'meaningful human control' with specific, measurable criteria: 'Human crew shall demonstrate control via: (1) [Situational awareness demonstrated by workload assessment per NASA TLX ≤ X \| Crew decision-making time ≤ Y seconds], (2) Takeover capability with [latency ≤ Z seconds \| success rate ≥ 99% in simulation]. Takeover shall be required for decisions involving: [phase change \| airspace boundary \| contingency response]. Crew monitoring shall occur [continuously \| at intervals ≤ N seconds] per [CAA-approved workload model].'

---

#### [CRITICAL · C10] Structural completeness gap: user stories absent for REQ017-020

*Type: undefined_reference*

**Detail:** REQ017-020 have titles but no user stories, success criteria, or accountable roles. Stakeholder engagement, security, environmental risk, and close-out are critical to regulatory approval but are not expressed as testable requirements. Without user stories, there is no actor (who is responsible?), no goal (what must be achieved?), and no verification (how will we know when it's done?).

**Recommendation:** Create explicit user stories for each: REQ017: 'As a CAA authorisation officer, I want a documented stakeholder engagement plan covering [community notification, press/media response, landowner coordination] so that I can approve the trial in compliance with CAP 1616 and GDPR.' REQ018: 'As a CAA/MOD liaison, I want a classified evidence handling procedure per CAP 722H and JSP 440 so that MOD and CAA can review safety cases without security compromise.' REQ019: 'As an Environmental Assessment Officer, I want evidence of environmental impact assessment [noise, wildlife, battery risk] so that I c

---

#### [CRITICAL · C9] Passive voice obscures accountability for 'defensibly' setting SAIL and OSO

*Type: passive_voice_hides_actor*

**Detail:** The word 'defensibly' is load-bearing in a safety-critical decision (setting SAIL/OSO). It hides the actor (who judges defensibility?) and the standard (defensible against whom? a court? peer review? regulator audit?). Dorothy glossary marks 'defensibly' as high-stakes and undefined. Without clarification, assessors cannot know what threshold they must meet and regulators cannot verify compliance.

**Recommendation:** Replace 'defensibly' with explicit criterion: 'I can set SAIL and OSO requirements supported by [quantitative risk model / expert panel consensus / peer-reviewed analysis / regulatory precedent]. Example: 'I can set SAIL and OSO requirements that satisfy the JARUS SORA v2.5 risk matrix and are documented in the SORA Case File.'

---

#### [CRITICAL · C9] 'Automatic containment'—trigger and scope undefined

*Type: vague_timing*

**Detail:** Dorothy glossary marks 'containment' as unverified with no specification of tolerance, fail-safe assumptions, or design standards. 'Automatic' lacks trigger criteria: loss of C2? Autonomy failure? Geofence breach? Each interpretation implies different system architecture. Is containment a hard stop (reject commands outside bounds) or soft limit (warn then enforce)? No definition provided.

**Recommendation:** Specify containment with explicit triggers and mechanisms: 'Automatic containment shall enforce airspace boundaries by [hard-coded geofence limits \| monitored by independent FPGA \| enforced by loss-of-signal failsafe]. Containment triggers on: (1) loss of C2 for > [X seconds], (2) autonomy detection of out-of-ODD condition, (3) [other conditions]. Containment tolerance band: [±Y meters].'

---

### M — Missing · Milarna

*10 findings*

#### [CRITICAL · C10] REQ017-020 absent user stories—four critical regulatory requirements have no acceptance criteria

*Type: missing_meta_requirement*

**Detail:** REQ017-020 are explicitly flagged as absent in the requirements source document. Dorothy's glossary, Flo's features analysis, Olivia's outcomes analysis, and Sophia's scenarios analysis all confirm these four are missing formal requirement specification. Alexa's ambiguity analysis confirms REQ017-020 have no user stories. Without user stories, these are aspirations, not requirements.

**Recommendation:** Create explicit user stories for REQ017-020: (1) REQ017: 'As a CAA community liaison I want to manage stakeholder consultation and prior notification per CAP 1616 so that community engagement is documented and GDPR obligations are met.' (2) REQ018: 'As a CAA security officer I want to manage classified MOD evidence per CAP 722H / JSP 440 so that regulatory assurance is enabled without security breach.' (3) REQ019: 'As a CAA environmental assessor I want to assess noise, species disturbance, and battery-fire environmental impact so that ecological compliance is verified.' (4) REQ020: 'As a CAA 

---

#### [CRITICAL · C9] No cross-cutting authentication / authorisation requirement—role-based access control undefined

*Type: missing_cross_cutting*

**Detail:** Flo's feature analysis identifies F25 (Operator-Private Feedback vs Regulator Decision Record Segregation) and F24 (Classification-Aware Evidence Segregation) as hidden features, implying role-based access is non-obvious but critical. Dorothy's glossary identifies terms like 'assure' and 'defensibly' that imply decision authority but do not define authority boundaries. No REQ explicitly states access control rules for different user roles.

**Recommendation:** Create explicit cross-cutting requirement: 'As a CAA system administrator I want role-based access control so that case file access is restricted to authorized roles and audit trail is maintained. Roles: [Applicant (read-only to own case), CAA Case Officer (read-write case metadata), SORA Assessor (read-write SORA evidence), DAA Assessor (read-write DAA evidence), Security Officer (read-write classified evidence with redaction), Regulator Panel (read-write decision records), CAA Director (override/escalation authority)]. Access rules: [Applicant cannot view regulator decision drafts], [Classif

---

#### [CRITICAL · C9] No audit logging requirement—system actions (approval, rejection, override) not traceable for forensic review

*Type: missing_cross_cutting*

**Detail:** Olivia's outcomes analysis explicitly names F30 (Audit Logging & Forensic Trail) as an 'implied by incident investigation (F13) and decision logging (F26)' but notes it is not explicit. Multiple analyses mention decision logging (Olivia) and reversible gates (Flo, Sophia) but no REQ specifies how reversals are logged or how audit trail is maintained. Dorothy's findings on 'assure' and accountability note that passive voice obscures responsibility.

**Recommendation:** Create explicit cross-cutting requirement: 'As a CAA auditor I want all system actions logged so that authorization decisions are forensically reviewable and audit trail is legally defensible. Audit log shall capture: [action type], [actor/role], [timestamp], [affected artefact], [change details], [justification/reason]. Immutability: logs cannot be modified post-creation; deletion only per [retention policy]. Access: audit log visible to [CAA management, external auditors, accident investigators] with [read-only \| audit trail summary only] permissions. Retention: [minimum 7 years post-author

---

#### [CRITICAL · C9] REQ016 phased gates lack explicit pass/fail criteria—evidence thresholds undefined

*Type: missing_outcome*

**Detail:** Sophia's scenarios analysis includes SCN-060 (phased trial gates with evidence type matrices) showing gate structure but notes this is data-driven (not a requirement). Olivia's outcomes analysis identifies 'phase gate progression decision criteria undefined' as major finding. Flo's features analysis notes 'phase gates lack explicit pass/fail criteria.' Multiple analysts identify the gap but no explicit REQ defines gate criteria.

**Recommendation:** Define explicit gate criteria in REQ016: 'For each phase gate, define entry criteria, pass metrics, and approval process: Phase 1 (single aircraft, VLOS/EVLOS): [Entry: completeness check pass. Pass metrics: 10 incident-free flights, ConOps nominal procedures demonstrated, crew competency validated. Approval: CAA programme manager with safety review.] Phase 2 (single aircraft, BVLOS): [Entry: Phase 1 pass. Pass metrics: 15 BVLOS flights, autonomy behavior nominal per ODD bounds, geofence integrity confirmed, link-loss contingency tested. Approval: CAA programme manager + SORA expert.] Phase 3 

---


*Full finding details for all 125 findings are in `openrequirements-results.json`.*

---

*Report generated by [OpenRequirements.ai](https://www.openrequirements.ai) · Based on the Business Story Method by Paul Gerrard & Susan Windsor*
