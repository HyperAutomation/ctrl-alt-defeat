@Version: 1
@LastUpdated: 2026-04-22 14:37:00.678976+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 51704556-016b-4bd0-8da3-1b2c1d820868
@TestID: REQ009
@Persona: general

Scenario: Negative Scenario - Failing to Trace HLR to LLR
	Given I have an incorrect or incomplete HLR requirement
	When I request the system to trace the given HLR requirement back to its corresponding LLR requirements
	Then the system fails to correctly trace the given HLR requirement back to its corresponding LLR requirements
	And I can verify that no or incorrect LLR requirements are traced