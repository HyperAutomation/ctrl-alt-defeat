# SORA Approval Document Generator — Design Plan

**Status:** Draft v1.1 — plan-before-implementation
**Author:** Sentinel (research assistant)
**Date:** 23 April 2026
**Audience:** Hackathon build team; reviewers from MAA RPAS Regulatory Branch and CAA Innovation Hub
**Parent story:** USER_STORY_CAA_MAA_SWARM.md — CAA/MAA Joint Approval Workbench for Live BVLOS Autonomous Swarm Flight Trials

### v1.1 revision history

- **§14** added — Requirements catalogue REQ001–REQ020 (from `requirements.csv`) folded in as a third axis below AC1–AC8.
- **§15** added — DTFEA stress-test pass (Data / Trust / Failure / Evidence / Authority) from `STRESS-Report.md` adopted as a second-axis check on every submission.
- **§16** added — Eight keystone failure-mode detectors hard-coded from the supplied critical-findings list.
- **§4.2, §6, §7, §8, §10, §11** updated to reference the new sections.

---

## 1. Purpose of this document

Design the **approach** — not yet the implementation — for a generator that ingests a SORA / Operating Safety Case submission pack and produces a structured **decision record** (approval OR refusal) aligned to acceptance criteria AC1–AC8 of the parent user story.

The plan is anchored on two reference submissions supplied:

| Sample | Outcome | Why |
|---|---|---|
| `scotland-sample-case.md` (Edinburgh Napier University Operating Safety Case v2.2) | **Would be approved** (under UKPDRA-01, Specific Category, VLOS) | Complete CAP 722A-compliant safety case: named Accountable Manager, qualified remote pilots, SMS aligned to CAP 1059, full emergency procedures library, logbooks, version-controlled change log, traceable references. |
| `sora-safety-case.txt` (CTRL-ALT-DEFEAT — 5x RigiTech Eiger BVLOS swarm, GNSS/C2-denied trial at Spadeadam) | **Would be refused** (as-submitted) | Swarm/BVLOS/autonomy-denied operation declared at SAIL I on SORA v2.0; only 6 of 24 OSOs addressed; no DAA evidence, no swarm-behaviour envelope, no AMLAS/SACE case, no named Duty Holder / RAISO, no C2 link budget. |

The gap between these two submissions — one comprehensively evidenced for a low-risk scenario, one skeletally evidenced for a high-risk scenario — defines the detection surface the generator must cover.

---

## 2. Scope of the generator

### 2.1 In scope

- **Ingest** of a submission pack (markdown, text, PDF, docx) containing any subset of: Operating Safety Case, JARUS SORA package, CONOPS, DAA report, C2 link analysis, swarm-behaviour envelope, AMLAS/SACE assurance case, CAP 1616 airspace-change evidence, Range Safety Case.
- **Classify** the operation (category, airspace, BVLOS/VLOS, autonomy posture, swarm/single, segregated/non-segregated, payload risk including munitions).
- **Coverage-map** each artefact to the relevant regulatory anchor corpus (CAP 722/722A/722B, DEFSTAN 00-970 Part 9, RA 1000/1600/2300 series, JSP 936 Part 1, JARUS SORA v2.5, CAP 1616, AMLAS, SACE, ASTM F3442 / EUROCAE ED-267).
- **Flag** gaps, ambiguity, unresolved hazards, extrapolation beyond the tested envelope, and weak claim-to-evidence traceability.
- **Draft** a structured decision record (approve-with-conditions, refuse-with-reasons, or return-to-applicant-for-clarification) complete with regulatory citations, evidence pointers, ALARP rationale, conditions, and review triggers.

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

### 3.2 SORA case (refuse) — defect families

