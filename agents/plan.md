# SORA Approval Document Generator — Design Plan

**Status:** Draft v1.2 — plan-before-implementation
**Author:** Sentinel (research assistant)
**Date:** 23 April 2026
**Audience:** Hackathon build team; reviewers from MAA RPAS Regulatory Branch and CAA Innovation Hub
**Parent story:** `USER_STORY_CAA_MAA_SWARM.md` — CAA/MAA Joint Approval Workbench for Live BVLOS Autonomous Swarm Flight Trials

**v1.1 revision history:**
- §14 added — Requirements catalogue REQ001–REQ020 (from `requirements.csv`) folded in as a third axis below AC1–AC8
- §15 added — DTFEA stress-test pass (Data / Trust / Failure / Evidence / Authority) from `STRESS-Report.md` adopted as a second-axis check on every submission
- §16 added — Eight keystone failure-mode detectors hard-coded from the supplied critical-findings list
- §4.2, §6, §7, §8, §10, §11 updated to reference the new sections

**v1.2 revision history** — triggered by the supplied `user journey.txt` service blueprint:
- §20 added — Service blueprint; the generator is now embedded in a 10-step, 3-phase user journey
- §21 added — Dual-mode engine: one codebase, two UX postures (operator-facing pre-submission vs. regulator-facing decision)
- §22 added — Submission Readiness Check as a formal pre-submission gate
- §23 added — Post-decision export, archive, and calibrated-improvement loop (no self-learning in safety decisions)
- §24 added — Revised phasing to include operator-journey phases
- §25 added — Plan-v1.2 definition of done
- Architectural consequence: the operator journey (Phase 1) demands private, non-punitive, iterative UX — the engine's output posture changes, not the engine itself

---

## 1. Purpose of this document

Design the **approach** — not yet the implementation — for a generator that ingests a SORA / Operating Safety Case submission pack and produces a structured **decision record** (approval OR refusal) aligned to acceptance criteria AC1–AC8 of the parent user story.

The plan is anchored on two reference submissions supplied:

| Sample | Outcome | Why |
|---|---|---|
| `scotland-sample-case.md` (Edinburgh Napier University Operating Safety Case v2.2) | **Would be approved** (under UKPDRA-01, Specific Category, VLOS) | Complete CAP 722A-compliant safety case: named Accountable Manager, qualified remote pilots, SMS aligned to CAP 1059, full emergency procedures library, logbooks, version-controlled change log, traceable references |
| `sora-safety-case.txt` (CTRL-ALT-DEFEAT — 5x RigiTech Eiger BVLOS swarm, GNSS/C2-denied trial at Spadeadam) | **Would be refused** (as-submitted) | Swarm/BVLOS/autonomy-denied operation declared at SAIL I on SORA v2.0; only 6 of 24 OSOs addressed; no DAA evidence, no swarm-behaviour envelope, no AMLAS/SACE case, no named Duty Holder / RAISO, no C2 link budget |

The gap between these two submissions — one comprehensively evidenced for a low-risk scenario, one skeletally evidenced for a high-risk scenario — defines the detection surface the generator must cover.

---

## 2. Scope of the generator

### 2.1 In scope

- **Ingest** of a submission pack (markdown, text, PDF, docx) containing any subset of: Operating Safety Case, JARUS SORA package, CONOPS, DAA report, C2 link analysis, swarm-behaviour envelope, AMLAS/SACE assurance case, CAP 1616 airspace-change evidence, Range Safety Case.
- **Classify** the operation (category, airspace, BVLOS/VLOS, autonomy posture, swarm/single, segregated/non-segregated, payload risk including munitions).
- **Coverage-map** each artefact to the relevant regulatory anchor corpus (CAP 722/722A/722B, DEFSTAN 00-970 Part 9, RA 1000/1600/2300 series, JSP 936 Part 1, JARUS SORA v2.5, CAP 1616, AMLAS, SACE, ASTM F3442 / EUROCAE ED-267).
- **Flag** gaps, ambiguity, unresolved hazards, extrapolation beyond the tested envelope, and weak claim-to-evidence traceability.
- **Draft** a structured decision record (approve-with-conditions, refuse-with-reasons, or return-to-applicant-for-clarification) complete with regulatory citations, evidence pointers, ALARP rationale, conditions, and review triggers.
- **(v1.2)** Support the 10-step service blueprint in §20 end-to-end — operator pre-submission, readiness gate, regulator review, post-decision archive and improvement loop.
- **(v1.2)** Operate in two UX postures — *Applicant mode* (private, iterative, non-punitive) and *Regulator mode* (logged, immutable, decision-bearing) — over the same core engine.

### 2.2 Explicitly out of scope

- Issuing the Military Permit to Fly (MPTF) itself — the signature remains a human regulator act.
- Autonomous clearance of a live flight.
- Displacing Duty Holder accountability or RAISO sign-off.
- Cross-border approvals outside UK sovereign airspace.
- Automated redaction of classified safety evidence.

---

## 3. What we learned from the two samples

### 3.1 Scotland (approve) — structural markers present

The Edinburgh Napier submission exhibits the *shape* of an approvable CAP 722A Operating Safety Case:

1. **Clear authorisation scope** — UKPDRA-01, Specific Category, VLOS only.
2. **Document control** — version 2.2 (14 Jun 2024), named author, change log back to v0.1.
3. **Safety policy and SMS** — 12-point policy; SMS aligned to CAP 1059; safety target "No Accidents".
4. **Named organisation** — Accountable Manager (Brian Davison), three qualified remote pilots with Flyer IDs and GVC qualifications.
5. **Roles & responsibilities** — Remote Pilot, Observer, Payload Operator — each with a discrete responsibility list.
6. **Occurrence-reporting flowchart** — definitions drawn from EU 376/2014 and 996/2010; ECCAIRS route to AAIB/CAA.
7. **Operating procedures** — viability study → site evaluation → risk analysis → call sheet → loading list → site checklist → crew briefing → pre-flight → post-flight, each with a template form in the appendix.
8. **Emergency procedures library** — 11 distinct failure modes covered (pilot incapacitation, airspace incursion, ground incursion, loss of link, rogue RPA, loss of power (air), loss of power (ground), unexpected behaviour, LiPo fault, RPA fire, loss of GNSS, compass error, abnormal environmental conditions).
9. **Fleet documented** — three aircraft each with MTOM, frequency, serial, assembly checklist.
10. **References & legislation** — full reference list with issue/date (CAP 722 v9, CAP 722A v2, ANO 2016/765, Assimilated Reg EU 2019/947).
11. **IMSAFE self-assessment**, Skywise subscription, currency requirement (2 hrs / 90 days), crew briefing protocol.

These markers are the **feature space** the generator needs to detect and score. Most are binary (present / absent / partial); a few are graded (e.g., SMS depth, currency evidence strength).

### 3.2 SORA case (refuse) — the failure pattern

The CTRL-ALT-DEFEAT submission is instructive because it *looks* like a SORA — it has the section numbering — but the content does not support the operation it describes. The defects fall into five families:

| Defect family | Specific instances in the sample | Which AC catches it |
|---|---|---|
| **Version / standard mismatch** | Claims SORA v2.0; JARUS v2.5 is the current version and carries 24 OSOs (v2.0 had ~24 but under a different rubric). CAP 722 v9 superseded. | AC1, AC2 |
| **Risk/SAIL incoherence** | 5-vehicle autonomous swarm, BVLOS, with *deliberate* GNSS and C2 denial → declared SAIL I. The combination of autonomy, swarm, and loss-of-reference testing should drive a much higher SAIL irrespective of airspace segregation. | AC2 |
| **Missing artefacts** | No DAA evidence (AC3), no C2 link budget / latency / crypto posture (AC4), no swarm-behaviour envelope with emergent-behaviour analysis (AC5), no CAP 1616 / TDA / NOTAM detail (AC6), no AMLAS / SACE autonomy assurance case (AC7), no Article 36 review even though not in scope here, no Range Safety Case appendix. | AC1, AC3, AC4, AC5, AC6, AC7 |
| **Partial OSO coverage** | 6 of 24 OSOs listed; OSO 10 declared "Partial — justified" with a one-line rationale. OSOs 5, 7 (proper), 8, 11–24 absent. For an autonomous swarm, OSOs 18–20 (Human Factors / adversarial / flight envelope) and OSO 24 (External services) are particularly load-bearing and missing. | AC2, AC7 |
| **Accountability gaps** | No named Accountable Manager, no Duty Holder (DDH/ODH), no RAISO sign-off, no Range Safety Officer identity, no remote pilot qualification evidence. "Operator: CTRL-ALT-DEFEAT" is the only organisational identifier. | AC1, AC7, AC8 |

