# Version: 1
# LastUpdated: 2026-04-22 14:37:00.792345+00:00
# Requirement Description: As a CAA AI/ML assurance specialist I want an AMLAS / SACE case a frozen-model manifest and explainability evidence so that ML components are assurable and forensically explainable.

@REQ009
Feature: AMLAS SACE Case Management

@PositiveFlow
Scenario: Positive Scenario - Generating Artifacts
	Given I have a valid frozen-model with all necessary metadata
	When I request the system to generate AMLAS / SACE case, frozen-model manifest and explainability evidence for the given model
	Then the system generates the required artifacts (AMLAS/SACE case, frozen-model manifest, and explainability evidence) correctly
	And I can verify that all generated artifacts are complete and accurate

@PositiveFlow
Scenario: Positive Scenario - Tracing HLR to LLR
	Given I have a specific HLR requirement
	When I request the system to trace the given HLR requirement back to its corresponding LLR requirements
	Then the system correctly traces the given HLR requirement back to its corresponding LLR requirements
	And I can verify that all traced LLR requirements are complete and accurate

@PositiveFlow
Scenario: Positive Scenario - Identifying New Hazards
	Given I have a new AI component with potential hazards
	When I request the system to identify and pass any new hazards introduced by this AI component back up to system-level safety processes for mitigation as derived requirements
	Then the system correctly identifies and passes any new hazards introduced by this AI component back up to system-level safety processes
	And I can verify that all passed hazards are complete, accurate, and actionable

@NegativeFlow
Scenario: Negative Scenario - Failing to Generate Artifacts
	Given I have an invalid frozen-model with missing metadata
	When I request the system to generate AMLAS / SACE case, frozen-model manifest and explainability evidence for the given model
	Then the system fails to generate the required artifacts (AMLAS/SACE case, frozen-model manifest, and explainability evidence) correctly
	And I can verify that no artifact is generated or an error message is displayed indicating the failure

@NegativeFlow
Scenario: Negative Scenario - Failing to Trace HLR to LLR
	Given I have an incorrect or incomplete HLR requirement
	When I request the system to trace the given HLR requirement back to its corresponding LLR requirements
	Then the system fails to correctly trace the given HLR requirement back to its corresponding LLR requirements
	And I can verify that no or incorrect LLR requirements are traced

@NegativeFlow
Scenario: Negative Scenario - Failing to Identify New Hazards
	Given I have a new AI component with potential hazards that the system is not able to identify
	When I request the system to identify and pass any new hazards introduced by this AI component back up to system-level safety processes for mitigation as derived requirements
	Then the system fails to correctly identify and pass any new hazards introduced by this AI component
	And I can verify that no hazard is passed or an error message is displayed indicating the failure
