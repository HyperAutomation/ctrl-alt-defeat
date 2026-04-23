@Version: 1
@LastUpdated: 2026-04-22 14:27:53.380776+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 79da0e93-59a6-47bb-b0b7-3e572f4dc9ec
@TestID: REQ006
@Persona: general

Scenario: Harmful Interference
	Given the RPAS data links are established
	When harmful interference occurs on the RPAS data links
	Then pairing, encryption, and backup link mechanisms protect the data links