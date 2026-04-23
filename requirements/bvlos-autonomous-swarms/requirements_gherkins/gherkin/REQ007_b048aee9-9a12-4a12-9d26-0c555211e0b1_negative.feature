@Version: 1
@LastUpdated: 2026-04-22 14:29:48.652854+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: bcb0db35-a37c-4ad5-a361-f5956e18f932
@TestID: REQ007
@Persona: general

Scenario: DO-365 / F3442 Evidence Generation - Negative Case
	Given the CAA DAA assessor is logged in to a system with no DO-365 / F3442 evidence generation capability
	When the CAA DAA assessor requests DO-365 / F3442 evidence for each aircraft
	Then an error message is displayed indicating that the requested evidence cannot be generated