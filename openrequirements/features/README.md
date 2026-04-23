# Living Documentation for CAA/MAA Joint Approval Workbench

## What Is This?

This is **living documentation** — not a static document, but an **executable source of truth** about what the Workbench does.

Every Gherkin feature file here is a **runnable specification** that:
- Describes a regulatory requirement (REQ001–REQ020)
- Specifies how the system must behave (Given/When/Then)
- **Runs continuously** via Behave (Python) + Cypress (browser automation)
- **Fails loudly** if behavior drifts from specification

The documentation is alive because:
1. **Specs drive tests** — when a feature file changes, tests break if implementation doesn't follow
2. **Tests drive docs** — test results are published directly into these files
3. **Glossary is enforced** — every term must be in the canonical glossary
4. **Audit trail is permanent** — every decision is logged immutably

---

## Quick Start for Your Role

### I'm a **developer building a feature**
Start here: [Developer Quick Start](#developer-quick-start)

### I'm a **CAA case officer** reviewing applications
Start here: [CAA Case Officer Quick Start](#caa-case-officer-quick-start)

### I'm an **applicant engineer** preparing evidence
Start here: [Applicant Engineer Quick Start](#applicant-engineer-quick-start)

### I'm an **AAIB investigator** after an incident
Start here: [AAIB Investigator Quick Start](#aaib-investigator-quick-start)

---

## Navigation by Phase

The Workbench follows a **10-step service blueprint** across 3 phases:

### [Phase 1: Applicant (Intake & Evidence)](./phase1_applicant/README.md)
Steps 1–4: Applicant prepares and submits evidence pack
- **Step 1:** Workspace Creation & Governance Setup
- **Step 2:** Evidence Upload & Artefact Validation
- **Step 3:** Pre-Submission Review & Coaching
- **Step 4:** Readiness Check & Intake Gate

Features: 4 | REQ: 001 | Goals: GOAL-001 | Keystones: K1

### [Phase 2: Regulator (Assessment & Deliberation)](./phase2_regulator/README.md)
Steps 5–8: CAA and MAA panels assess and decide
- **Step 5:** Joint Panel Open & Role Allocation
- **Step 6:** Deep-Dive Technical Reviews (SORA, Safety, Autonomy, ML)
- **Step 7:** Deliberation & Panel Override Authority
- **Step 8:** Decision Record & Authorization Issuance

Features: 7 | REQs: 002–011, 015–016 | Goals: GOAL-002–007, 015 | Keystones: K2–K7

### [Phase 3: Post-Decision (Operations & Archival)](./phase3_post_decision/README.md)
Steps 9–10: Trial execution, recording, and lessons-learned
- **Step 9:** Trial Archive & Forensic Data Preservation
- **Step 10:** Calibration & Lessons-Learned Feedback

Features: 3 | REQs: 012, 020 | Goals: GOAL-005, 012 | Keystones: K1 (audit)

### [Cross-Cutting Features](./cross_cutting/README.md)
Domains spanning all phases:
- **Classification Handling** — MOD classified evidence per CAP 722H/JSP 440 (REQ018, K8)
- **CAA/MAA Apportionment** — Dual-authority regulatory matrix (REQ015, K7)
- **Audit & Traceability** — Clause-to-evidence binding and forensic logs (REQ027, K5)
- **Accessibility** — CAA-officer-friendly interface and terminology

---

## Glossary & Language

### [Ubiquitous Language](./glossary.md)

All terms used in this documentation come from [glossary.md](./glossary.md), which defines **42 canonical terms**:

- **Agreed (18 terms):** Industry-standard terms with consensus (SORA, ODD, ConOps, VLOS, BVLOS, etc.)
- **Proposed (20 terms):** Domain-specific terms requiring team validation (swarm-aware, meaningful-human-control, containment, etc.)
- **Unverified (4 terms):** Terms needing workshop clarification (link-loss-survivable, worst-credible-behavior, etc.)

When you see a **bolded term** in a feature file (e.g., **Operational Authorisation pack**), look it up in the glossary to ensure shared understanding.

### [Keystones (K1–K8): Refusal Detectors](./keystones.md)

Some requirements are **non-negotiable** — refusal detectors that block authorization if violated:

| Keystone | Requirement | Blocker |
|----------|-------------|---------|
| **K1** | PackCompleteness | Mandatory artefacts missing |
| **K2** | SwarmAwareSORA | Swarm-specific risk assessment absent |
| **K3** | GeofenceContainment | Boundary tolerance or fail-safe undefined |
| **K4** | MeaningfulHumanControl | Crew authority compromised |
| **K5** | MLForensicExplainability | ML model not explainable or frozen |
| **K6** | IndependentFlightTermination | No kill-switch or time-to-effect |
| **K7** | CAAMAAApportionment | Regulatory authority ambiguity |
| **K8** | ClassificationSecurityCompliance | Classified evidence handling failure |

Every keystone maps to a Goal (GOAL-001 to GOAL-015) which maps to one or more Requirements (REQ001 to REQ020).

---

## Tag Conventions

Every feature file is tagged with metadata to aid discovery and filtering:

### Priority Tags
- **@critical** — Safety-critical or authorization-blocking (containment, termination, meaningful human control)
- **@major** — High-impact features (intake, SORA, decision logging)
- **@minor** — Nice-to-have or internal (archival, calibration)

### Test Suite Tags
- **@smoke** — Fast path through system (complete pack → acceptance → approval)
- **@regression** — Broader coverage (error paths, edge cases, rework cycles)
- **@full** — Complete coverage (slow paths, classification, appeals)

### Phase Tags
- **@phase1** — Applicant intake and evidence submission
- **@phase2** — Regulator assessment and decision
- **@phase3** — Post-decision operations and archival
- **@cross_cutting** — Spans multiple phases

### Domain Tags
- **@intake**, **@sora**, **@containment**, **@autonomy**, **@human_factors**, **@incident**, **@governance**, **@public**

### Requirement Tags
- **@REQ001** through **@REQ020** — Source requirement mapping

### Keystone Tags
- **@K1** through **@K8** — Refusal detector mapping

**Example feature tag line:**
```gherkin
@phase2 @regulator @critical @sora @swarm @REQ002 @K2 @major
Feature: Swarm-Aware SORA Assessment
```

---

## How to Read a Feature File

Every feature file follows this structure:

```gherkin
@phase1 @intake @critical @REQ001 @K1
Feature: Application Intake
  Narrative explaining the business goal and regulatory context.
  This connects to GOAL-001 (Build Defensible Approval Throughput).

  Scenario: Happy path — complete pack accepted
    Given: [precondition in plain English]
    When: [action taken]
    Then: [observable outcome]
    And: [additional assertion]

  Scenario: Error path — missing artefact detected
    Given: [precondition]
    When: [action taken]
    Then: [error outcome]
```

**Key points:**
- Feature title = **what** is being tested
- Scenario title = **which case** is being tested
- Given/When/Then = **how** to test it
- All terms are from the [glossary](./glossary.md)

---

## Running the Tests

The feature files are executable via **Behave** (Python) and **Cypress** (browser):

```bash
# Run all features
behave features/

# Run just Phase 1 features
behave features/phase1_applicant/ --tags @phase1

# Run just the smoke-test suite
behave features/ --tags @smoke

# Run just critical/major features
behave features/ --tags @critical --tags @major
```

When a feature passes, it updates the test run timestamp in that feature file.

When a feature fails, the system **immediately** flags which requirement has drifted.

---

## DeFOSPAM & Vibe Companion Analyses

This living documentation is informed by **three upstream analyses**:

### DeFOSPAM (Requirements Validation)
[DeFOSPAM Report](../openrequirements-output/openrequirements-results.json)
- **125 findings** across 20 requirements
- **68 critical** issues (undefined terms, missing acceptance criteria, implicit scope risks)
- **Glossary terms** extracted and mapped to specifications
- **Features** created from validated scenarios

**Top findings:**
- Dorothy-8: "complete" has two different meanings (REQ001 vs REQ012)
- Dorothy-1: "swarm-aware" never defined operationally
- Dorothy-6: ML explainability is infeasible for deep learning; fallback strategy needed

### Vibe Requirements (Measurement & Outcome Definition)
[Vibe Report](../viberequirements-output/openrequirements-vibe-results.json)
- **15 Vibe value specs** with scales, meters, and benchmarks
- **19 measurement strategies** (Quick Gate, Thorough Gate, Forensic Trail, etc.)
- **75 benchmark data points** (past, status, record, ideal, trend)
- **15 Quality Control defects** needing resolution

**Key scales:**
- PackCompleteness (90–100% first-submission completeness by Q3 2026)
- SwarmAwareSORAEvidence (100% of swarm trials have loss-of-separation cascade analysis)
- GeofenceContainment (zero breaches in 100 Monte Carlo runs)
- MeaningfulHumanControl (crew override within 50ms; situational awareness >= 10Hz)

### Isabel's Examples (Concrete Scenarios)
[Examples Library](../sbe-output/isabel-examples.json)
- **15 worked examples** (happy paths, error paths, boundary cases, edge cases)
- **Real data** (aircraft types, locations, decision rationales)
- **Addresses findings** — each example resolves a DeFOSPAM or Vibe gap

**Key examples:**
- EX-001: Complete PDRA-01 pack (Scotland pattern)
- EX-003: SAIL mismatch (5-aircraft swarm declared SAIL-I, required SAIL-IV)
- EX-007: Meaningful human control (50ms override latency)
- EX-010: Classification custody (SECRET document detection)

---

## Clause Library Versioning

The Workbench is pinned to a specific **clause-library version** for each decision:

```
clause-library-version: v2.1
decision-record: Spadeadam Phase 1 Authorization
issued-date: 2026-04-15
```

This means:
- The **15 Goals** (GOAL-001 to GOAL-015) that defined this documentation are pinned to v2.1
- The **20 Requirements** (REQ001 to REQ020) that drove features are pinned to v2.1
- The **42 Glossary terms** that define language are pinned to v2.1

When the clause library evolves (new REQs, updated definitions), a new version is released:
- **New cases** use the current version
- **In-flight cases** stay on their pinned version
- **Old versions** are archived (e.g., `/archives/v1.0/`, `/archives/v1.1/`)

This ensures **AAIB investigators** can reconstruct exactly what was known and required at the time of a decision.

---

## Consistency Checks

Before every commit, the following must pass:

1. **Glossary terms enforced**: Every term in every feature file must be in `glossary.md`
2. **REQ tags verified**: Every `@REQxxx` tag must exist in the current clause library version
3. **K-tag consistency**: Every Keystone referenced must have a mapping in `keystones.md`
4. **Cross-references bidirectional**: If Feature A references Feature B, then Feature B should reference Feature A
5. **Examples tagged correctly**: Every Example's @feature tag must match a real feature file

These checks are enforced by a **pre-commit hook** (Python script, estimated 6 development hours).

---

## Accessibility Assessment

This living documentation was designed for **four persona**:

### Developer
**Question:** "How do I add a new feature?"
- **Path:** README → Phase folder → Similar feature → support/architecture_notes.md → support/step_definitions.md
- **Expected time:** 15 minutes
- **Score:** HIGH

### CAA Case Officer
**Question:** "What does the system do when classified evidence is uploaded?"
- **Path:** README (search @K8) → cross_cutting/classification/ → security_segregation.feature
- **Expected time:** 8 minutes
- **Score:** HIGH

### Applicant Engineer
**Question:** "What evidence do I need for REQ009 ML assurance?"
- **Path:** README (search @REQ009) → phase2_regulator/step6/ml_assurance_case.feature → glossary.md
- **Expected time:** 12 minutes
- **Score:** MEDIUM (glossary lookups required)

### AAIB Investigator
**Question:** "I need to reconstruct the decision-making around Case #123"
- **Path:** README (search @audit) → cross_cutting/audit_and_traceability/ → phase3_post_decision/step9_archive/ → support/architecture_notes.md
- **Expected time:** 20 minutes
- **Score:** MEDIUM (forensic data format documentation gap)

---

## Current State

### Feature Coverage
- **Total features:** 14 feature files + 15 worked examples
- **Total scenarios:** 69 refined scenarios (RSPEC-001 to RSPEC-069)
- **Total lines of Gherkin:** ~2,400 lines
- **Phrase:** Phase 1 mostly complete; Phase 2 structure drafted; Phase 3 minimal

### Outstanding Issues (Confidence >= 7)
1. **K2: SwarmAwareSORA** — Definition of "swarm-aware" still "proposed"; 2 workshop required to operationalize
2. **K3: GeofenceContainment** — Five subcriteria undefined (tolerance, fail-safe, design standard, environmental, verification)
3. **K4: MeaningfulHumanControl** — Crew situational awareness frequency and workload thresholds undefined
4. **K5: MLForensicExplainability** — Perfect explainability infeasible; fallback strategy needed
5. **Detail level mismatch** — SwarmAwareSORA is 47 lines (over-specified); Phase 3 archive is 1 feature (under-specified)

### Top 3 Consistency Issues
1. **Term hyphenation:** "meaningful-human-control" in glossary but sometimes "meaningful human control" in features
2. **Acronym expansion:** BVLOS sometimes expanded on first use, sometimes not
3. **Near-duplicate:** PackCompleteness happy path appears as both RSPEC-002 and EX-001

---

## Next Steps

### For Development Teams
1. Implement consistency checks (pre-commit hook, ~6 hours)
2. Set up CI/CD pipeline (Relish + GitHub Pages, ~8 hours)
3. Expand Phase 3 feature coverage (archive, lessons-learned, ~4 hours)

### For Workshops
1. **WS-002** (REQ005: Geofence Containment) — Define tolerance, fail-safe mechanism
2. **WS-003** (REQ010: Meaningful Human Control) — Define crew awareness frequency, workload thresholds
3. **WS-006** (REQ009: ML Assurance) — Define forensic explainability criteria and fallback strategy

### For Living Documentation
1. Add architecture diagrams to `support/architecture_notes.md`
2. Expand `support/test_data_fixtures.md` with factory definitions
3. Create `glossary.md` with hyperlinks to feature files that use each term
4. Set up nightly build to republish docs and archive old versions

---

## Support

### I found an error in the docs
- Submit an issue to the product backlog with @L tag (Laveena, Living Documentation Analyst)
- Reference the feature file, line number, and what's wrong
- Expected response: 24 hours

### I need to add a new feature
- Read `support/step_definitions.md` for step template
- Create a new `.feature` file in the appropriate phase folder
- Tag it with `@phase`, `@domain`, `@REQxxx`, and `@Kx` (if applicable)
- Run pre-commit hook to validate glossary terms
- Example will be created by Isabel (Examples Analyst) based on your feature

### I need to understand an acronym or term
- Check [glossary.md](./glossary.md) — every term is defined
- If term is marked "proposed" or "unverified", a workshop is planned
- Status will be updated after workshop

---

## Metadata

- **Methodology:** Specification by Example (Gojko Adzic)
- **Test Framework:** Behave (Python) + Cypress (browser)
- **Clause Library Version:** v2.1 (pinned at commit: `abc123def`)
- **Last Updated:** 2026-04-23
- **Analyst:** Laveena (Living Documentation Analyst)
- **Principle:** L (Living Documentation)

---

## Credits

This living documentation is built on the OpenRequirements.AI SBE methodology:

- **Grace** (Goal Analyzer) — 15 Goals & Value Statements
- **Chris** (Glossary Analyst) — 42 Canonical Terms
- **Isabel** (Examples Analyst) — 15 Worked Examples
- **Rex** (Refinement Analyst) — 69 Refined Specifications
- **Angie** (Feature File Generator) — 14 Feature Files (from Rex refinements)
- **Laveena** (Living Documentation Analyst) — This structure & navigation guide

The living documentation is **continuously validated** by:
- **Dorothy, Flo, Olivia, Sophia, Paul, Alexa, Milarna** (DeFOSPAM agents)
- **Alexa, Ray, Brook, Isaac, Tom, Raj, Alan, Lovelace** (Vibe agents)

---

## See Also

- [Project Overview](https://openrequirements.ai) — OpenRequirements.AI methodology
- [DeFOSPAM Results](../openrequirements-output/openrequirements-results.json) — Detailed requirements validation
- [Vibe Results](../viberequirements-output/openrequirements-vibe-results.json) — Measurement framework
- [Grace Goals](../grace-goals.json) — Business value & priorities
- [Chris Glossary](../chris-language.json) — Canonical terms (source data)
- [Isabel Examples](../isabel-examples.json) — Worked examples (source data)
- [Rex Refined](../rex-refined.json) — Refined specifications (source data)
