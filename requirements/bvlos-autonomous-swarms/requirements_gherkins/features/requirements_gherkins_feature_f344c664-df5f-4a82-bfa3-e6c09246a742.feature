# Version: 1
# LastUpdated: 2026-04-22 14:19:29.973855+00:00
# Requirement Description: As a CAA airspace regulator I want a TDA and consultation package so that I can segregate the trial from other users.

@REQ004
Feature: TDA and Consultation Package

@PositiveFlow
Scenario: Valid TDA and Consultation Package
	Given a valid trial flight request has been submitted to the system
	When the system creates a TDA and consultation package for the trial flight based on the provided information
	Then the created TDA and consultation package meets CAA's requirements and is accepted by the CAA
	And the trial flight can proceed with proper segregation from other users

@PositiveFlow
Scenario: Remote Pilot With Equivalent Experience
	Given a remote pilot with equivalent experience accrued outside of the competence framework submits a trial flight request
	When the system verifies that the remote pilot meets other criteria (e.g., through personal logbook) and creates a TDA and consultation package for the trial flight based on the provided information
	Then the created TDA and consultation package is accepted by the CAA
	And the trial flight can proceed with proper segregation from other users

@NegativeFlow
Scenario: Invalid TDA and Consultation Package
	Given an invalid trial flight request has been submitted to the system
	When the system creates a TDA and consultation package for the trial flight based on the provided information
	Then the created TDA and consultation package does not meet CAA's requirements
	And the CAA rejects the TDA and consultation package

@NegativeFlow
Scenario: Remote Pilot Who Does Not Meet Criteria
	Given a remote pilot who does not meet the criteria set out in the competence framework submits a trial flight request
	When the system verifies that the remote pilot does not meet all requirements and rejects their TDA and consultation package application
	Then the remote pilot's TDA and consultation package is rejected
	And they are informed of the reason for rejection

@NegativeFlow
Scenario: Inappropriate PFA
	Given a Practical Flight Assessor (PFA) with inappropriate knowledge, background, or experience submits a trial flight request
	When the system verifies that the PFA does not meet all requirements and rejects their TDA and consultation package application
	Then the PFA's TDA and consultation package is rejected
	And they are informed of the reason for rejection

@NegativeFlow
Scenario: Lack of Notification
	Given a trial flight request is submitted without proper notification to other airspace users
	When the system fails to make the required notifications to other airspace users
	Then other airspace users are not informed of the trial flight
	And the CAA may take appropriate action

@NegativeFlow
Scenario: Significant Change Without Assessment
	Given a significant change is made to an Applicant's OSC without proper assessment by the CAA or approved organization
	When the system allows the implementation of the changes without proper assessment
	Then the changes are not implemented until proper assessment has been conducted
	And appropriate action may be taken
