@Version: 1
@LastUpdated: 2026-04-22 14:44:08.393261+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 6086434a-3b60-45b1-bdf8-b921e9589874
@TestID: REQ011
@Persona: general

Scenario: Independent Flight Termination System (Negative)
	Given I am a CAA flight-ops inspector
	When I verify the RPAS's equipment
	Then the RPAS does not have an independent flight termination system