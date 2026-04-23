@Version: 1
@LastUpdated: 2026-04-22 15:03:27.271775+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: cfe4f5f2-bfc6-4e59-b316-8a309315e115
@TestID: REQ016
@Persona: general

Scenario: Invalid Phased Trial Build-Up
	Given the CAA program manager is logged in to the system
	When they try to create a new phased trial build-up without defining any gates or evidence requirements
	Then the system should not allow them to save the invalid phased trial build-up
	And it should display an error message indicating missing gate and/or evidence requirement