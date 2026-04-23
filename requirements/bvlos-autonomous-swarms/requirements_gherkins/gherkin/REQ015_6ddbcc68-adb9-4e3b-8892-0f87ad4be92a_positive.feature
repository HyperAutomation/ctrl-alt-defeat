@Version: 1
@LastUpdated: 2026-04-22 14:57:50.816228+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: bca53a7d-a026-4baf-a9f2-a330482a5a37
@TestID: REQ015
@Persona: general

Scenario: CAA Approves Change in Entity Ownership
	Given a change in Entity ownership
	When the change is considered significant and requires an approval by the CAA
	Then the CAA approves the change in Entity ownership