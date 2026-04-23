# Feature: Geofence & Containment Enforcement
# Business Goal: GOAL-003 Ensure Containment & Flight Safety
# Active geofence boundary enforcement with fail-safe assumptions

@containment @F06 @REQ005 @GOAL-003 @K1
Feature: Geofence & Containment Enforcement
  As a CAA flight safety officer
  I want geofence systems to actively prevent UAS from exiting authorized airspace
  So that public below is protected from uncontrolled aircraft regardless of link loss or autonomy failure

  Background:
    Given trial airspace TDA is activated and published via NOTAM
    And geofence boundary is uploaded to aircraft via pre-flight briefing
    And ground monitoring station tracks aircraft position in real-time
    And containment system has redundant triggers: onboard geofence + ground safety pilot

  @critical @smoke
  Scenario: Geofence breach detected and RTL triggered within acceptable latency
    Given Spadeadam trial: 5x Eiger at authorized position 54.9167N 2.5667W
    And geofence tolerance set to 50m
    And wind gust causes aircraft to drift 55.3m beyond boundary at t=100ms
    When geofence logic detects breach
    Then RTL (Return-to-Launch) command issued within 100ms
    And aircraft landing completed within 3.2 seconds total
    And audit log records GEOFENCE_BREACH event with:
      | Timestamp                 |
      | Breach distance (55.3m)   |
      | Trigger latency (100ms)   |
      | RTL completion time (3.2s)|

  @critical
  Scenario Outline: Geofence tolerance thresholds per operation type
    Given <operation_type> trial with <aircraft_count> aircraft
    And airspace has <airspace_buffer> separation from populated area
    When wind speed reaches <wind_speed_knots>
    Then geofence tolerance must accommodate <wind_drift_margin>
    And containment system transitions to RTL if breach exceeds <tolerance_m>

    Examples:
      | operation_type    | aircraft_count | airspace_buffer | wind_speed_knots | wind_drift_margin | tolerance_m |
      | VLOS (populated)  | 1              | 300m            | 15               | 30m              | 20m         |
      | VLOS (remote)     | 1              | 1000m           | 25               | 60m              | 50m         |
      | BVLOS Swarm       | 5              | 2000m           | 20               | 75m              | 75m         |

  @major
  Scenario: Geofence ceiling breach triggers autonomous descent
    Given trial authorized altitude 500ft AGL
    And software limit set to 550ft AGL (50ft margin)
    When aircraft altitude exceeds 550ft
    Then onboard autonomy triggers descent command
    And descent rate limited to 2 ft/sec to avoid loss of control
    And crew alerted with visual/audio warning

  @major
  Scenario: Multiple simultaneous geofence violations handled safely
    Given 5x swarm aircraft with inter-vehicle spacing 20m
    When all 5 aircraft simultaneously breach geofence due to wind gust
    Then all RTL commands issued within 50ms of each other
    And aircraft form landing pattern to avoid mid-air collision
    And ground safety pilot has takeover authority if RTL anomalies detected

  @major
  Scenario: Geofence verification pre-flight checklist
    Given pilot conducts pre-flight briefing
    When ground station uploads geofence boundary to all aircraft
    Then upload completion status confirmed for each aircraft
    And 3D geofence visualization displayed to crew
    And crew signs-off confirmation in flight plan
