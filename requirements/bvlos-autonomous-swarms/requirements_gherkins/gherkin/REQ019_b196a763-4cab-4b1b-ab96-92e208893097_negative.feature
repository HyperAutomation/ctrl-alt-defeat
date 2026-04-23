@Version: 1
@LastUpdated: 2026-04-22 15:14:38.468249+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: d1bb3128-33f5-4a96-9e54-6a1a8e36e15c
@TestID: REQ019
@Persona: general

Scenario: Multiple User Stories for Battery-Fire Environmental Risk on Ground - Negative
	Given the system is in operation and there are multiple user stories related to battery-fire environmental risk on ground
	When a user tries to activate any of these user stories
	Then the system should display an error message indicating that such activation is not allowed