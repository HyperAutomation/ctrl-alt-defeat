@Version: 1
@LastUpdated: 2026-04-22 14:23:52.405322+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 43f6671d-1686-457a-8b3b-d6b2d5b3cd89
@TestID: REQ005
@Persona: general

Scenario: Automatic Containment Not Triggered
	Given an unmanned aircraft system (UAS) is operating within Class D controlled airspace
	When the UAS experiences a fly-away situation and automatic containment is not enabled
	Then the UAS does not remain contained within the geofence boundaries