# Version: 1
# LastUpdated: 2026-04-22 14:44:08.460799+00:00
# Requirement Description: As a CAA flight-ops inspector I want independent termination a contingency matrix and ATSU coordination so that the trial can be made safe in any off-nominal state.

@REQ011
Feature: Independent Termination of Contingency Matrix and ATSU Coordination

@PositiveFlow
Scenario: Independent Flight Termination System (Positive)
	Given I am a CAA flight-ops inspector
	When I verify the RPAS's equipment
	Then the RPAS is equipped with an independent flight termination system

@PositiveFlow
Scenario: Terminate RPAS in Off-Nominal State (Positive)
	Given I am a CAA flight-ops inspector
	And the RPAS is in an off-nominal state
	When I initiate independent termination of the RPAS
	Then the RPAS safely shuts down

@PositiveFlow
Scenario: Access Contingency Matrix (Positive)
	Given I am a CAA flight-ops inspector
	When I access the RPAS's contingency matrix
	Then I can view and understand the contingency matrix

@PositiveFlow
Scenario: ATSU Coordination (Positive)
	Given I am a CAA flight-ops inspector
	When I coordinate with the ATSU for RPAS operations
	Then the ATSU is able to monitor and provide input on RPAS operations

@PositiveFlow
Scenario: Appropriate Warnings (Positive)
	Given I am a CAA flight-ops inspector
	When I observe RPAS operations
	Then appropriate audible and visible warnings are present

@PositiveFlow
Scenario: Appropriate Conspicuity (Positive)
	Given I am a CAA flight-ops inspector
	When I observe RPAS operations from a distance
	Then the RPAS is easily visible

@NegativeFlow
Scenario: Terminate RPAS in Off-Nominal State (Negative)
	Given I am a CAA flight-ops inspector
	And the RPAS is in an off-nominal state
	When I attempt to initiate independent termination of the RPAS
	Then the RPAS does not shut down

@NegativeFlow
Scenario: ATSU Coordination (Negative)
	Given I am a CAA flight-ops inspector
	When I attempt to coordinate with the ATSU for RPAS operations
	Then the ATSU is unable to monitor or provide input on RPAS operations

@NegativeFlow
Scenario: Appropriate Warnings (Negative)
	Given I am a CAA flight-ops inspector
	When I observe RPAS operations without any off-nominal state
	Then no audible or visible warnings are present

@NegativeFlow
Scenario: Independent Flight Termination System (Negative)
	Given I am a CAA flight-ops inspector
	When I verify the RPAS's equipment
	Then the RPAS does not have an independent flight termination system
