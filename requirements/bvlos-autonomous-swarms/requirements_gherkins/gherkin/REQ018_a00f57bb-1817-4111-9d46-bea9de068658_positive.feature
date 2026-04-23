@Version: 1
@LastUpdated: 2026-04-22 15:10:46.989885+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: b038ec13-6547-42f3-bd6a-fa426c6b04cb
@TestID: REQ018
@Persona: general

Scenario: Presenting Classified Evidence Correctly
	Given the user is a CAA officer and has access to classified MOD evidence under CAP 722H / JSP 440
	When the user presents the classified MOD evidence to the CAA
	Then the CAA receives the classified MOD evidence without compromise