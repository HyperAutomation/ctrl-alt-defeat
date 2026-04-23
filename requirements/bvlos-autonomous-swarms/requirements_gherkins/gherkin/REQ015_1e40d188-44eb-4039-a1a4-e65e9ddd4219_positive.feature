@Version: 1
@LastUpdated: 2026-04-22 14:57:50.569507+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: bca53a7d-a026-4baf-a9f2-a330482a5a37
@TestID: REQ015
@Persona: general

Scenario: CAA Accepts Remote Pilot Experience
	Given a CAA/MAA liaison is present
	And given the remote pilot has equivalent remote pilot experience accrued outside of the competence framework
	When the remote pilot submits their personal logbook to demonstrate their experience
	Then the CAA accepts the remote pilot's experience for initial PFA qualification