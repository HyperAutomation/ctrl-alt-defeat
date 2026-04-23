@Version: 1
@LastUpdated: 2026-04-22 15:03:27.361184+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: cfe4f5f2-bfc6-4e59-b316-8a309315e115
@TestID: REQ016
@Persona: general

Scenario: Unlocked Gate Change Success
	Given the CAA program manager is logged in to the system and there is an existing phased trial build-up with gates that have been locked
	When they unlock a gate and make changes at it
	Then the system should allow them to make changes
	And it should save their changes