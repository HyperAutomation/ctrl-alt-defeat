# User Story — CAA/MAA Joint Approval Workbench for Live BVLOS Autonomous Swarm Flight Trials

**Status:** Draft for hackathon / backlog seed
**Author:** Sentinel (research assistant)
**Audience:** UK MAA RPAS Regulatory Branch · MAA-CTS · CAA Airspace, ATM & Aerodromes · CAA Flight Operations Inspectorate · CAA Innovation Hub · Duty Holders · Range Safety Authorities
**Compiled:** April 2026

---

## Story

> **As** a Lead Inspector in the UK Military Aviation Authority's RPAS Regulatory Branch — sitting on a joint review panel with CAA Airspace, ATM & Aerodromes (AAA) and Flight Operations Inspectorate counterparts — responsible for granting or refusing a Military Permit to Fly (MPTF) and the associated Flight Trials Instruction for a Beyond Visual Line of Sight (BVLOS) autonomous swarm of uncrewed air systems operating across both segregated Danger Area airspace and non-segregated corridors,
>
> **I want** an assurance-grounded joint Approval Workbench that (a) ingests the applicant's safety case, JARUS SORA package, SACE- or AMLAS-aligned autonomy assurance case, Detect and Avoid (DAA) evidence, command-and-control (C2) link analysis, swarm-behaviour envelope, and CAP 1616 airspace change artefacts, (b) cross-checks the submission against the RA 1000 / 1600 / 2300 series, DEFSTAN 00-970 Part 9, CAP 722 / 722A / 722B, JSP 936 Part 1, and AOP-15 / Article 36 where munitions are carried, (c) flags residual risks, unresolved hazards, extrapolation beyond the flight-tested envelope, and weak traceability from claim to evidence, and (d) produces a structured decision record with conditions, operating limits, review triggers, and rationale captured in engineering English,
>
> **So that** I can issue — or defensibly refuse — an MPTF for the live BVLOS swarm trial with confidence that ALARP has been demonstrated, Meaningful Human Control and Duty Holder accountability are intact, third-party airspace users and the public below are not exposed to unacceptable risk, and a transparent audit trail is available to the Release to Service Authority, the Defence Aviation Safety Board, Ministers, and — should it be needed — any future Service Inquiry or AAIB investigation.

---

## Context

Autonomous swarm flight trials sit in the awkward intersection between three unsettled regulatory regimes: BVLOS in non-segregated airspace (CAA, CAP 722B), RPAS airworthiness and flight test (MAA, RA 1600 / RA 2335 series), and AI/autonomy assurance (JSP 936 Part 1, AMLAS, SACE). No single rulebook covers a swarm cleanly. Approvals today are bespoke, slow, and consume senior-inspector bandwidth that the UK has too little of — particularly with the Protector RG Mk1 transition, GCAP/Tempest early airframe work, and Project Alvina's attritable-mass experimentation all converging through 2026–2028. A joint MAA/CAA Approval Workbench is the natural place to institutionalise this emerging practice — not to automate the regulator out of the loop, but to give them clause-level coverage, evidence traceability, and a defensible record at speed.

## Personas

- **Primary — MAA Lead Inspector, RPAS Regulatory Branch.** Chairs the joint review panel; signs the decision record; accountable upward to the MAA Regulator.
- **Co-Primary — CAA Inspector (AAA + Flight Operations Inspectorate).** Assesses airspace integration, third-party risk, CAP 1616 evidence; co-signs on any non-segregated leg.
- **Secondary — Delivery Duty Holder (DDH) / Operating Duty Holder (ODH).** Owns residual safety risk once the Permit is issued; acknowledges conditions.
- **Secondary — RAISO (JSP 936 Part 1 accountable officer).** Accountable for the AI-assisted decision-making onboard the swarm.
- **Secondary — Range Safety Officer (e.g. Aberporth / West Wales UAS Environment, Hebrides Range, Boscombe Down).** Owns live trial execution on the day.
- **Secondary — Independent Technical Advisor (MAA-CTS, QinetiQ at Boscombe Down, DAIC).** Provides specialist advice on autonomy and assurance claims.

## Scope

**In scope:** Ingestion of submission pack, clause-level cross-check against regulatory anchors, gap and ambiguity flagging, AI/autonomy assurance posture review, DAA evidence assessment, swarm envelope and emergent-behaviour challenge, airspace and third-party risk review, drafting of a structured decision record with conditions and review triggers.

**Out of scope:** Issuing the MPTF itself (the signature is a human regulator act, not a system action); any autonomous clearance of live flight; any displacement of Duty Holder accountability or RAISO sign-off; automated redaction of safety evidence; cross-border approvals outside UK sovereign airspace.

---

## Acceptance Criteria

Written in Given / When / Then form so they can be lifted directly into a backlog or a specification-by-example workshop.

### AC1 — Submission completeness and clause coverage

