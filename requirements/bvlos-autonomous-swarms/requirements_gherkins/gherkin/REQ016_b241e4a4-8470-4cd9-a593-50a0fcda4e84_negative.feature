@Version: 1
@LastUpdated: 2026-04-22 15:03:27.538689+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: cfe4f5f2-bfc6-4e59-b316-8a309315e115
@TestID: REQ016
@Persona: general

Scenario: Inactive/Deleted Phased Trial Build-Up Details Viewing Failure
	Given the CAA program manager is logged in to the system and there are existing inactive or deleted phased trial build-ups
	When they try to view details of an inactive or deleted phased trial build-up
	Then they should not be able to see any relevant information about the inactive or deleted phased trial build-up
	And it should display a message indicating that the phased trial build-up is either inactive or has been deleted