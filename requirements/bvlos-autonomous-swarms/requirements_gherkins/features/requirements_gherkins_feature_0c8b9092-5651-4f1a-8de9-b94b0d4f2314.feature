# Version: 1
# LastUpdated: 2026-04-22 14:06:30.599062+00:00
# Requirement Description: As a CAA case officer I want to receive a complete Operational Authorisation pack so that I can open a valid case.

@REQ001
Feature: Operational Authorization Pack Generation

@PositiveFlow
Scenario: Complete OA Pack Received
	Given the CAA case officer has access to the applicant's Operational Authorisation (OA) pack
	When the OA pack is reviewed and found complete according to the compliance checklist
	Then a valid case can be opened by the CAA case officer

@NegativeFlow
Scenario: Incomplete OA Pack Received
	Given the CAA case officer has access to the applicant's incomplete Operational Authorisation (OA) pack
	When the OA pack is reviewed and found incomplete according to the compliance checklist
	Then a valid case cannot be opened by the CAA case officer

@NegativeFlow
Scenario: Missing Information in OA Pack
	Given the CAA case officer has access to the applicant's Operational Authorisation (OA) pack with missing information
	When the OA pack is reviewed and found incomplete according to the compliance checklist, but a note from the applicant explaining that they will provide the missing information later is present
	Then a valid case cannot be opened by the CAA case officer until all required information is provided

@NegativeFlow
Scenario: Incorrect Documentation in OA Pack
	Given the CAA case officer has access to the applicant's Operational Authorisation (OA) pack with incorrect or outdated documentation
	When the OA pack is reviewed and found incomplete according to the compliance checklist due to incorrect or outdated documentation
	Then a valid case cannot be opened by the CAA case officer until all required documentation is corrected

@NegativeFlow
Scenario: Missing Compliance Checklist
	Given the CAA case officer has access to the applicant's Operational Authorisation (OA) pack without a compliance checklist
	When the OA pack is reviewed and found incomplete according to the compliance checklist because it lacks a compliance checklist
	Then a valid case cannot be opened by the CAA case officer until a complete compliance checklist is provided

@NegativeFlow
Scenario: Incorrect Compliance Checklist
	Given the CAA case officer has access to the applicant's Operational Authorisation (OA) pack with an incorrect or incomplete compliance checklist
	When the OA pack is reviewed and found incomplete according to the compliance checklist due to errors on the compliance checklist
	Then a valid case cannot be opened by the CAA case officer until all required information on the compliance checklist is corrected
