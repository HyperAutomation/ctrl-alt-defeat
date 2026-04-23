@Version: 1
@LastUpdated: 2026-04-22 14:57:50.775697+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: bca53a7d-a026-4baf-a9f2-a330482a5a37
@TestID: REQ015
@Persona: general

Scenario: CAA Rejects Variation
	Given an Entity submits an application for a variation
	When they fail to demonstrate to the CAA before implementing the change that it will continue to comply with the requirements of the RAE(PC) scheme after implementation
	Then the CAA rejects the variation