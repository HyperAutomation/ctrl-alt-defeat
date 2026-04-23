@Version: 1
@LastUpdated: 2026-04-22 15:07:30.251165+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: c8c08621-87d5-4243-8fda-6cbca6729991
@TestID: REQ017
@Persona: general

Scenario: Industrial Sites - Negative Case
	Given a user is planning an operation near an industrial site
	When the user does not assess or mitigate risks associated with operations near industrial sites or activities such as live firing, gas venting, high-intensity radio transmissions
	Then the system fails to identify and manage risks associated with operations near industrial sites