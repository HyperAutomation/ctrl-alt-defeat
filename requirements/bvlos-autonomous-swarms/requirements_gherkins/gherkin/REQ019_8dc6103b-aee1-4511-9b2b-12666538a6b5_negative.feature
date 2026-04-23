@Version: 1
@LastUpdated: 2026-04-22 15:14:38.556681+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: d1bb3128-33f5-4a96-9e54-6a1a8e36e15c
@TestID: REQ019
@Persona: general

Scenario: Active User Stories for Noise Species Disturbance at Dusk/Night and Battery-Fire Environmental Risk on Ground - Negative
	Given the system is in operation during dusk or night with active user stories related to noise species disturbance at dusk/night and battery-fire environmental risk on ground
	When a user tries to perform any action that would trigger these user stories but the conditions for their execution are not met
	Then the system should display an error message indicating that the conditions for execution of such user stories are not met