@Version: 1
@LastUpdated: 2026-04-22 14:29:48.742854+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: bcb0db35-a37c-4ad5-a361-f5956e18f932
@TestID: REQ007
@Persona: general

Scenario: Coordinated Swarm De-Confliction - Negative Case
	Given a group of aircraft are in close proximity and need to coordinate their movements
	When the CAA DAA assessor initiates coordinated swarm de-confliction procedures but the system fails to resolve encounters predictably
	Then an error message is displayed indicating that the coordination was not successful