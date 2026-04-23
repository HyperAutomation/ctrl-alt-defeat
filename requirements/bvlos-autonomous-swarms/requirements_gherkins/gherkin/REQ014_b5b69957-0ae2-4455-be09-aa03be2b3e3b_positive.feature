@Version: 1
@LastUpdated: 2026-04-22 14:53:02.239293+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 5029e5fb-6750-44d5-ac21-af5c37b27e4f
@TestID: REQ014
@Persona: general

Scenario: Verifying Evidenced Competency for Safe Flight Operations (positive)
	Given the CAA licensing inspector is logged in and has access to the system
	And the crew member's competency records are available
	When the CAA licensing inspector reviews the crew member's evidenced competency records
	Then the CAA licensing inspector can confirm that the crew member is qualified and meets all required competencies for safe flight operations