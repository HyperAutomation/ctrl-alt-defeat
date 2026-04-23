@Version: 1
@LastUpdated: 2026-04-22 14:27:53.336020+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 79da0e93-59a6-47bb-b0b7-3e572f4dc9ec
@TestID: REQ006
@Persona: general

Scenario: Non-Functioning C2 Link
	Given the CAA spectrum specialist has authorized a monitored C2 link
	When the C2 link does not function correctly
	Then an emergency recovery function is triggered and the aircraft returns to home