A sixth subtle defect: the submission treats *segregated airspace* as a blanket risk-eraser. Segregation mitigates mid-air collision with third-party traffic. It does **not** mitigate emergent swarm behaviour, geofence breach, or uncontrolled flight termination toward range boundary — which is exactly what a GNSS/C2-denied trial is designed to probe.

### 3.3 Detection implication

A well-constructed generator must be able to say, in plain engineering English:

> *"The operation as described is SAIL V-adjacent under JARUS v2.5 (autonomous swarm BVLOS with deliberate loss-of-reference); the submission asserts SAIL I. This asymmetry between operational complexity and declared assurance is the dominant reason for refusal. It is not curable by panel deliberation — it requires resubmission with a re-derived SAIL, the corresponding OSO coverage, and the artefacts listed in AC3–AC7 above."*

The generator should *not* simply red-flag line items; it should explain the **logic of refusal**.

---

## 4. Architecture of the generator

### 4.1 High-level flow

> *v1.2 note:* the pipeline is the same in both UX postures — Applicant and Regulator modes share components 1–8. The modes differ in what the engine *outputs* (§21), not in what it *computes*.

```
  [Submission pack]
        |
        v
  [0. Baseline configurator (v1.2)] -->  (selects clause sub-library based on
        |                                  operation type, airspace, regulator)
        v
  [1. Ingest & segmentation]  -->  (sections, tables, figures, metadata)
        |
        v
  [2. Operation classifier]   -->  (category, airspace, BVLOS, autonomy, swarm, payload)
        |
        v
  [3. Artefact detector]      -->  (OSC, SORA, DAA, C2, swarm env, AMLAS/SACE, CAP1616, Article36)
        |
        v
  [4. Regulatory mapper]      -->  (clause-level coverage matrix, RAG rated)
        |
        v
  [5. SORA evaluator]         -->  (GRC, ARC, SAIL, OSO-by-OSO compliance check)
        |
        v
  [6. Gap & extrapolation analyser]
        |
        v
  [7. Decision drafter]       -->  (approve-with-conditions | refuse-with-reasons | return-for-clarification)
        |
        v
  [8. Evidence traceability binder]
        |
        +---- (Applicant mode)  -->  [Operator Feedback Report + Readiness Dashboard]   (§21)
        |
        +---- (Regulator mode)  -->  [Structured Decision Record + Coverage Matrix +
                                      Gap Report + Panel Deliberation Log]              (§7, §21)
```

### 4.2 Component responsibilities

> *v1.1 note:* components 5 and 6 now run *two* passes in sequence — (i) regulatory-coverage pass, as originally designed, and (ii) **DTFEA stress-test pass** per §15. Component 7 (decision drafter) consumes both.

**1. Ingest & segmentation.** Accept MD / TXT / PDF / DOCX. Normalise to a sectioned internal representation. Preserve page/paragraph anchors — every later citation must resolve to an original-document coordinate. Re-use the `pdf` skill for PDFs and `docx` for Word; markdown/text pass through a header-aware splitter.

**2. Operation classifier.** Extract structured facts from the submission:
- Operator identity; Accountable Manager; Duty Holder; RAISO
- Aircraft make/model, quantity, MTOM, configuration
- Operation type (photo/survey/delivery/trial), airspace class, segregated or not, BVLOS/VLOS
- Autonomy posture (teleoperated / supervised autonomy / full autonomy / swarm)
- Payload (benign, hazardous, weapon-bearing → triggers AOP-15 / Article 36)
- Range and duration; day/night; populated-area overflight
- Declared category (Open / Specific / Certified) and standard scenario (PDRA-01/02, STS-01/02)

**3. Artefact detector.** Check for presence and basic structural adequacy of each required evidence artefact. A binary "present" is not enough — e.g., a DAA section that is three paragraphs long with no sensor specs fails the detector's minimum-content heuristic.

**4. Regulatory mapper.** Uses a configuration-controlled clause library. Every artefact section is linked to the clause(s) it purports to satisfy, and vice versa. Produces a red/amber/green matrix per AC1. Clauses drawn from:
- **CAP 722** — UAS operations in UK airspace (current: v9, Dec 2022)
- **CAP 722A Second Edition** — Operating Safety Cases (Dec 2022)
- **CAP 722B Fifth Edition** — RAE(PC) / BVLOS-relevant sections (2025)
- **CAP 1616** — Airspace Change Process
- **DEFSTAN 00-970 Part 9, Issue 13** — RPAS design & airworthiness
- **RA 1000 / 1600 / 2300 series** — MAA Regulatory Articles (current dated as late as 31 Mar 2026 in supplied source)
- **JSP 936 Part 1 v1.1** — Dependable AI in Defence (Nov 2024)
- **JARUS SORA v2.5** — 24 OSOs
- **AMLAS (6-stage)** and **SACE (8-stage)** — York CAA / CfAA autonomy assurance methodologies
- **ASTM F3442** / **EUROCAE ED-267** — DAA technical frameworks
- **AOP-15** and **Article 36 (AP I Geneva)** — weapon review

**5. SORA evaluator.** Walks the JARUS SORA v2.5 algorithm end-to-end:
- Verify declared iGRC against population density + MTOM table
- Verify mitigations M1 (ground-level risk reduction), M2 (effect of ground impact), M3 (ERP)
- Derive final GRC and cross-check against declared value
- Verify ARC derivation and tactical mitigations
- Derive SAIL from the GRC × ARC grid; refuse auto-green if declared SAIL < derived SAIL
- Walk all 24 OSOs; each must be Met / Enhanced / High / Not-applicable-with-rationale; any partial or unmet OSO is flagged for mandatory panel deliberation and a written rationale before any green rating is issued
- Flag when OSO robustness level falls below SAIL requirement

**6. Gap & extrapolation analyser.** Four checks:
- *Coverage gap* — required artefact or clause missing
- *Strength gap* — artefact present but evidence too thin to carry the claim
- *Envelope extrapolation* — operational envelope (altitude, speed, density, duration, number of agents) exceeds the tested envelope, especially for DAA sensors and swarm behaviour
- *DTFEA failure-mode gap* (v1.1) — submission passes regulatory coverage but fails one or more pillars (Data / Trust / Failure / Evidence / Authority) per §15
Each flag explains which rule fired, which evidence it drew on (or where it looked and found nothing), and the regulator's next action in plain engineering English.

**7. Decision drafter.** Produces one of three outputs:
- **Approve with conditions** — full decision record per AC8 with limits, triggers, and signatures block
- **Refuse with reasons** — structured refusal enumerating each unresolvable blocker with the clause it breaches and what would be required to convert to approval
- **Return for clarification** — where defects are recoverable by addition rather than resubmission; lists exactly what is required and sets a clock

**8. Evidence traceability binder.** Every quantitative claim in the decision record resolves to an evidence artefact, page, and paragraph. No claim without a pointer; no pointer without a claim. This is a hard invariant — the drafter refuses to emit an unsourced quantitative assertion.

### 4.3 Human-in-the-loop markers

Per NFRs in the user story (override-first UI, mandatory panel deliberation on every amber/red flag): the generator never auto-closes amber or red. It produces the draft; the joint panel signs. The tool logs every comment / accept / challenge / override immutably.

