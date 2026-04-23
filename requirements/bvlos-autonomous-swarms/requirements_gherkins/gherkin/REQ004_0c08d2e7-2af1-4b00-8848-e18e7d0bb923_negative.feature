@Version: 1
@LastUpdated: 2026-04-22 14:19:29.953345+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: aae2b0e9-fbc9-4928-9e1e-f6d8e1063678
@TestID: REQ004
@Persona: general

Scenario: Significant Change Without Assessment
	Given a significant change is made to an Applicant's OSC without proper assessment by the CAA or approved organization
	When the system allows the implementation of the changes without proper assessment
	Then the changes are not implemented until proper assessment has been conducted
	And appropriate action may be taken