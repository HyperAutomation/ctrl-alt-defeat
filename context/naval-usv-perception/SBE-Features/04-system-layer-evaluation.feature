@phase-4 @PSRQ
Feature: Hardware-in-the-loop and parametric scenario evaluation of collision-avoidance stack
  As a System Integrator
  I want to validate full decision stack (perception + collision-avoidance + human handover) in closed-loop simulation
  So that Phase 5 sea trials are de-risked and system-layer integration is proven safe

  Background:
    Given the USV perception stack is under formal qualification
    And the PSRQ programme gate for Phase 4 is active
    And collision-avoidance algorithms are integrated with perception stack in HIL environment
    And physics simulator is configured with realistic maritime sensor feedback

  @critical @smoke @REQ-008 @SCEN-010
  Scenario: Execute collision-avoidance scenarios without incident in nominal conditions
    Given a collision-avoidance stack running in HIL with physics-realistic sensor feedback from physics simulator
    When the system integrator executes 50 scripted encounter scenarios (head-on, crossing, overtake)
    Then all 50 scenarios complete without collision, emergency stop or human override
    And telemetry is logged and traces are exported to the GSN safety case
    And scenario execution report shows zero safety-critical failures

  @critical @REQ-006 @SCEN-011
  Scenario Outline: Validate safe-state transition and human handover under degraded sensors
    Given HIL scenario with <degraded_sensor> denial and <additional_loss>, forcing reliance on <available_sensors>
    When the USV autonomy stack detects confidence falling below handover threshold (70%)
    Then a safe-state transition fires: the system reduces speed to 2 knots and raises human-control alert
    And the human operator assumes manual helm within <handover_latency> seconds; event logged as successful handover
    And handover telemetry is recorded and linked to system-layer evidence

    Examples:
      | degraded_sensor | additional_loss  | available_sensors     | handover_latency |
      | GPS             | LiDAR dropout    | visual and radar      | 5                |
      | radar           | visual degradation | LiDAR and IR          | 4                |
      | GPS + radar     | none             | visual, IR, LiDAR     | 6                |

  @critical @REQ-006 @SCEN-012
  Scenario: Maintain collision avoidance during transient sensor loss
    Given a 3-vessel encounter scenario (crossing traffic + stationary buoy) with radar briefly offline (2 s)
    When the radar signal is lost during the critical 60–65 s window of the encounter
    Then the collision-avoidance algorithm reverts to visual + IR detection and maintains safe separation
    And recovery time is logged; if >10 s, a minor safety finding is raised for human review
    And encounter completion report confirms zero collisions or safety exceptions

  @critical @REQ-009 @SCEN-018
  Scenario Outline: Generate parametric encounter scenarios covering pairwise ODD combinations
    Given a scenario DSL script defining encounter geometry with <num_factors> factors: vessel-distance (<num_distance_levels> levels), approach-angle (<num_angle_levels>), sea-state (<num_sea_levels>), visibility (<num_vis_levels>)
    When the scenario architect invokes pairwise (2-way) coverage generation over sea-state × visibility × sensor-mode
    Then the framework generates <num_scenarios> minimal encounter variants covering all sea-state–visibility pairs
    And each variant is executable in physics simulator; <num_derivatives> parametric derivatives can be scripted in <generation_time>
    And traceability links each scenario to specific ODD environment-variable combinations

    Examples:
      | num_factors | num_distance_levels | num_angle_levels | num_sea_levels | num_vis_levels | num_scenarios | num_derivatives | generation_time |
      | 4           | 3                   | 4                | 3              | 3              | 15            | 100             | <2 hours        |
      | 5           | 3                   | 4                | 4              | 3              | 18            | 150             | <3 hours        |

  @critical @REQ-010 @SCEN-019
  Scenario: Link scenario variants to ODD environment-variable combinations
    Given scenario DSL defines encounters across sea-state ∈ {Beaufort 2,3,4}, visibility ∈ {50 m,200 m,500 m}, sensor ∈ {radar, lidar, visual}
    When the scenario generator applies pairwise (2-factor) coverage design-of-experiments
    Then 9 minimum scenarios are generated, each covering unique pairs
    And traceability links each scenario to a specific ODD environment-variable combination in the traceability matrix
    And all scenarios are validated against physics constraints and ODD partitions

  @major @REQ-010 @SCEN-020
  Scenario: Warn and truncate scenario expansion under combinatorial explosion
    Given a scenario DSL script with 50 scenario parameters (12 per factor across 5 environmental dimensions)
    When the scenario expansion reaches combinatorial explosion (e.g., 2^50 potential variants)
    Then the generator warns and truncates to greedy-maximal coverage (e.g., 50 scenarios max)
    And uncovered factor combinations are flagged for manual prioritization
    And warning is logged with severity MAJOR; scenario architect must justify coverage choice

  @critical @REQ-008
  Scenario: Validate full decision stack in multi-vessel close-quarters scenario
    Given a high-complexity scenario: 5 merchant vessels, 3 RIBs, crossing traffic, restricted channel, visibility 200 m, sea state Beaufort 3
    When the collision-avoidance stack executes evasive maneuvers under time-critical navigation constraints
    Then all vessels maintain safe separation (>500 m standoff); no collision events; human override not required
    And decision trace (perception → collision-avoidance → helm command) is exported and reviewed for safety
    And scenario outcome is approved as evidence for Phase 5 gate clearance
