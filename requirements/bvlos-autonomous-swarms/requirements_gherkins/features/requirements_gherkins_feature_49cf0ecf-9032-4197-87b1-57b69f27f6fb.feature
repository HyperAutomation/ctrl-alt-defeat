# Version: 1
# LastUpdated: 2026-04-22 15:10:47.324964+00:00
# Requirement Description: No user story addresses how classified MOD evidence is presented to the CAA under CAP 722H / JSP 440 without compromise to either side.

@REQ018
Feature: Classified Evidence Presentation for CAA Compliance

@PositiveFlow
Scenario: Presenting Classified Evidence Correctly
	Given the user is a CAA officer and has access to classified MOD evidence under CAP 722H / JSP 440
	When the user presents the classified MOD evidence to the CAA
	Then the CAA receives the classified MOD evidence without compromise

@PositiveFlow
Scenario: Raising Level-One Finding Correctly
	Given the user is a CAA officer and finds non-compliance with requirements that could lead to an effect on the safety of a UAS operation
	When the user raises a Level-one finding to the Entity approval holder
	Then the Entity approval holder receives the Level-one finding

@PositiveFlow
Scenario: Raising Observation Correctly
	Given the user is a CAA officer and considers that there is potential for future non-compliance or wishes to indicate an opportunity for safety improvement
	When the user raises an observation to the Entity approval holder
	Then the Entity approval holder receives the observation

@PositiveFlow
Scenario: Taking Subsequent Actions Correctly
	Given the user is a CAA officer and has received a notification of a finding or an observation
	When the user takes subsequent actions as expected (e.g., investigation, communication with Entity approval holder)
	Then the oversight report and associated findings/observations are closed

@NegativeFlow
Scenario: Not Taking Subsequent Actions Incorrectly
	Given the user is a CAA officer and has received a notification of a finding or an observation
	When the user does not take subsequent actions as expected (e.g., investigation, communication with Entity approval holder)
	Then the oversight report and associated findings/observations are not closed

@NegativeFlow
Scenario: Presenting Classified Evidence Incorrectly
	Given the user is a CAA officer and has access to classified MOD evidence under CAP 722H / JSP 440
	When the user presents the compromised classified MOD evidence to the CAA
	Then the CAA does not receive the classified MOD evidence without compromise

@NegativeFlow
Scenario: Raising Non-Level-One Finding Incorrectly
	Given the user is a CAA officer and finds non-compliance with requirements that does not lead to an effect on the safety of a UAS operation
	When the user raises a Level-one finding to the Entity approval holder
	Then the Entity approval holder does not receive the Level-one finding

@NegativeFlow
Scenario: Not Raising Observation Incorrectly
	Given the user is a CAA officer and considers that there is potential for future non-compliance or wishes to indicate an opportunity for safety improvement
	When the user does not raise an observation to the Entity approval holder
	Then the Entity approval holder does not receive the observation