---

## 5. Knowledge base construction

The generator is only as good as its clause library. Three indices must be built and kept under joint MAA/CAA configuration control:

| Index | Contents | Source | Update cadence |
|---|---|---|---|
| **Clause library** | Every cited clause, paragraph, or table from the regulatory anchor corpus, with issue/date | CAP 722 family, RA 1000/1600/2300 series, DEFSTAN 00-970 Part 9, JSP 936 Part 1, JARUS SORA v2.5, CAP 1616, AOP-15 | Quarterly MAA/CAA alignment review; on-publication hot-patch for named amendments |
| **Artefact schema** | What a compliant DAA report / swarm envelope / AMLAS case must contain at minimum | Derived from CAP 722A §3 & §4, AMLAS/SACE templates, EUROCAE ED-267 §5 | On methodology revision |
| **Requirements catalogue** (v1.1) | REQ001–REQ020 — the CAA operational-authorisation-pack requirement set, with per-REQ acceptance gates | `requirements.csv`, extensible by joint MAA/CAA configuration control | Per programme; version-pinned to submission under review |
| **DTFEA rubric** (v1.1) | 5-pillar stress-test questions (Dana/Trevor/Fiona/Evan/Aria) with severity × confidence scoring | `STRESS-Report.md` methodology | On methodology revision |
| **Historical decision ledger** | Every previous decision record (approve/refuse/return) plus the evidence pack and the panel's deliberation notes | The Workbench itself, with a read-back loop | Continuous; used for calibration audits |

Superseded revisions are archived, not silently updated — per the NFR on traceability.

### 5.1 Version pinning — non-negotiable

The generator tags every clause citation with the publication revision in force on the date of review. Example: a review on 23 April 2026 cites CAP 722A Second Edition (Dec 2022) and RA 2305 Issue 7 (updated 31 Mar 2026 per the supplied FLY 2000 series print). A re-review 12 months later may cite different revisions; the two decision records remain individually coherent.

---

## 6. Mapping AC1–AC8 and REQ001–REQ020 onto generator capability

This is the coverage claim. Each user-story acceptance criterion maps to one or more generator components and produces a named section of the output decision record.

| AC | User-story requirement (one line) | Generator components involved | Output section | REQs that feed into it |
|---|---|---|---|---|
| AC1 | Submission completeness & clause-coverage RAG matrix | 1, 3, 4 | *Coverage Matrix* appendix | REQ001, REQ013, REQ014, REQ016, REQ020 |
| AC2 | SORA ground assessment: GRC / ARC / SAIL / 24 OSOs | 5 | *SORA Evaluation* section | REQ002, REQ003 |
| AC3 | DAA evidence with envelope coverage test | 3, 6 | *Detect & Avoid* section | REQ007 |
| AC4 | C2 link, loss-of-link behaviour, swarm-consensus flag | 3, 6 | *Command & Control* section | REQ005, REQ006, REQ011 |
| AC5 | Swarm-specific emergent behaviour, containment, live-flight coverage | 3, 6 | *Swarm Behaviour Envelope* section | REQ005, REQ008 |
| AC6 | Airspace integration, CAP 1616, NOTAM, e-conspicuity, third-party risk | 4, 6 | *Airspace & Third-Party Risk* section | REQ004, REQ013, REQ017, REQ019 |
| AC7 | AMLAS/SACE posture, JSP 936 RAISO sign-off, Meaningful Human Control, ODD | 3, 4 | *Autonomy Assurance Posture* section | REQ003, REQ008, REQ009, REQ010 |
| AC8 | Structured decision record with conditions, triggers, signatures, full traceability | 7, 8 | *Decision Record* (the main document) | REQ012, REQ015, REQ018, REQ020 |

This cross-map is load-bearing: the AC1–AC8 axis comes from the user story (what the *Workbench* must do); the REQ001–REQ020 axis comes from the requirements catalogue (what an *operational-authorisation pack* must contain). The generator evaluates both. A submission can pass AC1 (all artefacts present) and still fail a REQ (e.g., REQ009 — AMLAS container named but no re-evidencing cycle) — that's exactly the class of defect the v1.0 plan missed and v1.1 closes.

### 6.1 Walkthrough against the two samples

**Scotland sample through the generator:**
- AC1: **Green** — all required PDRA-01 artefacts present (OSC complete, no DAA/C2/swarm/AMLAS required at this SAIL)
- AC2: **N/A (PDRA-01 path)** — operation is a standard scenario under UKPDRA-01, so the full 24-OSO walk is replaced by the PDRA assurance pack
- AC3–AC5: **N/A** — VLOS only, single-vehicle, no autonomy
- AC6: **Green** — Class G/D covered with NSF process where needed
- AC7: **N/A** — no autonomy load-bearing
- AC8: **Approve with conditions** — conditions are essentially the PDRA-01 operational limits (daylight, 400 ft ASL, 500 m VLOS, 50 m from uninvolved, etc.)

**SORA case through the generator:**
- AC1: **Red** — DAA, C2 link analysis, swarm envelope, AMLAS/SACE all absent
- AC2: **Red** — SORA v2.5 not used; SAIL declaration incoherent with operation; 18 of 24 OSOs absent
- AC3: **Red** — DAA envelope not tested (none provided)
- AC4: **Red** — loss-of-link is *intentional*; no link budget; no crypto posture; no individual-vehicle vs swarm-level behaviour table — and a GNSS/C2 denial trial that depends on continued swarm consensus is **explicitly** flagged as high-risk by AC4
- AC5: **Red** — no emergent-behaviour analysis, no sim-plus-flight coverage matrix, no containment evidence beyond "hard geofencing" (claim without derivation)
- AC6: **Amber** — segregated airspace is claimed; NOTAM and TDA not evidenced but plausibly recoverable
- AC7: **Red** — no AMLAS/SACE case; no RAISO sign-off; no ODD; no MHC concept of use at vehicle/swarm/mission layers
- AC8: **Refuse** — the submission is not curable by panel deliberation; resubmission required with re-derived SAIL

---

## 7. Output — the decision record

A single structured Markdown document that renders to PDF. Fixed section order so reviewers, Duty Holders, and AAIB readers can find any element without a table of contents search.

```
Decision Record — CAA/MAA Joint Approval Workbench
==================================================

0. Front matter
   0.1 Submission ID, applicant, operation title, review date
   0.2 Panel composition and signatures block
   0.3 Classification marking (highest element in pack)

1. Decision
   1.1 APPROVE WITH CONDITIONS | REFUSE | RETURN FOR CLARIFICATION
   1.2 One-paragraph rationale in engineering English

2. Operation summary
   2.1 Concept of Operations (machine-extracted, human-verified)
   2.2 Classification: category, SAIL, BVLOS, swarm, autonomy, payload

3. Regulatory basis
   3.1 Cited clauses with revision tags
   3.2 Applicability map

4. Coverage matrix (AC1)
   4.1 Artefact presence table (RAG)
   4.2 Clause-to-evidence trace

5. SORA evaluation (AC2)
   5.1 GRC derivation and mitigations
   5.2 ARC derivation and mitigations
   5.3 SAIL determination
   5.4 24 OSO walk with evidence pointers

6. Detect & Avoid (AC3)
7. Command & Control and loss-of-link (AC4)
8. Swarm behaviour envelope (AC5)
9. Airspace and third-party risk (AC6)
10. Autonomy assurance posture (AC7)

11. Residual risks and ALARP rationale
12. Conditions (if approve)
    12.1 Operational limits (weather, day/night, max airborne agents, volume, payload, crew qualifications)
    12.2 Review triggers (loss-of-link, containment breach, weather excursion, software update)
    12.3 Reporting obligations
13. Reasons (if refuse) — itemised blockers, clause, and remedy

14. Signatures
    14.1 MAA Lead Inspector
    14.2 CAA co-signer (non-segregated legs)
    14.3 Duty Holder acknowledgement
    14.4 RAISO acknowledgement (where AI load-bearing)

Appendix A — Coverage matrix (detailed)
Appendix B — Evidence index with page/paragraph pointers
Appendix C — Panel deliberation log (immutable, timestamped)
Appendix D — Gap report (flags raised, resolution notes)
```

