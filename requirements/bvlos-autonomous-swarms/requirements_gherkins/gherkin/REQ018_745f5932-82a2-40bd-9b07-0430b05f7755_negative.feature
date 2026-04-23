@Version: 1
@LastUpdated: 2026-04-22 15:10:47.123412+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: b038ec13-6547-42f3-bd6a-fa426c6b04cb
@TestID: REQ018
@Persona: general

Scenario: Raising Non-Level-One Finding Incorrectly
	Given the user is a CAA officer and finds non-compliance with requirements that does not lead to an effect on the safety of a UAS operation
	When the user raises a Level-one finding to the Entity approval holder
	Then the Entity approval holder does not receive the Level-one finding