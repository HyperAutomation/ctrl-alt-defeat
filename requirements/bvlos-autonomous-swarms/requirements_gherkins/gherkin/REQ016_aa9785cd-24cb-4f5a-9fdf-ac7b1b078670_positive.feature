@Version: 1
@LastUpdated: 2026-04-22 15:03:27.494352+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: cfe4f5f2-bfc6-4e59-b316-8a309315e115
@TestID: REQ016
@Persona: general

Scenario: Phased Trial Build-Up Details Viewing Success
	Given the CAA program manager is logged in to the system and there is an existing phased trial build-up
	When they view details of the existing phased trial build-up
	Then they should be able to see all relevant information about the phased trial build-up
	And it should display a clear and comprehensive overview