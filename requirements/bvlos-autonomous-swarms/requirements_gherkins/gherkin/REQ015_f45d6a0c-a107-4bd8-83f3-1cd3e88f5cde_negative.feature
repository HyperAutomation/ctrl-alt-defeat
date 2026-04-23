@Version: 1
@LastUpdated: 2026-04-22 14:57:50.612180+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: bca53a7d-a026-4baf-a9f2-a330482a5a37
@TestID: REQ015
@Persona: general

Scenario: CAA Withdraws Remote Pilot Experience Provision
	Given a CAA/MAA liaison is present
	When the remote pilot submits their personal logbook to demonstrate their experience outside of competence framework after the provision has been withdrawn by amending policy
	Then the CAA does not accept the remote pilot's experience for initial PFA qualification