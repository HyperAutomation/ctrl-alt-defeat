@Version: 1
@LastUpdated: 2026-04-22 15:14:38.333614+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: d1bb3128-33f5-4a96-9e54-6a1a8e36e15c
@TestID: REQ019
@Persona: general

Scenario: No User Story for Battery-Fire Environmental Risk on Ground - Positive
	Given the system is in operation
	When a user tries to create a new user story related to battery-fire environmental risk on ground
	Then the system should not allow the creation of such a user story