| Defect family | Specific instances in the sample | Which AC catches it |
|---|---|---|
| Wrong methodology version | SORA v2.0 used; SAIL I declared for swarm BVLOS in C2/GNSS-denied trial | AC2 |
| Missing artefacts | No DAA evidence, no C2 link budget / latency analysis, no swarm-envelope, no AMLAS/SACE case | AC1, AC3, AC4, AC5, AC7 |
| Missing accountability | No named Duty Holder, no RAISO, no Accountable Manager apportionment | AC7, AC8 |
| OSO under-coverage | 6 of 24 OSOs addressed; 18 absent | AC2 |
| Envelope extrapolation | Operational envelope vastly exceeds any tested envelope | AC3, AC5 |

The generator should *not* simply red-flag line items; it should explain the **logic of refusal**.

---

## 4. Architecture of the generator

### 4.1 High-level flow

```
[Submission pack]
        │
        ▼
[1. Ingest & segmentation]   ── (sections, tables, figures, metadata)
        │
        ▼
[2. Operation classifier]    ── (category, airspace, BVLOS, autonomy, swarm, payload)
        │
        ▼
[3. Artefact detector]       ── (OSC, SORA, DAA, C2, swarm env, AMLAS/SACE, CAP1616, Article36)
        │
        ▼
[4. Regulatory mapper]       ── (clause-level coverage matrix, RAG rated)
        │
        ▼
[5. SORA evaluator]          ── (GRC, ARC, SAIL, OSO-by-OSO compliance)
        │
        ▼
[6. Gap & extrapolation analyser]
        │
        ▼
[7. Decision drafter]        ── (approve-with-conditions │ refuse-with-reasons │ return-for-clarification)
        │
        ▼
[8. Evidence traceability binder]
        │
        ▼
[Structured Decision Record + Coverage Matrix + Gap Report]
```

### 4.2 Component responsibilities

> *v1.1 note:* components 5 and 6 now run *two* passes in sequence — (i) regulatory-coverage pass, as originally designed, and (ii) **DTFEA stress-test pass** per §15. Component 7 (decision drafter) consumes both.

**1. Ingest & segmentation.** Accept MD / TXT / PDF / DOCX. Normalise to a sectioned internal representation. Preserve page/paragraph anchors — every later citation must resolve to an original-document coordinate.

**2. Operation classifier.** Extract structured facts from the submission: operator identity; Accountable Manager; Duty Holder; RAISO; aircraft make/model/quantity/MTOM; operation type; airspace; segregated or not; BVLOS/VLOS; autonomy posture; payload (benign / hazardous / weapon-bearing → triggers AOP-15 / Article 36); range and duration; day/night; populated-area overflight; declared category and standard scenario.

**3. Artefact detector.** Check for presence and basic structural adequacy of each required evidence artefact. A binary "present" is not enough — e.g., a DAA section that is three paragraphs long with no sensor specs fails the detector's minimum-content heuristic.

**4. Regulatory mapper.** Uses a configuration-controlled clause library. Every artefact section is linked to the clause(s) it purports to satisfy, and vice versa. Produces a red/amber/green matrix per AC1. Clauses drawn from:

- **CAP 722** — UAS operations in UK airspace (current: v9, Dec 2022)
- **CAP 722A Second Edition** — Operating Safety Cases (Dec 2022)
- **CAP 722B Fifth Edition** — RAE(PC) / BVLOS-relevant sections (2025)
- **CAP 1616** — Airspace Change Process
- **DEFSTAN 00-970 Part 9, Issue 13** — RPAS design & airworthiness
- **RA 1000 / 1600 / 2300 series** — MAA Regulatory Articles
- **JSP 936 Part 1 v1.1** — Dependable AI in Defence (Nov 2024)
- **JARUS SORA v2.5** — 24 OSOs
- **AMLAS (6-stage)** and **SACE (8-stage)** — York / CfAA autonomy assurance
- **ASTM F3442 / EUROCAE ED-267** — DAA technical frameworks
- **AOP-15 and Article 36 (AP I Geneva)** — weapon review

