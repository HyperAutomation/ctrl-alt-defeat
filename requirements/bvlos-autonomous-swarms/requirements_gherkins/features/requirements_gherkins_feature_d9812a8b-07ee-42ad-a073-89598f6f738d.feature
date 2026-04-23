# Version: 1
# LastUpdated: 2026-04-22 15:14:38.578116+00:00
# Requirement Description: No user story covers noise species disturbance at dusk/night or battery-fire environmental risk on ground.

@REQ019
Feature: Environmental Risk Assessment

@PositiveFlow
Scenario: No User Story for Noise Species Disturbance at Dusk/Night - Positive
	Given the system is in operation during dusk or night
	When a user tries to create a new user story related to noise species disturbance at dusk/night
	Then the system should not allow the creation of such a user story

@PositiveFlow
Scenario: No User Story for Battery-Fire Environmental Risk on Ground - Positive
	Given the system is in operation
	When a user tries to create a new user story related to battery-fire environmental risk on ground
	Then the system should not allow the creation of such a user story

@PositiveFlow
Scenario: Multiple User Stories for Noise Species Disturbance at Dusk/Night - Positive
	Given the system is in operation during dusk or night and there are multiple user stories related to noise species disturbance at dusk/night
	When a user tries to activate any of these user stories
	Then the system should not allow activation of such user stories

@PositiveFlow
Scenario: Active User Stories for Noise Species Disturbance at Dusk/Night and Battery-Fire Environmental Risk on Ground - Positive
	Given the system is in operation during dusk or night with active user stories related to noise species disturbance at dusk/night and battery-fire environmental risk on ground
	When a user tries to perform any action that would trigger these user stories
	Then the system should execute the actions as per the requirements of each active user story

@NegativeFlow
Scenario: No User Story for Noise Species Disturbance at Dusk/Night - Negative
	Given the system is in operation during dusk or night
	When a user creates and saves a new user story related to noise species disturbance at dusk/night
	Then the system should display an error message indicating that such a user story is not allowed

@NegativeFlow
Scenario: No User Story for Battery-Fire Environmental Risk on Ground - Negative
	Given the system is in operation
	When a user creates and saves a new user story related to battery-fire environmental risk on ground
	Then the system should display an error message indicating that such a user story is not allowed

@NegativeFlow
Scenario: Multiple User Stories for Battery-Fire Environmental Risk on Ground - Negative
	Given the system is in operation and there are multiple user stories related to battery-fire environmental risk on ground
	When a user tries to activate any of these user stories
	Then the system should display an error message indicating that such activation is not allowed

@NegativeFlow
Scenario: Active User Stories for Noise Species Disturbance at Dusk/Night and Battery-Fire Environmental Risk on Ground - Negative
	Given the system is in operation during dusk or night with active user stories related to noise species disturbance at dusk/night and battery-fire environmental risk on ground
	When a user tries to perform any action that would trigger these user stories but the conditions for their execution are not met
	Then the system should display an error message indicating that the conditions for execution of such user stories are not met