Every quantitative claim in sections 1–14 resolves to an Appendix B entry. This is the traceability invariant restated at the output level.

### 7.1 Additional output sections (v1.1)

Two new sections are inserted into the decision record to reflect the requirements catalogue and the DTFEA stress-test:

```
15. Requirements catalogue compliance (REQ001–REQ020)
    15.1 Per-REQ verdict table with evidence pointers
    15.2 Absent-by-default REQs flagged (REQ017 public engagement, REQ018 classification, REQ019 environmental, REQ020 close-out)

16. DTFEA stress-test matrix
    16.1 Per-pillar maturity % (D / T / F / E / A)
    16.2 Critical / major / minor finding counts
    16.3 Top-20 findings (severity × confidence) with recommendations
    16.4 Keystone failure-mode detector results (§16 of plan)
```

Appendix E — Requirements-to-AC cross-reference matrix.
Appendix F — DTFEA findings in full, per-REQ, per-pillar.

---

## 8. Validation strategy — how we prove it works

### 8.1 Twin-sample regression

The supplied Scotland and SORA samples are the first regression cases. Expected behaviour:

| Scenario | Expected decision | Expected failure families flagged (if refuse) |
|---|---|---|
| `scotland-sample-case.md` as-is | Approve with PDRA-01 conditions | None |
| `scotland-sample-case.md` with §3.3 (personnel) redacted | Return for clarification — AC1 §3 missing | Named personnel absent |
| `scotland-sample-case.md` escalated to BVLOS claim | Refuse — operation exceeds authorisation | Operation type vs authorisation mismatch |
| `sora-safety-case.txt` as-is | Refuse | AC1 artefacts, AC2 SAIL incoherence, AC3, AC4, AC5, AC7 |
| `sora-safety-case.txt` re-submitted at SAIL V with full SORA v2.5 OSO pack, swarm envelope, AMLAS case | Return → Approve with heavy conditions | Remaining gaps (e.g., Article 36 if payload changes) |

If the generator approves the SORA case as-submitted, or refuses the Scotland case, the regression fails and the build is blocked.

### 8.2 Red-team probe

Per Definition of Done in the parent story, an independent red-team run against:
- **Automation bias** — can an inspector silently accept a red flag? (No — mandatory deliberation lock.)
- **Evidence fabrication** — does the generator cite a non-existent page? (Binder invariant should block.)
- **Classification leakage** — does a SECRET paragraph end up in an OFFICIAL export? (Classification-aware pipeline, two-person downgrade.)
- **Prompt injection** — does content in the submission cause the generator to skip checks? (Guardrails isolate submission text from control flow.)

### 8.3 Calibration audit

Held-out historical decisions (from the MAA RPAS Regulatory Branch archive, if released) re-run through the generator and compared to the human panel's original verdict and rationale. Disagreements are the training ground — not to make the generator agree with the human (the human might have been wrong), but to force explicit rationale on both sides.

### 8.4 Drift monitoring

Per NFRs: the generator's own AI components carry a drift-monitoring plan with an owner. When regulatory text, clause numbering, or OSO structure shifts, the clause library update triggers a re-run of the twin-sample regression before the new version is released to inspectors.

---

## 9. Assurance of the tool itself

The generator is itself a load-bearing component in a safety-regulatory decision loop. Per the user story's Definition of Done:

- The Workbench's own assurance case must be signed off by MAA-CTS or CAA Innovation Hub.
- Drift monitoring on AI components with a named owner.
- UNCLASSIFIED lessons-learned published to the wider UK aviation regulatory community.

We treat the generator as an AMLAS-stage artefact in its own right: ODD (inspector-facing review of UK UAS submissions), training/validation data provenance (historical decisions + synthetic edge cases), residual-risk claims (what the generator does *not* catch and the compensating controls that catch it instead).

---

## 10. Implementation phases

The plan stops short of writing code but sets up the work.

### Phase 0 — Clause library boot (1 sprint)
Ingest the supplied regulatory corpus. Tag every citable paragraph with revision and date. Produce a machine-readable clause index. Deliverable: `clause_library_v0.json` + a human-browsable HTML mirror.

### Phase 1 — Ingest + classify (1 sprint)
Components 1 & 2. Target accuracy: ≥95% correct extraction of operator identity, MTOM, airspace class, BVLOS/VLOS, swarm/single on the twin samples plus 5 synthetic variants.

### Phase 2 — Artefact detector + regulatory mapper (2 sprints)
Components 3 & 4. Produces the AC1 coverage matrix. Passes the twin-sample regression at coverage-matrix level.

### Phase 3 — SORA evaluator (2 sprints)
Component 5. End-to-end JARUS SORA v2.5 walk. SAIL derivation cross-checker. OSO-by-OSO walk. Passes the twin-sample regression at SORA-evaluator level.

### Phase 4 — Gap analyser + decision drafter (2 sprints)
Components 6 & 7. Produces the full decision record document. Passes the twin-sample regression at document level.

### Phase 5 — Traceability binder + HITL (1 sprint)
Component 8. Binder invariant enforcement. Panel deliberation log. Accessibility pass (WCAG 2.2 AA).

### Phase 6 — Red-team + calibration + drift monitor (1 sprint)
Validation §§8.2–8.4. Release candidate.

### Phase 7 — Joint MAA/CAA panel trial (1 sprint, live)
First real submission through the Workbench without fallback to manual workflow. Decision record accepted by Duty Holder without rework on structure or traceability. Definition of Done — first checkbox met.

**Total:** ~10 sprints from zero to first live joint-panel approval. This is deliberately padded — regulatory tool development is not a place for optimistic estimates.

---

## 11. Risks to the plan

| Risk | Mitigation |
|---|---|
| Clause library drifts out of sync with live publications | Quarterly MAA/CAA alignment review; on-publication hot-patch discipline; version-pinned citations |
| Over-reliance on pattern-matching to declare a submission "complete" when content is thin | Strength gap check (component 6) forces minimum-content heuristics per artefact type |
| Generator produces a plausible-sounding refusal for a valid submission (false refuse) | Calibration audit + human-in-the-loop override-first UI; no auto-close on amber/red |
| Generator approves a bad submission (false approve) | Binder invariant plus mandatory SAIL cross-check; the SORA sample is explicitly the canonical false-approve regression case |
| Classification leakage in multi-level submissions | Classification-aware pipeline from ingest onwards; two-person downgrade for any export |
| Scope creep into MPTF issuance | Generator hard-stops at the draft decision record; signature remains human by design |

---

## 12. Open questions — need regulator input before Phase 2

1. What is the authoritative source-of-truth for the clause library — a live CAA/MAA feed, or manually curated under joint configuration control? (Assumed the latter for now.)
2. How does the Workbench ingest SECRET and STRAP submissions in practice — secure enclave, offline instance, or classification-aware sanitisation? (Assumed secure enclave on UK sovereign infrastructure.)
3. Where does the Range Safety Case sit in the decision record — embedded, or cross-referenced as an out-of-band artefact that the Workbench acknowledges but does not evaluate? (Assumed the latter; consistent with the NFR that Workbench unavailability must never block a live trial.)
4. For coalition swarm variants (AUKUS/NATO), does the decision record format need to render to an interop schema for peer regulators? (Out of scope for v1; parent story lists it as a related story.)

---

## 13. Definition of plan-complete

This plan is ready for implementation when:

- [ ] The build team and a named MAA/CAA reviewer agree the scope in §2 is correct.
- [ ] The mapping in §6 from AC1–AC8 to generator components is accepted.
- [ ] The twin-sample expected behaviour in §8.1 is accepted as the regression contract.
- [ ] Open questions in §12 are either answered or explicitly deferred with ownership.
- [ ] A hackathon timebox decision is made — full Phase 0–7 will not fit; the hackathon target is most likely Phase 0 + Phase 1 + a partial Phase 2 producing the AC1 coverage matrix, with the two supplied samples as the live demo.

