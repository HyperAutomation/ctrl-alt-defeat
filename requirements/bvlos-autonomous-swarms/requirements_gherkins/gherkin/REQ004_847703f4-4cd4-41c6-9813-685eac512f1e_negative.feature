@Version: 1
@LastUpdated: 2026-04-22 14:19:29.910020+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: aae2b0e9-fbc9-4928-9e1e-f6d8e1063678
@TestID: REQ004
@Persona: general

Scenario: Lack of Notification
	Given a trial flight request is submitted without proper notification to other airspace users
	When the system fails to make the required notifications to other airspace users
	Then other airspace users are not informed of the trial flight
	And the CAA may take appropriate action