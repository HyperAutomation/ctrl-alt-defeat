@Version: 1
@LastUpdated: 2026-04-22 15:03:27.449627+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: cfe4f5f2-bfc6-4e59-b316-8a309315e115
@TestID: REQ016
@Persona: general

Scenario: Inactive Phased Trial Build-Up Deletion Success
	Given the CAA program manager is logged in to the system and there is an existing inactive phased trial build-up
	When they delete the inactive phased trial build-up
	Then the system should allow them to delete it
	And it should remove all related data