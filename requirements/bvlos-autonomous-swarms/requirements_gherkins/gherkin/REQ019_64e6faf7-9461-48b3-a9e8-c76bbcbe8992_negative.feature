@Version: 1
@LastUpdated: 2026-04-22 15:14:38.289214+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: d1bb3128-33f5-4a96-9e54-6a1a8e36e15c
@TestID: REQ019
@Persona: general

Scenario: No User Story for Noise Species Disturbance at Dusk/Night - Negative
	Given the system is in operation during dusk or night
	When a user creates and saves a new user story related to noise species disturbance at dusk/night
	Then the system should display an error message indicating that such a user story is not allowed