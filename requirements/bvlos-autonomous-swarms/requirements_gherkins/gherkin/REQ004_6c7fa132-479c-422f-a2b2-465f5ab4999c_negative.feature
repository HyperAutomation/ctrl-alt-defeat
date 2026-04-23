@Version: 1
@LastUpdated: 2026-04-22 14:19:29.736414+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: aae2b0e9-fbc9-4928-9e1e-f6d8e1063678
@TestID: REQ004
@Persona: general

Scenario: Invalid TDA and Consultation Package
	Given an invalid trial flight request has been submitted to the system
	When the system creates a TDA and consultation package for the trial flight based on the provided information
	Then the created TDA and consultation package does not meet CAA's requirements
	And the CAA rejects the TDA and consultation package