**5. SORA evaluator.** Walks the JARUS SORA v2.5 algorithm end-to-end: verify declared iGRC against population density + MTOM table; verify mitigations M1/M2/M3; derive final GRC and cross-check against declared value; verify ARC derivation and tactical mitigations; derive SAIL from the GRC × ARC grid (refuse auto-green if declared SAIL < derived SAIL); walk all 24 OSOs; flag any robustness level below SAIL requirement.

**6. Gap & extrapolation analyser.** Four checks:

- *Coverage gap* — required artefact or clause missing.
- *Strength gap* — artefact present but evidence too thin to carry the claim.
- *Envelope extrapolation* — operational envelope (altitude, speed, density, duration, number of agents) exceeds the tested envelope.
- *DTFEA failure-mode gap* (v1.1) — submission passes regulatory coverage but fails one or more pillars (Data / Trust / Failure / Evidence / Authority) per §15.

**7. Decision drafter.** Produces one of three outputs:

- **Approve with conditions** — full structured per AC8 with limits, triggers, and signatures block.
- **Refuse with reasons** — enumerates each unresolvable blocker with the clause it breaches.
- **Return for clarification** — applicant-facing list of questions and missing artefacts.

**8. Evidence traceability binder.** Every quantitative claim in the decision record resolves to an evidence artefact, page, and paragraph. No claim without a pointer; no pointer without a claim. **Hard invariant** — the drafter refuses to emit an unsourced quantitative assertion.

### 4.3 Human-in-the-loop markers

Per NFRs in the user story (override-first UI, mandatory panel deliberation on every amber/red flag): the generator never auto-closes amber or red. It produces the draft; the joint panel signs. The tool logs every comment / accept / challenge / override immutably.

---

## 5. Knowledge base construction

The generator is only as good as its clause library. Three indices must be built and kept under joint MAA/CAA configuration control:

| Index | Contents | Source | Update cadence |
|---|---|---|---|
| **Clause library** | Every cited clause, paragraph, or table from the regulatory anchor corpus, with issue/date | CAP 722 family, RA 1000/1600/2300, DEFSTAN 00-970 Pt 9, JSP 936 Pt 1, JARUS SORA v2.5, CAP 1616, AOP-15 | Quarterly MAA/CAA alignment; on-publication hot-patch |
| **Artefact schema** | What a compliant DAA report / swarm envelope / AMLAS case must contain at minimum | CAP 722A §3 & §4, AMLAS/SACE templates, EUROCAE ED-267 §5 | On methodology revision |
| **Requirements catalogue** *(v1.1)* | REQ001–REQ020 — the CAA operational-authorisation-pack requirement set, with per-REQ acceptance gates | `requirements.csv`, extensible by joint MAA/CAA config control | Per programme; version-pinned to submission |
| **DTFEA rubric** *(v1.1)* | 5-pillar stress-test questions (Dana / Trevor / Fiona / Evan / Aria) with severity × confidence scoring | `STRESS-Report.md` methodology | On methodology revision |
| **Historical decision ledger** | Every previous decision record (approve / refuse / return) plus evidence pack and panel deliberation notes | The Workbench itself, with a read-back loop | Continuous; used for calibration audits |

Superseded revisions are archived, not silently updated — per the NFR on traceability.

### 5.1 Version pinning — non-negotiable

The generator tags every clause citation with the publication revision in force on the date of review. Example: a review on 23 April 2026 cites CAP 722A Second Edition (Dec 2022) and RA 2305 Issue 7 (updated 31 Mar 2026). A re-review 12 months later may cite different revisions; the two decision records remain individually coherent.

---

## 6. Mapping AC1–AC8 and REQ001–REQ020 onto generator capability

This is the coverage claim. Each user-story acceptance criterion maps to one or more generator components and produces a named section of the output decision record.

