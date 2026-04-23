@Version: 1
@LastUpdated: 2026-04-22 14:15:04.033878+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 66fd8664-6c8c-4fdd-b989-13adf036799f
@TestID: REQ003
@Persona: general

Scenario: Unclear ConOps and ODD provided
	Given a CAA safety-case reviewer is presented with unclear or incomplete ConOps and ODD for a UAS operation
	When the reviewer attempts to judge nominal and worst-credible behaviour based on the provided ConOps and ODD
	Then the reviewer cannot accurately judge nominal and worst-credible behaviour