@Version: 1
@LastUpdated: 2026-04-22 14:29:48.609906+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: bcb0db35-a37c-4ad5-a361-f5956e18f932
@TestID: REQ007
@Persona: general

Scenario: DO-365 / F3442 Evidence Generation - Positive Case
	Given the CAA DAA assessor is logged in to the system
	When the CAA DAA assessor requests DO-365 / F3442 evidence for each aircraft
	Then the system generates and displays DO-365 / F3442 aligned evidence for each aircraft