| AC | Requirement | Components | Output section | REQs |
|---|---|---|---|---|
| AC1 | Submission completeness & clause-coverage RAG matrix | 1, 3, 4 | *Coverage Matrix* appendix | REQ001, REQ013, REQ014, REQ016, REQ020 |
| AC2 | SORA ground assessment: GRC / ARC / SAIL / 24 OSOs | 5 | *SORA Evaluation* | REQ002, REQ003 |
| AC3 | DAA evidence with envelope-coverage test | 3, 6 | *Detect & Avoid* | REQ007 |
| AC4 | C2 link, loss-of-link behaviour, swarm-consensus flag | 3, 6 | *Command & Control* | REQ005, REQ006, REQ011 |
| AC5 | Swarm-specific emergent behaviour, containment, live-flight coverage | 3, 6 | *Swarm Behaviour Envelope* | REQ005, REQ008 |
| AC6 | Airspace integration, CAP 1616, NOTAM, e-conspicuity, third-party risk | 4, 6 | *Airspace & Third-Party Risk* | REQ004, REQ013, REQ017, REQ019 |
| AC7 | AMLAS/SACE posture, JSP 936 RAISO sign-off, MHC, ODD | 3, 4 | *Autonomy Assurance Posture* | REQ003, REQ008, REQ009, REQ010 |
| AC8 | Structured decision record with conditions, triggers, signatures, full traceability | 7, 8 | *Decision Record* (the main document) | REQ012, REQ015, REQ018, REQ020 |

This cross-map is load-bearing: AC1–AC8 comes from the user story (what the Workbench must do); REQ001–REQ020 comes from the requirements catalogue (what an operational-authorisation pack must contain). A submission can pass AC1 (all artefacts present) and still fail a REQ (e.g., REQ009 — AMLAS container named but no re-evidencing cycle) — that's exactly the class of defect the v1.0 plan missed and v1.1 closes.

### 6.1 Walkthrough against the two samples

**Scotland sample** (PDRA-01 path)

- **AC1:** Green — all required PDRA-01 artefacts present.
- **AC2:** N/A — UKPDRA-01 standard scenario; full 24-OSO walk replaced by PDRA assurance pack.
- **AC3–AC5:** N/A — VLOS only, single-vehicle, no autonomy.
- **AC6:** Green — Class G/D covered with NSF process where needed.
- **AC7:** N/A — no autonomy.
- **Decision:** **Approve with conditions.**

**SORA case** (Spadeadam swarm trial)

- **AC1:** Red — DAA, C2 link analysis, swarm envelope, AMLAS/SACE all absent.
- **AC2:** Red — SORA v2.5 not used; SAIL declaration incoherent with operation; 18 of 24 OSOs absent.
- **AC3:** Red — DAA envelope not tested.
- **AC4:** Red — loss-of-link is *intentional*; no link budget; no crypto posture; swarm-consensus dependence under GNSS/C2 denial flagged high-risk.
- **AC5:** Red — no emergent-behaviour analysis; no sim-plus-flight coverage matrix; no containment derivation.
- **AC6:** Amber — segregated airspace claimed; NOTAM and TDA not evidenced but plausibly recoverable.
- **AC7:** Red — no AMLAS/SACE case; no RAISO sign-off; no ODD; no MHC concept of use.
- **Decision:** **Refuse** — not curable by panel deliberation; resubmission required with re-derived SAIL.

---

## 7. Output — the decision record

A single structured Markdown document that renders to PDF. Fixed section order so reviewers, Duty Holders, and AAIB readers can find any element without a table-of-contents search.

```
Decision Record — CAA/MAA Joint Approval Workbench
==================================================

0. Front matter
   0.1 Submission ID, applicant, operation title, review date
   0.2 Panel composition and signatures block
   0.3 Classification marking (highest element in pack)

1. Decision
   1.1 APPROVE WITH CONDITIONS │ REFUSE │ RETURN FOR CLARIFICATION
   1.2 One-paragraph rationale in engineering English

2. Operation summary
   2.1 Concept of Operations (machine-extracted, human-verified)
   2.2 Classification: category, SAIL, BVLOS, swarm, autonomy, payload

3. Regulatory basis
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
…
16. DTFEA stress-test matrix
    16.1 Per-pillar maturity % (D / T / F / E / A)
    16.2 Critical / major / minor finding counts
    16.3 Top-20 findings (severity × confidence) with recommendations
    16.4 Keystone failure-mode detector results (§16)
```

