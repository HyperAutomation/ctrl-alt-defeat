# Vibe Requirements Specification Report

**Powered by [OpenRequirements.ai](https://openrequirements.ai)** · Based on Tom Gilb's Planguage methodology

![Values](https://img.shields.io/badge/values-15-blue) ![Meters](https://img.shields.io/badge/meters-19-purple) ![Constraints](https://img.shields.io/badge/constraints-24-orange) ![Targets](https://img.shields.io/badge/targets-45-green) ![Completeness](https://img.shields.io/badge/completeness-63%25-yellow) ![Exit](https://img.shields.io/badge/exit-major--rework-red)

**Source:** `requirements-221fbff5.csv` + DeFOSPAM output (`openrequirements-results.json`)
**Analysis date:** 2026-04-23 10:42 UTC

---

## Executive Summary

Quantified **15 vague values** from 20 source requirements using the full Planguage apparatus (Scale, Meter, Benchmarks, Constraints, Targets, Background, Stakeholders, QC).

- **15** Scales defined (Alexa) — each with parameters and sub-scales where needed
- **19** Meters designed (Ray) — quick + thorough measurement processes
- **75** benchmark data points (Brook) — Past, Status, Record, Ideal, Trend
- **82** stakeholder mappings (Alan) — conflicts surfaced
- **24** Constraints (Isaac) — Tolerable / Survival / Regulatory
- **45** Targets (Tom) — 15 × Wish / Goal / Stretch
- **15** Background specs (Raj) — owners, risks, motivation
- **15** QC defects (Lovelace)

**Overall completeness:** 63%
**Defects per spec:** 0.93
**Exit recommendation:** `major_rework`

### Headline conclusion

The vibe requirements specification achieves 63% overall completeness, below the 85% threshold for 'ready' exit recommendation. Quality posture is 'major_rework' (0.93 defects per spec; defect density moderate but concentrated in critical safety domains). The specification demonstrates strong architectural foundation: Alexa's 15 scales are well-operationalized with Planguage rigor, Ray's 19 meters span simulation-to-flight validation, Brook's benchmarks establish baselines and trends, Alan's stakeholder mappings identify ownership. However, execution maturity lags specification: the critical gap is REALIZATION—current Status values (Brook benchmarks) for 8 value tags are BELOW the Tolerable constraints Isaac defined. This indicates the specification is ambitious but not achievable with current industry practice. The single largest quality risk is MLForensicExplainability: Status (28%) is dangerously close to the Survival threshold (70%), creating regulatory integrity risk—AAIB will refuse to investigate black-box ML decisions post-incident, blocking authorization on AI-safety grounds. The second-largest risk is SwarmAwareSORAEvidence: Status (15% adoption) is far below Tolerable (80%), indicating swarm-specific risk assessment is not yet mainstream in the civil UAS regulatory ecosystem. These two defects alone threaten authorization viability for ML-based autonomous swarms. Moderately severe gaps exist in ConOpsClarity (30-point deficit), DAAPerformance (11.9-point regulatory shortfall), MeaningfulHumanControl (18-point workload deficit), and PublicEngagementCoverage (social-license risk). The specification is well-structured but describes aspirational targets that exceed current industry capability. The exit recommendation is 'major_rework' because: (a) completion deficits across 8 value tags require upstream engineering development (not just regulatory process), (b) social-license risk (PublicEngagementCoverage deprioritization) is unaddressed in original requirements, (c) novel domain maturity (SwarmEmergentBoundedness, PhasedGateReversibility) lacks industry practice baseline. Critical path to authorization is: (1) ML explainability tooling adoption (3-6 months), (2) swarm SORA taxonomy standardization (12-18 months), (3) ConOps clarity guidance and HMI design maturity (6-9 months), (4) public engagement elevation to mandatory criterion (immediate policy change). Without these upstream improvements, first swarm authorizations are blocked or stalled on safety/regulatory grounds.

### Top priority fixes

1. MLForensicExplainability (62% gap from Status to Ideal): Single-largest quality risk. Immediate action: mandate explainability approach by model type (decision trees 100%, SVMs feature importance + boundary, neural networks LIME/SHAP >= 80% coverage). Ray's METER-011 becomes standard gate. Freeze model development post-authorization. Industry adoption of explainability tooling required; AAIB acceptance of proxy explanations essential.
2. SwarmAwareSORAEvidence (65-point gap from Status to Tolerable): Regulatory integrity crisis. CAA publishes exemplary swarm SORA evidence packages (AMLAS case studies); conduct assessor training on JARUS SORA v2.5 swarm-risk taxonomy. Ray's METER-003 enforces minimum evidence (>= 3 distinct items per aircraft addressing loss-of-separation, emergent failure, coordination mechanism). Monthly CAA feedback loop accelerates adoption.
3. MeaningfulHumanControl (18-point gap from Status to Tolerable, 65-point to Ideal): Swarm workload overwhelms crews. HMI redesign critical: auto-triage alerts (1-2 concurrent max), progressive disclosure, swarm-level abstraction, pre-positioned crew takeover. Ray's METER-013 validates workload in simulation. NASA-TLX workload measurement mandatory. Crew training on multi-event prioritization required.
4. ConOpsClarity (30-point gap from Status to Tolerable): Inter-rater clarity deficient. Publish ConOps template with mandatory sections: nominal behavior quantified, worst-credible boundary explicit, recovery procedure per phase. Ray's METER-004 (kappa >= 0.8) becomes standard gate. Exemplar swarm ConOps library (AMLAS) + ASTM F3642 adoption.
5. DAAPerformance (11.9-point gap from Status to Regulatory minimum): BVLOS authorization impossible without 99.9% encounter resolution success. Algorithm development required: invest in non-cooperative radar detection (current 70-90%, target 99%+), sensor fusion. Ray's METER-008 runs >= 200 scenarios; analyze failures and iterate. Define swarm DAA protocol (coordinated resolution across formation).

---

## Planguage Vibe Specifications

Each of the 15 values is presented in formal Planguage form. For the full per-field data, see `openrequirements-vibe-results.json`.

### PackCompleteness

```planguage
Tag: PackCompleteness
Type: Vibe Requirement.
Ambition: "a complete Operational Authorisation pack" <- REQ001 (requirements-221fbff5.csv)
Scale: Percentage of submitted Operational Authorisation packs where all mandatory document types and sections for the classified operation type [OpType] are present and meet acceptance criteria on first Readiness Check, measured across [TimePeriod].
Scale-Parameters: [OpType], [TimePeriod]
Sub-Scales: PackDocumentationCoverage - count of mandatory document types (ConOps, SORA, Safety Case, Training Plan, Personnel List, Environmental Assessment) present, PackSectionCompleteness - percentage of required sections within each document that contain substantive content (not placeholder), PackAcceptanceCriteriaMet - count of document-type-specific acceptance gates passed
Unit: percentage

Meter [METER-001]: Artefact Detector Quick Gate. For each submitted pack, the Workbench component 3 (Artefact Detector) automatically parses the submission and maps each artefact (ConOps, SORA, Safety Case, Training Plan, Personnel List, Environmental Assessment, Insurance, Ground Survey, crew credentials, ML manifest if applicable) against a regu (Automated: True)
Meter [METER-002]: Paragraph-Level Coverage Audit (Thorough Gate). After Quick Gate passes, a detailed audit runs on each artefact: for each required section (identified from regulatory checklist per operation type [OpType]), human or semi-automated reviewer verifies that the section contains substantive content, not placeholder text. For ConOps, mandatory sections (Automated: False)

Past: 70 percentage [FY 2024] <- JARUS SORA adoption anecdata; industry reports on first-submission pack acceptance rates (estimated)
Status: 72 percentage [2026-04-23] <- Industry anecdata; no live CAA operational data available (estimated)
Record: 95 percentage [held by: Mature commercial BVLOS operators (e.g., Airborne Support, DJI Enterprise partners)]
Ideal: 100 percentage [All mandatory document types and sections present on first readiness check, per Alexa's scale defini]
Trend: improving at 3-5% per year

Tolerable: 100 percentage by by Submission Readiness Check. all mandatory document types and sections contain substantive content on first readiness check; binary gate (pass/fail)

Wish: 90 percentage by 2026-09-30. Feasibility: achievable
Goal: 100 percentage by 2026-12-31. Feasibility: achievable
Stretch: 100 percentage by 2026-12-31. Feasibility: achievable

Owner: CAA case officer (application intake team)
Authority: CAA Innovation Hub
Motivation: Complete submission packs enable efficient case opening and reduce rework cycles. Incomplete packs block downstream review (SORA, safety case, crew training) and delay authorization decisions. Operator throughput depends on intake quality.
Priority: critical (rank 1/15)
Keystone: K1 (application intake process integrity)
Primary Stakeholder: CAA Case Officer
Conflicts: Applicant wants flexibility on first submission (incomplete pack with remediation path acceptable); Case Officer wants 100% completeness on submission (no rework cycles). Conflict resolved by Case Off

QC: 1 defect(s) flagged — see qc_findings
```

### SwarmAwareSORAEvidence

```planguage
Tag: SwarmAwareSORAEvidence
Type: Vibe Requirement.
Ambition: "swarm-aware SORA evidence" <- REQ002 (requirements-221fbff5.csv)
Scale: Count of SORA risk evidence items that explicitly address swarm-specific failure modes. Target: >= 3 distinct items per aircraft establishing swarm-aware risk factors.
Scale-Parameters: [SwarmSize], [RiskDomain]
Sub-Scales: SwarmInterdependencyEvidence - count of SORA items addressing failure cascades, EmergentBehaviorEvidence - count of SORA items addressing unintended collective behaviors, CoordinationMechanismEvidence - count of SORA items documenting de-confliction logic
Unit: count of evidence items per aircraft

Meter [METER-003]: Swarm-Specific Risk Evidence Inventory Audit. SORA assessor reviews the submitted SORA evidence document and extracts all risk items (hazards, failure modes, controls, residual risks). For each risk item, assessor tags whether it explicitly addresses swarm-specific failure modes: (1) Coordinated-link-loss cascades (e.g., one aircraft's C2 loss  (Automated: False)

Past: 5 percentage of submissions [FY 2024] <- JARUS SORA v2.5 adoption timeline; EUROCAE WG6 swarm guidance release (late 2024) (estimated)
Status: 15 percentage of submissions [2026-04-23] <- JARUS SORA v2.5 adoption curve; AMLAS/SACE pilot integration (estimated)
Record: 60 count of evidence items per aircraft (evidence coverage) [held by: Academic and research operators (e.g., Centre for Assuring Autonomy, York CAA centre); AMLAS pilot frontrunners]
Ideal: 80 percentage of submissions with >= 3 distinct swarm-specific SORA items per aircraft [Per Alexa's scale, target is >= 3 distinct items per aircraft establishing swarm-aware risk factors.]
Trend: improving at 10-15% per quarter

Tolerable: 3 count of evidence items per aircraft by by SORA Assessment gate (before first flight trial). at least 3 distinct SORA evidence items per aircraft addressing swarm-specific failure modes (loss-of-separation, loss-of-coordination, emergent-failu
Regulatory: 5 count of evidence items per aircraft by by Regulatory Acceptance (authorization decision). JARUS SORA v2.5 conformance mandates >= 5 distinct evidence items per aircraft for complex swarms (>= 3 aircraft)

Wish: 60 percentage of submissions by 2026-09-30. Feasibility: stretch
Goal: 80 percentage of submissions by 2027-12-31. Feasibility: stretch
Stretch: 95 percentage of submissions by 2028-12-31. Feasibility: uncertain

Owner: CAA SORA assessor (flight safety team)
Authority: CAA SORA Assessment Authority (aligned with JARUS SORA v2.5 working group)
Motivation: Swarm-aware SORA evidence documents coordinated-failure modes (loss-of-separation cascades, emergent misbehavior) that single-aircraft SORA misses entirely. Without swarm-specific risk pathways, SAIL and OSO determinations are defensibly unsound and authorization is at risk.
Priority: critical (rank 2/15)
Keystone: K2 (swarm-specific risk assessment integrity)
Primary Stakeholder: CAA SORA Assessor
Conflicts: SORA Assessor and Autonomy Reviewer want maximal swarm-specific evidence (all failure cascades enumerated, all emergent behaviors bounded); Applicant prefers minimal viable evidence to reduce engineer

QC: 1 defect(s) flagged — see qc_findings
```

### ConOpsClarity

```planguage
Tag: ConOpsClarity
Type: Vibe Requirement.
Ambition: "a clear ConOps and ODD" <- REQ003 (requirements-221fbff5.csv)
Scale: Percentage of ConOps sections that explicitly define both nominal and worst-credible behavior boundaries for each operational phase [Phase], such that any two independent safety-case reviewers score the ConOps clarity identically.
Scale-Parameters: [Phase], [TimePeriod]
Sub-Scales: NominalBehaviorSpecification - percentage of phases where nominal behavior is documented with quantified parameters, WorstCredibleBoundaryDefinition - percentage of phases where worst-credible boundaries are explicitly stated, ReviewerAgreement - inter-rater reliability (kappa >= 0.8) of two independent reviewers scoring clarity
Unit: percentage

Meter [METER-004]: Inter-Rater Clarity Consensus Test. Two independent safety-case reviewers (neither has seen ConOps before) are given: (1) ConOps document, (2) ConOps Clarity Scoring Sheet (structured questionnaire: 'For takeoff phase, describe nominal behavior boundary in 2-3 sentences' + 'For takeoff phase, what is worst-credible behavior?' + 10 sim (Automated: False)

Past: 50 percentage [FY 2024] <- CAA safety case review feedback (anecdata); ASTM F3642 clarity assessment guide (estimated)
Status: 55 percentage [2026-04-23] <- CAA safety case reviewer feedback; no formal metrics published (estimated)
Record: 85 percentage [held by: Mature military aviation programs (RAF Protector, Reaper); leading civil operators (e.g., Airborne Support)]
Ideal: 100 percentage [Per Alexa's scale: all ConOps sections explicitly define nominal and worst-credible behavior for eac]
Trend: improving at 3-5% per year

Tolerable: 85 percentage by by ConOps & ODD Review gate. ConOps sections explicitly define nominal and worst-credible behavior for >= 85% of operational phases, with inter-rater clarity (kappa >= 0.8)

Wish: 80 percentage inter-rater agreement (Cohen's kappa >= 0.8) by 2026-09-30. Feasibility: achievable
Goal: 90 percentage inter-rater agreement (Cohen's kappa >= 0.9) by 2027-12-31. Feasibility: achievable
Stretch: 95 percentage inter-rater agreement (Cohen's kappa >= 0.95) by 2028-12-31. Feasibility: achievable

Owner: CAA safety-case reviewer + applicant ConOps author
Authority: CAA Innovation Hub (ConOps guidance); CAA case officer (review gate)
Motivation: ConOps clarity determines whether crew training is well-grounded and safety case hazard analysis is defensible. Vague ConOps (e.g., 'swarm will maintain formation' without specifying tolerance or recovery procedure) leads to crew confusion and unanalyzed failure modes.
Priority: critical (rank 3/15)
Keystone: K3 (operational clarity for crew training and hazard analysis)
Primary Stakeholder: CAA Safety-Case Reviewer
Conflicts: Safety-Case Reviewer demands inter-rater clarity (kappa >= 0.8); regulator reviewers may disagree on what constitutes 'worst-credible' (statistical vs absolute). Applicant prefers bounded definition (

QC: 1 defect(s) flagged — see qc_findings
```

### GeofenceContainment

```planguage
Tag: GeofenceContainment
Type: Vibe Requirement.
Ambition: "automatic containment so that a fly-away cannot become uncontrolled BVLOS" <- REQ005 (requirements-221fbff5.csv)
Scale: Percentage of simulated failure scenarios where the geofence logic correctly prevents boundary exceedance, measured across [NumScenarios] Monte Carlo trials spanning environmental ODD [OddBounds] and single/dual failure modes. Success threshold: >= 99.9% of trials result in zero boundary exceedance.
Scale-Parameters: [NumScenarios], [OddBounds], [FailureModes]
Sub-Scales: BoundaryTolerance - horizontal and vertical geofence boundary margin enforced, FailureModeCoverage - count of single and dual failure scenarios tested, SurvivalTime - mean time to containment after failure detection
Unit: percentage

Meter [METER-005]: Monte Carlo Simulation Gauntlet (Quick & Thorough). Before first flight, Range Safety Officer (RSO) or Workbench simulator runs 10,000 Monte Carlo trials of geofence enforcement. Each trial: (1) Initializes swarm in random position within authorized area, (2) Simulates random failure modes from list: C2 loss, GPS loss, altimeter failure, geofence log (Automated: True)
Meter [METER-006]: Live Fly-Away Breach Test (High-Cost Validation). After Monte Carlo passes, a controlled flight test is conducted with Range Safety Officer present and termination system armed. Setup: (1) Swarm launches within authorized area. (2) RSO deliberately commands aircraft to approach boundary via GPS waypoint or C2 manual input. (3) Geofence logic is mon (Automated: False)

Past: 99.5 percentage [FY 2024] <- CAA annual safety reports on geofence-related incidents; published BVLOS trial outcomes (Project XCelerate, AUVSI data)
Status: 99.6 percentage [2026-04-23] <- Continuous monitoring via CAA incident reporting (MOR); trial outcome data from AMLAS/SACE
Record: 99.99 percentage [held by: Leading military and commercial operators with redundant containment (RAF Protector; Airborne Support BVLOS fleet)]
Ideal: 100 percentage [Zero boundary exceedances in any simulated or operational scenario. 100% containment is the safety i]
Trend: stable at 0.1% per year improvement

Tolerable: 99.5 percentage by by first flight trial. Monte Carlo simulation (>= 10,000 trials) shows >= 99.5% success preventing boundary exceedance across ODD and single/dual failures
Survival: 99.0 percentage by pre-authorization; absolute rock-bottom. below 99% containment, regulator cannot authorize due to excessive fly-away risk
Regulatory: 99.9 percentage by for populations >= 100 within 500m radius. for populated trial areas (residential density > 0.1/hectare), regulator demands 99.9% standard

Wish: 99.9 percentage by 2026-09-30. Feasibility: achievable
Goal: 99.95 percentage by 2027-12-31. Feasibility: achievable
Stretch: 99.99 percentage by 2028-12-31. Feasibility: stretch

Owner: Applicant (airframe/autonomy designer) + CAA airspace regulator
Authority: CAA airspace change team (trial segregation approval)
Motivation: Geofence is the automated last line of defense against uncontrolled BVLOS flight. Single-point-failure in geofence enforcement can release aircraft into uncontrolled airspace, creating public-below and third-party safety hazard. Keystone K1 safety mechanism.
Priority: critical (rank 4/15)
Keystone: K1 (automated containment; safety-critical single-point failure mitigation)
Primary Stakeholder: CAA Airspace Regulator
Conflicts: CRITICAL CONFLICT: Airspace Regulator demands 99.9% success (hard containment); Applicant wants proportional requirement based on crew intervention availability and response time (98-99% acceptable if

QC: 1 defect(s) flagged — see qc_findings
```

### C2LinkResilience

```planguage
Tag: C2LinkResilience
Type: Vibe Requirement.
Ambition: "link loss is survivable and non-interfering" <- REQ006 (requirements-221fbff5.csv)
Scale: Time duration (seconds) for which loss of C2 link does not result in loss-of-separation or uncontrolled flight. Target: >= 30 seconds autonomous survival for loss-of-C2; >= 120 seconds if crew manual takeover is available.
Scale-Parameters: [LinkLossScenario], [TimePeriod]
Sub-Scales: C2LossAutoSurvivalTime - seconds of autonomous flight safety after C2 loss, C2LossCrewTakeoverLatency - seconds available for crew to detect link loss and regain control, InterVehicleLinkLossBehavior - documented swarm response to inter-vehicle link loss, CombinedFailureSurvival - survival time when C2 and GPS are both unavailable
Unit: seconds

Meter [METER-007]: Link Loss Survival Hold-Safe Validation. Controlled simulation test: swarm is flying autonomous waypoint mission. Test operator cuts C2 link (RF kill switch or simulator command). Telemetry system logs: (1) Link loss detection time (latency from actual link break to system recognizing loss), (2) Swarm response: do swarm members continue wa (Automated: True)

Past: 30 seconds [FY 2024] <- BVLOS trial outcomes (Project XCelerate, published ASTM F3550 test data)
Status: 45 seconds [2026-04-23] <- Current BVLOS swarm trial data; AMLAS/SACE pilot outcomes
Record: 120 seconds [held by: Military autonomous systems (RAF Protector, Reaper); leading civil operators with redundant C2]
Ideal: 300 seconds [Per Alexa's scale: >= 30 seconds autonomous survival for loss-of-C2; >= 120 seconds if crew takeover]
Trend: improving at 5-10 seconds per year

Tolerable: 99 percentage link availability by by first flight trial. C2 link maintains >= 99% availability; loss triggers autonomous safe state within 30 seconds
Survival: 30 seconds autonomous survival post-total-loss by mandatory minimum for all BVLOS operations. after C2 loss, aircraft maintains safe state (within geofence) >= 30 seconds for crew RTL trigger

Wish: 60 seconds by 2026-09-30. Feasibility: achievable
Goal: 90 seconds by 2027-12-31. Feasibility: stretch
Stretch: 300 seconds by 2028-12-31. Feasibility: uncertain

Owner: Applicant (C2 system designer) + CAA spectrum specialist
Authority: CAA spectrum / communications assurance team
Motivation: C2 link loss is inevitable in RF-contested environments. Autonomous survival time is the grace period for crew detection and RTL trigger. Without documented survival time (>= 30 seconds), BVLOS authorization cannot be defended if link loss occurs.
Priority: critical (rank 5/15)
Keystone: K4 (graceful degradation under link loss)
Primary Stakeholder: CAA Spectrum Specialist
Conflicts: Spectrum Specialist demands high survival times (>= 30 sec autonomous) to prove non-interference; Applicant may want lower thresholds (e.g., 15 sec) as easier to achieve. Conflict resolved by Spectrum

QC: 1 defect(s) flagged — see qc_findings
```

### DAAPerformance

```planguage
Tag: DAAPerformance
Type: Vibe Requirement.
Ambition: "cooperative and non-cooperative encounters resolved predictably" <- REQ007 (requirements-221fbff5.csv)
Scale: Percentage of encounter scenarios where the DAA system resolution is consistent with pre-defined decision rules and results in loss-of-separation recovery within [RecoveryTime] seconds, without subsequent secondary conflicts, measured across [NumEncounters] test encounters.
Scale-Parameters: [EncounterType], [RecoveryTime], [NumEncounters]
Sub-Scales: CooperativeEncounterResolution - percentage of encounters with ADS-B-equipped intruders where DAA resolution is predictable, NonCooperativeEncounterResolution - percentage of encounters with non-equipped intruders where DAA resolution follows pre-defined rules, SwarmCoordinationUponEncounter - percentage of encounters where swarm formation is maintained post-encounter, DecisionConsistency - inter-test consistency of DAA decisions (same encounter repeated; resolution must be identical >= 95%)
Unit: percentage

Meter [METER-008]: DO-365 Encounter Resolution Test Matrix. DAA system is tested against a suite of >= 100 encounter scenarios drawn from DO-365 (Detect-and-Avoid standards). Scenarios span: (1) Cooperative intruders (ADS-B equipped, altitude/velocity known), (2) Non-cooperative intruders (radar-only, no velocity info), (3) Head-on, crossing, overtake geomet (Automated: True)

Past: 85 percentage [FY 2024] <- DO-365 minimum operational performance standard; published ASTM F3442 test data
Status: 88 percentage [2026-04-23] <- BVLOS trial DAA test results; AMLAS/SACE performance metrics
Record: 99.9 percentage [held by: Military autonomous systems with advanced radar and sensor fusion (RAF Protector, Reaper); research systems with cooperative airspace]
Ideal: 99.95 percentage [Per Alexa's scale: consistent resolution with pre-defined decision rules, recovery within target tim]
Trend: improving at 2-4% per year

Tolerable: 99.5 percentage resolution success by by first flight trial. DAA resolves >= 99.5% of cooperative and non-cooperative encounter scenarios predictably, with recovery within target time and no secondary conflicts
Regulatory: 99.9 percentage by regulatory minimum for certification. DO-365 minimum: 99.9% detection confidence for cooperative DAA systems

Wish: 93 percentage by 2026-09-30. Feasibility: achievable
Goal: 97 percentage by 2027-12-31. Feasibility: achievable
Stretch: 99.5 percentage by 2028-12-31. Feasibility: stretch

Owner: Applicant (DAA algorithm developer) + CAA DAA assessor
Authority: CAA flight safety assessment team (aligned with DO-365 / F3442 certification body)
Motivation: DAA system resolves encounters with cooperative and non-cooperative aircraft. Failure results in mid-air collision. DO-365 is the regulatory standard; swarms must demonstrate consistent, predictable resolution across cooperative and non-cooperative encounter geometries.
Priority: critical (rank 6/15)
Keystone: K5 (mid-air collision avoidance)
Primary Stakeholder: CAA DAA Assessor
Conflicts: DAA Assessor wants maximum encounter coverage (all geometry types, all relative speeds, all weather conditions) to prove robustness; Applicant wants bounded test scenarios (representative sample of 10

QC: 1 defect(s) flagged — see qc_findings
```

### SwarmEmergentBoundedness

```planguage
Tag: SwarmEmergentBoundedness
Type: Vibe Requirement.
Ambition: "airborne limits and emergent-behaviour evidence" <- REQ008 (requirements-221fbff5.csv)
Scale: Count of distinct emergent behaviors documented in the swarm decision-making architecture case, each with a defined boundary and a detection/recovery mechanism if boundary is exceeded. A swarm is bounded if: (1) >= 5 emergent behaviors are identified and bounded, (2) each boundary is quantified, (3) test evidence demonstrates the swarm stays within bounds in >= 95% of flight test hours.
Scale-Parameters: [EmergentBehavior], [BoundaryDefinition], [TestEvidence]
Sub-Scales: EmergentBehaviorInventory - count of distinct emergent behaviors identified and documented, BoundaryQuantification - percentage of identified emergent behaviors with quantified state limits and detection criteria, RecoveryCapability - count of out-of-bounds behaviors for which a recovery/abort action is pre-defined, TestCoverage - percentage of test flight hours where swarm operates within all defined bounds
Unit: count of behaviors with boundaries

Meter [METER-009]: Emergent Behavior Boundary Documentation Audit. Autonomy designer submits a structured manifest of emergent behaviors identified in the swarm architecture. For each behavior (e.g., formation tightening, consensus deadlock, flocking), the manifest documents: (1) Description of the behavior (what happens, when does it occur), (2) Quantified boundar (Automated: False)
Meter [METER-010]: Emergent Behavior Flight Test Coverage Validator. During flight testing, telemetry logs capture swarm state at 10Hz or higher. After each flight, data is analyzed: for each emergent behavior from the manifest (METER-009), auditor verifies: (1) Did the behavior occur during flight? If yes, did it stay within documented boundary? (2) If boundary was  (Automated: True)

Past: 2 count of bounded emergent behaviors [FY 2024] <- AMLAS pilot program case studies; EUROCAE WG6 early swarm guidance (FY 2024) (estimated)
Status: 3 count of bounded emergent behaviors [2026-04-23] <- AMLAS/SACE pilot maturity; EUROCAE WG6 swarm decision-making guidance (released 2025) (estimated)
Record: 7 count of bounded emergent behaviors [held by: Research swarms and leading AMLAS pilot operators (Centre for Assuring Autonomy, University of Bristol swarm research)]
Ideal: 8 count of behaviors with quantified boundaries, recovery mechanisms, and >= 95% test coverage [Per Alexa's scale: >= 5 emergent behaviors with quantified boundaries, detection criteria, and docum]
Trend: improving at 1-2 behaviors per year

Tolerable: 95 percentage of test flight hours within documented bounds by by first flight trial completion. swarm operates within all emergent-behavior boundaries >= 95% of accumulated test flight hours; out-of-bounds events logged
Survival: 90 percentage of test flight hours within bounds by absolute minimum for trial continuation. out-of-bounds in > 10% of hours triggers trial pause and emergent-behavior investigation

Wish: 5 count of bounded emergent behaviors by 2026-09-30. Feasibility: achievable
Goal: 6 count of bounded emergent behaviors by 2027-12-31. Feasibility: stretch
Stretch: 8 count of behaviors with boundaries, recovery, and >= 99% test coverage by 2028-12-31. Feasibility: uncertain

Owner: Applicant (autonomy architect) + CAA autonomy reviewer
Authority: CAA innovation / autonomy assurance team (emerging role; no precedent yet)
Motivation: Swarm behavior emerges from interaction of individual control laws; emergent behavior can violate safety invariants unexpectedly. Documentation of emergent behaviors and quantified boundaries is essential to assure swarms are controllable within operational envelope.
Priority: critical (rank 7/15)
Keystone: K6 (emergent-behavior assurance)
Primary Stakeholder: CAA Autonomy Reviewer
Conflicts: Autonomy Reviewer wants exhaustive emergent behavior inventory (formation geometry drift, coordination latency, flocking instability, split/rejoin behavior, multi-vehicle collision avoidance); Applica

QC: 1 defect(s) flagged — see qc_findings
```

### MLForensicExplainability

```planguage
Tag: MLForensicExplainability
Type: Vibe Requirement.
Ambition: "ML components are assurable and forensically explainable" <- REQ009 (requirements-221fbff5.csv)
Scale: Percentage of safety-critical ML model decisions where the explainability evidence allows independent verification of the decision logic. Evidence sufficiency determined by model type: decision trees = 100% requirement; SVMs = feature importance + decision boundary; neural networks = saliency maps + LIME/SHAP with >= 80% decision-path coverage.
Scale-Parameters: [ModelType], [TestSet], [SafetyCriticality]
Sub-Scales: ModelTransparencyLevel - by-model-type explainability requirement, ReviewerReconstruction - percentage of test decisions where independent reviewers can reconstruct the decision, FrozenModelDocumentation - presence of frozen-model manifest (training data provenance, hyperparameters, validation performance), DecisionLogging - presence of runtime logging capturing ML decision inputs, internal states, and explainability evidence
Unit: percentage

Meter [METER-011]: ML Decision Reconstruction Forensic Test. For each safety-critical ML model (e.g., autonomy-mode classifier, emergency-decision network), a post-hoc forensic test is conducted: (1) Select N=50 representative decisions from logged flight data. (2) For each decision, freeze the model state at that moment (inputs, weights, internal activations (Automated: False)

Past: 20 percentage [FY 2024] <- AMLAS pilot program; industry survey of UAS ML practices (ASTM F38 working group) (estimated)
Status: 28 percentage [2026-04-23] <- AMLAS/SACE pilot outcomes; evolving industry practice on LIME/SHAP adoption (estimated)
Record: 80 percentage [held by: Academic research systems (Centre for Assuring Autonomy; University of Bristol safety-critical ML lab); AMLAS pilot frontrunners with decision-tree-based systems]
Ideal: 90 percentage [Per Alexa's scale: >= 80% decision-path coverage via saliency maps + LIME/SHAP for neural networks; ]
Trend: improving at 5-10% per year

Tolerable: 80 percentage of decisions reconstructable by independent reviewer by by first flight trial. Decision trees 100%; SVMs feature importance + boundary; neural networks saliency + LIME/SHAP >= 80% coverage. >= 80% safety-critical decisions indepe
Survival: 70 percentage by minimum for authorization. below 70%, AAIB refuses to investigate black-box decisions, blocking authorization

Wish: 80 percentage by 2026-09-30. Feasibility: stretch
Goal: 90 percentage by 2027-12-31. Feasibility: stretch
Stretch: 95 percentage by 2028-12-31. Feasibility: uncertain

Owner: Applicant (ML model developer) + CAA AI/ML assurance specialist + AAIB (investigative interest)
Authority: CAA AI/ML assurance authority (emerging; parallels AMLAS/SACE work)
Motivation: ML-based autonomy decision-making (mode selection, emergency response, formation adjustment) must be forensically explainable for post-incident investigation. Black-box neural networks defeat AAIB investigative capacity and block authorization based on AI-safety grounds.
Priority: critical (rank 8/15)
Keystone: K7 (ML forensic explainability for post-incident investigation)
Primary Stakeholder: CAA AI/ML Assurance Specialist
Conflicts: CRITICAL CONFLICT: AAIB wants maximal explainability (every decision path reconstructable, zero black-box); Applicant wants practical threshold (neural networks with SHAP >= 80% coverage acceptable). 

QC: 1 defect(s) flagged — see qc_findings
```

### MeaningfulHumanControl

```planguage
Tag: MeaningfulHumanControl
Type: Vibe Requirement.
Ambition: "meaningful human control demonstrated throughout" <- REQ010 (requirements-221fbff5.csv)
Scale: Composite score across four dimensions of human control, each scored 0-100: (1) SituationalAwareness: crew update frequency on swarm state (target >= 2Hz for nominal, >= 10Hz for off-nominal). (2) AuthorityPreservation: percentage of decisions requiring explicit crew authorization (target: 100% for irreversible decisions, >= 80% for reversible). (3) TakeoverLatency: seconds available for crew to r
Scale-Parameters: [OperationalPhase], [DecisionType]
Sub-Scales: SituationalAwarenessScore - [0-100] based on state update frequency and display comprehensiveness, AuthorityPreservationScore - [0-100] percentage of decisions requiring crew sign-off, TakeoverLatencyScore - [0-100] based on time available to regain control, WorkloadScore - [0-100] based on concurrent event load and duty cycle
Unit: composite score [0-100]

Meter [METER-012]: Crew State-Update Frequency & Display Completeness Audit. Human factors inspector reviews ConOps and UI mockups/actual system. Verifies crew display updates swarm state at target frequency: nominal operations >= 2Hz (swarm position, health, altitude), off-nominal scenarios >= 10Hz (alerts, DAA events, link status). Inspector also audits display completenes (Automated: False)
Meter [METER-013]: Crew Workload & Takeover Latency Simulation Test. Crew is placed in high-fidelity simulator with full swarm flight scenario. Scenario unfolds: (1) Nominal transit (baseline workload measurement), (2) Unexpected event injection (e.g., DAA encounter, C2 glitch, swarm member health alert). During simulation: (1) Crew's workload is measured via NASA-TL (Automated: False)

Past: 45 composite score [0-100] [FY 2024] <- CAA human factors inspection data; ASTM F38 early human factors guidance (estimated)
Status: 52 composite score [0-100] [2026-04-23] <- Recent BVLOS swarm trial human factors assessments; AMLAS/SACE crew training data (estimated)
Record: 85 composite score [0-100] [held by: Military crewed aircraft with advanced cockpit design (e.g., F-35, Apache); leading civil operators with mature HMI (Airborne Support)]
Ideal: 100 composite score [0-100] [Per Alexa's scale: SituationalAwareness >= 2Hz nominal / >= 10Hz off-nominal; AuthorityPreservation ]
Trend: improving at 5-8 points per year

Tolerable: 70 composite score [0-100] by by first flight trial. SituationalAwareness >= 2Hz nominal / >= 10Hz off-nominal; AuthorityPreservation >= 80% reversible / 100% irreversible; TakeoverLatency >= 10s; Worklo

Wish: 70 composite score [0-100] by 2026-09-30. Feasibility: achievable
Goal: 85 composite score [0-100] by 2027-12-31. Feasibility: stretch
Stretch: 100 composite score [0-100] by 2028-12-31. Feasibility: unreachable

Owner: Applicant (HMI designer) + CAA human factors inspector + DDH (legal/ethical implications)
Authority: CAA human factors and innovation teams; DDH policy guidance on AI oversight
Motivation: Meaningful human control ensures crew retains authority over safety-critical decisions and can intervene if autonomy fails. Without demonstrated MHC, authorization may be refused on legal/ethical grounds (AI accountability, responsibility assignment).
Priority: critical (rank 9/15)
Keystone: K8 (crew authority and situational awareness)
Primary Stakeholder: CAA Human Factors Inspector
Conflicts: CRITICAL CONFLICT: Human Factors Inspector wants high control authority (100% on irreversible, >= 80% on reversible) and fast takeover (>= 10 sec); Applicant prefers high autonomy (>= 90% autonomous d

QC: 1 defect(s) flagged — see qc_findings
```

### IndependentFlightTermination

```planguage
Tag: IndependentFlightTermination
Type: Vibe Requirement.
Ambition: "independent termination is effective in any off-nominal state" <- REQ011 (requirements-221fbff5.csv)
Scale: Percentage of simulated off-nominal scenarios where independent flight termination is successfully triggered and executed within [TerminationTime], measured across [NumScenarios] failure and environmental scenarios. Success = swarm reaches safe configuration (motors off, drift ceased) without secondary hazards.
Scale-Parameters: [OffNominalScenario], [TerminationTime], [NumScenarios]
Sub-Scales: TerminationTriggerReliability - percentage of scenarios where termination is correctly triggered, TerminationExecutionCompleteness - percentage of triggers that result in complete motor cutoff and safe configuration, PostTerminationActions - count of defined sub-actions after termination (crew alert, ATSU notification, data preservation, recovery), EnvironmentalRobustness - termination success rate across environmental extremes within ODD bounds
Unit: percentage

Meter [METER-014]: Independent Termination Fault-Injection Test (FMEA-Derived). Failure Modes and Effects Analysis (FMEA) is conducted on termination system (hardware, firmware, power supply, sensors, command path). From FMEA, >= 50 failure scenarios are identified. Test procedure: (1) For each scenario, inject the failure (simulator or hardware-in-the-loop testbed). (2) Trigge (Automated: True)

Past: 98 percentage [FY 2024] <- BVLOS trial outcomes; published flight termination test data (ASTM F3642, EUROCAE WG6)
Status: 99.1 percentage [2026-04-23] <- Current BVLOS swarm trial outcomes; AMLAS/SACE flight termination test data
Record: 99.99 percentage [held by: Military autonomous systems with triple-redundant termination (RAF Protector, Reaper); research swarms with provably correct termination logic]
Ideal: 99.99 percentage [Per Alexa's scale: >= 99.9% effectiveness across all off-nominal scenarios, within target time, with]
Trend: stable at 0.5% per year improvement

Tolerable: 99.9 percentage effectiveness across failure scenarios by by first flight trial. Termination triggers correctly and executes completely >= 99.9% of simulated off-nominal scenarios (>= 50 distinct). Safe configuration achieved witho
Survival: 99.0 percentage by pre-authorization floor. below 99%, flight ops cannot authorize due to uncontrolled descent risk

Wish: 99.95 percentage by 2026-09-30. Feasibility: achievable
Goal: 99.99 percentage by 2027-12-31. Feasibility: achievable
Stretch: 99.999 percentage by 2028-12-31. Feasibility: uncertain

Owner: Applicant (termination system hardware/firmware designer) + CAA flight-ops inspector
Authority: CAA flight operations and safety assurance team
Motivation: Independent flight termination is the last-resort safety mechanism. If autonomy or C2 fails, independent termination must fire to prevent uncontrolled descent. Single-point-failure in termination is catastrophic.
Priority: critical (rank 10/15)
Keystone: K1 (independent safety mechanism; single-point-failure mitigation)
Primary Stakeholder: CAA Flight-Ops Inspector
Conflicts: Single vs dual redundancy: Flight-Ops Inspector prefers dual-channel termination (fail-safe); Applicant wants single-channel (lower cost) if reliability is proven. Conflict: scale requires >= 50 test 

QC: 1 defect(s) flagged — see qc_findings
```

### MORForensicCompleteness

```planguage
Tag: MORForensicCompleteness
Type: Vibe Requirement.
Ambition: "complete recorded evidence accepted MOR obligations" <- REQ012 (requirements-221fbff5.csv)
Scale: Percentage of incident events where a complete recorded evidence set is captured: all aircraft state variables sampled at >= 10Hz and logged for >= [RetentionTime] post-incident, with data integrity verified (no gaps > 100ms, checksums valid) and forensic provenance documented.
Scale-Parameters: [StateVariables], [SamplingRate], [RetentionTime], [MORTrigger]
Sub-Scales: DataSchemaCoverage - count of required state variables captured, DataIntegrity - percentage of logged time intervals with valid data (no gaps > 100ms), ForensicProvenance - presence of cryptographic hash, timestamp, source certification for each data file, RetentionCompliance - percentage of incidents where evidence is retained for full MOR investigation duration
Unit: percentage

Meter [METER-015]: Data Recording Completeness & Integrity Audit. Before flight commences, data recording system is audited: (1) Schema audit: verify all required state variables are logged (position XYZ, velocity, acceleration, heading, engine RPM, autonomy mode, sensor inputs, crew commands, system alerts). Target: all 15+ variables present. (2) Sampling rate au (Automated: True)

Past: 85 percentage [FY 2024] <- CAA mandatory occurrence reporting (MOR) database analysis; published incident investigation reports
Status: 88 percentage [2026-04-23] <- Current BVLOS trial data logging practices; AMLAS/SACE pilot outcomes
Record: 99.5 percentage [held by: Military systems with triple-redundant flight data recording (RAF Protector, Reaper); research systems with forensic-grade logging]
Ideal: 100 percentage [Per Alexa's scale: 100% of incident events with complete recorded evidence, all state variables >= 1]
Trend: improving at 2-3% per year

Tolerable: 100 percentage of incident events with complete recorded evidence by mandatory for all BVLOS operations. All incidents logged with complete state (XYZ, velocity, accel, heading, engine, autonomy, sensors, crew, alerts) >= 10Hz, no gaps > 100ms, forensic p

Wish: 95 percentage by 2026-09-30. Feasibility: achievable
Goal: 100 percentage by 2027-12-31. Feasibility: achievable
Stretch: 100 percentage by 2028-12-31. Feasibility: uncertain

Owner: CAA flight safety investigator (MOR handler) + applicant (data logger owner)
Authority: CAA flight safety investigation authority; AAIB (investigative interest)
Motivation: Mandatory Occurrence Reporting (MOR) regulations require complete flight data for post-incident investigation. Data gaps defeat AAIB investigation and block learning from incidents. Forensic provenance ensures data integrity is defensible in incident proceedings.
Priority: high (rank 11/15)
Keystone: K9 (forensic data preservation for incident investigation)
Primary Stakeholder: CAA Flight Safety Investigator
Conflicts: Sampling rate: AAIB wants 50Hz (high-frequency dynamics capture); Applicant prefers 10Hz (bandwidth/cost trade-off). Conflict: scale defaults to >= 10Hz nominal, >= 50Hz high-frequency; Applicant must

QC: 1 defect(s) flagged — see qc_findings
```

### CrewCompetencyEvidence

```planguage
Tag: CrewCompetencyEvidence
Type: Vibe Requirement.
Ambition: "evidenced competency" <- REQ014 (requirements-221fbff5.csv)
Scale: Count of documented competencies per crew member, each with evidence of demonstrated proficiency. For each operational role [Role], a crew member is competent if: (1) holds required certification [Certification], (2) completed role-specific training with documented pass/fail result, (3) demonstrated emergency procedure execution in simulation with >= 90% success rate, (4) logged >= [MinFlightHours
Scale-Parameters: [Role], [Certification], [MinFlightHours]
Sub-Scales: CertificationCoverage - count of crew members holding all required certifications, TrainingCompleteness - count of role-specific training courses completed with documented pass/fail, SimulationProficiency - percentage of emergency procedure simulations executed with >= 90% success, OperationalExperience - total flight hours logged in similar operational conditions
Unit: count of documented competencies per crew member

Meter [METER-016]: Crew Emergency Procedure Simulation Validation. For each crew member and assigned role (pilot, sensor operator, safety officer), a simulator-based assessment is conducted. Scenarios test: (1) Link-loss response (correct execution of RTL / contingency procedures), (2) Geofence-breach response (abort mission, land immediately), (3) DAA encounter re (Automated: False)

Past: 3 documented competencies per crew member [FY 2024] <- CAA licensing and training records; published UAS operator certification standards (estimated)
Status: 3.5 documented competencies per crew member [2026-04-23] <- Current UAS operator licensing requirements; AMLAS/SACE crew training data (estimated)
Record: 6 documented competencies per crew member [held by: Mature military UAS operators (RAF Protector pilots); leading civil operators with specialized training (Airborne Support)]
Ideal: 5 documented competencies per crew member [Per Alexa's scale: certification (CAA UAS operator, swarm-operations endorsement, type rating), role]
Trend: improving at 0.3-0.5 competencies per year

Tolerable: 5 documented competencies per crew member by before first flight trial. Each crew member: (1) CAA UAS operator cert, (2) aircraft type rating, (3) swarm-operations endorsement, (4) role-specific training (pass/fail), (5) e

Wish: 4 documented competencies per crew member by 2026-09-30. Feasibility: achievable
Goal: 5 documented competencies per crew member by 2027-12-31. Feasibility: achievable
Stretch: 6 documented competencies per crew member by 2028-12-31. Feasibility: achievable

Owner: Applicant (crew training organization) + CAA licensing inspector
Authority: CAA licensing and training authority (Part-FCL alignment)
Motivation: Crew must demonstrate competency across multiple dimensions: certification, training, simulation proficiency, and operational experience. Without documented evidence, pilot-in-charge integrity is unverified and crew cannot legally operate.
Priority: medium (rank 12/15)
Keystone: K10 (crew competency baseline)
Primary Stakeholder: CAA Licensing Inspector
Conflicts: Experience requirement: Licensing Inspector wants >= 50 hours BVLOS swarm experience; Applicant wants waiver if simulation proficiency is high (cost-driven, schedule-driven). Conflict: Licensing Inspe

QC: 1 defect(s) flagged — see qc_findings
```

### CAAMAAApportionmentGapFreeness

```planguage
Tag: CAAMAAApportionmentGapFreeness
Type: Vibe Requirement.
Ambition: "signed apportionment so that regulatory ownership is gap-free" <- REQ015 (requirements-221fbff5.csv)
Scale: Percentage of safety-critical design and operational aspects covered by a signed CAA/MAA apportionment matrix, such that responsibility for each aspect is assigned to exactly one regulatory body, with no gaps (unassigned aspects) and no overlaps. Coverage target: >= 100% of hazards identified in SORA, >= 100% of design domains, >= 100% of operational domains.
Scale-Parameters: [Domain], [HazardCategory], [SignatoryStatus]
Sub-Scales: HazardCoverage - count of SORA hazards assigned to CAA or MAA in apportionment matrix, DesignDomainCoverage - count of design domains with assigned responsibility, OperationalDomainCoverage - count of operational domains with assigned responsibility, OverlapDetection - count of aspects assigned to both CAA and MAA (target: 0 overlaps)
Unit: percentage

Meter [METER-017]: Regulatory Responsibility Traceability Matrix Audit. A responsibility matrix is constructed (rows = safety-critical design/operational domains from SORA hazard list + design domains + operational domains; columns = CAA responsibility, MAA responsibility, shared, unassigned). For each row, the applicant assigns responsibility to exactly one party (CAA, (Automated: False)

Past: 75 percentage [FY 2024] <- Published CAA/MAA trial apportionment matrices (Project XCelerate, AMLAS pilot); CAA governance records (estimated)
Status: 80 percentage [2026-04-23] <- Current CAA/MAA apportionment matrices; published trial governance documents (estimated)
Record: 100 percentage [held by: RAF MOD research programs with integrated CAA/MOD governance; mature civil trials with comprehensive apportionment review]
Ideal: 100 percentage [Per Alexa's scale: 100% of safety-critical aspects covered by signed apportionment, exactly one owne]
Trend: improving at 5-10% per year

Tolerable: 100 percentage coverage with no gaps or overlaps by by Submission Readiness Check. Signed CAA/MAA apportionment covers 100% SORA hazards, 100% design domains, 100% operational domains. Each aspect assigned to exactly one body. No gap

Wish: 85 percentage by 2026-09-30. Feasibility: achievable
Goal: 100 percentage by 2027-12-31. Feasibility: stretch
Stretch: 100 percentage by 2028-12-31. Feasibility: unreachable

Owner: CAA/MAA liaison team (joint governance)
Authority: CAA Innovation Hub + MAA RPAS Regulatory Branch (joint authority)
Motivation: Civil/military regulatory boundary must be clearly defined. Ambiguous responsibility assignments (swarm-specific SORA assessment: CAA or MAA? ML explainability: CAA or RAISO?) create regulatory risk for operators and delay authorization decisions.
Priority: high (rank 13/15)
Keystone: K11 (regulatory responsibility clarity)
Primary Stakeholder: CAA/MAA Liaison (joint panel)
Conflicts: CRITICAL CONFLICT: CAA and MAA may disagree on responsibility split: CAA may claim public-safety authority over all aspects; MAA may claim range-safety authority as primary. Example: geofence enforcem

QC: 1 defect(s) flagged — see qc_findings
```

### PhasedGateReversibility

```planguage
Tag: PhasedGateReversibility
Type: Vibe Requirement.
Ambition: "phased gates so that evidence builds progressively and is reversible" <- REQ016 (requirements-221fbff5.csv)
Scale: Count of well-defined phased trial gates, where each gate has: (1) Clear Criterion: quantified evidence requirement. (2) Reversibility: documented procedure to exit the current phase if new evidence suggests unacceptable risk. (3) Data Immutability: all evidence data preserved and audit-logged so gates can be re-evaluated. (4) Re-entry Procedure: re-entry criteria and evidence refresh requirements
Scale-Parameters: [PhaseLabel], [GateCriterion], [ReversibilityScenario]
Sub-Scales: GateCount - number of distinct phases with explicit gates (target: >= 4), CriterionClarity - percentage of gates with quantified progression criteria, ReversibilityDocumentation - percentage of gates with documented exit criteria and phase-reversal procedures, DataImmutability - evidence that all phase data is preserved in write-once storage or audit-logged
Unit: count of well-defined gates

Meter [METER-018]: Phased Gate Criteria & Reversibility Procedure Specification. For each trial phase (e.g., Phase 1: 2-aircraft VLOS, Phase 2: 4-aircraft VLOS, Phase 3: 4-aircraft BVLOS), a gate specification document is drafted. For each gate, the document contains: (1) Gate Criterion (quantified evidence threshold, e.g., 'Phase 1 gate: 10 successful flights with zero loss-of- (Automated: False)

Past: 2 count of well-defined gates [FY 2024] <- Published trial protocols (Project XCelerate, AMLAS pilot); EUROCAE WG6 guidance (FY 2024) (estimated)
Status: 2.5 count of well-defined gates [2026-04-23] <- Current AMLAS/SACE trial protocols; emerging phased-trial guidance (estimated)
Record: 5 count of well-defined gates [held by: Mature military programs (RAF Protector, Reaper) with multi-phase test and evaluation; leading AMLAS pilot operators]
Ideal: 6 count of well-defined gates with clear criteria, reversibility, data immutability, and re-entry procedures [Per Alexa's scale: >= 4 well-defined phases with explicit gates, reversibility documentation, data a]
Trend: improving at 0.5-1 gate per year

Tolerable: 100 percentage of gates with documented exit/reversal criteria by before trial commences. Every phased gate has: clear criterion, documented exit/reversal procedure, data immutability (write-once or audit-log), re-entry criteria. All eviden

Wish: 4 count of well-defined gates by 2026-09-30. Feasibility: achievable
Goal: 5 count of well-defined gates by 2027-12-31. Feasibility: stretch
Stretch: 6 count of gates with rollback budget <= 1 hour by 2028-12-31. Feasibility: uncertain

Owner: CAA programme manager (trial governance) + applicant (phased trial execution)
Authority: CAA Innovation Hub (programme governance authority)
Motivation: Phased trial gates allow progressive evidence accumulation and rapid learning cycles. Reversibility ensures unexpected findings (emergent-behavior anomaly, higher-than-expected failure rate) trigger phase reversal, not program cancellation, enabling safe innovation.
Priority: medium (rank 14/15)
Keystone: K12 (reversible trial progression for safe innovation)
Primary Stakeholder: CAA Programme Manager
Conflicts: CRITICAL CONFLICT: Programme Manager values reversibility (risk reduction, adaptive management); Applicant wants forward momentum (cost, schedule urgency). Applicant fears that reversibility is an exc

QC: 1 defect(s) flagged — see qc_findings
```

### PublicEngagementCoverage

```planguage
Tag: PublicEngagementCoverage
Type: Vibe Requirement.
Ambition: "community consultation and media handling (absent-by-default)" <- REQ017 (requirements-221fbff5.csv)
Scale: Count of stakeholder groups engaged prior to trial authorization, with documented consultation evidence. Target: >= 5 stakeholder groups engaged (e.g., local residents, landowners, environmental, aviation community, local media). For each group, engagement completeness measured as: (1) Prior notification (timing >= [NotificationLeadTime] before flight). (2) Documented feedback collection (survey, 
Scale-Parameters: [StakeholderGroup], [Radius], [NotificationLeadTime]
Sub-Scales: StakeholderIdentification - count of stakeholder groups identified and engaged (target: >= 5), PriorNotification - percentage of stakeholders receiving advance notice >= [NotificationLeadTime], FeedbackCollection - count of distinct feedback mechanisms used and percentage of stakeholders responding, FeedbackResponseCoverage - percentage of feedback items receiving documented response
Unit: count of engaged stakeholder groups

Meter [METER-019]: CAP 1616 Consultation Audit & Community Engagement Report. CAP 1616 (Engagement, Coordination and Access for Airspace Users) prescribes a consultation process. Meter: auditor reviews consultation evidence package submitted by applicant. Verifies: (1) StakeholderIdentification: applicant has identified >= 5 distinct stakeholder groups (residents within [Radi (Automated: False)

Past: 1 count of stakeholder groups engaged [FY 2024] <- CAP 1616 airspace change process; published trial community engagement reports (limited) (estimated)
Status: 2 count of stakeholder groups engaged [2026-04-23] <- Recent BVLOS trial engagement reports; emerging CAP 1616 best practices (estimated)
Record: 5 count of stakeholder groups engaged with documented feedback response [held by: Leading civil trials with comprehensive community engagement (e.g., some AMLAS pilots); published CAP 1616 exemplary cases]
Ideal: 6 count of engaged stakeholder groups with prior notification, feedback collection, documented response, and residual concern escalation [Per Alexa's scale: >= 5 stakeholder groups (residents, landowners, environmental, aviation, media) w]
Trend: improving at 0.5-1 stakeholder group per year

Tolerable: 5 count of engaged stakeholder groups by before first flight trial (>= 30-day lead). Engaged >= 5 groups (residents within 5km, landowners, environmental, aviation, media) with prior notification (>= 30 days), feedback collection, docu
Regulatory: 6 count of stakeholder groups by mandatory for near-populated trials (residential > 0.1/hectare). For trials within 5km of residential areas, engage >= 6 groups (add local council as mandatory 6th per enhanced CAP 1616)

Wish: 3 count of engaged stakeholder groups by 2026-09-30. Feasibility: achievable
Goal: 5 count of engaged stakeholder groups by 2027-12-31. Feasibility: stretch
Stretch: 6 count of groups with published feedback dashboard by 2028-12-31. Feasibility: uncertain

Owner: Applicant (community engagement lead) + CAA airspace change team (TDA consultation)
Authority: CAA Innovation Hub (policy guidance) + CAA airspace team (TDA consultation process)
Motivation: Community consultation (CAP 1616) and public engagement builds social license for BVLOS swarm operations. Without engagement, public opposition can delay or block trial authorization. GDPR and human rights law require prior notification to affected individuals.
Priority: high (rank 15/15)
Keystone: K13 (social license and community trust)
Primary Stakeholder: CAA Airspace Regulator (AAA)
Conflicts: CRITICAL CONFLICT: Local Communities and Media want maximum engagement and transparency; Applicant wants minimal engagement (cost, schedule overhead). CAA Airspace Regulator enforces CAP 1616 minimum 

QC: 1 defect(s) flagged — see qc_findings
```

---

## Quality Control Summary

Lovelace ran Spec QC on the complete vibe spec set:

- **Total defects:** 15
- **Defects per spec:** 0.93
- **Overall completeness:** 63%
- **Exit recommendation:** `major_rework`

**Defects by type:**

- inconsistency: 2
- incomplete_spec: 4
- status_below_tolerable: 8

**Completeness by value:**

| Value | Completeness |
|---|---:|
| GeofenceContainment | 85% |
| IndependentFlightTermination | 80% |
| PackCompleteness | 75% |
| C2LinkResilience | 70% |
| MORForensicCompleteness | 70% |
| DAAPerformance | 65% |
| MeaningfulHumanControl | 65% |
| CrewCompetencyEvidence | 65% |
| CAAMAAApportionmentGapFreeness | 65% |
| ConOpsClarity | 60% |
| PhasedGateReversibility | 55% |
| SwarmAwareSORAEvidence | 45% |
| PublicEngagementCoverage | 45% |
| SwarmEmergentBoundedness | 40% |
| MLForensicExplainability | 35% |

---

*Report generated by [OpenRequirements.ai](https://www.openrequirements.ai) · Vibe Requirements methodology by Tom Gilb*