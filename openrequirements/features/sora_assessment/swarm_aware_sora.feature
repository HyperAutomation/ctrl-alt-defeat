# Feature: Swarm-Aware SORA Assessment
# Business Goal: GOAL-002 Assure Swarm-Aware Safety Assessment
# Risk assessment accounting for multi-aircraft interdependencies and emergent behaviours

@sora_assessment @F03 @REQ002 @REQ008 @GOAL-002
Feature: Swarm-Aware SORA Assessment
  As a CAA SORA assessor
  I want to evaluate operational risks specific to coordinated swarm operations
  So that safety requirements account for collective failure modes beyond single-aircraft analysis

  Background:
    Given SORA assessor has completed swarm-specific training
    And clause library v2.1 pins JARUS SORA v2.5 Appendix C (Swarm)
    And case status is SORA_READY
    And swarm-aware evidence is available in case

  @critical
  Scenario: Multi-agent hazard analysis required for swarm trials
    Given 5x RigiTech Eiger aircraft in autonomous coordinated swarm
    And applicant claims SAIL-I (lowest assurance)
    When SORA assessor applies JARUS v2.5 Appendix C methodology
    And reviews multi-agent hazard tree including:
      | Loss of swarm consensus             |
      | Inter-vehicle separation loss       |
      | Cascading aircraft link failures    |
      | Shared geofence collision           |
    Then assessor determines actual SAIL-IV required
    And case returns for re-evidence submission with feedback

  @critical
  Scenario: Swarm interdependency discovery gap
    Given Spadeadam swarm trial: 5x Eiger, autonomous formation, GNSS/C2 denial scenario
    And ConOps describes individual aircraft loss-of-separation mitigations only
    When assessor applies swarm-aware decomposition
    Then identifies missing evidence:
      | Swarm-consensus timeout procedures |
      | Multi-aircraft geofence overlap    |
      | Emergent formation instability     |
    And case transitions to RETURN_FOR_CLARIFICATION
    And coaching note: swarm decision-making architecture required in ConOps Revision 3

  @major @regression
  Scenario Outline: SORA outcome matrix (single vs swarm)
    Given <aircraft_count>x aircraft operating <coordination_mode>
    And evidence demonstrates <risk_factor>
    When SORA assessment completed
    Then SAIL outcome is <single_sail> → <swarm_sail>
    And <severity> feedback provided

    Examples:
      | aircraft_count | coordination_mode   | risk_factor                     | single_sail | swarm_sail | severity |
      | 1              | N/A (single)        | GPS/Link loss, RTL procedures   | SAIL-I      | N/A        | N/A      |
      | 2              | Cooperative        | Separation enforcement          | SAIL-II     | SAIL-III   | major    |
      | 5              | Autonomous swarm    | Consensus timeout absence       | SAIL-II     | SAIL-IV    | critical |
      | 5              | Autonomous swarm    | Emergent bounds proven          | SAIL-III    | SAIL-III   | major    |

  @major
  Scenario: Worst-credible swarm behaviour evidence
    Given 5x Eiger swarm configured for SAIL-III (moderate assurance)
    And worst-credible swarm scenario: 2x simultaneous link loss + geofence intrusion
    When assessor requires evidence that swarm survives scenario
    Then applicant must provide:
      | Formal verification or Monte Carlo simulation |
      | Independent flight termination fallback       |
      | Crew override latency <= 50ms                 |
    And evidence accepted only if peer-reviewed