Appendices: **E** — Requirements-to-AC cross-reference matrix. **F** — DTFEA findings in full, per-REQ, per-pillar.

---

## 8. Validation strategy — how we prove it works

### 8.1 Twin-sample regression

The two reference submissions are fixtures. Every release of the generator must reproduce: **Scotland → approve-with-conditions** and **SORA case → refuse**. Any drift is a release blocker.

### 8.2 Calibration audits

The historical decision ledger feeds quarterly calibration audits — does the generator's draft match the panel's final decision? Where it diverges, why?

### 8.3 Adversarial samples

A small library of *deliberately defective* submissions — each crafted to trip a specific detector — is run on every release.

### 8.4 Drift monitoring

Track precision/recall against the panel ground truth over time. Falling below thresholds triggers a methodology review.

---

## 9. Phasing

| Phase | Scope | Sprints |
|---|---|---|
| **Phase 1** | Ingest, classifier, artefact detector | 2 |
| **Phase 2** | Regulatory mapper + clause library v1 | 2 |
| **Phase 3** | SORA evaluator (end-to-end SORA v2.5 walk, SAIL cross-check, OSO-by-OSO) | 2 |
| **Phase 4** | Gap analyser + decision drafter (full document) | 2 |
| **Phase 5** | Traceability binder + HITL UX | 1 |
| **Phase 6** *(v1.1)* | DTFEA stress-test pass + 8 keystone detectors | 2 |
| **Phase 7** | Joint-panel pilot + calibration audit instrumentation | 1 |

**Revised total:** ~12 sprints to first live joint-panel approval (was ~10). The extra two sprints buy a much sharper detection surface — and a far more defensible decision record for the refusal case.

---

## 10. Risk register

| Risk | Mitigation |
|---|---|
| Automation bias among inspectors | Override-first UI; mandatory panel deliberation; calibration audits |
| Regulatory drift between MAA and CAA | Shared clause library under joint config control; quarterly alignment |
| Over-reliance on simulation for emergent behaviour | Explicit live-flight coverage matrix; mandatory extrapolation flags |
| Classification handling breach | Class-aware pipeline; marking enforcement; two-person review on downgrade |
| Third-party risk underestimation | CAA FOI review gate on every non-segregated leg |
| Scope creep into MPTF issuance | Generator hard-stops at the draft decision record; signature remains human by design |
| Generator itself is wrong | Twin-sample regression + adversarial fixtures + calibration audits — explicit working assumption that **the AI will sometimes be wrong** |

---

## 11. Open questions — need regulator input before Phase 2

1. What is the authoritative source-of-truth for the clause library — a live CAA/MAA feed, or manually curated under joint configuration control? (Assumed the latter.)
2. How is classification handling reconciled when the generator runs in OFFICIAL-SENSITIVE infrastructure but the pack contains SECRET or STRAP material?
3. Who owns the historical decision ledger — MAA, CAA, or a joint custodian?
4. Acceptance criteria for the calibration audit — what divergence from panel decisions triggers a methodology review?

---

## 14. Requirements catalogue (REQ001–REQ020)

A third axis below AC1–AC8: the operational-authorisation-pack requirement set, version-pinned to the submission under review. Highlights:

- **REQ001** — Operator identity & accountability chain
- **REQ002** — Operation classification (category / SAIL)
- **REQ003** — Hazard register
- **REQ004** — Airspace integration plan
- **REQ005** — C2 architecture, link budget, swarm consensus
- **REQ006** — Loss-of-link behaviours
- **REQ007** — DAA evidence with envelope coverage
- **REQ008** — Swarm behaviour envelope
- **REQ009** — Autonomy assurance container (AMLAS/SACE)
- **REQ010** — RAISO sign-off and MHC concept of use
- **REQ011** — Crypto posture and security
- **REQ012** — Decision record format
- **REQ013** — Third-party risk
- **REQ014** — Document control & change log
- **REQ015** — ALARP demonstration
- **REQ016** — Evidence traceability
- **REQ017** — NOTAM & e-conspicuity
- **REQ018** — Classification custodian & apportionment
- **REQ019** — Environmental impact (noise, species, battery fire)
- **REQ020** — Signatures, conditions and review triggers

