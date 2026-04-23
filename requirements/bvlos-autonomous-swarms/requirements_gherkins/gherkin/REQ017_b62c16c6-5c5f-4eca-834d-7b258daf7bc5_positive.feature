@Version: 1
@LastUpdated: 2026-04-22 15:07:30.031861+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: c8c08621-87d5-4243-8fda-6cbca6729991
@TestID: REQ017
@Persona: general

Scenario: Community Consultation - Positive Case
	Given a user is planning an operation in a community area
	When the user initiates press/media handling or prior-notification to landowners as required by CAP 1616 and GDPR
	Then the system correctly handles press/media requests and notifies landowners