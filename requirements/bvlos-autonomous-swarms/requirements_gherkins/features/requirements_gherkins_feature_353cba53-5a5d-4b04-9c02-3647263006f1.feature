# Version: 1
# LastUpdated: 2026-04-22 14:40:24.752389+00:00
# Requirement Description: As a CAA human factors inspector I want workload duty and take-over evidence so that meaningful human control is demonstrated throughout.

@REQ010
Feature: Human Oversight and Crew Fitness

@PositiveFlow
Scenario: Ongoing Oversight
	Given the system is configured to allow CAA human factors inspector oversight
	When a CAA human factors inspector requests ongoing oversight of a specific crew member's workload duty and take-over evidence
	Then the system allows the inspector to review the requested information
	And the inspector can verify that the displayed information is accurate

@PositiveFlow
Scenario: Adequate Facilities and Conditions
	Given the Entity has submitted its exposition to the CAA
	When the CAA reviews the information provided by the Entity regarding facilities, working conditions, equipment, tools, processes, personnel, organization and coordination
	Then the CAA determines that the Entity's facilities, working conditions, equipment, tools, processes, personnel, organization and coordination are adequate to discharge their obligations under the requirements of the RAE(PC) scheme
	And the Entity is granted approval for practical flight training

@PositiveFlow
Scenario: Valid Workload Duty and Take-Over Evidence
	Given the CAA human factors inspector is logged in to the system
	When the inspector requests workload duty and take-over evidence for a specific crew member
	Then the system displays valid workload duty and take-over evidence for the requested crew member
	And the inspector can verify that the displayed information is accurate

@NegativeFlow
Scenario: No Ongoing Oversight
	Given the system is configured to disallow CAA human factors inspector oversight
	When a CAA human factors inspector requests ongoing oversight of a specific crew member's workload duty and take-over evidence
	Then an error message is displayed indicating that they are not allowed to perform the requested action
	And the inspector cannot proceed with their inspection

@NegativeFlow
Scenario: Inadequate Facilities and Conditions
	Given the Entity has submitted its exposition to the CAA
	When the CAA reviews the information provided by the Entity regarding facilities, working conditions, equipment, tools, processes, personnel, organization and coordination
	Then the CAA determines that the Entity's facilities, working conditions, equipment, tools, processes, personnel, organization and coordination are inadequate to discharge their obligations under the requirements of the RAE(PC) scheme
	And the Entity is denied approval for practical flight training

@NegativeFlow
Scenario: Incorrect Workload Duty and Take-Over Evidence
	Given the CAA human factors inspector is logged in to the system
	When the inspector requests workload duty and take-over evidence for a specific crew member who does not have valid data available
	Then an error message is displayed indicating that there's no valid workload duty or take-over evidence available
	And the inspector cannot proceed with their inspection
