# IEEE 830 Software Requirements Specification Report

**Powered by [OpenRequirements.ai](https://openrequirements.ai)** · Based on IEEE Std 830-1998

![Requirements](https://img.shields.io/badge/functional_reqs-75-blue) ![Findings](https://img.shields.io/badge/findings-85-purple) ![Critical](https://img.shields.io/badge/critical-37-red) ![Overall](https://img.shields.io/badge/overall_quality-45%25-yellow)

**Source:** DeFOSPAM + Vibe + PE + SBE + `requirements-221fbff5.csv`
**Generated:** 2026-04-23 12:00 UTC
**System:** CAA/MAA Joint Approval Workbench for BVLOS UAS Swarm Flight Trials

---

## IEEE 830 Quality Scorecard

| Characteristic | Agent | Score | Status | Findings (C/M/m) |
|---|---|---:|---|---|
| **C** — Correct | Chelcie | 41% | ✗ FAIL | 8 (5/3/0) |
| **U** — Unambiguous | Odin | 0% | ✗ FAIL | 22 (15/7/0) |
| **C** — Complete | Lucy | 44% | ✗ FAIL | 10 (4/5/1) |
| **C** — Consistent | Ophellia | 45% | ✗ FAIL | 9 (4/5/0) |
| **R** — Ranked | Natasha | 74% | ⚠ WARN | 7 (1/5/1) |
| **V** — Verifiable | Iris | 49% | ✗ FAIL | 10 (3/7/0) |
| **M** — Modifiable | Amelia | 48% | ✗ FAIL | 8 (4/4/0) |
| **T** — Traceable | Lewis | 62% | ✗ FAIL | 11 (1/9/1) |
| **Overall** | — | **45%** | | |

### Executive Verdict

The SRS for the CAA/MAA Joint Approval Workbench **meets IEEE 830 structure**: 75 functional requirements assigned across a feature-based organisation (Amelia), 20 ranked by necessity/stability/version (Natasha), 20 with formal acceptance criteria (Iris), and 20 with complete RTM entries (Lewis). **IEEE 830 Section coverage: 88%** (13 populated / 8 partial / 0 empty) across 21 sections. **However, 20 TBDs remain** (8 critical, 11 major, 1 minor) — stakeholder workshops (WS-001 swarm SORA, WS-002 containment design, WS-003 human factors) are the critical path before the SRS can be declared v1.0 complete.

---

## Requirements Apportionment (IEEE 830 §2.6)

- **Essential:** 7 REQs (must-have)
- **Conditional:** 8 REQs (should-have)
- **Optional:** 5 REQs (could-have)

- **Stable:** 8 REQs (unlikely to change 2026-2028)
- **Moderate:** 7 REQs (may change within project lifecycle)
- **Volatile:** 5 REQs (high change probability)

### Version targets

| Version | Scope | Count |
|---|---|---:|
| **v1.0** — end 2026 | Essential + stable: foundations (K1, K6, AC1, AC2 core) | 5 |
| **v1.0-minor** — Q1-Q2 2027 | Essential conditional: AC3-AC8 expansion, K2-K5 | 3 |
| **v1.1** — end 2027 | Conditional + moderate: calibration, REQ017-020 authored | 7 |
| **v2.0** — future | Optional + volatile: coalition, urban, maritime variants | 5 |

---

## Sample IEEE 830 Rewrites (Odin — first 6 of 20)

### REQ001

**Original:** As a CAA case officer I want to receive a complete Operational Authorisation pack so that I can open a valid case.

**IEEE 830 rewrite:** The Workbench shall, upon applicant submission, execute the Artefact Detector component to validate the Operational Authorisation Pack against the mandatory-artefact list for the classified operation type. The Pack shall be considered complete when all 8 mandatory artefacts (ConOps, SORA, Safety Case, Training Plan, Personnel List, Environmental Assessment, Insurance, Ground Survey) are present, validly formatted (PDF/XLSX/DOCX), and exceed minimum page thresholds: ConOps >= 5 pages, SORA >= 3 pages, Safety Case >= 10 pages. An incomplete pack shall cause the case to enter the return-for-clarification state with explicit specification of missing artefacts. A complete pack shall cause the case to enter the open-case state and advance to SORA Assessment phase.

*Canonical terms used: Operational Authorisation Pack, Artefact Detector, return-for-clarification, open-case state, SORA Assessment*

### REQ002

**Original:** As a CAA SORA assessor I want swarm-aware SORA evidence so that I can set SAIL and OSO requirements defensibly.

**IEEE 830 rewrite:** The SORA Assessor shall, when evaluating a BVLOS swarm trial, demand swarm-aware SORA evidence that explicitly accounts for: (1) collective behavior arising from inter-vehicle coordination; (2) coordination dependencies between aircraft; (3) emergent risks (separation loss, deadlock, single-point-of-failure cascades) not present in single-aircraft SORA. Evidence shall be defensible through reference to JARUS SORA v2.5 methodology, documented hazard analysis (FTA or STAMP), and verification against swarm-specific scenarios. Upon evaluation, the assessor shall issue SAIL (Specific Assurance and Integrity Level) and OSO (Operational Safety Objectives) targets that explicitly reference swarm coordination constraints (e.g., 'Separation maintained during coordinated evasion maneuver shall be >= 50 meters horizontally and 20 meters vertically').

*Canonical terms used: swarm-aware, SORA (Specific Operational Risk Assessment), SAIL (Specific Assurance and Integrity Level), OSO (Operational Safety Objectives), defensibly, inter-vehicle coordination, emergent risks, JA*

### REQ003

**Original:** As a CAA safety-case reviewer I want a clear ConOps and ODD so that I can judge nominal and worst-credible behaviour.

**IEEE 830 rewrite:** The Safety Case Reviewer shall receive a Concept of Operations (ConOps) document containing: (1) swarm composition and roles; (2) operational phases with crew decision points; (3) failure modes and contingency responses; (4) nominal behavior thresholds (e.g., 'normal flight plan deviation < 2 degrees, descent rate < 100 ft/min'). The Reviewer shall also receive the Operational Design Domain (ODD) specifying operating conditions (wind speed <= 15 knots, temperature -5°C to +30°C, GPS accuracy better than 5 meters, daylight hours only). Upon review, the Reviewer shall validate that all worst-credible behavior scenarios are addressed by documented crew procedures or containment systems. Worst-credible behavior is defined as the most severe single failure or environmental excursion reasonably foreseeable (e.g., loss of GPS signal, C2 link loss, geofence breach) that the system and crew must survive. The Reviewer shall issue accept, return-for-clarification, or refuse-with-reasons decision.

*Canonical terms used: Concept of Operations (ConOps), Operational Design Domain (ODD), nominal behavior, worst-credible behaviour, single failure, containment, return-for-clarification*

### REQ004

**Original:** As a CAA airspace regulator I want a TDA and consultation package so that I can segregate the trial from other users.

**IEEE 830 rewrite:** The Applicant shall submit a Temporary Danger Area (TDA) request to the Airspace Regulator specifying: (1) 3D airspace volume (latitude, longitude, altitude bands, time window); (2) NOTAM text (formatted per ICAO Annex 15) for publication to civilian traffic; (3) coordination evidence showing consultation with ATSU (Air Traffic Service Unit), airspace users (e.g., commercial routes), and affected landowners. The Airspace Regulator shall review the TDA and consultation evidence to confirm: (A) TDA boundaries do not overlap with published airways, restricted airspace, or active training routes; (B) ATSU has confirmed capacity to issue NOTAM and monitor boundary compliance; (C) duration and re-entry procedures are documented. Upon approval, the Regulator shall authorize TDA publication. Upon rejection, the Regulator shall specify which elements (3D volume, NOTAM text, or coordination evidence) require revision.

*Canonical terms used: Temporary Danger Area (TDA), NOTAM (Notice to Airmen), ICAO Annex 15, ATSU (Air Traffic Service Unit), segregation, airspace users*

### REQ005

**Original:** As a CAA airspace regulator I want automatic containment so that a fly-away cannot become uncontrolled BVLOS.

**IEEE 830 rewrite:** The UAS shall be equipped with automatic containment systems that prevent egress beyond the geofence (defined 3D boundary: latitude ±tolerance, longitude ±tolerance, altitude floor/ceiling) independent of C2 link state or onboard autonomy. Containment shall combine: (1) geofence monitor (runs onboard, polling GNSS at 10 Hz minimum); (2) primary containment action (priority: Return-to-Launch if GPS available; fallback: climb to safe altitude and hold). Upon geofence breach detection (aircraft position exceeds boundary by > 10 meters for > 2 seconds), the system shall: (A) trigger containment action within 500 milliseconds; (B) log breach event (timestamp, coordinates, breach direction); (C) notify crew via alert (audio + visual) within 1 second. Containment design shall be validated through software testing (hitl simulation, boundary stress testing) and approved by CAA autonomy reviewer before trial authorization. Failure of containment shall result in mandatory trial suspension and inv

*Canonical terms used: automatic containment, geofence, fly-away, Return-to-Launch, GNSS (Global Navigation Satellite System), BVLOS, HITL (Hardware-in-the-Loop)*

### REQ006

**Original:** As a CAA spectrum specialist I want authorised monitored C2 and inter-vehicle links so that link loss is survivable and non-interfering.

**IEEE 830 rewrite:** The Applicant shall obtain spectrum authorization from the Spectrum Regulator for: (1) C2 (Command and Control) link frequency allocation and power limits; (2) inter-vehicle link frequency allocation (for swarm aircraft-to-aircraft coordination). Authorization shall require evidence that link design is: (A) non-interfering: power spectral density meets ITU-R recommendations and is validated through EMC testing; (B) monitored: real-time link quality telemetry (RSSI, BER) is transmitted to ground crew and logged. Upon C2 link loss (signal quality drops below minimum threshold for > 1 second), the aircraft shall execute failover: (1) if GPS available, maintain altitude and execute Return-to-Launch trajectory; (2) if GPS unavailable, climb to safe altitude (500 feet AGL minimum) and hold. Swarm coordination during C2 loss shall rely on inter-vehicle links and pre-programmed contingency responses. Survival time (duration crew can maintain safe state without ground crew C2) shall be demonstr

*Canonical terms used: C2 link (Command and Control), inter-vehicle links, link loss survivable, non-interfering, RSSI (Received Signal Strength Indicator), BER (Bit Error Rate), Return-to-Launch, EMC testing*

---

## Sample Acceptance Criteria (Iris — first 6 of 20)

**REQ001 — Operational Authorisation Pack Completeness and Case Opening**

- Verification method: `test`
- Acceptance criterion: The Workbench Artefact Detector shall, upon applicant submission of an Operational Authorisation Pack, execute automated validation against the mandatory-artefact list (ConOps, SORA, Safety Case, Training Plan, Personnel List, Environmental Assessment, Insurance, Ground Survey) within 10 minutes of upload. Output: Red/Amber/Green coverage matrix. Pack shall be marked GREEN when all 8 mandatory art
- Pass threshold: 100% detection accuracy across 50 sample packs; all 8 mandatory artefacts correctly identified; case state transition executed correctly (open-case for complete, return-for-clarification for incomplet
- Test owner: Workbench QA / CAA case officer (manual verification of complex cases)
- Verifiable: True

**REQ002 — Swarm-Aware SORA Evidence and SAIL/OSO Derivation**

- Verification method: `inspection`
- Acceptance criterion: The SORA Assessor shall, when evaluating a BVLOS swarm trial, review the SORA evidence and extract all risk items (hazards, failure modes, controls). For each risk item, assessor shall tag whether it explicitly addresses swarm-specific failure modes: (1) Coordinated-link-loss cascades, (2) Emergent misbehavior (deadlock, oscillation), (3) Unintended inter-vehicle interactions. Target: >= 3 distinc
- Pass threshold: 100% of SORA packages contain >= 3 swarm-aware risk items distributed across 3 categories; 100% include evidence citations (test reports, FTA, STAMP); 100% of derived SAIL/OSO explicitly reference swa
- Test owner: CAA SORA Assessor (human domain expert)
- Verifiable: True

**REQ003 — Clear ConOps and ODD for Nominal and Worst-Credible Behaviour Assessment**

- Verification method: `inspection`
- Acceptance criterion: The Safety Case Reviewer shall receive a Concept of Operations (ConOps) document specifying: (1) Swarm composition and roles, (2) Operational phases with crew decision points, (3) Failure modes and contingency responses, (4) Nominal behavior thresholds (e.g., normal flight plan deviation < 2 degrees, descent rate < 100 ft/min). The Reviewer shall also receive the Operational Design Domain (ODD) sp
- Pass threshold: 100% ConOps documents contain all 4 required sections; 100% ODD documents specify numeric environmental bounds for wind, temperature, GPS accuracy, lighting; >= 90% of credible single-failure scenario
- Test owner: CAA Safety Case Reviewer (human inspector)
- Verifiable: True

**REQ004 — Temporary Danger Area and Consultation Evidence Package**

- Verification method: `inspection`
- Acceptance criterion: The Applicant shall submit a Temporary Danger Area (TDA) request to the Airspace Regulator specifying: (1) 3D airspace volume (latitude, longitude, altitude bands, time window in ICAO format), (2) NOTAM text formatted per ICAO Annex 15 for publication to civilian traffic, (3) Coordination evidence showing documented consultation with ATSU (Air Traffic Service Unit), airspace users (e.g., commercia
- Pass threshold: 100% of TDA requests contain: proper 3D airspace volume specification (latitude, longitude, altitude, time), valid ICAO Annex 15 NOTAM text, documented evidence of consultation with 3 stakeholder grou
- Test owner: CAA Airspace Regulator / ATSU liaison
- Verifiable: True

**REQ005 — Automatic Containment Systems for Geofence Enforcement**

- Verification method: `test`
- Acceptance criterion: The UAS shall be equipped with automatic containment systems (geofence monitor + primary containment action) that prevent egress beyond the geofence (defined 3D boundary: latitude ±tolerance, longitude ±tolerance, altitude floor/ceiling) independent of C2 link state or onboard autonomy. Containment shall combine: (1) Geofence monitor running onboard, polling GNSS at 10 Hz minimum, (2) Primary cont
- Pass threshold: 100% of simulated geofence breach scenarios result in containment action within 500 ms; 100% of breaches logged with timestamp/coordinates; 100% of crew alerts delivered within 1 second; robust operat
- Test owner: Applicant autonomy team (HITL + flight test), CAA autonomy reviewer (approval gate)
- Verifiable: True

**REQ006 — Spectrum-Authorized C2 and Inter-Vehicle Links with Link-Loss Survivability**

- Verification method: `test`
- Acceptance criterion: The Applicant shall obtain spectrum authorization from Spectrum Regulator for: (1) C2 (Command and Control) link frequency allocation and power limits, (2) Inter-vehicle link frequency allocation (for swarm aircraft-to-aircraft coordination). Authorization requires evidence that link design is: (A) Non-interfering: power spectral density meets ITU-R recommendations, validated through EMC testing (
- Pass threshold: 100% EMC tests pass ITU-R power spectral density limits per EN 61000-6-4; 100% of C2 link-loss scenarios (loss for > 1 sec) trigger failover within 500 ms; 100% of failover maneuvers execute correctly
- Test owner: Spectrum Regulator (EMC authorization), Applicant link-design team (failover testing), CAA flight test observer
- Verifiable: True

---

## Requirements Traceability Matrix (first 10 of 20 entries)

| REQ | Source | Goal | Keystone | Vibe | SBE Gherkin count | NFR | Status |
|---|---|---|---|---|---:|---|---|
| REQ001 | REQ001 | GOAL-001 | K1 | PackCompleteness | 3 | NFR-F1-001 | trace_complete |
| REQ002 | REQ002 | GOAL-002 | K2 | SwarmAwareSORAEvidence scale | 1 | NFR-F2-002 | trace_complete |
| REQ003 | REQ003 | GOAL-002 | K2 |  | 0 | NFR-F3-003 | dead_end |
| REQ004 | REQ004 | GOAL-003 | K3 |  | 0 | NFR-F4-004 | dead_end |
| REQ005 | REQ005 | GOAL-003 | K3 | GeofenceContainment scale | 1 | NFR-F5-005 | trace_complete |
| REQ006 | REQ006 | GOAL-003 | K3 | C2LinkResilience scale | 1 | NFR-F6-006 | trace_complete |
| REQ007 | REQ007 | GOAL-002 | K2 | DAAPerformance scale | 1 | NFR-F7-007 | trace_complete |
| REQ008 | REQ008 | GOAL-002 | K2 | SwarmEmergentBoundedness scale | 1 | NFR-F8-008 | trace_complete |
| REQ009 | REQ009 | GOAL-004 | K6 | MLForensicExplainability scale | 1 | NFR-F9-009 | trace_complete |
| REQ010 | REQ010 | GOAL-004 | K6 | MeaningfulHumanControl scale ( | 1 | NFR-F10-010 | trace_complete |

Full RTM in `lewis-matrix.json`.

---

## Findings by IEEE 830 Characteristic

### C — Correct · Chelcie

*8 findings · Score: 41% [FAIL]*

#### [CRITICAL · C10] REQ017-020 features built on unvalidated stakeholder assumptions

**Detail:** The source requirements explicitly state: 'No user story covers' these topics. Yet four features (F19-F22) address them. Features F19 (Public & Stakeholder Engagement), F20 (Security Classification Handling), F21 (Environmental Impact Assessment), F22 (Post-Trial Close-out) are implicitly derived from regulatory hints (CAP 1616, GDPR, JSP 440) and the system context, NOT from explicit CAA/MAA stakeholder approval. This violates the IEEE 830-1998 principle that requirements shall reflect agreed u

**Recommendation:** Obtain explicit stakeholder validation (CAA program manager sign-off, MAA liaison confirmation) for each of F19-F22 before they enter the SRS. For REQ017 (Public Engagement): CAP 1616 mandates consultation, but the workbench's scope (internal regulator tool) may exclude public-facing features—clarify if the CAA will use this tool to manage engagement, or if engagement happens outside. For REQ018 (Classified Evidence): JSP 440 / CAP 722H handling is critical for MOD partnerships, but the Vibe fin

---

#### [CRITICAL · C10] Five foundational terms lack authoritative definition; stakeholder alignment unconfirmed

**Detail:** Dorothy identifies 16 undefined terms critical to requirements interpretation. Five are regulatory anchors: (1) 'swarm-aware' (REQ002)—without this, SORA assessors have no criteria for what constitutes swarm-specific risk evidence vs. single-aircraft evidence; (2) 'defensibly' (REQ002)—evocative but undefined; regulators and applicants may interpret 'defensible' differently (e.g., statistical 99% confidence vs. expert judgment). (3) 'meaningful human control' (REQ010)—contested across CAA (empha

**Recommendation:** Before SRS approval, conduct joint CAA/MAA/JARUS working group session to define these five terms. Publish glossary with examples from prior BVLOS swarm trials (e.g., JARUS SORA v2.5 swarm case studies, UK BVLOS trials at Porthcawl/Cardington). For 'meaningful human control': adopt ISO 9646 workload scale + NASA-TLX measurement protocol, with explicit thresholds (e.g., workload <= 60 on NASA-TLX during nominal, crew takeover within 2 seconds). For 'containment': explicitly separate procedural (e

---

#### [CRITICAL · C10] Geofence breach, link loss, and DAA resolution outcomes undefined—SRS silent on safety actions

**Detail:** The SRS states what outcomes are needed ('containment so a fly-away cannot become uncontrolled BVLOS', 'link loss is survivable', 'encounters are resolved predictably') but does not specify the MECHANISM or DECISION TREE. REQ005 says the system shall provide 'automatic containment' but does not say: What triggers containment? (Geofence breach detected? Timeout? Crew command?) What is the fail-safe? (RTL to home? Parachute? Hover and await recovery?) What if that fails? (E.g., RTL fails due to GP

**Recommendation:** Decompose REQ005-008 into explicit outcome rules: REQ005a: 'IF geofence boundary breach detected THEN RTL initiated within 2 seconds'; REQ005b: 'IF RTL fails THEN crew receives 60dB audio alert + swarm transitions to autonomous hover at last-valid altitude, maintaining separation from nearest aircraft >= min-separation'; REQ005c: 'IF hover fails THEN [emergency parachute deployment / immediate descent procedure per applicant design]'. Similar specificity for REQ006 (link loss) and REQ007 (DAA). 

---

#### [MAJOR · C9] REQ001 happy-path focused; sad-path (incomplete pack rejection) undefined

**Detail:** REQ001 says 'As a CAA case officer I want to receive a complete Operational Authorisation pack so that I can open a valid case.' This is outcome-focused (case opened) but silent on the rejection path. The SRS does not specify: What constitutes a 'complete' pack? (Checklist? Signature validation? Conformance to CAP 722 Section 4.1?) If incomplete, what is the rejection message? (Item-level feedback or summary?) Can the applicant resubmit the same pack or must a new one be uploaded? Is there a res

**Recommendation:** Decompose REQ001 into two requirements: REQ001a: 'The workbench shall validate each Operational Authorisation pack against a CAA-published completeness checklist (e.g., ConOps present, insurance certificate, crew competency evidence, etc.). If valid, the case shall transition to Draft status and notify the assigned case officer within 1 hour.' REQ001b: 'If a pack is incomplete, the system shall identify missing items by category (ConOps, Insurance, Evidence, etc.) and notify the applicant of def

---

#### [MAJOR · C8] Regulatory references accurate but version status and obsolescence risk require tracking

**Detail:** Cross-check conducted: (1) CAP 722 v9 is current (2024 CAA guidance). (2) CAP 722A Second Edition Dec 2022 is current. (3) CAP 722B Fifth Edition confirmed as current authority. (4) JARUS SORA v2.5 with 24 OSOs is correct (JARUS v2.5 issued 2023). (5) JSP 936 v1.1 Nov 2024 is correct (UK MOD guidance). (6) DEFSTAN 00-970 Part 9 Issue 13 is correct. (7) RA 2305 Issue 7 noted as current. HOWEVER: Risk factors for future obsolescence: (a) EASA/OECD are revising swarm guidance (anticipated 2026-2027

**Recommendation:** Add an NFR to the SRS: 'The workbench shall maintain a regulatory reference manifest that pinpoints exact versions (CAP 722 v9, JSP 936 v1.1, JARUS SORA v2.5, AMLAS v1.X) used to construct any trial's evidence case. When the CAA updates foundational guidance (e.g., CAP 722 -> v10), a compliance review workflow shall notify case officers of potential re-assessment triggers.' Establish a quarterly CAA/JARUS/EASA guidance update review process to flag which changes affect active cases vs. future ca

---

### U — Unambiguous · Odin

*22 findings · Score: 0% [FAIL]*

#### [CRITICAL · C10] Vague qualifier 'complete' used in two contexts with conflicting meanings

**Detail:** This is the most pervasive semantic ambiguity across the SRS. Using 'complete' for both artefact intake and telemetry logging creates risk that case officers and investigators will apply inconsistent acceptance criteria. Dorothy-8 rated confidence 10/10 because the distinction has material regulatory impact: incomplete application intake should halt a case (return-for-clarification), whereas incomplete telemetry might be acceptable if incident was minor. These are opposite decisions.

**Recommendation:** CRITICAL: Replace 'complete' with two distinct terms: 'Pack Completeness' (artefact presence) and 'Evidentiary Completeness' (telemetry presence). Update SRS glossary with explicit distinction. Train case officers on the two acceptance criteria.

---

#### [CRITICAL · C10] Undefined term 'swarm-aware' is foundational to SORA assessment without clear criteria

**Detail:** This term is foundational to REQ002, which is a gate requirement for SORA assessment. Without defining 'swarm-aware,' SORA assessors (different individuals across trials) will develop inconsistent interpretations. Some may accept single-aircraft SORA with swarm annotations; others may demand swarm-specific methodology (JARUS SORA Swarm Extension). This inconsistency violates IEEE 830 principle of unambiguous requirements.

**Recommendation:** CRITICAL: Add 'swarm-aware' to SRS glossary with explicit definition (see proposed rewrite). Reference JARUS SORA v2.5 swarm guidance and enumerate 3 required evidence components (collective behavior, coordination dependencies, emergent risks). Update REQ002 to reference this definition.

---

#### [CRITICAL · C10] Vague qualifier 'defensibly' lacks measurable criteria for SORA approval

**Detail:** SAIL and OSO are regulatory gates that permit or deny trial progression. 'Defensibly' is the success criterion for these gates, yet it is subjective. Different assessors may have different thresholds for what constitutes defensible evidence. This violates IEEE 830 unambiguity: every requirement must have one interpretation.

**Recommendation:** CRITICAL: Define 'defensibly' operationally in SRS glossary. Reference JARUS methodology, require GSN or CAF structured argument, and require documentation of CAA precedent. Update REQ002 to reference this definition.

---

#### [MAJOR · C9] Undefined term 'contingency matrix' lacks format specification and completeness criteria

**Detail:** Contingency matrix is the onboard state-machine specification for autonomy. Without specifying format and completeness criteria, different implementations will have different coverage and different safety profiles. Some may address only communication losses; others may also address environmental hazards. This creates inconsistency in trial assurance.

**Recommendation:** MAJOR: Define 'contingency matrix' in SRS glossary with format (table, minimum 15 events) and completeness criteria (100% credible failure modes mapped). Enumerate 4 event categories (communication, environmental, system, human) with examples. Update REQ011 to reference this definition and require contingency matrix review before trial authorization.

---

#### [MAJOR · C8] Passive voice in REQ001 hides submission actor and validation trigger

**Detail:** Passive voice obscures responsibility and causality. In requirements, passive voice often hides the actor responsible for an action, creating confusion about who does what. Here, 'receive' does not specify whether the case officer manually retrieves the pack or the system auto-validates and alerts. This leads to different implementations.

**Recommendation:** MINOR: Replace 'receive' with active voice specifying: (1) applicant submits via web portal, (2) Workbench auto-validates upon receipt, (3) case officer is notified of validation results. This clarifies the flow and responsibility.

---

### C — Complete · Lucy

*10 findings · Score: 44% [FAIL]*

#### [CRITICAL · C10] 20 TBDs span critical swarm-safety methodology gaps blocking REQ002 (swarm-aware SORA assessment)

**Detail:** DeFOSPAM Dorothy-1 identified 'swarm-aware' as critical undefined term (confidence 10/10). Chris language file defines swarm-aware but provides no methodology. Odin rewrite references JARUS v2.5 but does not address swarm-specific gaps. Grace goal GOAL-002 (Assure Swarm-Aware Safety Assessment) is the highest-risk goal for first trial cohort because methodology does not yet exist.

**Recommendation:** Establish WS-001 swarm SORA methodology workshop (Q2 2026): CAA + JARUS liaison + industry safety engineers. Define: (1) hazard taxonomy specific to swarm (loss-of-separation modes, separation-loss cascade triggers); (2) analysis methodology (FTA extensions for multi-agent systems, STAMP for distributed control); (3) acceptance criteria (e.g., 'quantified maximum cascade depth = 2 aircraft, probability of cascade < 0.1% per flight'); (4) evidence template (documentation structure for applicant s

---

#### [CRITICAL · C10] Containment design standard undefined (5 critical subcriteria per Dorothy-4)

**Detail:** DeFOSPAM Dorothy-4 identified 'containment' as critical undefined term with 5 subcriteria. Odin rewrite specifies mechanism and response time but not design rationale. Containment is safety-critical per Grace goal GOAL-003 (Ensure Containment & Flight Safety) but lacks formal design basis. Risk: applicant may propose inadequate containment; CAA reviewer lacks standard to assess adequacy.

**Recommendation:** Establish WS-002 containment design-standard workshop (Q2 2026): CAA + autonomy engineers + safety engineers. Develop: (1) containment failure-mode taxonomy (geofence-sensor loss, computation latency, motor failure, firmware bug); (2) failure-rate assumptions (design basis accident: geofence breach must not exceed 0.1% per flight hour); (3) fail-safe mechanism specification (mechanical kill-switch + software enforcement + procedural backup); (4) design reference standards (adapt DO-178C for auto

---

#### [CRITICAL · C10] Meaningful human control measurable criteria undefined (Dorothy-2, international debate ongoing)

**Detail:** DeFOSPAM Dorothy-2 identified 'meaningful human control' as critical undefined term (confidence 10/10). Chris language defines it as 'Active, informed crew awareness and retained authority.' Odin operationalizes with measurable thresholds (1 Hz, <2s, workload %). But empirical basis for these thresholds lacking. Grace goal GOAL-004 (Assure Autonomous Decision-Making & Human Control) depends on MHC definition for acceptability criteria.

**Recommendation:** Establish WS-003 human factors workshop (Q3 2026): CAA + university human-factors research lab + applicant crew trainers. Conduct: (1) simulator study (swarm scenario playback with human subjects) measuring take-over response time, workload under various scenario complexities, crew situation awareness recovery time; (2) evidence synthesis (compare proposed thresholds to manned-aviation precedent, military UAV precedent); (3) develop 'Meaningful Human Control Assurance Guidance' specifying: situa

---

#### [MAJOR · C8] 10 REQs (REQ008-REQ011, REQ015-REQ020) have partial operational specifications requiring per-trial negotiation or stakeholder workshops

**Detail:** Odin rewrites were authored by Odin's IEEE 830 agents with high confidence (8-9) on operational specification. However, 6-10 REQs introduce complexity that requires either (1) external standard integration (REQ018 CAP 722H), (2) per-trial decision logic (REQ011 IFT triggers), or (3) stakeholder consensus (REQ010 workload thresholds). This is expected SRS maturity for a regulated domain with emerging technology (swarm autonomy). Recommendation is to accept per-trial negotiation for first trial co

**Recommendation:** Prioritize TBD workshops as follows: (1) WS-001 (swarm SORA, Q2 2026) - critical path for REQ002 operationalization; (2) WS-002 (containment design, Q2 2026) - critical path for REQ005 design justification; (3) WS-003 (human control, Q3 2026) - critical path for REQ010 threshold validation. For first trial cohort: accept per-trial specifications for REQ008 (emergent-behavior evidence), REQ009 (ML explainability fallback), REQ011 (IFT triggers), REQ015 (apportionment signatures). For REQ017-REQ02

---

#### [MAJOR · C8] REQ001 and REQ012 use 'complete' with different meanings; ambiguity not fully resolved in Odin rewrite

**Detail:** Ambiguity is correctly identified by DeFOSPAM but not fully resolved by Odin. Odin rewrite clarifies meaning through operationalization (8 artefacts for REQ001, 6 telemetry for REQ012) but uses same English word 'complete' in both contexts. Chris language file does not disambiguate. Risk is low because operationalizations are distinct, but clarity is low because same word is overloaded.

**Recommendation:** Update SRS terminology in final draft: (1) REQ001 (Application Intake & Completeness Check): use term 'pack completeness' or 'submission completeness' to refer to mandatory artefacts present; define PackCompleteness scale per Vibe requirements (Vibe Scale from openrequirements-vibe-results.json). (2) REQ012 (Data MOR & DPIA Obligations): use term 'evidentiary completeness' or 'telemetry recording completeness' to refer to 6 categories recorded; define MORForensicCompleteness scale per Vibe requi

---

### R — Ranked · Natasha

*7 findings · Score: 74% [WARN]*

#### [CRITICAL · C10] REQ017 (Public Engagement) and REQ018 (Security Classification) lack user stories and acceptance criteria; no explicit process defined

**Detail:** REQ017 and REQ018 were flagged in the raw requirements CSV as "Strongly implied by CAP 1616 and GDPR" and "addresses how classified MOD evidence is presented" respectively, but neither has a user story or acceptance criteria. Grace-goals confirm implicit scope risks: REQ017 "CAP 1616 scope not specified (what level of consultation is sufficient?)" and REQ018 "REQ018 lacks user story and acceptance criteria; no explicit process defined." Yet both are assigned to GOAL-010 (rank 2, conditional) and

**Recommendation:** IMMEDIATE: Conduct rapid requirements-gathering sessions with CAA communications (REQ017) and MOD security officer (REQ018) to author explicit user stories and acceptance criteria. GATE: These should not progress to v1.0-minor without signed acceptance criteria. ALTERNATE: If acceptance criteria cannot be defined by Q2 2026, reclassify both as v2.0 (future) and note as out-of-scope for v1.0 panel.

---

#### [MAJOR · C9] REQ008, REQ009 volatile autonomy standards assigned v1.1 target—AMLAS/SACE guidance not yet published

**Detail:** REQ008 (Swarm Decision-Making Architecture Review) and REQ009 (ML Assurance Case) are critical to GOAL-004 (Assure Autonomous Decision-Making & Human Control, rank 2) but depend on emerging AMLAS/SACE standards. DeFOSPAM reports 3 critical findings on REQ009 (undefined term "emergent behavior", frozen-model manifest scope, explainability evidence criteria). Grace-goals implicitly scope RISK: "AMLAS/SACE case mandatory but guidance not yet published; assumption that these standards apply to swarm

**Recommendation:** OPTION A (Recommended): Reclassify REQ008 and REQ009 as v1.0-minor (extension phase, Q1-Q2 2027), paired with explicit dependency on AMLAS/SACE v1.0 publication. OPTION B: Create v1.0 "placeholder" requirement (frozen model manifest, audit trail) with v1.1 extension for full AMLAS case. Either way, establish explicit external dependency gate in phase-gate model (GOAL-007).

---

#### [MAJOR · C9] REQ017 (Public Engagement) vs REQ018 (Classified MOD Evidence): conflict on scope boundary—unclear if classified trials can have public engagement

**Detail:** REQ017 (Public & Stakeholder Engagement, GOAL-010 rank 2) mandates "community consultation, press/media engagement, stakeholder feedback capture" with CAP 1616 and GDPR compliance. REQ018 (Security Classification Handling, GOAL-009 rank 3) mandates "evidence classification per CAP 722H, JSP 440 marking and segregation controls, reviewer security clearance validation." Grace-goals for GOAL-009 note: "Interaction with public engagement (REQ017): can classified trials have public engagement?" This 

**Recommendation:** DECISION GATE (pre-v1.0-minor): CAA regulatory leadership must decide one of: (A) Classified trials are out-of-scope for v1.0—only unclassified BVLOS swarm trials proceed. Then REQ017 and REQ018 are sequential: v1.0 unclassified, v2.0 classified. (B) Classified trials proceed in parallel with unclassified—then REQ017 and REQ018 must be jointly authored with explicit redaction rules (e.g., "consult communities on trial logistics and safety, redact platform capabilities"). (C) Classified trials ar

---

### V — Verifiable · Iris

*10 findings · Score: 49% [FAIL]*

#### [CRITICAL · C10] REQ002: 'Swarm-aware' and 'defensibly' undefined; no acceptance criteria

**Detail:** DeFOSPAM Dorothy-1, Dorothy-3: 'swarm-aware' is undefined term (confidence 10/10 criticality); 'defensibly' has no criteria for defense. Chris's definition of 'swarm-aware' is 'methodology or evidence accounting for collective behavior.' Operationalizing through 3-component evidence framework (coordinated-link-loss, emergent-misbehavior, inter-vehicle interactions) makes 'swarm-aware' repeatable. 'Defensibly' tied to JARUS v2.5 + documented analysis.

**Recommendation:** Replace subjective terms ('defensibly', 'swarm-aware') with enumerated criteria and methodology references. Require evidence citations (FTA, STAMP, test reports) to tie defense logic to recognized standards.

---

#### [CRITICAL · C10] REQ005: 'Automatic containment' undefined; critical safety gap (5 subcriteria)

**Detail:** DeFOSPAM Dorothy-4 (5 subcriteria undefined for 'containment'); Observation-1: critical safety gap. 'Containment' lacks design and verification criteria. Operationalizing through 3 design components (monitor, action, alert), specific response times (500 ms action, 1 sec alert), and margin testing (15 m GPS noise). Makes containment testable and verifiable.

**Recommendation:** For all safety-critical requirements, specify design components, response-time budgets, margin factors, and verification approach (simulation + flight test). Tie to performance engineering SLAs (e.g., NFR-LAT-005 for decision latency).

---

#### [CRITICAL · C9] REQ010: 'Meaningful human control' undefined; 'throughout' temporal ambiguity; workload thresholds missing

**Detail:** DeFOSPAM Dorothy-2: 'meaningful human control' lacks measurable criteria. 'Throughout' is temporal ambiguity (no assessment frequency). Workload and takeover thresholds undefined. Chris defines 'meaningful' as 'Active, informed crew awareness and retained authority.' Operationalizing through: (1) frequency metric (1 Hz), (2) override latency (< 2 sec), (3) intervention time window (5-10 sec phase-dependent), (4) workload thresholds (75-85%), (5) measurement (NASA-TLX, simulator, observer). 'Thro

**Recommendation:** For all human-factors requirements, specify: (1) awareness frequency (Hz), (2) authority latency (milliseconds), (3) intervention time windows (seconds, phase-dependent), (4) workload thresholds (% of cognitive capacity), (5) measurement instrument (NASA-TLX, SWAT, etc.). Require simulator practice hours and flight-test observer validation.

---

#### [MAJOR · C9] REQ001: Vague 'complete' qualifier lacks quantification

**Detail:** DeFOSPAM Dorothy-8 identified 'complete' as vague qualifier. Operationalizing through explicit enumeration of 8 required artefacts and numeric page-count thresholds makes 'completeness' testable and repeatable. Acceptance criterion is binary (all 8 + format + thresholds or fail).

**Recommendation:** Require all 20 REQ to enumerate specific artefacts, page counts, or numeric acceptance criteria. Use Vibe meters (METER-001, METER-002) to operationalize compliance scoring.

---

#### [MAJOR · C9] REQ003: 'Clear' and 'judge' are subjective verbs; worst-credible-behaviour undefined

**Detail:** DeFOSPAM Dorothy-5: 'clear' (no clarity criteria), 'judge' (passive subjective verb), 'worst-credible behaviour' (credibility boundary undefined). Operationalizing 'clear' by enumerating 4 required ConOps sections per Vibe meter METER-002. 'Worst-credible' scoped to single-failure assumption (not common-mode). 'Judge' replaced with 'validate against documented procedures' (testable, binary pass/fail).

**Recommendation:** Replace subjective verbs ('clear', 'judge') with testable actions ('validate', 'verify'). Enumerate specific document sections and acceptance criteria. Define 'worst-credible' scope explicitly (e.g., single-failure assumption).

---

### M — Modifiable · Amelia

*8 findings · Score: 48% [FAIL]*

#### [CRITICAL · C9] Terminology Collision: 'Complete' Used with Conflicting Meanings Across Requirements

**Detail:** REQ001 (Application Intake & Completeness Check) uses 'complete' to mean 'all mandatory fields submitted and valid'. REQ012 (Data MOR & DPIA Obligations) uses 'complete' to mean 'satisfies GDPR Article 35 Data Protection Impact Assessment requirements'. These two meanings are semantically distinct but both occupy the glossary term 'Completeness' without disambiguation. Chelcie-findings.json (finding-003) and odin-findings.json (finding-009) both flagged this collision. When SRS reviewers or impl

**Recommendation:** Establish distinct glossary terms: (1) 'Application Pack Completeness' for REQ001 (all mandatory fields present and syntactically valid), (2) 'GDPR Completeness' for REQ012 (DPIA requirements satisfied per Art. 35). Update all cross-references and child FRs (FR-001 through FR-007 for REQ001; FR-221-260 for REQ012) to use precise terminology. Add decision rule in Section 3.2 (Specific Requirements Structure) clarifying that these gates are sequential: Application Pack Completeness is prerequisite

---

#### [CRITICAL · C8] Evidence-Artifact Overlap: REQ002 vs REQ008 Swarm Assessment Deliverables

**Detail:** REQ002 (SORA 2.0 Assessment for Swarm) requires 'documented hazard mitigation rationale for swarm-specific scenarios per JARUS SORA v2.5 Chapter 6' (ophellia-findings.json finding-004 documents this). REQ008 (Swarm Decision-Making Architecture Review) requires 'peer-reviewed evidence that autonomous decision logic does not contradict human operator intent' (odin-findings.json finding-014 raises concern about 'contradicts' being unmeasurable). Both requirements demand evidence artifacts (mitigati

**Recommendation:** Clarify artifact ownership: (1) Designate REQ002 as responsible for SORA-specific hazard evidence (swarm navigation, spectrum interference, geofence bypass scenarios). (2) Designate REQ008 as responsible for autonomous decision-logic evidence (decision tree validation, reward-function alignment, human-operator override capability proof). (3) Create interface requirement IR-004 (SORA-to-DecisionLogic Traceability) establishing that REQ008 evidence must demonstrate that every swarm decision compli

---

#### [CRITICAL · C8] Fallback-Sequence Conflict: REQ005 Containment vs REQ011 Flight Termination Incomplete Ordering

**Detail:** REQ005 (Geofence / Containment Enforcement) mandates 'automated swarm repositioning to bring all UAS back within operational boundary within 5 seconds if any aircraft drifts >50m outside declared geofence' (amelia-ids.json FR-041-062 child FRs detail containment algorithms). REQ011 (Contingency and Flight Termination) mandates 'safe controlled descent with engine shutdown if swarm loses C2 link >5 seconds' (amelia-ids.json FR-063-090). Both are essential (must_have, priority rank 1 in natasha-ra

**Recommendation:** (1) Add explicit sequencing rule to Section 3.3: 'REQ005 (Containment) is primary fallback; REQ011 (Termination) is secondary fallback triggered only if REQ005 fails to recover swarm position within 10 seconds cumulative.' (2) Create DC-003 (Design Constraint: Fallback Priority Chain): 'Swarm decision logic shall evaluate containment algorithms first; if all aircraft positions remain outside geofence after 10s, initiate termination sequence. No concurrent execution of containment and termination

---

#### [MAJOR · C8] Organizational Fragmentation: PE (Performance/End-User) NFRs Spread Across Multiple Sections Without Unified Governance

**Detail:** Amelia-outline.json adopts feature-based organization (by_feature scheme: 8 clusters + cross-cutting). However, cross-functional NFRs (Performance, Availability, Scalability, Security, Usability, Maintainability, Latency, Capacity) are listed as 'Distributed cross-references' in Section 3.2 rather than consolidated. Specifically: (1) Latency NFRs appear in 3.3 (Containment C2 link latency <50ms) and 3.4 (DAA latency <2s), but latency budget reconciliation is missing. (2) Capacity NFRs appear in 

**Recommendation:** (1) Retain feature-based organization for FRs (REQs 001-020 child FRs remain distributed by feature in Sections 3.1-3.9). (2) Create new unified Section 3.14 (Non-Functional Requirements Specification): Consolidate all NFRs into single section organized by NFR type (Performance, Availability, Scalability, Security, Usability, Maintainability, Latency, Capacity). (3) For each NFR type, establish: (a) global budget or threshold (e.g., 'System Latency Budget: 200ms end-to-end, apportioned as: C2 li

---

#### [MAJOR · C7] Missing Cross-Reference: Public Engagement (REQ017) Lacks Traceability to Stakeholder Feedback Loop

**Detail:** REQ017 (Public and Stakeholder Engagement) requires 'documented communication of trial scope, risk mitigation, and results to public and regulatory stakeholders; feedback mechanisms established' (amelia-ids.json FR-311-370 child FRs sketch this). However, amelia-outline.json Section 3.8 does not establish feedback loops that flow back into REQs 001-016. No requirement explicitly states 'REQ017 feedback shall trigger re-assessment of REQ002 (SORA) or REQ012 (Data Privacy) if stakeholder concerns 

**Recommendation:** (1) Create new requirement REQ021 (Feedback Integration Loop): 'Public and stakeholder feedback received via REQ017 engagement shall be logged, categorized (safety hazard / privacy concern / operational feasibility / regulatory interpretation), and evaluated for impact on REQs 001-016. Feedback triggering substantive changes to core requirements shall initiate change-control process per Section 3.10 (Traceability).' (2) Add child FR under REQ017: 'FR-3XX: Feedback Categorization and Impact Asses

---

### T — Traceable · Lewis

*11 findings · Score: 62% [FAIL]*

#### [CRITICAL · C9] REQ016 (Phased Trial Build-Up) is a single point of failure affecting 5+ dependent requirements

**Detail:** REQ016 (Phased Trial Build-Up) maps to GOAL-007 (Support Phased Trial Build-Up) and GOAL-015 (Panel Override), and is traced by multiple SBE scenarios (angie: 5 scenarios). If REQ016 is not properly implemented (gating logic, reversibility mechanics, phase criteria), all phased progression and oversight mechanisms fail. This is a critical architectural requirement.

**Recommendation:** Elevate REQ016 to must_have (v1.0) status. Ensure phased gate logic is thoroughly validated through scenario testing and integration testing. Implement audit trail for all phase progression decisions.

---

#### [MAJOR · C9] Dead-end requirement: REQ003 has no forward trace to SBE or acceptance criteria

**Detail:** REQ003 (ConOps & ODD Review) is not mapped to any SBE scenario (angie-traceability) or acceptance criterion (iris-criteria). This requirement lacks forward traceability to test scenarios and acceptance validation.

**Recommendation:** Ensure REQ003 has mapped SBE scenarios that explicitly validate the requirement during trial. If REQ003 is not testable, reconsider necessity or move to v2.0.

---

#### [MAJOR · C9] Dead-end requirement: REQ004 has no forward trace to SBE or acceptance criteria

**Detail:** REQ004 (Airspace Change & TDA Coordination) is not mapped to any SBE scenario (angie-traceability) or acceptance criterion (iris-criteria). This requirement lacks forward traceability to test scenarios and acceptance validation.

**Recommendation:** Ensure REQ004 has mapped SBE scenarios that explicitly validate the requirement during trial. If REQ004 is not testable, reconsider necessity or move to v2.0.

---


*Report generated by [OpenRequirements.ai](https://www.openrequirements.ai) · Based on IEEE Std 830-1998*