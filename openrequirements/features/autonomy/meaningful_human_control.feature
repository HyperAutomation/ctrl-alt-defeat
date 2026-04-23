# Feature: Meaningful Human Control
# Business Goal: GOAL-004 Assure Autonomous Decision-Making & Human Control
# Crew retains informed authority over safety-critical decisions

@autonomy @F11 @REQ010 @GOAL-004 @K5
Feature: Meaningful Human Control & Crew Authority
  As a CAA human factors specialist
  I want to ensure crew maintains informed awareness and control authority over swarm
  So that crew can perceive system state, understand autonomy decisions, and intervene on safety-critical matters

  Background:
    Given crew consists of pilot (flight control) and observer/systems manager
    And telemetry link provides 10Hz minimum update rate
    And workload monitoring system tracks concurrent demands on crew
    And crew training and competency verified per role

  @critical @smoke
  Scenario: Crew override latency compliance
    Given Spadeadam autonomous formation hold at 500ft altitude
    And crew observes unexpected altitude deviation on GCS
    When crew presses emergency override button at t=45.2s
    Then C2 uplink transmits override command within 15ms
    And all 5 aircraft receive command and transition to hover mode within 50ms total
    And crew regains full manual control (throttle, heading, altitude)
    And case history records OVERRIDE_ACTIVATED event
    And measured latency: 50ms (well within 100ms requirement)

  @critical
  Scenario: Situational awareness requirement via telemetry
    Given autonomous swarm in BVLOS operation
    When crew monitors system via GCS display
    Then GCS displays must show:
      | Real-time position of each aircraft (map view)    |
      | Altitude, heading, airspeed per aircraft          |
      | Current autonomous mode (formation hold, climb, etc)|
      | Crew command input status                         |
      | Link quality and signal strength                  |
      | Any active alarms or mode transitions             |
    And telemetry update frequency at least 10Hz
    And latency from aircraft to GCS <= 200ms

  @critical
  Scenario Outline: Workload assessment gate for crew authority
    Given crew composition: <crew_type>
    And trial involves <autonomy_level> swarm autonomy
    And <concurrent_demands> concurrent decisions per hour
    When workload assessment conducted
    Then workload level is <workload_category>
    And crew ability to exercise meaningful control is <control_status>

    Examples:
      | crew_type                        | autonomy_level | concurrent_demands | workload_category | control_status |
      | Single pilot (multi-skilled)     | Manual VLOS    | 5                  | Low              | PASS (pilot alert)  |
      | Pilot + Observer/systems manager | Autonomous VLOS| 20                 | Moderate         | PASS (monitored)    |
      | Pilot + Observer + Safety officer| Autonomous BVLOS Swarm| 50          | High             | MARGINAL (procedure dependent) |
      | Single pilot (multi-skilled)     | Autonomous BVLOS Swarm| 80          | Very High        | FAIL (workload exceeds limits) |

  @major
  Scenario: Crew training requirement for meaningful control
    Given new crew member assigned to BVLOS swarm trial
    When crew competency assessment conducted
    Then crew must demonstrate:
      | Knowledge of swarm decision architecture      |
      | Understanding of ODD (Operational Design Domain)|
      | Proficiency with override button latency      |
      | Ability to interpret GCS displays under stress |
      | Situational awareness of failure modes        |
    And training completion logged in case record

  @major
  Scenario: Autonomous-decision transparency requirement
    Given swarm executing autonomous de-confliction maneuver
    When crew observes autonomous action
    Then crew must be able to answer:
      | Why did swarm climb?                                   |
      | What sensor triggered decision? (intruder aircraft, etc)|
      | What action was prevented by climb? (collision, etc)   |
      | What crew authority exists to reverse action? (override button)|
    And if crew cannot answer, training gap identified

  @major
  Scenario: Take-over drill conducted pre-flight
    Given crew qualified for autonomous BVLOS operation
    When pre-flight procedures initiated
    Then crew conducts take-over drill:
      | Autonomous mode: swarm in formation hold                      |
      | Crew presses override button                                  |
      | All aircraft transition to hover mode within 50ms             |
      | Crew assumes manual control and executes 30-second maneuvre  |
      | Crew transitions back to autonomous mode                      |
    And drill completion logged and witnessed by safety officer

  @major
  Scenario: Loss of meaningful control triggers containment
    Given autonomous swarm performing BVLOS operation
    And crew workload exceeds acceptable threshold (>3 concurrent alarms)
    When crew signals inability to maintain situational awareness
    Then autonomy system automatically triggers:
      | Hold current altitude (no further maneuvers)        |
      | Crew alert with medium priority (yellow)           |
      | Real-time workload reduction (fewer updates)       |
      | If crew does not recover within 30s: RTL activation|
    And crew can regain control via override button at any time
