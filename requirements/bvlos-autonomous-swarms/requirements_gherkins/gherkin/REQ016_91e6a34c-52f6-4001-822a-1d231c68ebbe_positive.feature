@Version: 1
@LastUpdated: 2026-04-22 15:03:27.227923+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: cfe4f5f2-bfc6-4e59-b316-8a309315e115
@TestID: REQ016
@Persona: general

Scenario: Correct Phased Gates Implementation
	Given the CAA program manager is logged in to the system
	When they create a new phased trial build-up with defined gates and evidence requirements
	Then the system should save the new phased trial build-up with all defined gates and evidence requirements
	And it should allow for reversible changes at each gate