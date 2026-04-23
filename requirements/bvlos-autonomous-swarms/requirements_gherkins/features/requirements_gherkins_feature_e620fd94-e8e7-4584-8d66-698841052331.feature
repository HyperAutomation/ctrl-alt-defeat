# Version: 1
# LastUpdated: 2026-04-22 14:32:41.084680+00:00
# Requirement Description: As a CAA autonomy reviewer I want the decision-making architecture airborne limits and emergent-behaviour evidence so that I can assure what the swarm will do collectively.

@REQ008
Feature: Swarm Decision Making Architecture Review

@PositiveFlow
Scenario: Reviewer can view airborne limits
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the decision-making architecture airborne limits for a swarm
	Then the requested information about the airborne limits should be displayed

@PositiveFlow
Scenario: Reviewer can view emergent behaviour
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the emergent behaviour evidence for a swarm
	Then the requested information about the emergent behaviour should be displayed

@PositiveFlow
Scenario: Reviewer can view multiple swarm data
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the decision-making architecture airborne limits and emergent behaviour evidence for multiple valid swarms
	Then the requested information about all specified swarms should be displayed

@PositiveFlow
Scenario: Reviewer can filter swarm data
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the decision-making architecture airborne limits and emergent behaviour evidence for multiple valid swarms with specific filtering options
	Then the requested information about all specified swarms that match the filter criteria should be displayed

@PositiveFlow
Scenario: Reviewer can change swarm data format
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the decision-making architecture airborne limits and emergent behaviour evidence for multiple valid swarms in a specific format (e.g., table, graph)
	Then the requested information about all specified swarms should be displayed in the chosen format

@NegativeFlow
Scenario: Reviewer cannot view airborne limits
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the decision-making architecture airborne limits for an invalid swarm ID
	Then a relevant error message should be displayed

@NegativeFlow
Scenario: Reviewer cannot view emergent behaviour
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the emergent behaviour evidence for an invalid swarm ID
	Then a relevant error message should be displayed

@NegativeFlow
Scenario: Reviewer cannot view multiple invalid swarm data
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the decision-making architecture airborne limits and emergent behaviour evidence for multiple invalid swarm IDs
	Then a relevant error message should be displayed

@NegativeFlow
Scenario: Reviewer cannot filter swarm data
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the decision-making architecture airborne limits and emergent behaviour evidence for multiple valid swarms with invalid or missing filtering options
	Then a relevant error message should be displayed

@NegativeFlow
Scenario: Reviewer cannot change swarm data format
	Given the CAA autonomy reviewer is logged in to the system
	When the reviewer requests the decision-making architecture airborne limits and emergent behaviour evidence for multiple valid swarms in an unsupported format (e.g., text, image)
	Then a relevant error message should be displayed
