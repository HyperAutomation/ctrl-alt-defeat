# Living Documentation: Feature Files Index

## Royal Navy USV Perception T&E — Specification by Example (SBE)

Welcome to the **living documentation** for the PSRQ (Perception Stack Robustness Qualification) 7-phase evaluation framework. This index guides users to relevant features, scenarios, and evidence across the Royal Navy USV autonomous perception programme.

---

## Structure Overview

Features are organized by PSRQ phase (1–7) and AMLAS assurance activity. Each phase directory contains Gherkin `.feature` files with examples, refined specifications, and traceability links.

| Phase | Directory | AMLAS Activity | Key Requirements | Sample Feature Count |
|-------|-----------|----------------|------------------|----------------------|
| **Phase 1** | `01-requirements-decomposition/` | Activity 1: Planning & Specification | REQ-001, REQ-002 | 2 |
| **Phase 2** | `02-data-curation/` | Activity 2: Data Specification & Curation | REQ-002, REQ-003 | 2 |
| **Phase 3** | `03-model-evaluation/` | Activity 3: Model Testing & Robustness | REQ-004, REQ-005, REQ-006, REQ-007 | 4 |
| **Phase 4** | `04-system-evaluation/` | Activity 4: System Testing | REQ-008, REQ-009 | 2 |
| **Phase 5** | `05-physical-validation/` | Activity 5: Operational Validation | REQ-010 | 1 |
| **Phase 6** | `06-safety-case/` | Activity 6: Evidence & Assurance Case | REQ-011, REQ-012 | 2 |
| **Phase 7** | `07-in-service-monitoring/` | Post-Deployment Monitoring | REQ-013, REQ-014 | 2 |
| **Cross-Cutting** | `15-cross-cutting/` | Governance, Access Control, CI/CD | REQ-015, REQ-016 | 2 |

---

## Quick Navigation by Role

### I'm a T&E Engineer — where do I start?
1. Read `01-requirements-decomposition/README.md` — understand ODD decomposition and test condition atoms.
2. Explore `02-data-curation/` — real sensor logs and synthetic augmentation.
3. Jump to `04-system-evaluation/` — scenario design and HIL testing.
4. Reference: `docs/role-guides/te-engineer-path.md`

### I'm a Safety Engineer — I need to verify AMLAS compliance
1. Start with `docs/amlas-activity-index/index.md` — cross-reference all 6 activities.
2. For Activity 3 (robustness): `03-model-evaluation/REQ-005-adversarial-robustness.feature`
3. For Activity 6 (safety case): `06-safety-case/REQ-011-evidence-bundle.feature`
4. Reference: `docs/role-guides/safety-engineer-path.md`

### I'm a Legal Reviewer (Article 36)
1. Navigate to `06-safety-case/REQ-012-article-36-export.feature`
2. Review: `docs/glossary/` entry for "Article 36" with linked evidence artifacts
3. Reference: `docs/role-guides/legal-reviewer-path.md`

### I'm looking for a specific scenario (e.g., "Sea State 5 fog adversarial")
1. Use `docs/scenario-search/index.html` — filter by ODD tags (@sea-state-5, @visibility-low, @adversarial)
2. Or search glossary backlinks: `docs/glossary/glossary.md#fog` → lists all features using "fog" terminology
3. Or query AMLAS activity: `docs/amlas-activity-index/` → find which activity covers adversarial robustness

---

## How to Run / Execute Features

### Using Cucumber (Gherkin) Runner
```bash
# Install dependencies
gem install cucumber

# Run all features
cucumber features/

# Run specific phase
cucumber features/01-requirements-decomposition/

# Run with tags (e.g., all Phase 3 robustness tests)
cucumber features/ --tags @phase-3 --tags @adversarial-robustness
```

### Using Pickles (Living Documentation Generator)
```bash
# Generate HTML living docs from features
pickles features/ -o ./living-docs-html

# Open in browser
open ./living-docs-html/index.html
```

### Using LivingDoc (Alternative)
```bash
# Generate LivingDoc report
livingdoc publish features/ -o ./livingdoc-output
```

---

## File Naming Convention

Features follow the pattern: `REQ-[number]-[descriptor].feature`