**Given** a swarm BVLOS flight trial submission pack,
**When** it is uploaded to the Workbench,
**Then** the system shall (a) identify each required artefact — safety case, SORA, DAA report, C2 link report, swarm-behaviour envelope, airspace change evidence (CAP 1616), AMLAS/SACE autonomy assurance case, Range Safety Case, Article 36 review where weapons are carried, (b) map each artefact to the relevant clauses of the RA 1600 / 2300 series, DEFSTAN 00-970 Part 9, and CAP 722 / 722A / 722B, and (c) produce a red / amber / green coverage matrix with explicit pointers to evidence pages and paragraph numbers.

### AC2 — SORA / operational risk ground assessment

**Given** a JARUS SORA v2.5 package,
**When** the joint panel opens the risk review,
**Then** the Workbench shall verify: Ground Risk Class (GRC), Air Risk Class (ARC), mitigations M1 through M3, strategic and tactical mitigations, derived Specific Assurance and Integrity Level (SAIL), and each of the 24 Operational Safety Objectives (OSOs). Any unmet or partially met OSO shall be flagged for explicit panel deliberation with a mandatory written rationale before any green rating can be issued.

### AC3 — Detect and Avoid (DAA) evidence

**Given** the submitted DAA evidence pack,
**When** it is reviewed,
**Then** the Workbench shall assess (a) sensor performance under declared operational conditions (weather, lighting, cooperative vs non-cooperative intruders), (b) tested closure geometries vs the declared BVLOS corridor, (c) the Well Clear volume applied and its derivation, and (d) compliance with ASTM F3442 / EUROCAE ED-267 frameworks where claimed. The system shall refuse any automatic green rating when the tested DAA envelope does not fully enclose the operational envelope, and shall explicitly surface the uncovered region to the panel.

### AC4 — Command and control link and loss-of-link behaviour

**Given** a C2 link report covering the full swarm and its ground control segment,
**When** it is reviewed,
**Then** the Workbench shall verify link budget, end-to-end latency, resilience under RF interference and GNSS denial, authentication and cryptographic posture, and the declared loss-of-link behaviours at both individual-vehicle and swarm level (return-to-base, orbit-and-wait, autonomous land, flight termination). Any loss-of-link behaviour that depends on continued swarm-level consensus after link loss shall be flagged as high-risk and shall require explicit panel challenge before approval.

### AC5 — Swarm-specific: emergent behaviour, cohesion, and containment

**Given** a declared swarm behaviour envelope covering inter-vehicle separation, collective manoeuvre rules, task-allocation algorithm, and degraded-member fallback,
**When** it is reviewed,
**Then** the Workbench shall require (a) simulation coverage across pertinent stress cases (communications degradation, single- and multiple-vehicle loss, sensor failure, adversarial spoofing), (b) live flight-test coverage with instrumented runs, (c) containment (geofencing) enforcement at both individual-vehicle and swarm level, and (d) explicit emergent-behaviour analysis showing that the swarm's collective state space — not only the individual agent's — has been explored. Any proposed trial segment that extrapolates beyond the explored envelope shall trigger a mandatory panel decision with a recorded rationale.

### AC6 — Airspace integration and CAP 1616 evidence

**Given** a proposal to operate over non-segregated airspace, or to transit between segregated and non-segregated airspace,
**When** it is reviewed,
**Then** the Workbench shall verify the CAP 1616 airspace change evidence (where required), NOTAM coverage and lead time, electronic conspicuity provisions (transponder mode, ADS-B Out, Remote ID), Temporary Danger Area / Temporary Reserved Area applications and their validity windows, and the third-party risk assessment covering overflight of inhabited areas, roads, and critical infrastructure. The Workbench shall flag any proposed leg that exceeds the authorised volume, altitude, or timing and shall prevent a green rating on that leg until reconciled.

### AC7 — AI / autonomy assurance posture

**Given** the onboard autonomy stack (perception, planning, multi-agent reinforcement learning, classical control) and the offboard swarm-orchestration stack,
**When** it is reviewed,
**Then** the Workbench shall (a) verify an AMLAS- or SACE-aligned assurance case with documented Operational Design Domain (ODD), training and validation data provenance, drift-monitoring plan, and residual-risk claims, (b) cross-check evidence of JSP 936 Part 1 RAISO sign-off, (c) confirm that the Meaningful Human Control concept of use is explicit at vehicle, swarm, and mission layers, and (d) flag any autonomy function whose worst-case failure mode has not been bounded to an explicit SACE-defined severity band. The Workbench shall not close out AC7 where any of these are absent.

### AC8 — Decision record, conditions, and review triggers

**Given** that panel deliberation is complete,
**When** the Lead Inspector closes the review,
**Then** the Workbench shall produce a structured decision record containing: the regulatory basis, the evidence relied upon, the residual risks and their ALARP justification, the approval conditions (for example: weather minima, day-only vs day-and-night, maximum simultaneous airborne agents, airspace volume, payload constraints, crew qualifications), the review triggers that require panel reconvening (any loss-of-link event, any containment breach, any weather deviation outside the declared envelope, any software update affecting autonomy), and the signatures required (MAA Lead Inspector, CAA co-signer where applicable, Duty Holder acknowledgement, RAISO acknowledgement where AI functions are load-bearing). Every quantitative claim in the record shall be traceable to an underlying evidence artefact, page, and paragraph.

