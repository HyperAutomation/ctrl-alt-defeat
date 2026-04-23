@Version: 1
@LastUpdated: 2026-04-22 15:10:47.211856+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: b038ec13-6547-42f3-bd6a-fa426c6b04cb
@TestID: REQ018
@Persona: general

Scenario: Not Raising Observation Incorrectly
	Given the user is a CAA officer and considers that there is potential for future non-compliance or wishes to indicate an opportunity for safety improvement
	When the user does not raise an observation to the Entity approval holder
	Then the Entity approval holder does not receive the observation