Examples:
- `REQ-001-ODD-decomposition.feature` — Phase 1, requirements decomposition
- `REQ-005-adversarial-robustness.feature` — Phase 3, adversarial robustness testing
- `REQ-012-article-36-export.feature` — Phase 6, legal compliance

---

## Consistency & Terminology

All features use **ubiquitous language** defined in `chris-language.json` (55 agreed terms).

**Key Terms:**
- **ODD**: Operational Design Domain (declared conditions under which USV operates safely)
- **AMLAS**: Assurance of Machine Learning for use in Autonomous Systems (6-activity framework)
- **evidence bundle**: Complete AMLAS-compliant deliverable (GSN + traceability + test results + bounds)
- **robustness bound**: Certified resilience bounds under adversarial perturbations (per object class & sensor modality)

For full glossary, see `docs/glossary/glossary.md`.

---

## Traceability & Evidence Linkage

Each feature links to:
- **Requirements** (grace-goals.json) — business goals & acceptance criteria
- **Examples** (isabel-examples.json) — concrete test scenarios with data
- **Refined Specs** (rex-refined.json) — refined Given/When/Then with improved precision
- **Test Evidence** (test results, robustness certificates, model cards) — AMLAS activity artifacts

Example trace: `REQ-005 (business goal) → REF-007 (refined spec) → EX-015 (example) → 03-model-evaluation/REQ-005-adversarial-robustness.feature (executable spec) → [test results] → evidence bundle`

---

## Accessibility & Discovery

### ODD Coverage Matrix
Visualize test coverage across visibility, sea-state, illumination, sensor modes:
```
docs/odd-coverage-heatmap/index.html
```
Interactive: click a cell (e.g., "Sea State 5, Visibility < 50m, Radar+Visual") → see all scenarios covering that condition.

### Scenario Search & Registry
Searchable catalog of 28 scenarios with tag filtering:
```
docs/scenario-search/index.html
```
Filter by: @phase-X, @severity, @odd-dimension, @amlas-activity

### Glossary Backlinks
For any term, see which features & examples use it:
```
docs/glossary/glossary.md → [term] → "Used in: REQ-005, REQ-006, EX-015"
```

---

## Evolution & Maintenance

### Adding a New Feature
1. Create new file in appropriate phase directory: `features/0N-phase/REQ-XXX-descriptor.feature`
2. Write Gherkin scenarios using terms from `chris-language.json`
3. Link to requirements (grace-goals.json), examples (isabel-examples.json), refined specs (rex-refined.json)
4. Commit with message: `feat(REQ-XXX): Add feature description`
5. CI/CD pipeline validates:
   - Gherkin syntax (Cucumber)
   - Terminology consistency (regex vs. chris-language.json)
   - Traceability completeness (requirement → feature → evidence)
   - Generates living docs (Pickles)

### Updating Glossary
Edit `chris-language.json`, commit with `docs(glossary): ...` message. CI/CD regenerates `docs/glossary/glossary.md` with backlinks.

### Deprecation
Mark outdated features with `@deprecated` tag. CI/CD warns on use; removed after 2-week sunset.

---

## Key Contacts & Governance

| Role | Approver |
|------|----------|
| **Phase Owner** (each PSRQ phase) | T&E Lead / Dstl |
| **Glossary Custodian** | Safety Lead |
| **AMLAS Evidence Lead** | York CfAA / DAIC |
| **Classified Data Access** | Dstl Autonomy Lab |

---

## Reports & Artifacts

- **Consistency Report**: `docs/consistency/consistency-report.md` (updated per CI/CD run)
- **AMLAS Activity Index**: `docs/amlas-activity-index/index.md` (cross-phase traceability)
- **ODD Coverage Heatmap**: `docs/odd-coverage-heatmap/coverage-matrix.csv` (ODD state coverage %)
- **Scenario Registry**: `docs/scenario-search/scenarios.json` (searchable catalog)

---

## Support & Questions

For issues, suggestions, or new features:
- **T&E Process**: Open issue in `features/` directory with `[PHASE-X]` prefix
- **Terminology**: Propose new term with issue `[GLOSSARY-NEW-TERM]`
- **CI/CD / Evolution**: Contact DevOps Engineer with `[PROCESS]` prefix

---

**Last Updated**: 2026-04-22 | **Version**: SBE-Phase-3 (Laveena Living Documentation Analyst)