---

*End of v1.0 plan body. Implementation begins only after sign-off on §13.*

---

# v1.1 Addendum — Requirements catalogue & DTFEA stress-test

*Incorporating `requirements.csv` (20 REQs) and `STRESS-Report.md` (DTFEA methodology, 100 findings across 5 pillars)*

## 14. Requirements catalogue REQ001–REQ020

The requirements catalogue is a CAA-oriented pack-level view that sits **below** AC1–AC8 and **above** individual clause checks. Each REQ is phrased as a user story from a specific CAA role (case officer, SORA assessor, airspace regulator, spectrum specialist, DAA assessor, autonomy reviewer, AI/ML specialist, human factors inspector, flight-ops inspector, flight safety investigator, authorisation officer, licensing inspector, CAA/MAA liaison, programme manager). The generator walks the catalogue for every submission and produces a per-REQ verdict.

### 14.1 Catalogue summary

| REQ | Name | CAA role | Primary AC binding |
|---|---|---|---|
| REQ001 | Application intake & completeness check | Case officer | AC1 |
| REQ002 | SORA 2.0 assessment for swarm | SORA assessor | AC2 |
| REQ003 | ConOps & ODD review | Safety-case reviewer | AC2, AC7 |
| REQ004 | Airspace change & TDA coordination | Airspace regulator | AC6 |
| REQ005 | Geofence / containment enforcement | Airspace regulator | AC4, AC5 |
| REQ006 | C2 link & spectrum assurance | Spectrum specialist | AC4 |
| REQ007 | Detect-and-avoid performance | DAA assessor | AC3 |
| REQ008 | Swarm decision-making architecture | Autonomy reviewer | AC5, AC7 |
| REQ009 | ML assurance case (AMLAS / SACE) | AI/ML assurance specialist | AC7 |
| REQ010 | Human oversight & crew fitness | Human factors inspector | AC7 |
| REQ011 | Contingency & flight termination | Flight-ops inspector | AC4 |
| REQ012 | Data, MOR & DPIA obligations | Flight safety investigator | AC8 |
| REQ013 | Insurance & ground-environment survey | Authorisation officer | AC1, AC6 |
| REQ014 | Crew training & competency | Licensing inspector | AC1 |
| REQ015 | CAA/MAA interface management | CAA/MAA liaison | AC8 |
| REQ016 | Phased trial build-up | Programme manager | AC1 |
| REQ017 | Public & stakeholder engagement | *absent-by-default — CAP 1616 / GDPR implied* | AC6 |
| REQ018 | Security classification handling | *absent-by-default — CAP 722H / JSP 440* | AC8 |
| REQ019 | Environmental impact | *absent-by-default — noise, species, battery fire* | AC6 |
| REQ020 | Post-trial assurance & close-out | *absent-by-default — lessons learned, evidence preservation* | AC1, AC8 |

### 14.2 The absent-by-default quartet (REQ017–REQ020)

REQ017–REQ020 are not in the user-story set — they were identified as **gaps** by the stress-test. The generator treats them as *proactive checks*: for every submission, it asks "is there evidence of community consultation? classification handling? environmental impact? post-trial closeout plan?" — and flags absence even when the applicant has not been asked for them. This is a deliberate asymmetric behaviour: better to surface a gap the applicant missed than let it surface during a live incident.

### 14.3 Using the catalogue against the two samples

- **Scotland sample:** REQ001–REQ003 effectively green (PDRA-01 scenario has the catalogue built in via CAP 722A conformance). REQ004–REQ011 mostly N/A (VLOS, single-vehicle, no autonomy). REQ012–REQ014 green (MOR via ECCAIRS, U.M. Association insurance, GVC + currency). REQ015 N/A (civil-only). REQ016 N/A. REQ017 partial (no explicit community engagement but CAA Skywise subscription present). REQ018 N/A (unclassified). REQ019 partial (LiPo fire procedure present; noise/species not). REQ020 amber (change log present; formal close-out practice implicit). **Net:** green with one or two amber notes — approve.
- **SORA case:** REQ001 red (no named accountable manager). REQ002 red (SORA v2.0 not v2.5; swarm-specific evidence absent). REQ003 red (ConOps sparse; ODD not defined). REQ004 amber (segregated airspace claimed; NOTAM / TDA process not evidenced). REQ005 red (hard geofencing claimed; independence not demonstrated; see keystone K1 in §16). REQ006 red (no link budget, no crypto posture, no inter-vehicle link analysis). REQ007 red (no DAA evidence of any kind — though arguably N/A in segregated; still required for containment-breach scenarios). REQ008 red (no architecture review, no emergent-behaviour evidence). REQ009 red (no AMLAS/SACE case). REQ010 red (no MHC operationalisation). REQ011 red (termination logic one line; no independence). REQ012 red (MOR not addressed). REQ013 red (no insurance statement, no ground survey). REQ014 red (personnel named by role only, no qualifications). REQ015 red (CAA/MAA apportionment not signed; this is a military-range civil-trial — mandatory). REQ016 N/A (single trial window). REQ017 red. REQ018 red (classified-range submission; no protocol). REQ019 red. REQ020 red. **Net:** refuse, not curable without re-submission.

---

## 15. DTFEA stress-test pass

### 15.1 The methodology

Per `STRESS-Report.md`: every requirement (and, by extension, every submission section) is stress-tested across five independent pillars. Each pillar carries a named analyst persona so the rubric can be held and applied consistently:

| Pillar | Analyst | Question |
|---|---|---|
| **D — Data** | Dana | What data does this depend on? Is provenance known? Is bias, drift, class imbalance, sensor-coverage surfaced? |
| **T — Trust** | Trevor | Who has to trust this output? Are model cards, uncertainty bounds, explainability, meaningful human control triggers in place for each consumer role? |
| **F — Failure** | Fiona | What happens when this fails, silently or loudly? Is there redundancy, independent containment, out-of-distribution detection, forensic audit, canary/sandbox? |
| **E — Evidence** | Evan | What evidence will convince a regulator? Acceptance criteria, test plans, re-evidencing cycle, state-space coverage, go/no-go thresholds? |
| **A — Authority** | Aria | Who is accountable when this goes wrong? Is the human-in-the-loop role named? Is inter-organisational apportionment signed? |

Working assumption (explicit): **the AI will sometimes be wrong.** This applies to the onboard autonomy, to the applicant's AI, and — importantly — to the generator itself.

### 15.2 Scoring and maturity

Each finding carries a **severity** (critical / major / minor) and a **confidence** (0–10). The per-pillar maturity percentage is a function of:
- Count and severity of findings
- Coverage of the pillar's question set
- Traceability of evidence to finding

In the supplied stress-test example: D 35%, T 40%, F 32%, E 21%, A 45% — overall "Not suitable (yet)". These percentages and the finding counts (28 critical / 50 major / 20 minor) provide a concrete shape the generator should reproduce on any submission.

### 15.3 Gates derived from DTFEA

The generator applies two gates on top of the regulatory coverage gate:

**Gate 1 — Pillar maturity floor.** Minimum 60% per pillar for approval. Below 60% forces *refuse* or *return-for-clarification*. The stress-test example's 21–45% range falls far below the floor; the "not suitable (yet)" verdict is mathematically determined rather than judgement-based.

**Gate 2 — No unmitigated critical.** Any critical finding with confidence ≥9 blocks approval until explicitly mitigated or formally accepted by the panel with a written rationale in the decision record.

### 15.4 Wiring into the decision record

Output sections 15 and 16 (see §7.1) render the REQ table and the DTFEA matrix directly into the decision record. The top-20 findings with severity × confidence, per the STRESS-Report format, form the body of §16.3.

---

