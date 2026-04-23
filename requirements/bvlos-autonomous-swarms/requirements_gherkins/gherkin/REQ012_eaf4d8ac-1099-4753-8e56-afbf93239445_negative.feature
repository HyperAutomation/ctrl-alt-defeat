@Version: 1
@LastUpdated: 2026-04-22 14:47:53.100887+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 3f4067ab-608f-4795-8ef8-e09234bf0dff
@TestID: REQ012
@Persona: general

Scenario: System Fails To Generate DPIA & MOR Obligations Upon Request
	Given the CAA flight safety investigator is logged in to the system
	When the CAA flight safety investigator requests complete recorded evidence for an incident investigation
	Then the system does not generate a DPIA or MOR obligations