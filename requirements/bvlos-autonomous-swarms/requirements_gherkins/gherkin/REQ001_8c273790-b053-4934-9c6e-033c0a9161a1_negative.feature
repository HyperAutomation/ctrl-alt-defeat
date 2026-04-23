@Version: 1
@LastUpdated: 2026-04-22 14:06:30.352173+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 1dcc3b01-95e7-4a2c-945b-8bf34fbd12be
@TestID: REQ001
@Persona: general

Scenario: Incomplete OA Pack Received
	Given the CAA case officer has access to the applicant's incomplete Operational Authorisation (OA) pack
	When the OA pack is reviewed and found incomplete according to the compliance checklist
	Then a valid case cannot be opened by the CAA case officer