# Feature: Independent Flight Termination
# Business Goal: GOAL-003 Ensure Containment & Flight Safety
# Ultimate safety net allowing forced aircraft descent when all other systems fail

@containment @F12 @REQ011 @GOAL-003 @K6
Feature: Independent Flight Termination
  As a Range Safety Officer
  I want to force immediate cessation of all flight via RF kill-switch
  So that uncontrolled aircraft can be safely landed when autonomy and crew control both fail

  Background:
    Given independent termination system uses 915 MHz frequency (separate from C2)
    And kill-switch signal is cryptographically signed and time-stamped
    And all aircraft have dual independent termination receivers
    And motor-shutdown failsafe activated by kill-signal reception
    And Range Safety Officer trained and authorized for system use

  @critical @smoke
  Scenario: Dual-link failure forces independent termination
    Given Spadeadam trial with swarm at 500ft AGL, drifting uncontrolled
    And both C2 link and inter-vehicle links failed simultaneously
    And aircraft autonomy unable to determine safe action
    When Range Safety Officer activates independent termination RF kill-switch at t=623s
    Then kill-code transmitted at 915 MHz with cryptographic authentication
    And signal received by all aircraft at t=673ms (50ms propagation)
    And all motors unpowered within 350ms of reception
    And aircraft descend under gravity with parachute deployment (if equipped)
    And ground impact occurs safely without secondary hazard
    And post-flight inspection confirms RF kill-switch functionality

  @critical
  Scenario: Kill-switch latency compliance verification
    Given independent termination system specification requires:
      | Total latency from button press to motors off: <= 500ms |
    When end-to-end latency test conducted
    Then measured latency breakdown:
      | RSO button press to RF transmission: 50ms   |
      | RF propagation to aircraft: 50ms            |
      | Receiver processing: 10ms                   |
      | Motor controller shutdown: 50ms             |
      | Total: 160ms (well within 500ms limit)      |
    And compliance test passed and logged

  @major
  Scenario: Kill-switch testing without operational impact
    Given swarm is grounded in safe location (hangar)
    And independent termination test scheduled pre-flight
    When test signal sent to single aircraft receiver
    Then kill-signal received and processed (motors de-powered in ground test)
    And actual flight operations unaffected (test signal not broadcast to airborne aircraft)
    And test log recorded in maintenance record

  @major
  Scenario: Authorization and chain-of-command for kill-switch activation
    Given Range Safety Officer (RSO) is authorized personnel
    And RSO undergoes quarterly competency assessment
    When emergency condition warrants termination decision
    Then RSO makes activation call with proper authority level
    And decision logged in real-time audit trail with:
      | Timestamp                  |
      | RSO name and authorization |
      | Reason for activation      |
      | Aircraft state at activation |

  @major
  Scenario: Redundant kill-switch channels prevent single point of failure
    Given 915 MHz primary channel for kill-signal
    And 2.4 GHz secondary backup channel pre-programmed
    When primary 915 MHz jammed or unavailable
    Then backup 2.4 GHz channel can be activated
    And both channels use identical cryptographic authentication
    And only one activation is needed to shut down all aircraft

  @minor
  Scenario: Post-termination aircraft recovery
    Given aircraft safely on ground after kill-switch activation
    When recovery crew approaches downed aircraft
    Then aircraft motors remain unpowered due to fail-safe
    And manual motor reset required via maintenance panel
    And no automatic re-ignition possible without crew authorization
