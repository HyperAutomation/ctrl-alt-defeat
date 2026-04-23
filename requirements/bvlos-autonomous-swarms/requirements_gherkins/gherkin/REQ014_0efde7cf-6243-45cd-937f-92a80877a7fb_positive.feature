@Version: 1
@LastUpdated: 2026-04-22 14:53:02.329039+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 5029e5fb-6750-44d5-ac21-af5c37b27e4f
@TestID: REQ014
@Persona: general

Scenario: RAE(PC) Approval for Training & Assessment (positive)
	Given the RAE(PC) has submitted a request for approval
	When the CAA evaluates the RAE(PC)'s application and determines they meet all requirements
	Then the CAA approves the RAE(PC) to carry out training and assessment of remote pilots against required competencies