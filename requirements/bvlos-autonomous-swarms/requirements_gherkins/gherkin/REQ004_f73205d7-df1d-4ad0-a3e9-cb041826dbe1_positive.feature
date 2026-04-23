@Version: 1
@LastUpdated: 2026-04-22 14:19:29.693201+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: aae2b0e9-fbc9-4928-9e1e-f6d8e1063678
@TestID: REQ004
@Persona: general

Scenario: Valid TDA and Consultation Package
	Given a valid trial flight request has been submitted to the system
	When the system creates a TDA and consultation package for the trial flight based on the provided information
	Then the created TDA and consultation package meets CAA's requirements and is accepted by the CAA
	And the trial flight can proceed with proper segregation from other users