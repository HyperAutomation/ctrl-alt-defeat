# Version: 1
# LastUpdated: 2026-04-22 15:03:27.560222+00:00
# Requirement Description: As a CAA programme manager I want phased gates so that evidence builds progressively and is reversible.

@REQ016
Feature: Phased Gate Management

@PositiveFlow
Scenario: Correct Phased Gates Implementation
	Given the CAA program manager is logged in to the system
	When they create a new phased trial build-up with defined gates and evidence requirements
	Then the system should save the new phased trial build-up with all defined gates and evidence requirements
	And it should allow for reversible changes at each gate

@PositiveFlow
Scenario: Unlocked Gate Change Success
	Given the CAA program manager is logged in to the system and there is an existing phased trial build-up with gates that have been locked
	When they unlock a gate and make changes at it
	Then the system should allow them to make changes
	And it should save their changes

@PositiveFlow
Scenario: Inactive Phased Trial Build-Up Deletion Success
	Given the CAA program manager is logged in to the system and there is an existing inactive phased trial build-up
	When they delete the inactive phased trial build-up
	Then the system should allow them to delete it
	And it should remove all related data

@PositiveFlow
Scenario: Phased Trial Build-Up Details Viewing Success
	Given the CAA program manager is logged in to the system and there is an existing phased trial build-up
	When they view details of the existing phased trial build-up
	Then they should be able to see all relevant information about the phased trial build-up
	And it should display a clear and comprehensive overview

@NegativeFlow
Scenario: Invalid Phased Trial Build-Up
	Given the CAA program manager is logged in to the system
	When they try to create a new phased trial build-up without defining any gates or evidence requirements
	Then the system should not allow them to save the invalid phased trial build-up
	And it should display an error message indicating missing gate and/or evidence requirement

@NegativeFlow
Scenario: Locked Gate Change Failure
	Given the CAA program manager is logged in to the system and there is an existing phased trial build-up with gates that have been locked
	When they try to make changes at a locked gate
	Then the system should not allow them to make changes
	And it should display an error message indicating the gate has been locked

@NegativeFlow
Scenario: Active Phased Trial Build-Up Deletion Failure
	Given the CAA program manager is logged in to the system and there is an existing active phased trial build-up
	When they try to delete the active phased trial build-up
	Then the system should not allow them to delete it
	And it should display an error message indicating that the phased trial build-up cannot be deleted while it is still active

@NegativeFlow
Scenario: Inactive/Deleted Phased Trial Build-Up Details Viewing Failure
	Given the CAA program manager is logged in to the system and there are existing inactive or deleted phased trial build-ups
	When they try to view details of an inactive or deleted phased trial build-up
	Then they should not be able to see any relevant information about the inactive or deleted phased trial build-up
	And it should display a message indicating that the phased trial build-up is either inactive or has been deleted
