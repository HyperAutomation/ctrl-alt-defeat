# Feature: Panel Decision-Making & Override Authority
# Business Goal: GOAL-015 Support Joint CAA/MAA Panel Decision-Making
# CAA and MAA panels with override capability and full audit trail

@panel_review @F26 @REQ016 @GOAL-001 @GOAL-015
Feature: Panel Decision-Making & Override Authority
  As a CAA Lead Inspector and joint panel
  I want to make binding authorization decisions with override capability
  So that exceptional cases receive human judgment while maintaining full accountability

  Background:
    Given panel composition includes CAA Lead Inspector, Autonomy Specialist, MAA Air Safety Officer
    And panel briefing includes full case evidence and assessment summaries
    And clause library v2.1 is reference for decision gates
    And decision record template follows CAP 722D Appendix E structure

  @critical @smoke
  Scenario: Panel decision of APPROVE WITH CONDITIONS
    Given Spadeadam trial passes all technical gates
    When joint panel convenes for deliberation
    Then panel votes to APPROVE WITH CONDITIONS for Phase 1 only
    And decision record documents:
      | Decision: APPROVE_WITH_CONDITIONS_PHASE_1            |
      | Approval scope: VLOS operation, 500m radius, 2 aircraft max, daylight only |
      | Mandatory Conditions:                                  |
      |   - CAA Observer required for all flights              |
      |   - C2 Link Continuity monitored real-time             |
      |   - Emergency Authority (crew override) mandatory      |
      |   - Incident Reporting to CAA within 48 hours         |
      |   - Phase 2 Readiness Gate review after 10 flights    |
      | Review Triggers:                                       |
      |   - Phase 2 Readiness Gate (technical + operational)  |
      |   - Incident-Triggered Re-assessment (MOR auto-trigger)|
      |   - Workload Limit Breach (crew demands exceed limits) |
    And decision record signed by CAA Lead Inspector, MAA Air Safety Officer, Applicant
    And decision record published in case file

  @critical
  Scenario: Panel override of AI flag with documented rationale
    Given SORA Assessment AI tool flags ConOps missing 3rd loss-of-separation mitigation item
    When CAA Lead Inspector John Smith reviews ConOps detail
    And discovers swarm-consensus-timeout procedure documented in Section 4.3 Table 4-1
    Then John submits override with rationale:
      | Finding ID: AI-SORA-0342                            |
      | AI Flag Status: OVERRIDE                             |
      | Override Rationale: "Consensus timeout IS documented |
      | in ConOps Section 4.3 as third loss-of-sep mitigation|
      | Item is present, flagging system was too strict."   |
      | Override Authority: Chief Inspector (escalation path)|
    And audit log records:
      | OVERRIDE_SUBMITTED at 2026-04-23 14:15:32.847        |
      | Write latency: 342ms                                 |
      | Actor: John Smith                                    |
      | Authority level: Chief Inspector                     |
    And override is immutable; case history shows John's name, timestamp, reasoning permanently

  @major
  Scenario: Panel refusal decision with blockers and re-application path
    Given hypothetical BVLOS Swarm application: 10x DJI Matrice, autonomous swarm, ML collision avoidance
    And applicant claims crew monitor-only (no override authority)
    When joint panel convenes
    Then panel votes REFUSE AUTHORIZATION with blocking findings:
      | Finding 1: Meaningful Human Control violation (crew monitor-only violates REQ010) |
      | Finding 2: ML Explainability insufficient (no off-distribution evidence) |
      | Finding 3: Emergent Behavior Bounds undefined (swarm deadlock scenario possible) |
    And decision record documents:
      | Decision: REFUSE_AUTHORIZATION                        |
      | Blocking Findings: 3                                 |
      | Appeal Window: 30 days from date of refusal           |
      | Path to Reapplication:                                |
      |   - Redesign ConOps with mandatory crew override      |
      |   - Provide ML robustness evidence (adversarial testing) |
      |   - Submit emergent-behavior assurance case with proof|
      | Expected Re-review Timeline: 8-12 weeks              |
    And case closed unless applicant files appeal

  @major @regression
  Scenario Outline: Panel decision matrix
    Given case with <evidence_adequacy> evidence
    And <risk_profile> risk profile per SORA
    When panel deliberates
    Then decision outcome is <panel_decision>
    And <conditions_count> approval conditions imposed if approval granted

    Examples:
      | evidence_adequacy | risk_profile | panel_decision              | conditions_count |
      | Complete, credible | SAIL-I (Low) | APPROVE (full scope Phase 1+2) | 0               |
      | Complete, credible | SAIL-II (Medium)| APPROVE_WITH_CONDITIONS (Phase 1 only)| 3     |
      | Partial, minor gaps| SAIL-II (Medium)| RETURN_FOR_CLARIFICATION | N/A            |
      | Incomplete, critical gaps | SAIL-IV (High)| REFUSE_AUTHORIZATION | N/A            |

  @major
  Scenario: Applicant appeal of panel refusal
    Given applicant receives REFUSE_AUTHORIZATION decision
    When applicant submits appeal within 30-day window
    And appeal includes:
      | Detailed response to each blocking finding         |
      | Additional evidence not available at first review  |
      | Revised ConOps with crew override implemented      |
    Then appeal is assigned to different panel composition
    And re-review scheduled within 8 weeks of appeal submission
