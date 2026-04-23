@Version: 1
@LastUpdated: 2026-04-22 14:15:04.122791+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 66fd8664-6c8c-4fdd-b989-13adf036799f
@TestID: REQ003
@Persona: general

Scenario: CAA decision not appealed
	Given a remote pilot is dissatisfied with the way an RAE has conducted their competency assessment but does not raise that issue with the CAA
	When the pilot fails to request a review of conduct of test or exam
	Then the CAA's decision stands