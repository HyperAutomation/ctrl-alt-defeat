@Version: 1
@LastUpdated: 2026-04-22 14:57:50.694332+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: bca53a7d-a026-4baf-a9f2-a330482a5a37
@TestID: REQ015
@Persona: general

Scenario: CAA Assesses Financial Incentives
	Given a trainer or assessor is involved in the assessment activities
	When they have financial incentive that could affect their judgement or results of their assessments
	Then the CAA does not accept the results of their assessments