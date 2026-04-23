# Version: 1
# LastUpdated: 2026-04-22 14:29:48.764188+00:00
# Requirement Description: As a CAA DAA assessor I want DO-365 / F3442-aligned evidence for each aircraft and coordinated swarm de-confliction so that cooperative and non-cooperative encounters are resolved predictably.

@REQ007
Feature: Coordinated Swarm De Confliction

@PositiveFlow
Scenario: DO-365 / F3442 Evidence Generation - Positive Case
	Given the CAA DAA assessor is logged in to the system
	When the CAA DAA assessor requests DO-365 / F3442 evidence for each aircraft
	Then the system generates and displays DO-365 / F3442 aligned evidence for each aircraft

@PositiveFlow
Scenario: Coordinated Swarm De-Confliction - Positive Case
	Given a group of aircraft are in close proximity and need to coordinate their movements
	When the CAA DAA assessor initiates coordinated swarm de-confliction procedures
	Then the system predictably resolves cooperative and non-cooperative encounters

@NegativeFlow
Scenario: DO-365 / F3442 Evidence Generation - Negative Case
	Given the CAA DAA assessor is logged in to a system with no DO-365 / F3442 evidence generation capability
	When the CAA DAA assessor requests DO-365 / F3442 evidence for each aircraft
	Then an error message is displayed indicating that the requested evidence cannot be generated

@NegativeFlow
Scenario: Coordinated Swarm De-Confliction - Negative Case
	Given a group of aircraft are in close proximity and need to coordinate their movements
	When the CAA DAA assessor initiates coordinated swarm de-confliction procedures but the system fails to resolve encounters predictably
	Then an error message is displayed indicating that the coordination was not successful
