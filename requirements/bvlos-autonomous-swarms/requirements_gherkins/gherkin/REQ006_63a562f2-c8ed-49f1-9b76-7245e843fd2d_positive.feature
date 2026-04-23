@Version: 1
@LastUpdated: 2026-04-22 14:27:53.290980+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 79da0e93-59a6-47bb-b0b7-3e572f4dc9ec
@TestID: REQ006
@Persona: general

Scenario: Functioning Inter-Vehicle Links
	Given the inter-vehicle links are established
	When the inter-vehicle links function without loss or interference
	Then no link loss or interference is detected