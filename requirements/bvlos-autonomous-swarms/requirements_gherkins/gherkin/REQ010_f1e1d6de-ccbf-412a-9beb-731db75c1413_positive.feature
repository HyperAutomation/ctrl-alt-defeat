@Version: 1
@LastUpdated: 2026-04-22 14:40:24.510720+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 509822f8-d30c-4819-9520-d9fc5b98f8bd
@TestID: REQ010
@Persona: general

Scenario: Valid Workload Duty and Take-Over Evidence
	Given the CAA human factors inspector is logged in to the system
	When the inspector requests workload duty and take-over evidence for a specific crew member
	Then the system displays valid workload duty and take-over evidence for the requested crew member
	And the inspector can verify that the displayed information is accurate