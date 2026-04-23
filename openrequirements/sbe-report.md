# Specification by Example Transformation Report

**Powered by [OpenRequirements.ai](https://openrequirements.ai)** · SBE methodology by Gojko Adzic

![Specs](https://img.shields.io/badge/refined_specs-69-blue) ![Features](https://img.shields.io/badge/feature_files-17-purple) ![Scenarios](https://img.shields.io/badge/gherkin_scenarios-84-green) ![Findings](https://img.shields.io/badge/findings-122-orange) ![Critical](https://img.shields.io/badge/critical-31-red)

**Source:** DeFOSPAM + Vibe Requirements + Performance Engineering + `requirements-221fbff5.csv`
**Analysis date:** 2026-04-23 11:30 UTC

---

## Executive Summary

Transformed 125 DeFOSPAM findings + 15 Vibe Requirements + 97 PE findings into:

- **15** business goals derived (Grace)
- **42** canonical language terms (Chris)
- **10** collaboration workshops recommended (Chris)
- **15** concrete key examples with realistic data (Isabel)
- **69** refined specifications — domain-language clean (Rex)
- **17** Gherkin feature files with **84** scenarios (angie)
- Validation: **10** smoke / **55** regression / **69** full (Victoria)
- Living documentation across 3 phases and 10 service-blueprint steps (Laveena)

### Summary by Process Pattern

| Pattern | Analyst | Findings | Critical | Major | Minor |
|---|---|---:|---:|---:|---:|
| **G** — Goals | Grace | 8 | 3 | 5 | 0 |
| **S** — Collaborate | Chris | 12 | 12 | 0 | 0 |
| **I** — Illustrate | Isabel | 8 | 3 | 5 | 0 |
| **R** — Refine | Rex | 64 | 0 | 59 | 5 |
| **A** — Automate | angie | 11 | 5 | 6 | 0 |
| **V** — Validate | Victoria | 9 | 4 | 5 | 0 |
| **L** — Living Docs | Laveena | 10 | 4 | 6 | 0 |

---

## Business Goals (Grace)

| Rank | Goal | Metric | Stakeholders |
|---:|---|---|---|
| 1 | **Build Defensible Approval Throughput** — Enable CAA to consistently authorize BVLOS UAS swarm trials through high-quality, complete application intake and defensible regulatory assessment | PackCompleteness scale (90-100% first-submission completeness by Q3 2026); case  | regulator, applicant |
| 1 | **Ensure Containment & Flight Safety** — Provide automated and procedural safeguards to prevent uncontrolled flight, loss-of-separation, and unplanned entry into adjacent airspace through geofence enforcement, C2 link resilience, and indepen | GeofenceContainment scale; C2LinkResilience scale; IndependentFlightTermination  | regulator, public |
| 2 | **Assure Swarm-Aware Safety Assessment** — Establish SORA and autonomy assessment processes that explicitly account for swarm interdependencies, emergent behavior, and collective failure modes beyond individual aircraft analysis | SwarmAwareSORAEvidence scale; DAAPerformance scale; SwarmEmergentBoundedness sca | regulator |
| 2 | **Assure Autonomous Decision-Making & Human Control** — Demonstrate that swarm autonomy systems and ML-based decision-making remain within airborne limits, are forensically explainable, and preserve meaningful human crew control over safety-critical decisi | MLForensicExplainability scale; MeaningfulHumanControl scale; SwarmEmergentBound | regulator, applicant |
| 2 | **Manage Regulatory Apportionment & Dual-Authority Approval** — Establish clear, gap-free delegation of regulatory responsibility between CAA (civil airspace) and MAA (military coordination) such that authorization decisions are unambiguously accountable and do no | CAAMAAApportionmentGapFreeness scale (target: 100% of submitted cases have signe | regulator |
| 2 | **Support Phased Trial Build-Up & Progressive Assurance** — Enable trials to progress through gated phases (evidence submission, technical review, operational validation, full deployment) with reversibility, allowing evidence to accumulate progressively and de | PhasedGateReversibility scale (target: 100% of trials proceed through documented | regulator, applicant |
| 2 | **Build Public Trust & Stakeholder Engagement** — Establish structured community consultation and media engagement processes compliant with CAP 1616 (civil engagement) and GDPR, such that public concern is addressed, prior notification is provided, a | PublicEngagementCoverage scale (target: 100% of trials have documented stakehold | public, ministers |
| 2 | **Ensure Evidence Traceability & Regulatory Audit Readiness** — Establish end-to-end traceability from regulatory clauses to submitted evidence and final decision, such that auditors and investigators can verify that every approval requirement was addressed and ev | Traceability binding completeness (target: 100% of regulatory clauses have mappe | regulator, aaib |
| 2 | **Support Joint CAA/MAA Panel Decision-Making & Override Authority** — Enable CAA and MAA panels to make binding authorization decisions with override capability for exceptional cases, with full audit trail of who overrode what and why | Panel override audit trail completeness (target: 100% of panel overrides logged  | regulator, applicant |
| 3 | **Enable Incident Investigation & Regulatory Closure** — Capture and preserve complete forensic evidence for post-incident investigation, mandatory occurrence reporting (MOR), and formal trial close-out with lessons-learned documentation | MORForensicCompleteness scale; post-trial evidence preservation rate (target: 10 | regulator, mod |
| 3 | **Establish Insurance & Ground Risk Mitigation** — Ensure third-party risk is both insurable (via commercial liability coverage) and factually grounded (via ground survey) such that public below is protected and regulator liability is transferred | Ground survey coverage percentage (100% of trial area surveyed pre-flight); insu | regulator, public |
| 3 | **Manage Classified MOD Evidence & Security Assurance** — Enable CAA and MAA to review MOD-sensitive evidence (program schedules, platform specifications, sensor capabilities) without security compromise, per CAP 722H and JSP 440 security classifications | Classification-aware evidence segregation effectiveness (target: 100% of classif | mod, regulator |
| 3 | **Assess Environmental & Ecological Impact** — Evaluate and document environmental risks (noise, wildlife disturbance, battery-fire hazard) to enable CAA environmental assessment and compliance with ecological regulations | Environmental impact assessment completeness (target: 100% of trials have assess | public, regulator |
| 3 | **Separate Applicant Feedback from Regulator Decision Records** — Maintain procedural fairness by segregating applicant feedback (revision requests, informal queries) from final regulator decision records, such that feedback is constructive and non-binding while dec | Decision record segregation (target: 100% of final approval decisions in separat | applicant, regulator |
| 3 | **Implement Regulatory Evidence Library & Version Control** — Maintain and version-control a regulatory evidence library (templates, standards, reference cases) such that applicants have clear guidance and regulators can consistently apply evolving requirements | Clause library version adoption (target: 100% of new cases use current clause li | applicant, regulator |

---

## Ubiquitous Language (42 terms — first 25 shown)

| Term | Canonical Definition | Status |
|---|---|---|
| **Operational Authorisation pack** | A complete submission to the CAA containing all regulatory evidence, safety cases, operational procedures, and technical documentation required for a BVLOS UAS trial to proceed. | agreed |
| **SORA** | Specific Operational Risk Assessment. A regulatory framework (JARUS SORA v2.5) for assessing UAS operational risks. | agreed |
| **SAIL** | Specific Assurance and Integrity Level. A risk classification level output by SORA assessment that quantifies the rigor of evidence required. | agreed |
| **OSO** | Operational Safety Objectives. Specific, measurable safety goals derived from SORA assessment that define required mitigation levels. | agreed |
| **swarm-aware** | Methodology or evidence that explicitly accounts for collective behavior, coordination dependencies, and emergent risks of multiple coordinated aircraft. | proposed |
| **meaningful human control** | Active, informed crew awareness and retained authority to perceive system state, understand autonomous actions, and intervene before safety-critical decisions. | proposed |
| **defensibly** | In a manner that can be justified through evidence and logical argument to regulatory scrutiny, peer review, and accident investigation. | proposed |
| **containment** | Systems combining mechanical, software, and procedural measures that prevent UAS from exiting operational boundary regardless of link loss or autonomy failure. | proposed |
| **geofence** | Virtual 3D boundary (lat/lon/altitude/time) defining the trial operational area. Geofence violations trigger containment actions. | agreed |
| **fly-away** | Loss of control of UAS such that it exits authorized airspace and cannot be recovered by operator. | agreed |
| **C2 link** | Command and Control link - communication pathway between ground crew and UAS for transmitting commands and receiving status/telemetry. | agreed |
| **inter-vehicle links** | Communication pathways between UAS aircraft within swarm for coordination, de-confliction, or status exchange. | agreed |
| **link loss survivable** | UAS and swarm have procedures and design such that loss of C2 or inter-vehicle comms can be managed without loss of separation or collision. | proposed |
| **ODD** | Operational Design Domain - set of operating conditions (environmental, technical, geographical, temporal) for which UAS and autonomy systems have been validated and approved. | agreed |
| **ConOps** | Concept of Operations - narrative description of trial conduct including flight profiles, crew roles, decision points, and normal procedures. | agreed |
| **nominal behaviour** | Expected, planned system performance under normal operating conditions as described in ConOps. | agreed |
| **worst-credible behaviour** | Most severe adverse system performance or failure mode reasonably foreseeable that must be survived by containment, backup systems, or crew intervention. | proposed |
| **TDA** | Temporary Danger Area - designated airspace volume and time window reserved for trial, excluding other civilian traffic. Established by NOTAM and managed by ATSU. | agreed |
| **NOTAM** | Notice to Airmen - notice issued by aeronautical authorities to alert operators to potential hazards. TDA trials must be published via NOTAM. | agreed |
| **ATSU** | Air Traffic Service Unit - regulatory organization responsible for monitoring airspace, issuing clearances, and managing NOTAMs and TDAs. | agreed |
| **DAA** | Detect-and-Avoid - capability for UAS to autonomously sense, track, and resolve conflicts with other aircraft without relying on ground crew or external feeds. | agreed |
| **resolved predictably** | Conflicts with other aircraft are resolved deterministically and foreseeable to all participants. Requires defined avoidance maneuver selection logic, coordination method, crew awareness, and verifica | proposed |
| **swarm decision-making architecture** | Design of how collective decisions are made by swarm: centralized (ground-based), distributed (peer voting), or hierarchical (lead decides). Must define: decision authority, communication topology, fa | proposed |
| **emergent behaviour** | Behavior arising from collective swarm interactions not explicitly programmed in individual aircraft. Can be desired (formation cohesion) or undesired (deadlock, separation loss). | proposed |
| **forensically explainable** | System (particularly ML models) whose decisions can be reconstructed and explained post-hoc through investigation of model weights, training data, decision logic, and failure modes. | proposed |

---

## Executable Specifications — Gherkin (17 feature files, 84 scenarios)

Feature files organised by business capability:

### applicant

- `features/applicant/application_intake.feature`
- `features/applicant/completeness_check.feature`
- `features/applicant/submission_readiness_check.feature`

### autonomy

- `features/autonomy/meaningful_human_control.feature`
- `features/autonomy/ml_forensic_explainability.feature`
- `features/autonomy/swarm_behavior_envelope.feature`

### classification

- `features/classification/classification_custodian.feature`

### containment_and_safety

- `features/containment_and_safety/c2_link_resilience.feature`
- `features/containment_and_safety/daa_performance.feature`
- `features/containment_and_safety/geofence_containment.feature`
- `features/containment_and_safety/independent_flight_termination.feature`

### governance

- `features/governance/caa_maa_apportionment.feature`
- `features/governance/public_engagement.feature`

### panel_review

- `features/panel_review/panel_decision_making.feature`

### post_decision

- `features/post_decision/archive_and_audit.feature`

### sora_assessment

- `features/sora_assessment/sail_determination.feature`
- `features/sora_assessment/swarm_aware_sora.feature`

### Sample Gherkin — `features/applicant/submission_readiness_check.feature`

```gherkin
# Feature: Submission Readiness & Gate Control
# Business Goal: GOAL-001 Build Defensible Approval Throughput
# Quality gate ensuring minimal viable evidence before assessment commences

@applicant @intake @regression @F04 @REQ001 @GOAL-001
Feature: Submission Readiness & Gate Control
  As a CAA intake team
  I want to verify that complete submissions meet minimum quality standards
  So that SORA assessors receive evidence bundles that are credible, traceable, and defence-ready

  Background:
    Given case status is INTAKE_COMPLETE
    And clause library v2.1 is current
    And Thorough Gate reviewer role exists

  @critical
  Scenario: Readiness gate blocks SORA progression on quality defects
    Given case has all mandatory artefacts present
    And Thorough Gate reviewer detects ConOps lacking crew workload analysis
    When reviewer initiates quality assessment
    Then case transitions to RETURN_FOR_CLARIFICATION
    And feedback specifies required additional analysis sections
    And estimated re-review timeline is provided

  @major
  Scenario Outline: Quality criterion evaluation matrix
    Given <operation_type> submission in INTAKE_COMPLETE status
    And <criterion> is evaluated per clause library
    When Thorough Gate reviewer assesses <criterion>
    Then outcome is <gate_status>
    And reason recorded in case history

    Examples:
      | operation_type      | criterion                              | gate_status              |
      | PDRA-01 VLOS        | ConOps describes nominal behaviour      | PASS → SORA_READY        |
      | PDRA-01 VLOS        | Risk Register missing worst-case       | BLOCK → RETURN_FOR_CLAIM |
      | BVLOS Swarm         | Swarm decision architecture incomplete  | BLOCK → RETURN_FOR_CLAIM |
      | BVLOS Swarm         | DAA evidence present and traced        | PASS → SORA_READY        |

  @major
  Scenario: Duty holder accountability gate
    Given Safety Case submitted with Duty Holder Declaration section
    When Thorough Gate reviewer verifies signature requirements
    And signature is present, dated, and notarized
    Then organisational accountability gate PASSES
    And case eligible for SORA assessment progression

  @minor
  Scenario: Evidence traceability spot-check
    Given case contains 15+ artefacts across 8 document types
    When Thorough Gate spot-checks 3 randomly selected clauses
    And verifies each clause has at least 1 mapped evidence artefact
    Then traceability sample audit completes
    And case readiness status APPROVED

```

---

## Key Examples — concrete data (15 total, first 6 shown)

**EX-001 — PackCompleteness happy path: Complete PDRA-01 VLOS pack (Scotland pattern)**

*happy_path · F02: Completeness Check · addresses: Dorothy-8; REQ001*

- **Given** Edinburgh Napier University submits PDRA-01 VLOS pack: ConOps v2.2, Personnel & Training Manual, Safety Case, Risk Register, Aircraft Technical Data, Insurance (GBP 10M+), Ground Survey, Environmental Assessment. All 8 artefacts present and validly f
- **When** Artefact Detector runs on upload
- **Then** All 8 artefact types flagged GREEN; case transitions to INTAKE_COMPLETE within 10 minutes

**EX-002 — PackCompleteness error: Sparse BVLOS Swarm pack missing SORA Swarm-Aware section**

*error · F02: Completeness Check · addresses: Dorothy-8; GOAL-002*

- **Given** CTRL-ALT-DEFEAT submits BVLOS Swarm trial (5x RigiTech Eiger, Spadeadam): SORA lacks swarm-specific sections, ML Model Manifest absent
- **When** Artefact Detector detects 7 of 8 mandatory types
- **Then** SORA flagged AMBER; ML Model Manifest flagged RED; case status = RETURN_FOR_CLARIFICATION

**EX-003 — Swarm-Aware SORA SAIL mismatch: 5-aircraft autonomous swarm declared SAIL-I, actual SAIL-IV required**

*boundary · F03: SORA Assessment · addresses: Dorothy-2; GOAL-002*

- **Given** Spadeadam swarm trial: 5x Eiger, autonomous swarm, GNSS/C2 denial, declared SAIL-I. But SORA lacks multi-agent hazard analysis
- **When** SORA assessor applies JARUS SORA v2.5 Appendix C (Swarm)
- **Then** Assessor determines actual SAIL-IV required due to swarm interdependencies

**EX-004 — Geofence breach action: 55.3m breach detected, RTL within 500ms**

*happy_path · F06: Geofence & Containment · addresses: Implicit Scope Risk GOAL-003*

- **Given** Spadeadam: 5x Eiger at 54.9167N 2.5667W, 50m geofence tolerance; wind gust causes 55.3m breach
- **When** Geofence logic detects breach at 100ms
- **Then** RTL command issued within 100ms; landing completed within 3.2s total

**EX-005 — DAA non-cooperative encounter: Category A intruder, autonomous climb executed**

*happy_path · F08: DAA Performance · addresses: REQ007*

- **Given** Spadeadam trial: 5x aircraft at 500ft; Cessna 172 intruder at 2000ft; DAA detects at 2.8nm
- **When** DAA resolver activates; autonomous climb command issued
- **Then** Swarm climbs to 1100ft; intruder passes below with 900ft separation

**EX-006 — C2 loss during swarm consensus: AC4 consensus timeout, autonomous RTL triggered**

*edge_case · F07: C2 Link Resilience · addresses: REQ006; Chris language: link-loss-survivable vague*

- **Given** Spadeadam intentional C2 denial test: 5x Eiger in AC4 consensus mode; C2 powered down at t=120s
- **When** C2 loss detected; aircraft enter autonomous mode; voting window opens
- **Then** Consensus resolves on MAINTAIN_ALTITUDE; timeout at t=420s triggers RTL; landing at t=425.8s

---

## Validation Strategy (Victoria)

| Suite | Scenarios | Target duration | Trigger |
|---|---:|---|---|
| **Smoke** | 10 | <5 min | on commit |
| **Regression** | 55 | <30 min | merge to main |
| **Full** | 69 | <2 hrs | nightly + release |

Performance gates (per Cerf PE agent) gate the release.

---

## Findings by Pattern

### G — Goals · Grace

*8 findings*

#### [CRITICAL · C10] Four critical regulatory requirements (REQ017-020) lack user stories and acceptance criteria—scope undefined

**Detail:** DeFOSPAM analysis confirms that REQ017-020 are documented in requirements-221fbff5.csv as titles only, with no user stories. Dorothy's glossary, Milarna's missing-data analysis, and Alexa's ambiguity analysis all confirm: 'REQ017 (Public/Stakeholder Engagement): No user story covers community consultation press/media handling or prior-notification to landowners. Strongly implied by CAP 1616 and GDPR but absent.' Same pattern for REQ018-020. Without user stories, there is no actor (who is respons

**Recommendation:** Create explicit user stories for REQ017-020 immediately, with acceptance criteria and success metrics: (1) REQ017: 'As a CAA community liaison I want to manage stakeholder consultation per CAP 1616 and prior notification to landowners per planning law so that community engagement is documented and GDPR obligations are met. Acceptance: community engagement plan signed off before trial authorization; 80%+ community satisfaction in post-trial survey.' (2) REQ018: 'As a CAA security officer I want t

---

#### [CRITICAL · C9] Swarm-aware requirement scope creep: 'swarm-aware SORA evidence', 'emergent behavior', and 'worst-credible' lack operationalized definitions

**Detail:** DeFOSPAM glossary confirms: 'swarm-aware SORA evidence' is marked unverified with note 'Critical undefined term. What constitutes swarm-aware SORA is ambiguous. Unclear what distinguishes swarm-aware SORA from standard SORA.' Similarly, 'worst-credible behaviour' is marked unverified: 'Ambiguous boundary: what is credible vs incredible? Who judges this? No quantitative threshold given.' And 'emergent behavior' is undefined in the source requirements. Vibe Requirements confirm: SwarmAwareSORAEvid

**Recommendation:** Before F03, F04, F09 can be implemented, CAA must publish swarm-specific SORA guidance including: (1) Loss-of-separation hazard tree for multi-agent interactions (what cascading failure modes are credible?); (2) Emergent-behavior analysis methodology (how to model collective swarm behavior? simulation? flight test protocols?); (3) Worst-credible scenario definition (e.g., 'up to 2 aircraft loss-of-separation for up to 5 seconds before recovery'). Recommend CAA coordinate with JARUS WG3 and EUROC

---

#### [CRITICAL · C8] Geofence tolerance and C2 link-loss survivability design standard absent—automation limits undefined

**Detail:** DeFOSPAM glossary confirms: 'containment' is marked unverified with note 'Critical safety term. Distinction between automatic containment and other forms undefined. No specification of tolerance, fail-safe assumptions, or design standards.' Performance Engineering NFR analysis confirms: C2LinkResilience and GeofenceContainment are priority-1 values with no quantitative targets (no NFR for 'containment tolerance' or 'link-loss survivability time'). Vibe Requirements benchmark notes: 'No measured 

**Recommendation:** Before F06 and F07 can be verified, CAA and MAA must jointly publish design standards for: (1) Geofence containment tolerance (e.g., 'breach of >50m or >5 seconds duration triggers emergency termination'); (2) C2 link-loss survivability minimum (e.g., 'autonomous flight termination must engage within 30 seconds of C2 link loss'). These should be tied to swarm-specific risk assessment (larger swarms may need tighter tolerance). Recommend CAA coordinate with EASA and JARUS to align with European s

---

#### [MAJOR · C8] Phase gate structure undefined—no specification of evidence requirements, trigger criteria, or reversibility mechanics

**Detail:** DeFOSPAM analysis shows REQ016 source stories do not specify phase structure, trigger criteria, or reversibility rules. Vibe Requirements define PhasedGateReversibility as a critical value but note: 'Phase gate structure not specified; unclear what evidence triggers advancement. Override criteria not defined. Re-opening reversibility mechanics not specified.' Performance Engineering NFR analysis confirms: no quantitative targets for gate progression cycle time or re-opening frequency. This is im

**Recommendation:** Before F16, F26, F29 can be implemented, CAA must publish Phase Gate Standard specifying: (1) Five phases: (Phase 0) Intake & Completeness Check; (Phase 1) Technical Review (SORA, Safety Case, Crew Training complete); (Phase 2) Operational Readiness (Containment validation, C2 link testing); (Phase 3) Operational Approval (Trial authorization issued); (Phase 4) Full Deployment. (2) Per-phase evidence gates: Phase 0 → all mandatory documents present; Phase 1 → SORA setpoints approved, Safety Case

---

#### [MAJOR · C8] ML assurance case scope assumes AMLAS/SACE applicability to swarm autonomy—standards coverage unclear

**Detail:** DeFOSPAM finding: 'Assurable and assure not operationalized with success criteria (confidence 9, critical).' REQ009 user story states 'ML components are assurable and forensically explainable' but does not define what 'assurable' means for swarm ML. Vibe Requirements note: 'AMLAS/SACE case mandatory but guidance not yet published; assumption that these standards apply to swarm autonomy.' Performance Engineering analysis confirms: MLForensicExplainability value defined but NFR targets depend on k

**Recommendation:** Before F10 can be verified, CAA must publish Swarm ML Assurance Guidance clarifying: (1) AMLAS/SACE case scope for individual aircraft ML (perception, mode selection); (2) Separate assurance case for swarm coordination algorithms (formation control, de-confliction, collective decision-making); (3) Evidence of emergent-behavior testing (simulation, flight test); (4) Forensic explainability requirements for collective decisions (audit trail of which aircraft influenced which decision); (5) Interac

---

### S — Collaborate · Chris

*12 findings*

#### [CRITICAL · C10] Swarm-aware SORA evidence is undefined

**Detail:** REQ002 is a foundational requirement for SORA assessment. Dorothy-1 finding identified the term is undefined. Without clarity on what swarm-aware means, SORA assessors lack criteria for what evidence to demand. Different assessors might reach different SAIL levels for identical systems, leading to inconsistent authorizations.

**Recommendation:** Conduct WS-001 (all-team workshop) with SORA assessor, applicant, autonomy engineer, and test engineer. Define swarm-aware operationally with reference to JARUS SORA v2.5 multi-UAS guidance.

---

#### [CRITICAL · C10] Meaningful human control lacks measurable criteria

**Detail:** REQ010 requires meaningful human control to be demonstrated but provides no definition or criteria. This term is borrowed from LAWS (Lethal Autonomous Weapons) debate and is inherently subjective. Dorothy-2 finding (confidence 10/10): without operational thresholds, CAA human factors inspectors cannot evaluate whether evidence is sufficient. Different inspectors may reach different conclusions on identical evidence.

**Recommendation:** Conduct WS-003 (all-team workshop) with CAA human factors inspector, applicant crew lead, test pilot, autonomy engineer, and human factors specialist. Define meaningful human control with measurable criteria: awareness frequency, authority preservation, takeover time, workload limits.

---

#### [CRITICAL · C10] Containment mechanism design and verification criteria undefined

**Detail:** REQ005 uses automatic containment as a critical safety mechanism but does not specify five critical subcriteria. Dorothy-4 finding (confidence 10/10): geofence tolerance, fail-safe mechanism, design standard, environmental factors, and verification approach are all undefined. Different developers might implement containment with different tolerances and fail-safes, leading to inconsistent safety levels.

**Recommendation:** Conduct WS-002 (all-team workshop) with CAA airspace regulator, applicant safety engineer, autonomy engineer, avionics engineer, and test engineer. Define geofence tolerance, fail-safe design, verification approach, and success criteria.

---

### I — Illustrate · Isabel

*8 findings*

#### [CRITICAL · C10] Meaningful human control definition lacks measurable acceptance criteria; crew override latency and authority not specified

**Detail:** Chris's ubiquitous language defines 'meaningful human control' as 'active, informed crew awareness and retained authority to perceive system state, understand autonomous actions, and intervene before safety-critical decisions', but REQ010 and CAP 722D Section 3.1 do not quantify 'meaningful' or 'before'. Vibe MeaningfulHumanControl scale has 4 dimensions (SituationalAwareness, AuthorityPreservation, TakeoverLatency, WorkloadBounds) but acceptance thresholds are undefined. Example EX-007 shows cr

**Recommendation:** Publish CAP 722D Addendum 1 (Meaningful Human Control Acceptance Criteria) specifying: (1) SituationalAwareness minimum: crew must receive swarm state updates at >= 2Hz nominal, >= 10Hz if off-nominal detected. (2) AuthorityPreservation minimum: >= 100% of irreversible decisions (e.g., formation change, altitude adjustment, swarm split) require explicit crew command; >= 80% of reversible decisions (e.g., hold vs advance) acceptable as autonomous with crew override. (3) TakeoverLatency minimum: c

---

#### [CRITICAL · C10] Emergent behavior definition and credibility bounds undefined; applicants cannot determine what swarm behaviors are 'assurable' vs 'too risky'

**Detail:** Chris language defines 'emergent behaviour' as 'behavior arising from collective swarm interactions not explicitly programmed in individual aircraft' and notes it is 'high-risk term, requires formal methods or Monte Carlo verification.' Vibe SwarmEmergentBoundedness scale requires 'count of distinct emergent behaviors documented, each with a defined boundary and detection/recovery mechanism', but what constitutes a 'distinct' behavior? Is formation-breakup one behavior or five (loss of leader, l

**Recommendation:** Develop CAP 722D Addendum 5 (Emergent Behavior Assurance Case) specifying: (1) taxonomy of emergent behaviors for multi-agent swarms: separation-loss (aircraft proximity <50m), formation-breakup (loss of leader-follower links), consensus-deadlock (voting cannot reach quorum), altitude-drift (swarm altitude deviates >50m from commanded), yaw-oscillation (formation heading oscillates >10deg peak-to-peak). (2) Credibility framework: single-failure assumption (one inter-vehicle link fails), environm

---

#### [CRITICAL · C9] Swarm-aware SORA evidence scope is undefined; applicants cannot distinguish evidence for SAIL-IV multi-agent risk from standard single-aircraft SAIL-II

**Detail:** DeFOSPAM Dorothy-2 and Sophia-3 identified that 'swarm-aware' is never defined in REQ002. Vibe analysis shows SwarmAwareSORAEvidence scale requires '3 distinct items per aircraft establishing swarm-aware risk factors', but what qualifies as a 'distinct item' is ambiguous. Spadeadam trial SORA declared SAIL-I but should be SAIL-IV due to multi-agent interdependencies. No applicant guidance exists on what evidence types (loss-of-separation cascades, emergent-behavior bounds, inter-vehicle link fai

**Recommendation:** Develop CAP 722B Appendix C (Swarm-Aware SORA Guidance) documenting: (1) JARUS SORA v2.5 Appendix C interpretation for CAA context, (2) five evidence buckets for swarm-aware risk (loss-of-separation analysis, emergent-behavior bounds, inter-vehicle link failure modes, autonomous-consensus timeouts, swarm-cohesion limits), (3) minimum evidence count per SAIL level (SAIL-I=0 swarm evidence, SAIL-III=1, SAIL-IV=3, SAIL-V=5+), (4) worked examples for common swarm architectures (distributed consensus

---

#### [MAJOR · C9] ML Model Manifest ('frozen model') requirements not standardized; applicants do not know what data, architecture, training scope, and explainability evidence to provide

**Detail:** REQ009 requires 'forensically explainable' ML models with 'frozen model manifest', but manifest structure is undefined. Chris language defines 'frozen model' but notes 7 subcriteria undefined: data retention, duration, security, manifest format, proprietary handling, ownership, reconstruction timing. Example EX-002 (Spadeadam case) is missing ML Model Manifest entirely, causing pack to fail completeness check. Example EX-014 (hypothetical refusal) applicant claims 95% explainability via LIME/SHA

**Recommendation:** Publish CAP 722D Addendum 3 (ML Model Manifest Template) specifying: (1) mandatory sections: model architecture (layers, weights count, hyperparameters), training data scope (size, domain, augmentation), testing scope (validation set, test set, out-of-distribution testing), explainability approach (decision-tree rules vs feature-importance rankings vs saliency maps per model type), version control (git commit hash of frozen weights). (2) Format template (3-page DOCX with fillable sections). (3) 

---

#### [MAJOR · C8] Geofence tolerance and containment action latency not specified; examples show 50m tolerance and 500ms deadline, but are these enforced across all trials?

**Detail:** REQ005 requires 'fail-safe containment' and 'geofence enforcement', but tolerance (how far beyond geofence before action triggers?) and latency (how fast must action execute?) are not defined. Vibe GeofenceContainment scale targets '99.9% success rate' but does not specify tolerance or latency budget. Example EX-004 (Spadeadam trial) assumes 50m tolerance and 500ms latency, but is this binding for all trials, or is it trial-specific? If Scotland PDRA-01 trial (EX-001) operates at 500m VLOS dista

**Recommendation:** Develop CAP 722D Section 6.3 (Geofence Containment Specification) defining: (1) tolerance bands by operation type [PDRA-01 VLOS: 10m tolerance max; BVLOS single-aircraft: 25m; BVLOS swarm: 50m]. (2) Latency budget by airspace type [populated area: 300ms; sparsely populated: 500ms; uninhabited: 800ms]. (3) Fail-safe action logic (RTL vs descend vs hold depends on altitude, wind, swarm state). (4) Verification approach (Monte Carlo simulation of 1,000 scenarios per operation type, showing >= 99.9%

---

### R — Refine · Rex

*64 findings*

#### [MAJOR · C8] RSPEC-008: Vague language reduces testability

**Detail:** Then clause uses conditional language (should, may, might) instead of deterministic assertions, making pass/fail criteria ambiguous.

**Recommendation:** Replace with definite statements: "system should record timestamp" → "the system records timestamp and actor"

---

#### [MAJOR · C7] RSPEC-001: Low use of canonical domain language (score 6.2)

**Detail:** Specification uses only 3 canonical terms. Domain vocabulary from Chris's ubiquitous language glossary is under-represented.

**Recommendation:** Inject domain terms where they clarify business intent. Example: "system accepts submission" → "the Workbench accepts the Operational Authorisation pack, enabling SORA assessment"

---

### A — Automate · angie

*11 findings*

#### [CRITICAL · C9] Hardware-in-the-loop required for latency-critical assertions

**Detail:** Latency-critical requirements (geofence RTL < 100ms, override < 50ms, kill-switch < 350ms) cannot be reliably tested via pure software mock. Software mock latencies are non-deterministic (OS context switches, CPU load). These scenarios require actual embedded hardware or real-time simulation (FPGA, RTX). No amount of test code can substitute for true latency measurement.

**Recommendation:** Implement hardware-in-the-loop (HIL) test bench for latency-critical paths. Candidate frameworks: NI LabVIEW, dSPACE, MathWorks HIL Blockset. Integrate with Behave via serial/Ethernet client binding (not native Gherkin). Estimate: 200 hours for HIL infrastructure setup; latency assertions in Behave verified against HIL measurements.

---

#### [CRITICAL · C9] ML model forensics require specialized test tooling

**Detail:** Scenario 'Post-incident model decision reconstruction' requires ML model inference replay, SHAP/LIME explainability, saliency maps. Standard Gherkin assertion libraries cannot inspect neural network decision boundaries. Requires specialized ML testing framework (e.g., deeptest, TensorFlow Model Audit, PYNVML for GPU profiling). Integration with Behave requires custom step definition that wraps Python ML libraries.

**Recommendation:** Create dedicated ML forensics Behave plugin (Python module wrapping TensorFlow/PyTorch + SHAP). Step definitions should accept model checkpoint + input feature vector, output decision reconstruction + explainability artifacts. Test data: use synthetic training/validation splits to ensure off-distribution detection scenarios are testable. Integrate with CI/CD GPU queue (model inference is computationally expensive).

---

#### [CRITICAL · C9] Emergent behavior test oracle problem unsolved

**Detail:** Scenario 'Emergent separation loss collision analysis' claims 'No path to zero-separation collision' via formal verification. But scenario does not specify HOW to verify this claim programmatically. Formal methods (model checking, SAT solving) require specialized tools (TLA+, Alloy, Z3) and expertise. Standard test automation frameworks assume deterministic execution; formal verification is off-equilibrium problem space.

**Recommendation:** Acknowledge test oracle limitation: establish clear boundary between 'executable Gherkin scenarios' and 'formal verification artifacts'. Gherkin scenarios should assert the OUTCOME (formal proof accepted/rejected), not the proof itself. Recommendation: modify scenario as follows: 'When formal verification model of swarm consensus is submitted / Then verification tool (TLA+ or equivalent) accepts model with 0 collision traces in 10M simulation runs'. This makes test oracle clear: tool output (pas

---

#### [MAJOR · C9] Shared step opportunities reduce automation maintenance burden

**Detail:** Analysis of all 17 feature files identified 12 recurring step patterns (e.g., 'Given clause library version is pinned to 2.1', 'When case status transitions to...', 'Then audit log records'). These steps appear 3-15 times across features. Factoring into shared library will improve maintainability and reduce duplication.

**Recommendation:** Create shared step library in Behave conftest.py with 12 reusable step definitions. Document parameter syntax for case status, timeline, audit log events. Estimated effort: 20 hours shared library development; 30% reduction in future step maintenance.

---

#### [MAJOR · C9] UK sovereign infrastructure constraints affect framework selection

**Detail:** Specification implies UK sovereign cloud (Google Cloud Storage with geo-redundancy, CAA Secure Archive). Standard open-source Gherkin frameworks (Cucumber, Behave, SpecFlow) assume public cloud (AWS, Azure) or on-prem deployment. GCS integration requires custom bindings. MOD classified trials require air-gap or classified cloud (e.g., UK IL5 equivalent). Dual-framework strategy (Behave for unclassified, isolated instance for classified) increases complexity.

**Recommendation:** Recommendation 1: Adopt Behave (Python) as primary framework. Justification: Python has strong GCS SDK (google-cloud-storage); classification-aware feature file plugins feasible. Recommendation 2: Create abstraction layer for artifact storage (interface abstraction, swappable GCS/local-storage backend) to support air-gapped classified trials. Recommendation 3: Plan separate test instances (public Workbench + classified Workbench) with shared step library but separate execution contexts.

---

### V — Validate · Victoria

*9 findings*

#### [CRITICAL · C9] 9 scenarios with high flakiness risk require test doubles, snapshots, and deterministic seeding

**Detail:** DeFOSPAM findings (125 total, 68 critical) expose foundational term ambiguity (swarm-aware, meaningful human control, containment) that cascades into test interpretation variance. Isabel's examples (EX-003, EX-006, EX-022, EX-038, EX-063, EX-067) all involve human judgment (SORA assessor, swarm consensus voting, DAA resolver confidence, ML classification detection) or tight timing windows (geofence breach <500ms, RF kill <350ms). Cerf's performance engineering (NFR-END-WB-001: 96h soak detecting

**Recommendation:** Immediate: (1) Create test-double factory for SORA assessor, DAA resolver, swarm consensus votings, and ML classifiers with frozen decision logic. (2) Implement snapshot testing framework with configurable tolerance bands per scenario. (3) Pin all external API versions in fixture metadata. (4) Add RNG seeding to all swarm/sensor simulation scenarios. Mid-term: (5) Run high-risk scenarios twice per week to detect drift; establish baseline confidence intervals. (6) Instrument audit log write path 

---

#### [CRITICAL · C9] Smoke suite must validate keystone safety gates in <5 minutes; current 10-scenario design is aligned with Grace's P1 priority goals

**Detail:** Grace's goals rank GOAL-001 (intake throughput), GOAL-003 (containment), GOAL-002 (swarm safety), GOAL-006 (apportionment), GOAL-015 (panel override audit) as P1/P2. Smoke suite must be a 'canary' that catches regressions in these core workflows on every commit. 10 scenarios = 14% of 69 total; statistical coverage of 95% of critical paths is achievable with this selection. Parallelization on GitHub Actions (matrix strategy with 4 workers) can keep smoke <5min.

**Recommendation:** Implementation: (1) Allocate GitHub Actions matrix with 4 parallel workers; assign 2-3 scenarios per worker. (2) Use docker-compose spin-up <10s per test to minimize setup latency. (3) Cache dependency downloads between runs. (4) Target: smoke completes in 3-4 minutes on main branch, 5-6 minutes under load. (5) Monitor: capture p95 execution time per scenario; alert if any smoke scenario >30s (indicates new flakiness). (6) Blocking: smoke must pass before merge to staging; regression + full requ

---

#### [CRITICAL · C8] Regression suite covers 55 scenarios (80% of 69); must execute <30 minutes and block main-branch merge

**Detail:** Regression suite bridges smoke and full: includes all major-severity scenarios (69 all tagged @major @regression), all AC1-AC8 pass/fail paths (Isabel's examples demonstrate twins: Scotland approval vs SORA refusal end-to-end), geofence/C2/termination failure modes (GOAL-003 containment assurance), panel override audit trails (GOAL-015 panel decision governance), apportionment (GOAL-006), classification handling (GOAL-009). Must run before merge to main to ensure release readiness. 55 scenarios 

**Recommendation:** Implementation: (1) Allocate 8-10 parallel GitHub Actions jobs. (2) Each job gets dedicated test PostgreSQL instance (docker-compose) with 10-20s spin-up. (3) Divide 55 scenarios among jobs; use scenario sharding by ID range (RSPEC-001-006, RSPEC-007-012, ..., RSPEC-049-055). (4) Implement database transaction rollback after each scenario to avoid state bleed. (5) Capture per-scenario execution time histogram; flag any scenario >45s (target p95 <30s). (6) Required check: regression suite must pa

---

#### [MAJOR · C8] Full suite (69 scenarios + NFR gates) requires nightly execution and integration with Cerf's 8 performance gates

**Detail:** Full suite captures: (1) all 69 refined scenarios (functional coverage), (2) all K1-K8 keystones (safety assurance), (3) all AC1-AC8 acceptance criteria, (4) Isabel's 15 examples end-to-end, (5) Cerf's 8 performance gates (NFR-LAT-001: setup latency <3s, NFR-CAP-WB-001: load baseline p95 <3.5s, NFR-END-WB-001: 96h soak <5% drift, etc.), (6) classification boundary scenarios across all 3 tiers (OFFICIAL, OFFICIAL-SENSITIVE, SECRET), (7) 24h endurance extract for audit log forensics. Nightly execu

**Recommendation:** Implementation: (1) Create nightly trigger in GitHub Actions: cron 0 2 * * * (0200 UTC). (2) Allocate 8 parallel workers for functional tests; each gets dedicated test DB + mocked external APIs. (3) Dedicate separate staging environment for Cerf NFR gates (soak/stress/spike); resource isolation critical for validity. (4) Sequence: functional tests (55 min) → performance gates (60 min) → alerts (if any failure). (5) Capture JUnit XML, Allure report, perf-timeline.json, flake-register.json. (6) Da

---

#### [MAJOR · C8] Performance gates (Cerf Phase 4-8) must be automated parallel checks in full suite; audit log write latency <500ms is critical for GOAL-015

**Detail:** Cerf's performance engineering (openperformance-results.json: NFR-END-WB-001 96h soak, NFR-LAT-001 setup <3s, NFR-CAP-WB-001 load baseline, NFR-LAT-002 3 MB/s throughput) directly maps to operational SLAs. Isabel's EX-011 (panel override audit trail <500ms write latency) is GOAL-015 requirement. Noyce's NFR-LAT-001 and NFR-LAT-002 are capacity budgets. Ada's NFR-CAP-WB-001 is load baseline. These gates are not optional; they define system readiness. Integrating gates into CI ensures every releas

**Recommendation:** Implementation: (1) Add GitHub Actions job 'Performance Gates' after functional tests pass. (2) Run gates in parallel (or sequence if resource-constrained): Gate 1 (unit tests, <1min), Gate 2 (workspace creation load test, <5min), Gate 3 (1h load baseline, <60min), Gate 4 (stress test 2x peak, <10min), Gate 5 (96h soak, <5h in pre-prod), Gate 6 (audit log latency benchmark, <5min), Gate 7 (coverage matrix batch inference, <10min), Gate 8 (evidence store PUT throughput, <10min). (3) Allocate dedi

---

### L — Living Docs · Laveena

*10 findings*

#### [CRITICAL · C10] SwarmAwareSORA definition still 'proposed'; requires workshop operationalization before living docs can be complete

**Detail:** The keystone K2 (SwarmAwareSORA) is non-negotiable for swarm trial authorization, yet the core concept remains 'proposed' (unverified). This means developers building features, CAA reviewers reading specs, and applicants preparing evidence all operate with different mental models of what 'swarm-aware' means. DeFOSPAM Dorothy-1 flagged this with confidence 10/10. Until this is operationalized in WS-001, the living docs cannot claim true specification completeness.

**Recommendation:** Schedule WS-001 (REQ002: Swarm-Aware SORA Assessment) as a blocker before Phase 2 feature files are marked 'stable'. Workshop agenda: (1) Define swarm-aware operationally; (2) Identify swarm-specific failure modes not covered in single-aircraft SORA; (3) Map evidence requirements (test data, analysis, simulation); (4) Define SAIL outcomes for swarm complexity.

---

#### [CRITICAL · C9] GeofenceContainment specification lacks five critical design subcriteria; feature file is incomplete without design workshop

**Detail:** A developer trying to implement geofence logic reads the feature file and sees 'RTL within 500ms', but cannot answer: What tolerance is acceptable? What wind speed is worst-credible? What GPS accuracy assumptions? What design standard applies (DO-254 DAL B?)? Without these clarifications, the implementation will lack regulatory defensibility. DeFOSPAM Dorothy-4 identified this as confidence 10/10 critical finding.

**Recommendation:** Schedule WS-002 (REQ005: Automatic Containment Design Specification) with: CAA airspace regulator, applicant safety engineer, autonomy engineer, test engineer. Agenda: (1) Define boundary tolerance (±X meters); (2) Specify fail-safe mechanism (independent altitude limiter?); (3) Identify design standard (DO-254 DAL B? DEFSTAN 00-970 Part 9?); (4) Map environmental factors (GPS multipath, wind prediction); (5) Define verification approach (Monte Carlo? Flight test?). Output: containment design sp

---

#### [CRITICAL · C9] MeaningfulHumanControl feature lacks quantified crew situational awareness and workload thresholds; specification is aspirational, not testable

**Detail:** A CAA human-factors inspector reading the feature file for meaningful human control can see the scenario ('crew observes altitude deviation, presses button, swarm halts within 50ms'), but cannot make a go/no-go decision without knowing: Is 50ms fast enough for true control authority? Is 10Hz telemetry update frequent enough for situational awareness? DeFOSPAM Dorothy-2 identified this as confidence 10/10 critical finding. Without quantified thresholds, the specification is aspirational (good goa

**Recommendation:** Schedule WS-003 (REQ010: Meaningful Human Control & Crew Workload Definition) with: CAA human factors inspector, applicant crew/flight ops lead, test pilot, autonomy engineer, human factors specialist. Agenda: (1) Define situational awareness update frequency (Hz? seconds?); (2) Define authority preservation scope (which decisions must crew pre-approve vs approve post-hoc?); (3) Define takeover time requirement (within X seconds for which off-nominal events?); (4) Define workload limits (max con

---

#### [MAJOR · C8] SwarmAwareSORA feature is over-specified (47 lines) while Phase 3 Archive feature is under-specified (1 feature); detail-level imbalance creates navigation friction

**Detail:** A developer navigating the feature files encounters SwarmAwareSORA with 47 lines and thinks 'this must be really complex', then navigates to Phase 3 and finds only 1 feature file for 2 different concerns. This creates a false sense of importance (SwarmAwareSORA is complex because over-specified, not because it's intrinsically harder than other features) and undersells Phase 3 (archive seems like an afterthought). The imbalance suggests incomplete specification in Phase 3.

**Recommendation:** Rebalance detail levels: (1) Break SwarmAwareSORA into 2 separate features: 'swarm-aware-hazard-analysis' (SAIL mapping) and 'swarm-specific-failure-modes' (loss-of-separation cascade). (2) Expand Phase 3 from 1 feature to 3: 'data-retention-and-security.feature', 'post-incident-aaib-extraction.feature', 'forensic-trail-reconstruction.feature'. (3) Add 3 worked examples for Phase 3 (currently 0 examples). (4) Limit feature files to 20–30 lines; break longer scenarios into separate features.

---

#### [MAJOR · C8] Glossary term hyphenation and acronym expansion inconsistent across feature files; pre-commit hook should enforce style

**Detail:** A CAA case officer reading two different feature files encounters 'meaningful human control' in one and 'meaningful-human-control' in another, and wonders if they are different concepts. This undermines confidence in the glossary and creates ambiguity about which definition applies. Consistency is not just style — it affects interpretability.

**Recommendation:** Implement pre-commit hook (Python script, ~6 development hours) that: (1) Validates every bolded term against glossary.md; (2) Enforces hyphenation/capitalization style from glossary; (3) Flags unexpanded acronyms on first use; (4) Rejects commits if inconsistencies found. Hook should provide diffs showing required fixes. Alternative: Run nightly linter on feature files and report style violations in daily standup.

---


*Report generated by [OpenRequirements.ai](https://www.openrequirements.ai) · SBE methodology by Gojko Adzic*