---

## Non-Functional Requirements

- **Traceability.** Every regulatory clause cited shall resolve to the authoritative MAA/CAA publication revision in force on the date of review; superseded revisions are archived, not silently updated.
- **Audit.** Every panel member action — comment, accept, challenge, override — is logged immutably with timestamp, identity, and rationale; export as a read-only PDF on close.
- **Classification.** Submission packs may contain UK OFFICIAL-SENSITIVE, SECRET, and occasionally STRAP material; storage, handling, and display shall match the highest element in the pack, with no cross-classification egress.
- **Latency.** Clause-coverage matrix available within 10 minutes of submission upload; AI-assisted narrative flags within 30 minutes; full workbench open-and-review cycle shall not require more than two working days for a representative swarm submission.
- **Explainability.** Every automated flag shall explain the rule that fired, the evidence it drew on, and the regulator's next action in plain engineering English — never in model internals.
- **Accessibility.** WCAG 2.2 AA for the inspector-facing UI; reasonable-adjustments profile available for screen reader and high-contrast use.
- **Resilience.** Workbench unavailability shall never block an in-progress live trial; any live-trial conditions are issued and tracked out-of-band via the Range Safety Case.
- **Data sovereignty.** All submission data held on UK sovereign infrastructure; no cloud egress without explicit authorisation.

## Assurance Anchors

- **RA 1000 series** — MAA Regulatory Principles; the Duty Holder construct (RA 1020).
- **RA 1600 series** — RPAS airworthiness, operation, and training.
- **RA 2325 / RA 2335** — Flight Test Permits and Flight Test and Evaluation.
- **DEFSTAN 00-970 Part 9** — Design requirements for RPAS.
- **CAP 722 / 722A / 722B** — UAS operations in UK airspace; operating safety cases; BVLOS.
- **CAP 1616** — Airspace Change Process.
- **JARUS SORA v2.5** — Specific Operations Risk Assessment (24 Operational Safety Objectives).
- **JSP 936 Part 1 (Nov 2024)** — Dependable AI in Defence; RAISO accountability.
- **AMLAS (6-stage) / SACE (8-stage)** — AI/ML and Autonomy assurance methodologies (University of York, Centre for Assuring Autonomy).
- **ASTM F3442 / EUROCAE ED-267** — DAA technical framework references.
- **AOP-15** — Where weapons are carried on the swarm.
- **Article 36 (Additional Protocol I to the Geneva Conventions)** — Where a weapon system is being tested.

## Definition of Done

- [ ] Acceptance criteria AC1–AC8 demonstrated end-to-end on a representative BVLOS swarm submission.
- [ ] A live joint MAA/CAA panel has completed at least one approval using the Workbench without falling back to manual workflow.
- [ ] Decision record accepted by the relevant Duty Holder without rework on structure or traceability.
- [ ] Independent assurance review (MAA-CTS or CAA Innovation Hub) has signed off the Workbench's own assurance case — the tool itself has been assured.
- [ ] Independent red-team probe for automation bias, evidence-fabrication, classification leakage, and prompt-injection completed; findings remediated or formally accepted.
- [ ] Drift monitoring on the Workbench's own AI components in place with owner assigned.
- [ ] UNCLASSIFIED lessons-learned note published for the wider UK aviation regulatory community.

## Related Stories / Epic Candidates

- **Single-vehicle BVLOS variant.** Same workbench pattern applied to individual-vehicle BVLOS approvals — e.g. Protector transit approvals between Waddington and North Sea ranges.
- **Urban BVLOS logistics variant.** Extension to urban drone logistics and medical delivery with heightened third-party risk and CAP 722C considerations.
- **Coalition swarm variant.** AUKUS / NATO coalition swarm trials requiring coordinated approval across multiple national regulators.
- **Maritime uncrewed variant.** Sister workbench applied to MCA and MAA Light Blue approvals for XLUUV and USV trials under the MASS Code of Practice.

## Risks and Mitigations

- **Automation bias among inspectors.** Mitigate with override-first UI, mandatory panel deliberation on every amber/red flag, periodic calibration audits against held-out historical cases.
- **Regulatory drift between MAA and CAA positions.** Mitigate with a shared clause library under joint configuration control and quarterly MAA/CAA alignment review.
- **Over-reliance on simulation evidence for swarm emergent behaviour.** Mitigate with an explicit live-flight coverage matrix and mandatory extrapolation flags.
- **Classification handling breach.** Mitigate with a classification-aware data pipeline, clear marking enforcement on exports, and mandatory two-person review for any downgrade action.
- **Third-party risk underestimation in non-segregated airspace.** Mitigate with a CAA Flight Operations Inspectorate review gate on every non-segregated leg and an explicit public-safety rationale in the decision record.
- **Scope creep into MPTF issuance.** Mitigate by designing the Workbench to stop at the draft decision record — the signature remains human, by design.
