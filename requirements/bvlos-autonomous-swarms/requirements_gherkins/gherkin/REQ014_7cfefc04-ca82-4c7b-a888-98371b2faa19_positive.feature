@Version: 1
@LastUpdated: 2026-04-22 14:53:02.419855+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 5029e5fb-6750-44d5-ac21-af5c37b27e4f
@TestID: REQ014
@Persona: general

Scenario: Remote Pilot Completes Syllabus (positive)
	Given the remote pilot has enrolled in a training program
	When the remote pilot completes all required syllabi for their specific use case
	Then the operator can confirm that the remote pilot has completed all necessary training