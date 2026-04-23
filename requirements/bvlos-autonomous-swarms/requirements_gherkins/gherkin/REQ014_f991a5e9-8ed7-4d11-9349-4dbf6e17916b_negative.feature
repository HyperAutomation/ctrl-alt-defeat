@Version: 1
@LastUpdated: 2026-04-22 14:53:02.654450+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 5029e5fb-6750-44d5-ac21-af5c37b27e4f
@TestID: REQ014
@Persona: general

Scenario: FSTD Not Used or Misused for Remote Pilot Skills Acquisition & Maintenance (negative)
	Given the operator has implemented an FSTD
	When remote pilots do not use the FSTD, or misuse it during training sessions
	Then the operator cannot confirm that remote pilots are maintaining their competency