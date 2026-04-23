@Version: 1
@LastUpdated: 2026-04-22 14:53:02.562796+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 5029e5fb-6750-44d5-ac21-af5c37b27e4f
@TestID: REQ014
@Persona: general

Scenario: Independent Assessment Does Not Meet Requirements (negative)
	Given the operator has implemented an independent assessment process
	When remote pilots fail to meet all competency and currency requirements during assessments
	Then the operator cannot confirm that their remote pilots are competent and qualified