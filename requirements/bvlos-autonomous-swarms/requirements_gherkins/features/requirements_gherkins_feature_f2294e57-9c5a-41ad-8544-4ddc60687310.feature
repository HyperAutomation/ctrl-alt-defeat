# Version: 1
# LastUpdated: 2026-04-22 14:53:02.676575+00:00
# Requirement Description: As a CAA licensing inspector I want evidenced competency so that the trial is flown by qualified crew.

@REQ014
Feature: Crew Training & Competency

@PositiveFlow
Scenario: Verifying Evidenced Competency for Safe Flight Operations (positive)
	Given the CAA licensing inspector is logged in and has access to the system
	And the crew member's competency records are available
	When the CAA licensing inspector reviews the crew member's evidenced competency records
	Then the CAA licensing inspector can confirm that the crew member is qualified and meets all required competencies for safe flight operations

@PositiveFlow
Scenario: RAE(PC) Approval for Training & Assessment (positive)
	Given the RAE(PC) has submitted a request for approval
	When the CAA evaluates the RAE(PC)'s application and determines they meet all requirements
	Then the CAA approves the RAE(PC) to carry out training and assessment of remote pilots against required competencies

@PositiveFlow
Scenario: Remote Pilot Completes Syllabus (positive)
	Given the remote pilot has enrolled in a training program
	When the remote pilot completes all required syllabi for their specific use case
	Then the operator can confirm that the remote pilot has completed all necessary training

@PositiveFlow
Scenario: Independent Assessment Meets Requirements (positive)
	Given the operator has implemented an independent assessment process
	When the remote pilots undergo regular assessments and meet all requirements
	Then the operator can confirm that their remote pilots are competent and qualified

@PositiveFlow
Scenario: FSTD Used for Remote Pilot Skills Acquisition & Maintenance (positive)
	Given the operator has implemented an FSTD
	When remote pilots use the FSTD to practice and maintain their skills
	Then the operator can confirm that remote pilots are maintaining their competency

@NegativeFlow
Scenario: Lack of Necessary Qualifications or Competencies (negative)
	Given the crew member's records show they do not meet all required qualifications and competencies
	When the CAA licensing inspector reviews the crew member's evidenced competency records
	Then the CAA licensing inspector cannot approve the crew member for flight operations

@NegativeFlow
Scenario: RAE(PC) Not Approved Due to Lack of Requirements (negative)
	Given the RAE(PC)'s application is incomplete or does not meet all requirements
	When the CAA evaluates the RAE(PC)'s application
	Then the CAA denies the RAE(PC) approval to carry out training and assessment of remote pilots against required competencies

@NegativeFlow
Scenario: Remote Pilot Fails to Complete Syllabus (negative)
	Given the remote pilot has enrolled in a training program
	When the remote pilot fails to complete one or more required syllabi for their specific use case
	Then the operator cannot confirm that the remote pilot is competent and qualified

@NegativeFlow
Scenario: Independent Assessment Does Not Meet Requirements (negative)
	Given the operator has implemented an independent assessment process
	When remote pilots fail to meet all competency and currency requirements during assessments
	Then the operator cannot confirm that their remote pilots are competent and qualified

@NegativeFlow
Scenario: FSTD Not Used or Misused for Remote Pilot Skills Acquisition & Maintenance (negative)
	Given the operator has implemented an FSTD
	When remote pilots do not use the FSTD, or misuse it during training sessions
	Then the operator cannot confirm that remote pilots are maintaining their competency
