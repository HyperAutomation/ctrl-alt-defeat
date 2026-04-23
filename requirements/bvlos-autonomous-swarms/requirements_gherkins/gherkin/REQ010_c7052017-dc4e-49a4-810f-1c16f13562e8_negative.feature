@Version: 1
@LastUpdated: 2026-04-22 14:40:24.643475+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 509822f8-d30c-4819-9520-d9fc5b98f8bd
@TestID: REQ010
@Persona: general

Scenario: No Ongoing Oversight
	Given the system is configured to disallow CAA human factors inspector oversight
	When a CAA human factors inspector requests ongoing oversight of a specific crew member's workload duty and take-over evidence
	Then an error message is displayed indicating that they are not allowed to perform the requested action
	And the inspector cannot proceed with their inspection