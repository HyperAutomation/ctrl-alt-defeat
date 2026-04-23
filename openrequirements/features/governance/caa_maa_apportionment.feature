# Feature: CAA/MAA Regulatory Apportionment & Dual-Authority
# Business Goal: GOAL-006 Manage Regulatory Apportionment
# Gap-free delegation of approval authority between CAA and MAA

@governance @F17 @REQ015 @GOAL-006 @K7
Feature: CAA/MAA Regulatory Apportionment & Dual-Authority
  As a CAA and MAA liaison officer
  I want to establish clear, gap-free delegation of approval authority
  So that authorization decisions are unambiguously accountable without conflicting requirements

  Background:
    Given trial may be civil-only (CAA) or civil+military (CAA+MAA)
    And apportionment matrix structure defined per Workbench specification
    And pre-existing CAA/MAA Memorandum of Understanding (MOU) governs escalation

  @critical @smoke
  Scenario: Apportionment matrix signed for dual-authority trial
    Given CTRL-ALT-DEFEAT applies for BVLOS Swarm at Spadeadam (MOD-owned military range)
    When apportionment matrix submitted with application intake
    Then matrix maps 15 approval gates as follows:
      | CAA-owned gates (11): Intake, Completeness, SORA Assessment, Safety Case, Insurance, Risk Assessment, Crew Training, Autonomy Review, Geofence Validation, Phase 1 Readiness, Phase 2 Readiness |
      | MAA-owned gates (1): Military Range Operational Coordination (Spadeadam TDA clearance) |
      | Joint gates (3): Spectrum Authorization (CAA+MAA), C2 Link Monitoring (CAA+MAA), Emergency Authority & Contingency (CAA+MAA) |
    And CAA Lead Inspector and MAA Air Safety Officer review and sign jointly
    And apportionment becomes binding contract for case duration
    And case status = APPORTIONMENT_COMPLETE
    And case progresses to Phase 1 SORA Assessment

  @critical
  Scenario: Escalation handling in apportionment
    Given joint CAA/MAA gate requiring both authorities
    And CAA Lead Inspector approves, MAA Air Safety Officer denies
    When escalation procedures invoked per MOU
    Then escalation path:
      | CAA denying authority escalates to CAA Chief Inspector     |
      | MAA denying authority escalates to MAA Group Captain       |
      | Senior authorities convene within 5 working days           |
      | Decision: proceed (override), modify scope, or refuse      |
    And escalation decision recorded in case history with rationale

  @major
  Scenario Outline: Apportionment matrix per operation location
    Given trial location is <location>
    When apportionment matrix structured
    Then CAA owns <caa_gates> gates, MAA owns <maa_gates> gates, joint owns <joint_gates>

    Examples:
      | location                      | caa_gates | maa_gates | joint_gates |
      | Edinburgh (civilian airspace) | 15        | 0         | 0           |
      | Spadeadam (MOD military range)| 11        | 1         | 3           |
      | Classified MOD program        | 8         | 3         | 4           |

  @major
  Scenario: Duty holder signature and accountability
    Given apportionment matrix completed
    When signed by authorities
    Then accountability is explicit:
      | CAA Lead Inspector signature: John Smith, signatory authority confirmed |
      | MAA Air Safety Officer signature: Flt Lt Mary Jones, SC cleared         |
      | Applicant signature: CEO John Doe (organizational accountability)       |
      | Clause library version: 2.1 (reference for gate definitions)            |
    And signatures immutable in case record (write-once archive)

  @major
  Scenario: Apportionment remapping during trial phases
    Given Phase 1 apportionment established for VLOS operation
    And applicant seeks Phase 2 upgrade to BVLOS
    When Phase 2 scope expansion proposed
    Then apportionment matrix may change:
      | New gates required: Spectrum re-authorization (joint CAA/MAA) |
      | Existing gates unchanged: SORA Assessment remains CAA-owned    |
    And new apportionment matrix signed before Phase 2 gate progression