## 16. Keystone failure-mode detectors

The stress-test surfaced eight critical patterns that recur across submissions. The generator hard-codes a detector for each. These are not discretionary — any one of K1–K8 blocks approval until explicitly resolved.

### K1 — Geofence / containment independence (REQ005, Fiona-critical, conf 10)
**Detector asks:** Does the geofence enforcement path run through the same compute and software stack as the primary autonomy? If yes — single-point failure — refuse.
**Expected evidence:** Dual-independent geofence (e.g., L2 swarm-coordinator + L3 safety-critical module hardened against corruption and spoof), with test evidence of enforcement under degraded states.
**Relevance to samples:** SORA case claims "hard geofencing" without independence evidence — red.

### K2 — DAA ML provenance and calibration (REQ007, Dana- and Fiona-critical, conf 10)
**Detector asks:** Does the DAA assurance pack contain (a) training dataset sheet with source, size, encounter types, sensor platforms, label accuracy metrics, (b) calibration study at 10 confidence thresholds with empirical ROC, (c) distributional-shift detection runtime? If absent — refuse.
**Expected evidence:** Full DO-365 / F3442 mapping matrix, acceptance criteria table, multi-agent deconfliction confidence model, out-of-distribution monitor at runtime.
**Relevance:** SORA case — no DAA content at all — red.

### K3 — Swarm emergent behaviour bounds (REQ008, Dana- and Fiona-critical, conf 10)
**Detector asks:** Is the swarm's collective state space explored in simulation *and* live flight? Are emergent-behaviour monitors present at runtime? Is a named human accountable for the emergent-behaviour envelope? If any no — refuse.
**Expected evidence:** State-space coverage report, simulation + flight-test matrix, runtime monitor for inter-agent consensus and cohesion, named role (Supplier for design, Operator for real-time supervision).
**Relevance:** SORA case — no emergent-behaviour analysis — red.

### K4 — ML forensic explainability (REQ009, Trevor- and Fiona-critical, conf 10)
**Detector asks:** Is there an onboard logging design that captures every input to DAA, swarm-decision, and geofence modules with intermediate confidence scores, timestamped, and exportable for post-incident forensic reconstruction? If no — refuse.
**Expected evidence:** AMLAS explainability module mapping each model component to consumer + explanation strategy; onboard-log schema; post-incident reconstruction playbook.
**Relevance:** SORA case — no AMLAS case — red.

### K5 — Meaningful Human Control operationalisation (REQ010, Trevor-critical, conf 10)
**Detector asks:** Is MHC defined with a decision-responsibility matrix (AI-sole / human-supervised / human-sole), measurable override latency (<1 s target), and workload thresholds for the human operator? If absent or narrative-only — refuse.
**Expected evidence:** Quantified override latency with test evidence, workload instrumentation plan, take-over simulator runs.
**Relevance:** SORA case — "Remote Pilot / Mission Supervisor" named without MHC model — red.

### K6 — Independent flight termination (REQ011, Fiona-critical, conf 10)
**Detector asks:** Is termination independent of the primary flight stack? Are there redundant termination channels (e.g., RC + software relay, plus independent RF kill)? Is final authority for termination explicitly human? If no or ambiguous — refuse.
**Expected evidence:** Redundant termination channels, independent power/compute paths, explicit statement that final override is human-exclusive.
**Relevance:** SORA case — "termination" mentioned in passing; independence unevidenced — red.

### K7 — CAA/MAA apportionment as a mandatory gate (REQ015, Aria-critical, conf 10)
**Detector asks:** For any operation that crosses civil/military regulatory boundaries (e.g., military range in civil airspace, civil operator on military aircraft), has a signed CAA/MAA Apportionment Agreement been produced *before* trial authorisation? If not — refuse.
**Expected evidence:** Signed apportionment naming regulatory ownership per leg, per event-class, per payload-class.
**Relevance:** SORA case — Spadeadam military range operation with no apportionment evidence — red. (This is one of the highest-severity findings in the whole stress-test.)

### K8 — Classification custodian & apportionment (REQ018, Aria-critical, conf 10)
**Detector asks:** Where any classified MOD evidence is presented to CAA, is a named **Security Classification Custodian** (joint MOD/CAA) identified, is a classification guide produced, and are CAP 722H / JSP 440 handling procedures explicit? If not — refuse.
**Expected evidence:** Custodian named, classification guide present, redaction protocol documented, two-person downgrade rule in force.
**Relevance:** SORA case — classified-adjacent range operation; no custodian — red.

### 16.1 How K1–K8 change the twin-sample expected behaviour

The §8.1 regression table stands, with one refinement: the SORA case refusal is now *over-determined* — any one of K1 through K8 fires independently with confidence 10 and blocks approval. The detector set is designed to be individually sufficient and jointly redundant, so a clever applicant cannot satisfice one while ignoring the others.

The Scotland sample passes K1–K8 by exemption rather than evidence — the PDRA-01 scenario does not carry the autonomy, swarm, or classification surface that the keystones guard. This is the correct behaviour: keystones should not penalise submissions that simply do not engage the failure mode they protect against.

---

## 17. Updates to implementation phases (supersedes §10 where in conflict)

Two new phases are inserted:

### Phase 2b — Requirements catalogue evaluator (1 sprint, parallel to Phase 2)
Component addition: walks REQ001–REQ020 and emits the per-REQ verdict table. Passes twin-sample regression at the REQ-verdict level.

### Phase 3b — DTFEA stress-test evaluator (2 sprints, parallel to Phase 3)
Component addition: runs the five-pillar rubric, produces per-pillar maturity, finding list with severity × confidence, and applies Gates 1 and 2. Passes twin-sample regression at the stress-test level.

### Phase 4b — Keystone detector hardening (1 sprint, parallel to Phase 4)
Component addition: K1–K8 hard-coded detectors with their own unit tests. Each detector must individually and independently refuse the SORA sample.

**Revised total:** ~12 sprints to first live joint-panel approval (was ~10). The extra two sprints buy a much sharper detection surface — and a far more defensible decision record for the refusal case.

---

## 18. Updated risk register (supersedes §11 additions)

| Risk | Mitigation |
|---|---|
| Generator passes regulatory coverage and fails DTFEA quietly | Gate 1 (pillar floor) and Gate 2 (no unmitigated critical) are blocking; the drafter cannot emit "approve" while either gate is open |
| Pillar maturity scores become a single number that hides detail | Each pillar score renders with its full finding list in the decision record; the number is a summary, never the whole story |
| Keystone detectors overfit to the SORA sample and become brittle | K1–K8 are expressed as invariants (e.g., "independence required") not patterns (e.g., "contains word 'independent'"); unit tests include paraphrase adversarials |
| REQ017–REQ020 (absent-by-default) produce noise on submissions where they genuinely don't apply | Each absent-by-default REQ has an N/A-with-rationale path; the generator requires the rationale, not the evidence, in N/A cases |
| DTFEA stress-test itself ages out of date as failure modes evolve | The rubric lives in the knowledge base (§5) under joint MAA/CAA configuration control; the stress-test is itself stress-tested annually by a red team |
| Generator fails K7 (CAA/MAA apportionment) too aggressively on civil-only trials | K7 is conditional on the operation crossing a regulatory boundary; civil-only and military-only operations skip K7 with an explicit rationale line |

---

## 19. Definition of plan-v1.1-complete

Supersedes §13. The plan is ready for implementation when:

- [ ] v1.0 definition of plan-complete (§13) items are all satisfied.
- [ ] The requirements catalogue in §14.1 is agreed by MAA and CAA reviewers as the right pack-level taxonomy.
- [ ] The DTFEA rubric in §15 is adopted as the second-axis check, with Gates 1 and 2 accepted as blocking.
- [ ] The keystone detectors K1–K8 are agreed — both the list and each detector's refusal logic.
- [ ] The twin-sample regression in §8.1 is re-run mentally against K1–K8 and the expected over-determined refusal for the SORA case is accepted.
- [ ] The revised ~12-sprint implementation schedule is resourced.

