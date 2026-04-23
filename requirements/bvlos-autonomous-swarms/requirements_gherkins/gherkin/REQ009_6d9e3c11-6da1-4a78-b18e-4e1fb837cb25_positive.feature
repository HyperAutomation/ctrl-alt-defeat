@Version: 1
@LastUpdated: 2026-04-22 14:37:00.540842+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 51704556-016b-4bd0-8da3-1b2c1d820868
@TestID: REQ009
@Persona: general

Scenario: Positive Scenario - Generating Artifacts
	Given I have a valid frozen-model with all necessary metadata
	When I request the system to generate AMLAS / SACE case, frozen-model manifest and explainability evidence for the given model
	Then the system generates the required artifacts (AMLAS/SACE case, frozen-model manifest, and explainability evidence) correctly
	And I can verify that all generated artifacts are complete and accurate