A submission can pass AC1 (all artefacts present) and still fail a REQ — that is exactly the class of defect the v1.0 plan missed and v1.1 closes.

---

## 15. DTFEA stress-test pass

### 15.1 The methodology

Every submission, after the regulatory-coverage pass, is run through a five-pillar **DTFEA** stress test:

| Pillar | Persona | Question class |
|---|---|---|
| **D**ata | Dana | Provenance, distribution, drift, labels |
| **T**rust | Trevor | Calibration, explainability, MHC |
| **F**ailure | Fiona | Loss-of-link, sensor failure, swarm-consensus collapse |
| **E**vidence | Evan | Traceability, claim-to-evidence binding, ALARP rationale |
| **A**uthority | Aria | Accountability chain, classification, apportionment |

Working assumption (explicit): **the AI will sometimes be wrong.** This applies to the onboard autonomy, to the applicant's AI, and — importantly — to the generator itself.

### 15.2 Scoring and maturity

Each finding carries a **severity** (critical / major / minor) and a **confidence** (0–10). The per-pillar maturity percentage is a function of: count and severity of findings; coverage of the pillar's question set; traceability of evidence to finding.

---

## 16. Eight keystone failure-mode detectors

Hard-coded, always-on. If any one of these fires critical without explicit panel rationale, the draft decision is **refuse**.

| Detector | Question | Expected evidence |
|---|---|---|
| **K1 — DAA assurance** | Is there a training dataset sheet, calibration ROC, and runtime distributional-shift detector? | DO-365 / F3442 mapping matrix; OOD monitor at runtime |
| **K2 — C2 link budget** | Closed-form link budget across the operating envelope? Crypto posture? | Link analysis with margin; key-management procedure |
| **K3 — Loss-of-link logic** | Per-vehicle and swarm-consensus behaviour table; recovery within tested envelope? | Loss-of-link state machine; tested cases |
| **K4 — Swarm envelope** | Sim + live coverage of collective state space; containment derivation | Coverage matrix; geofencing at agent and swarm level |
| **K5 — Autonomy assurance** | AMLAS/SACE case with ODD, drift monitor, re-evidencing cycle | Stage-by-stage AMLAS pack; SACE phase outputs |
| **K6 — RAISO accountability** | Named RAISO; MHC concept of use at vehicle / swarm / mission layers | JSP 936 Pt 1 sign-off |
| **K7 — Range / airspace** | Segregated airspace evidenced (TDA, NOTAM); third-party risk modelled | NOTAM trace; e-conspicuity plan |
| **K8 — Classification & apportionment** | Signed apportionment naming regulatory ownership per leg, per event-class, per payload-class | Apportionment matrix; classification custodian |

> The Spadeadam SORA case fires **K1, K2, K3, K4, K5, K6, K8** as critical with confidence 9–10. The Edinburgh Napier case fires none.

---

## 17. Updated phasing summary

> Revised total: **~12 sprints** to first live joint-panel approval (was ~10). The extra two sprints buy a much sharper detection surface — and a far more defensible decision record for the refusal case.

---

## 18. Updated risk register (supersedes §10 additions)

See §10 above for the consolidated table. The two additions in v1.1 are: **"Generator itself is wrong"** (mitigated by twin-sample regression, adversarial fixtures, calibration audits) and **"DTFEA pass becomes a checkbox exercise"** (mitigated by rotating personas, periodic methodology revisions, and panel-led red-team weeks).

---

*End of plan v1.1 — ready for Phase-1 sprint planning subject to regulator answers on §11 open questions.*