---

*End of v1.1 plan body. Implementation begins only after sign-off on §19.*

---

# v1.2 Addendum — Service blueprint, dual-mode engine, readiness gate, learning loop

*Incorporating `user journey.txt` — the 10-step, 3-phase end-to-end service blueprint for the Workbench*

## 20. Service blueprint — the 10 steps and 3 phases

The v1.0 and v1.1 plan treated the generator as a regulator-facing tool that runs once per submission. The blueprint corrects this: the Workbench is a **service** with three phases and ten steps, and the generator runs more than once in more than one posture.

### 20.1 Phase 1 — Operator Journey (Prepare · Improve · Submit)

Personas: Operator · Safety Manager · Autonomy Engineer · Airspace Consultant · Duty Holder

| Step | Operator action | Generator action | Outcome |
|---|---|---|---|
| **1. Create Application Workspace** | Selects operation type, aircraft/swarm size, airspace, regulator(s) | Component 0 (Baseline Configurator, v1.2) pulls the relevant clause sub-library (CAP 722/722A/722B, SORA v2.5, RA 1600/2300, CAP 1616 triggers, JSP 936/AMLAS/SACE expectations) | Operator sees exactly what is expected for this operation — no guesswork |
| **2. Upload Evidence Pack** | Uploads Safety Case, SORA, C2 link analysis, DAA evidence, swarm envelope, AMLAS/SACE case, CAP 1616 artefacts, Range Safety Case | Components 1–4 run; produces a live coverage matrix (RAG) | Operator immediately sees what's missing, weak, or unclear |
| **3. Assisted Pre-Submission Review** | Reads AI feedback, revises documents, uploads new evidence, adds justifications, iterates | Components 5–6 run; emits operator-friendly feedback ("OSO 10 partially met — loss-of-link behaviour depends on swarm consensus"); **private, non-punitive, invisible to the regulator** | Fewer weak submissions; higher-quality applications; reduced regulator rework |
| **4. Submission Readiness Check** | Runs the readiness check, captures Duty Holder acknowledgements, submits formally | System (§22) confirms all mandatory artefacts present, all red/amber items acknowledged, all required signatures captured | A clean, structured, regulator-ready submission enters the approval pipeline |

### 20.2 Phase 2 — Regulator Journey (Review · Challenge · Decide)

Personas: MAA Lead Inspector (Chair) · CAA Inspector (AAA / FOI) · RAISO · Range Safety Officer · Independent Technical Advisor

| Step | Panel action | Generator action | Outcome |
|---|---|---|---|
| **5. Joint Review Panel Opens Case** | Inspectors open a single, structured application view | Presents clause-level coverage against SORA OSOs, CAP 722, RA/DEFSTAN, AI assurance anchors; evidence traceable to page and paragraph; flags residual risks, extrapolations, inconsistencies | Inspectors start at engineering substance, not document hunting |
| **6. Deep-Dive Reviews** | Panel examines SORA / DAA / C2 / Swarm / Airspace / Autonomy — one sub-panel per area | Runs AC2–AC7 checks; highlights uncovered collision geometries, swarm-level link dependencies, extrapolation beyond validated envelope, AMLAS/SACE completeness, RAISO sign-off status | Panel focuses on judgement and challenge, not clerical checking |
| **7. Panel Deliberation & Overrides** | Inspectors accept / override / add concerns to every AI finding | All actions logged, attributed, justified in plain English; no auto-close on amber/red | Automation bias actively mitigated; accountability stays human |
| **8. Decision Record Generation** | Lead Inspector closes review | Component 7 drafts the decision record per §7 and §7.1 — approval/refusal, regulatory basis, residual risks + ALARP, limits, conditions, review triggers, signature blocks | Defensible, auditable, inquiry-ready decision artefact produced in hours, not weeks |

### 20.3 Phase 3 — Post-Decision & Learning

| Step | Action | Generator action | Outcome |
|---|---|---|---|
| **9. Export, Archive, Audit** | Decision record exported as read-only PDF; audit trail retained; clause library versioned (§23) | Generates classification-marked PDF; pushes immutable audit to the ledger; pins the clause-library revision used | Strong institutional memory and consistency across cases |
| **10. Continuous Improvement** | Lessons-learned captured; AI flags compared with regulator judgements; model performance calibrated under configuration control — **never via self-learning in safety decisions** (§23) | Calibration audits run against held-out cases; drift monitor alerts on divergence; clause-library updates follow joint MAA/CAA change control | The system improves without drifting regulation or authority |

### 20.4 How the service blueprint changes the plan

Three structural consequences:

1. **The engine runs more than once per submission.** In Phase 1 it runs iteratively as the operator revises. In Phase 2 it runs once formally for the panel. In Phase 3 it feeds the calibration loop. Same engine, different cadence and different output posture.
2. **Mode matters more than function.** The *what the engine computes* is identical in Applicant and Regulator modes. The *what the engine reveals, logs, and exports* is not. §21 formalises this.
3. **There is a gate between the phases.** §22 makes the Submission Readiness Check a discrete capability with its own acceptance criteria.

---

## 21. The dual-mode engine

### 21.1 One codebase, two UX postures

| Property | Applicant mode (Phase 1) | Regulator mode (Phase 2) |
|---|---|---|
| Audience | Operator, Safety Manager, Autonomy Engineer, Airspace Consultant, Duty Holder | Joint Review Panel + advisers |
| Tone | Helpful, non-punitive, coaching | Defensible, precise, challenge-ready |
| Visibility of findings | Private to the applicant; **not visible to the regulator** until submission | Visible to all panel members; immutable from open |
| Iteration | Unbounded re-runs as documents change | One formal run per review cycle; re-open requires panel action |
| Output type | Operator Feedback Report (revise-and-resubmit) + Readiness Dashboard (gauges) | Structured Decision Record + Coverage Matrix + Gap Report + Deliberation Log |
| Logging | Draft-scoped; discarded on submit unless the applicant opts in | Immutable; timestamp + identity + rationale on every action |
| Decision language | "This is likely to be challenged because ..." | "Approve with conditions / Refuse / Return for clarification" |
| Data retention | Per applicant policy; no regulator-side retention pre-submission | UK sovereign infrastructure; highest classification in pack |

### 21.2 Applicant-mode output — Operator Feedback Report

A living document the operator can revise against. Sections:

