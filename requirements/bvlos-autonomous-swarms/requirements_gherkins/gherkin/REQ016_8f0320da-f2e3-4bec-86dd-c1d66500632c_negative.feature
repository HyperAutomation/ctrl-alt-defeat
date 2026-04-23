@Version: 1
@LastUpdated: 2026-04-22 15:03:27.316539+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: cfe4f5f2-bfc6-4e59-b316-8a309315e115
@TestID: REQ016
@Persona: general

Scenario: Locked Gate Change Failure
	Given the CAA program manager is logged in to the system and there is an existing phased trial build-up with gates that have been locked
	When they try to make changes at a locked gate
	Then the system should not allow them to make changes
	And it should display an error message indicating the gate has been locked