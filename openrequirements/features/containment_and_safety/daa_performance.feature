# Feature: Detect-and-Avoid Performance Assurance
# Business Goal: GOAL-002 Assure Swarm-Aware Safety Assessment
# Autonomous collision avoidance capabilities meeting regulatory minimums

@containment @F08 @REQ007 @GOAL-002 @K2
Feature: Detect-and-Avoid (DAA) Performance Assurance
  As a CAA airspace safety assessor
  I want to verify that UAS can autonomously sense and avoid non-cooperative aircraft
  So that trials can be conducted in non-segregated airspace with acceptable collision risk

  Background:
    Given DAA system meets DO-365 or F3442 standards
    And detection range, closing speed, and time-to-closest-point (CPA) thresholds defined
    And case status is SORA_READY or DAA_EVIDENCE_UNDER_REVIEW

  @critical @smoke
  Scenario: DAA non-cooperative encounter with autonomous resolution
    Given Spadeadam trial: 5x Eiger at 500ft altitude in BVLOS swarm
    And intruder aircraft (Cessna 172) detected at 2.8nm horizontal, 2000ft altitude
    When DAA system detects intruder at 100ms latency
    Then detection confidence logged (98.3% in this case)
    And resolver calculates avoidance maneuver: climb to 1100ft altitude
    And climb command issued to all swarm aircraft
    And intruder passes below swarm with 900ft vertical separation
    And time-to-CPA: 18 seconds (well above minimum)
    And crew alerted and maintains situational awareness
    And case history records DAA_RESOLUTION event

  @critical
  Scenario Outline: DAA performance against encounter geometries
    Given <encounter_type> with intruder at <range_nm> and <closure_speed_kt>
    And <uas_maneuver> selected as avoidance action
    When <time_to_cpa_s> seconds remain to closest point
    Then <required_margin_ft> separation maintained
    And <detection_confidence_pct>% confidence in avoidance success

    Examples:
      | encounter_type          | range_nm | closure_speed_kt | uas_maneuver | time_to_cpa_s | required_margin_ft | detection_confidence_pct |
      | Head-on approach        | 3.0      | 200              | Climb 500ft  | 18            | 900                | 98.3                     |
      | Overtaking (catching up)| 2.0      | 80               | Descent 200ft| 25            | 500                | 95.1                     |
      | Parallel paths          | 1.5      | 0                | Lateral 0.5nm| N/A (diverging)| 1000               | 99.2                     |
      | Swarm-internal conflict | 0.3nm   | 30               | Formation hold RTL| 12       | 50 min sep         | 87.5                     |

  @major
  Scenario: Swarm-aware DAA with inter-vehicle coordination
    Given 5x Eiger intruder encounter while in coordinated swarm formation
    And detection range 3nm, time-to-CPA 18 seconds
    When DAA resolver activates
    Then avoidance maneuver coordinated across all aircraft:
      | All aircraft execute identical climb       |
      | No intra-swarm separation loss expected    |
      | Crew observes cohesion maintained         |
    And maneuver success logged per aircraft

  @major
  Scenario: DAA fall-through to crew manual override
    Given DAA system detects intruder but confidence < 70%
    When encounter geometry is ambiguous (e.g., radar ghost)
    Then DAA system alerts crew with AMBER priority
    And crew assumes manual control via C2 link
    And autonomous avoidance held until crew directs action
    And crew decision logged in audit trail

  @major
  Scenario: Independent Flight Termination as DAA ultimate fallback
    Given DAA system fails catastrophically (loss of sensor)
    And crew unable to regain manual control
    When uncontrolled flight toward populated area imminent
    Then Range Safety Officer can activate independent termination
    And all aircraft motors unpowered within 350ms
    And safe descent and landing occurs