1. **Readiness Gauges** — one per AC (AC1–AC8), one per pillar (DTFEA D/T/F/E/A), one per REQ (REQ001–REQ020), plus a keystone-detector panel (K1–K8).
2. **Top Issues** — highest-severity gaps, paraphrased as revise-next hints. Tone matches the blueprint examples: "OSO 10 partially met — loss-of-link behaviour depends on swarm consensus", "DAA tested envelope does not cover proposed operational geometry", "Autonomy failure modes not bounded to SACE severity levels".
3. **Suggested Evidence** — for each red/amber item, the artefact class that would clear it (not fabricated content — a pointer to what's missing).
4. **Duty Holder Checklist** — the acknowledgements the operator will need to capture before Step 4 will pass.

### 21.3 Critical constraint — no leakage between modes

The engine must not leak Applicant-mode findings into the Regulator-mode decision record. Two enforcements:

- **Data isolation** — applicant workspaces are logically separate from the regulator workspace; the only bridge is the formally submitted pack at Step 4.
- **Provenance** — every finding in the Regulator-mode decision record must cite a submitted artefact, never an Applicant-mode draft or revision history, unless the applicant has explicitly opted to include their change log.

This is not a policy preference; it is a mathematical invariant the drafter enforces at emit-time.

### 21.4 Why this matters

The Applicant mode is what turns the Workbench from a *gatekeeper* into a *service*. Operators get a private place to stress-test their own submission before it hits the formal pipeline. Regulators get fewer poor-quality submissions and cleaner decisions. The quality of the regulatory conversation improves because both sides start further forward.

---

## 22. Submission Readiness Check

### 22.1 The gate

The Submission Readiness Check is a pass/fail gate run by the operator at the end of Phase 1. It passes only when all of the following are true:

| Gate condition | How it's checked |
|---|---|
| All mandatory artefacts present for the classified operation type | Artefact detector (component 3) + baseline (component 0) — no red on AC1 |
| All red and amber items acknowledged with a written rationale from the operator | Each AC/REQ/DTFEA/K flag in the Operator Feedback Report carries an "acknowledged" marker with free-text; empty acknowledgements fail |
| Duty Holder acknowledgement captured | Signed declaration bound to the submission; must be present for DDH/ODH, RAISO where AI is load-bearing, RSO where a range is involved |
| Classification markings consistent | Every document carries a marking; the highest marking in the pack drives handling downstream |
| Submission pinned to a clause-library revision | Revision ID captured at submit; the panel will review against this revision even if the library is updated later |
| No open edits | All artefacts finalised; no draft flags |

### 22.2 What the gate produces

On pass: a **Submission Manifest** — the operator's signed, structured, regulator-ready package. The manifest is what enters Phase 2; the Applicant-mode feedback history does not cross the gate unless the operator opts in.

On fail: a **Readiness Gap List** — itemised, with the specific condition that blocked submission and the minimum action that would clear it. No punitive framing; the failed check is a recoverable state.

### 22.3 Why a formal gate rather than "submit whenever"

Three reasons:

1. **Panel efficiency.** The Phase 2 panel opens a case expecting structure. A free-for-all submission costs panel time to sort.
2. **Accountability snapshot.** The gate freezes the Duty Holder / RAISO acknowledgements at a specific moment. Later changes require a new submission, not a silent edit.
3. **Regression contract.** The gate is the point at which the engine's outputs must be coherent across the three axes — AC coverage, REQ catalogue, DTFEA pillars. If any axis is inconsistent, the gate holds.

---

## 23. Post-decision loop — export, archive, audit, and calibrated improvement

### 23.1 Export & archive (Step 9)

On decision close, the engine emits:

- **Read-only PDF** of the Decision Record (the whole document per §7 and §7.1), classification-marked to the highest element in the pack.
- **Evidence bundle** — the submitted artefacts as they were at the gate in §22, with cryptographic hashes.
- **Deliberation log** — immutable timestamped record of every panel action.
- **Clause-library revision pin** — the exact revision in force at review date, so any future re-read of the decision can reproduce the regulatory baseline.

All artefacts go to the read-only archive on UK sovereign infrastructure. Retention follows the MAA/CAA records schedule plus any specific inquiry-holding requirement.

### 23.2 Calibrated improvement (Step 10)

The continuous-improvement loop has one absolute constraint from the blueprint: **no self-learning in safety decisions**. The engine does not update its own decision logic on the basis of live operational outcomes without explicit human review and configuration-controlled release. In practice:

| Signal | Handling |
|---|---|
| Regulator accepts an AI flag | Logged; feeds calibration statistics (precision/recall of flags) |
| Regulator overrides an AI flag | Logged with panel rationale; triggers a quarterly calibration review if the same override pattern repeats |
| AI misses a defect that only surfaces in live operations | Post-incident review; feeds a candidate new detector (e.g., a new keystone K9) through the clause library / detector change control, not into the model directly |
| Clause or OSO changes publish | Hot-patch to clause library; twin-sample regression re-run before release |
| DTFEA rubric evolves | Annual red-team review; rubric updated under joint MAA/CAA configuration control |
| Drift monitor alerts on any AI component | Named owner investigates; the Workbench's own assurance case is updated |

Calibration audits run against **held-out historical cases** — never live ones. The engine's own AI components carry the same AMLAS posture the engine demands of applicants (§9), and this is itself stress-tested by the red-team probe referenced in the Definition of Done.

### 23.3 Institutional memory

The archive is the memory. Inspectors can retrieve any historical decision and replay the clause-library revision in force at that date. Decisions never silently update; superseded revisions are archived. This guarantees the "consistency across cases" outcome the blueprint promises.

---

## 24. Revised implementation phases (supersedes §10 and §17 where in conflict)

Four new phases are inserted to cover the operator journey, the gate, and Phase 3.

### Phase 0 — Clause library boot *(unchanged)*

### Phase 1 — Ingest + classify *(unchanged)*

### Phase 1b — Baseline configurator (1 sprint)
Component 0. Given operation type, aircraft, airspace, regulator, pulls the relevant clause sub-set. Deliverable: operator-facing workspace wizard.

### Phase 2 — Artefact detector + regulatory mapper *(unchanged)*

### Phase 2b — Requirements catalogue evaluator *(unchanged, v1.1)*

### Phase 2c — Applicant-mode output (Operator Feedback Report + Readiness Dashboard) (2 sprints)
Renders §21.2 from the same engine. Private. Iterable. Passes twin-sample regression at the Applicant-mode level.

### Phase 3 — SORA evaluator *(unchanged)*

### Phase 3b — DTFEA stress-test evaluator *(unchanged, v1.1)*

### Phase 4 — Gap analyser + decision drafter *(unchanged)*

### Phase 4b — Keystone detector hardening *(unchanged, v1.1)*

### Phase 4c — Submission Readiness Check (1 sprint)
Gate logic per §22. Duty Holder signature capture, classification-marking checker, clause-revision pin, manifest producer. Passes twin-sample regression: Scotland gates to Submit; SORA case fails at the Readiness Check stage with a clean gap list.

### Phase 5 — Traceability binder + HITL *(unchanged)*

### Phase 5b — Mode isolation enforcement (1 sprint)
Hard boundary between Applicant and Regulator workspaces per §21.3. Security review gate — no leakage between modes. This is a small-code, high-scrutiny phase.

### Phase 6 — Red-team + calibration + drift monitor *(unchanged)*

### Phase 6b — Post-decision archive & calibration loop (1 sprint)
Phase 3 of the blueprint. Export, archive, clause-library revision pinning, calibration statistics harness. No self-learning.

### Phase 7 — Joint MAA/CAA panel trial *(unchanged)*

**Revised total:** ~18 sprints from zero to first live joint-panel approval (was ~12 in v1.1, ~10 in v1.0).

The increase is not padding — it reflects the blueprint's insistence that the Workbench is a *service* not a *batch tool*. The Applicant-mode UX, the mode-isolation guarantee, and the post-decision loop all carry real implementation weight that v1.0 and v1.1 underestimated.

### 24.1 Hackathon cut (revised)

Target for a hackathon demo:

- Phase 0 (clause library boot) + Phase 1 (ingest/classify) + Phase 1b (baseline configurator) + part of Phase 2 (artefact detector producing AC1 coverage matrix) + a minimal Phase 2c (Operator Feedback Report with readiness gauges).
- Live demo narrative: operator creates workspace → uploads the two samples → sees immediate private feedback → Scotland goes green on the readiness gauges, SORA case lights up red across K1, K2, K3, K7, K8.
- Regulator-mode and Phase 3 are out of scope for the hackathon but represented in the plan as the next natural increment.

---

## 25. Definition of plan-v1.2-complete

Supersedes §19. The plan is ready for implementation when:

- [ ] v1.1 definition of plan-complete (§19) items are all satisfied.
- [ ] The 10-step / 3-phase service blueprint in §20 is accepted as the target user journey.
- [ ] The dual-mode architecture in §21 is agreed — one engine, two UX postures, hard isolation between them.
- [ ] The Submission Readiness Check in §22 is accepted as the formal Phase 1 → Phase 2 gate with its six pass conditions.
- [ ] The post-decision loop in §23 is agreed — *no self-learning in safety decisions* is a hard constraint.
- [ ] The revised ~18-sprint schedule in §24 is resourced, or the hackathon-cut in §24.1 is explicitly accepted as the first-milestone target.

---

*End of v1.2 plan. Implementation begins only after sign-off on §25.*
