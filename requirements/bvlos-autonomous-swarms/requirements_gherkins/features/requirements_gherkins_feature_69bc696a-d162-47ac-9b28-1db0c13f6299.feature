# Version: 1
# LastUpdated: 2026-04-22 14:23:52.813616+00:00
# Requirement Description: As a CAA airspace regulator I want automatic containment so that a fly-away cannot become uncontrolled BVLOS.

@REQ005
Feature: Automatic Geofence Enforcement

@PositiveFlow
Scenario: Automatic Containment Enabled
	Given an unmanned aircraft system (UAS) is operating within Class D controlled airspace
	When the UAS experiences a fly-away situation and automatic containment is enabled
	Then the UAS remains contained within the geofence boundaries

@PositiveFlow
Scenario: Manual Containment Triggered
	Given an unmanned aircraft system (UAS) is operating within Class D controlled airspace
	When the operator manually triggers containment for a fly-away situation
	Then the UAS remains contained within the geofence boundaries

@PositiveFlow
Scenario: Automatic Containment Encountering Obstacle
	Given an unmanned aircraft system (UAS) is operating within Class D controlled airspace with automatic containment enabled
	When the UAS encounters an obstacle during a fly-away situation
	Then the UAS remains contained within the geofence boundaries

@PositiveFlow
Scenario: Manual Containment Triggered Encountering Obstacle
	Given an unmanned aircraft system (UAS) is operating within Class D controlled airspace
	When the operator manually triggers containment for a fly-away situation and the UAS encounters an obstacle
	Then the UAS remains contained within the geofence boundaries

@PositiveFlow
Scenario: Automatic Containment Enabled Segregated Airspace
	Given an unmanned aircraft system (UAS) is operating within a designated segregated airspace
	When the UAS experiences a fly-away situation and automatic containment is enabled
	Then the UAS remains contained within the geofence boundaries

@NegativeFlow
Scenario: Automatic Containment Not Triggered
	Given an unmanned aircraft system (UAS) is operating within Class D controlled airspace
	When the UAS experiences a fly-away situation and automatic containment is not enabled
	Then the UAS does not remain contained within the geofence boundaries

@NegativeFlow
Scenario: Manual Containment Not Triggered
	Given an unmanned aircraft system (UAS) is operating within Class D controlled airspace
	When the operator does not manually trigger containment for a fly-away situation
	Then the UAS does not remain contained within the geofence boundaries

@NegativeFlow
Scenario: Automatic Containment Not Triggered Encountering Obstacle
	Given an unmanned aircraft system (UAS) is operating within Class D controlled airspace without automatic containment enabled
	When the UAS encounters an obstacle during a fly-away situation
	Then the UAS does not remain contained within the geofence boundaries

@NegativeFlow
Scenario: Manual Containment Not Triggered Encountering Obstacle
	Given an unmanned aircraft system (UAS) is operating within Class D controlled airspace
	When the operator does not manually trigger containment for a fly-away situation and the UAS encounters an obstacle
	Then the UAS does not remain contained within the geofence boundaries

@NegativeFlow
Scenario: Automatic Containment Not Triggered Segregated Airspace
	Given an unmanned aircraft system (UAS) is operating within a designated segregated airspace
	When the UAS experiences a fly-away situation and automatic containment is not enabled
	Then the UAS does not remain contained within the geofence boundaries
