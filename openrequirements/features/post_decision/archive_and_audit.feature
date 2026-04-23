# Feature: Post-Decision Archive & Audit Trail
# Business Goal: GOAL-005 Enable Incident Investigation & Regulatory Closure
# Complete evidence preservation for post-incident investigation and regulatory audit

@post_decision @F28 @REQ020 @GOAL-005 @GOAL-012
Feature: Post-Decision Archive & Case History Management
  As a CAA records officer and AAIB investigator
  I want to preserve complete case archives with immutable decision records
  So that post-incident investigations and regulatory audits have forensic evidence

  Background:
    Given trial has completed all authorized phases
    And case status is CLOSED or AWAITING_CLOSURE
    And CAA Secure Archive (Google Cloud Storage, geo-redundant, 10-year retention) is operational
    And archival process initiated within 30 days of trial closure

  @critical @smoke
  Scenario: Complete post-trial archival package generation
    Given Spadeadam trial Phase 1 + Phase 2 complete
    And all Phase 1 flights successful (no Mandatory Occurrence Reports)
    And Phase 2 approved and concluded on 2026-06-15
    When archival process triggered
    Then archival package created containing:
      | Decision PDFs (intake, SORA, autonomy, safety case approvals) |
      | Evidence Bundles (all submitted artefacts)                   |
      | Deliberation Log (panel meeting minutes, overrides, rationale)|
      | Clause Library v2.1 pin (which version applied to decision)  |
      | Archive Summary (metadata, case history timeline)           |
      | Flight telemetry (if incident-related closure)              |
    And total package size: 280 MB
    And archival timestamp: 2026-07-01T10:00:00Z

  @critical
  Scenario: Archive immutability and retention compliance
    Given archival package stored in CAA Secure Archive
    When archive is sealed (write-once storage)
    Then archive exhibits:
      | Immutability: no modification possible after sealing     |
      | Geo-redundancy: replicated across 2+ UK data centers    |
      | Retention: 10-year minimum hold (per CAA regulations)   |
      | Access Control: CAA + AAIB only (cryptographic access)  |
      | Audit logging: all read access logged with timestamp    |
    And compliance certified annually

  @major
  Scenario: Post-incident forensic archive retrieval
    Given Spadeadam swarm incident on 2026-05-23
    And AAIB investigator opens accident investigation
    When investigator requests case archive
    Then archive retrieved by CAA Records Officer
    And investigation access granted to AAIB with:
      | Read-only permissions                              |
      | Audit trail of what AAIB reviewed and when         |
      | Copy of frozen ML models (for simulation testing)  |
      | Flight telemetry for the incident flight           |
      | Decision record showing approvals and conditions   |
    And investigator can reconstruct incident context

  @major
  Scenario: Case history revision tracking
    Given case with multiple iterations (submissions, returns for clarification)
    When post-decision archive created
    Then case history shows complete timeline:
      | Initial submission: 2026-01-15 (case ABC-2026-001)                  |
      | RETURN_FOR_CLARIFICATION: 2026-01-28 (missing ConOps swarm section)  |
      | Resubmission: 2026-02-10 (evidence added)                            |
      | SORA assessment: 2026-02-15 to 2026-03-01                            |
      | Panel deliberation: 2026-03-05                                       |
      | APPROVE_WITH_CONDITIONS: 2026-03-05 Phase 1 (3 conditions)           |
      | Phase 1 flight operations: 2026-03-20 to 2026-05-15 (12 flights)     |
      | Phase 2 readiness gate: 2026-05-18 (approved, 2 new conditions)      |
      | Phase 2 operations: 2026-05-25 to 2026-06-15 (8 flights)             |
      | Trial closure: 2026-06-15                                            |
      | Archival: 2026-07-01                                                 |
    And each transition includes timestamp, actor, and decision rationale

  @major
  Scenario: Lessons-learned capture at trial closure
    Given trial closure on 2026-06-15
    When post-trial review conducted
    Then lessons-learned document created covering:
      | Operational insights: what worked well, what could improve  |
      | Evidence adequacy: which documents were most valuable       |
      | Crew performance: training gaps, workload assessments       |
      | Technical incidents: near-misses, anomalies encountered     |
      | Regulatory process: CAA decision workflow observations      |
      | Recommendations: for future similar trials                  |
    And lessons-learned document archived with case
    And CAA program management can access trends across trial cohort

  @minor
  Scenario: Archive access audit trail visibility
    Given archive stored and sealed for 2 years post-closure
    When AAIB investigator or CAA auditor retrieves archive
    Then access logged with:
      | Who accessed (name, role)                        |
      | When accessed (timestamp)                        |
      | What accessed (specific documents or sections)  |
      | Why accessed (investigation ID, audit purpose)  |
    And access log is itself archived as part of case record
