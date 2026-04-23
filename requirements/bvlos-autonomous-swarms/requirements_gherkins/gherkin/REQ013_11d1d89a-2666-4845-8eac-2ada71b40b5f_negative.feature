@Version: 1
@LastUpdated: 2026-04-22 14:50:26.873737+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: ba9467a5-ca38-4759-9750-e431b04e2348
@TestID: REQ013
@Persona: general

Scenario: CAA Authorisation Officer Requests Insurance and Ground Survey - Negative Case
	Given the CAA authorization officer is logged in to the system
	When the CAA authorization officer requests insurance and ground survey for a UAS operation with unacceptable risks
	Then the system returns an error message indicating that both insurance and ground survey have been denied due to high risk