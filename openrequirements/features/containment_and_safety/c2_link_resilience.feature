# Feature: C2 Link Resilience & Loss Survivability
# Business Goal: GOAL-003 Ensure Containment & Flight Safety
# Autonomous operations during loss of Command & Control communication

@containment @F07 @REQ006 @GOAL-003
Feature: C2 Link Resilience & Loss Survivability
  As a CAA spectrum and safety officer
  I want to verify that UAS can survive loss of ground command & control link
  So that loss of communication does not automatically result in uncontrolled flight

  Background:
    Given authorized monitored C2 link with spectrum license
    And inter-vehicle communication links available for swarm coordination
    And autonomy logic includes C2-loss handling state machines
    And contingency procedures documented in ConOps

  @critical @smoke
  Scenario: Swarm consensus timeout during intentional C2 denial
    Given Spadeadam C2 denial test: 5x Eiger in AC4 consensus mode
    And all aircraft maintain inter-vehicle links during C2 loss
    When C2 is powered down at t=120s
    Then aircraft detect loss and enter autonomous mode within 2 seconds
    And voting window opens for collective decision (MAINTAIN_ALTITUDE, RTL, or HOLD)
    And consensus resolves within 1.8 seconds
    And timeout at t=420s triggers RTL for all aircraft
    And landing completed at t=425.8s
    And audit trail records CONSENSUS_RESOLVED and LANDING_COMPLETE events

  @critical
  Scenario: C2 link restoration during autonomous flight
    Given 5x swarm in autonomous hover after C2 loss
    And inter-vehicle links stable and synchronized
    When C2 link restored at t=180s
    Then ground crew regains visibility of aircraft state
    And crew can assume control via C2 uplink
    And transition from autonomous to manual control confirmed by all aircraft
    And case history records C2 restoration event and crew takeover action

  @major @regression
  Scenario Outline: Link loss survivability matrix by operation type
    Given <operation_type> with <autonomy_level>
    And <comms_topology> communication architecture
    When <failure_mode> occurs
    Then <survival_action> triggered
    And recovery time <= <recovery_time_s>

    Examples:
      | operation_type   | autonomy_level | comms_topology      | failure_mode      | survival_action   | recovery_time_s |
      | VLOS single      | Manual         | C2 only             | C2 loss           | RTL at 2s         | 5               |
      | BVLOS single     | Semi-auto      | C2 + GPS            | C2 loss           | Hold altitude 60s | 60              |
      | BVLOS Swarm      | Full auto      | C2 + inter-vehicle  | C2 loss           | Consensus RTL     | 300             |
      | BVLOS Swarm      | Full auto      | C2 + inter-vehicle  | Inter-vehicle loss| C2 immediate RTL  | 5               |

  @major
  Scenario: Spectrum authorization and monitoring compliance
    Given trial operating on authorized UAS frequency band
    And CAA spectrum monitoring system assigned to trial
    When monitoring detects unauthorized interference on C2 link
    Then interference logged with timestamp and magnitude
    And crew receives medium-priority alert (non-blocking)
    And if interference degrades link quality below threshold, RTL triggered automatically
    And case officer notified for post-flight incident analysis

  @major
  Scenario: Distributed consensus decision determinism
    Given 5x aircraft with identical consensus voting weights
    When C2 loss occurs and voting begins
    And each aircraft proposes action based on local state
    Then consensus algorithm produces deterministic outcome
    And all aircraft execute identical action (e.g., all climb, all hold, all RTL)
    And no deadlock or divergence scenarios possible
