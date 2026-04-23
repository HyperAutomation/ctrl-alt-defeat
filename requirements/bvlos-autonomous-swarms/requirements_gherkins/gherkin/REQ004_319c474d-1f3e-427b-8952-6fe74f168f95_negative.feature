@Version: 1
@LastUpdated: 2026-04-22 14:19:29.824127+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: aae2b0e9-fbc9-4928-9e1e-f6d8e1063678
@TestID: REQ004
@Persona: general

Scenario: Remote Pilot Who Does Not Meet Criteria
	Given a remote pilot who does not meet the criteria set out in the competence framework submits a trial flight request
	When the system verifies that the remote pilot does not meet all requirements and rejects their TDA and consultation package application
	Then the remote pilot's TDA and consultation package is rejected
	And they are informed of the reason for rejection