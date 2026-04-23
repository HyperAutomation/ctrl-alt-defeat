@Version: 1
@LastUpdated: 2026-04-22 14:10:16.986673+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 3cc096a6-037d-4111-8f57-e20cdc485f29
@TestID: REQ002
@Persona: general

Scenario: Assessor sets SA/GR requirements with swarm-aware SORA evidence
	Given the CAA assessor has access to a UAS operational authorization application for operations with specific air and ground risks
	And given the assessor is using swarm-aware SORA evidence
	When the assessor reviews the provided swarm-aware SORA evidence
	And when the assessor sets SA/GR requirements based on that evidence
	Then the assessor can set SA/GR requirements defensibly