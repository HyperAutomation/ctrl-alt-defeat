@Version: 1
@LastUpdated: 2026-04-22 14:50:26.918926+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: ba9467a5-ca38-4759-9750-e431b04e2348
@TestID: REQ013
@Persona: general

Scenario: CAA Authorisation Officer Requests Insurance and Ground Survey - Missing Documents
	Given the CAA authorization officer is logged in to the system
	When the CAA authorization officer requests insurance and ground survey for a UAS operation without providing required documents
	Then the system returns an error message indicating that all necessary documents must be provided before approval can be granted