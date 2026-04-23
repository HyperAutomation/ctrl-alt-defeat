# Version: 1
# LastUpdated: 2026-04-22 14:47:53.298165+00:00
# Requirement Description: As a CAA flight safety investigator I want complete recorded evidence accepted MOR obligations and a DPIA so that any incident is investigable and privacy is protected.

@REQ012
Feature: Compliance Management: MOR & DPIA

@PositiveFlow
Scenario: CAA Flight Safety Investigator Requests Complete Recorded Evidence, MOR Obligations & DPIA
	Given the CAA flight safety investigator is logged in to the system
	When the CAA flight safety investigator requests complete recorded evidence for an incident investigation
	Then the system accepts the request and generates a DPIA along with MOR obligations

@PositiveFlow
Scenario: System Ensures No Damage To Or Tampering Of Records
	Given the system is storing recorded evidence
	When the system checks for any damage or tampering of records
	Then the system ensures no damage to, or tampering of records can occur

@PositiveFlow
Scenario: System Complies With Requests From Air Accident Investigation Branch Where Required
	Given the system receives a request from Air Accident Investigation Branch
	When the system complies with the request
	Then the system successfully completes any audits and inspections that may be required by the CAA as part of the application process

@NegativeFlow
Scenario: System Fails To Generate DPIA & MOR Obligations Upon Request
	Given the CAA flight safety investigator is logged in to the system
	When the CAA flight safety investigator requests complete recorded evidence for an incident investigation
	Then the system does not generate a DPIA or MOR obligations

@NegativeFlow
Scenario: System Fails To Prevent Damage To Or Tampering Of Records
	Given the system is storing recorded evidence
	When the system checks for any damage or tampering of records
	Then the system fails to prevent damage to, or tampering of records

@NegativeFlow
Scenario: System Fails To Comply With Requests From Air Accident Investigation Branch
	Given the system receives a request from Air Accident Investigation Branch
	When the system fails to comply with the request
	Then the system does not successfully complete any audits and inspections that may be required by the CAA as part of the application process
