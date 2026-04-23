@Version: 1
@LastUpdated: 2026-04-22 15:07:30.163513+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: c8c08621-87d5-4243-8fda-6cbca6729991
@TestID: REQ017
@Persona: general

Scenario: Airspace Restrictions - Negative Case
	Given a user is planning an operation in restricted airspace
	When the user does not obtain necessary permissions or disregards airspace restrictions
	Then the system fails to identify and enforce airspace restrictions