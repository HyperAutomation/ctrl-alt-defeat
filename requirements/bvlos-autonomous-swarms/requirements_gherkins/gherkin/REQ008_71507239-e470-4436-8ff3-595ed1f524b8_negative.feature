@Version: 1
@LastUpdated: 2026-04-22 14:32:40.785028+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 374e35d7-6b4a-462c-8530-217efbe55474
@TestID: REQ008
@Persona: general

Scenario: Reviewer cannot view emergent behaviour
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the emergent behaviour evidence for an invalid swarm ID
	Then a relevant error message should be displayed