@Version: 1
@LastUpdated: 2026-04-22 14:19:29.779746+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: aae2b0e9-fbc9-4928-9e1e-f6d8e1063678
@TestID: REQ004
@Persona: general

Scenario: Remote Pilot With Equivalent Experience
	Given a remote pilot with equivalent experience accrued outside of the competence framework submits a trial flight request
	When the system verifies that the remote pilot meets other criteria (e.g., through personal logbook) and creates a TDA and consultation package for the trial flight based on the provided information
	Then the created TDA and consultation package is accepted by the CAA
	And the trial flight can proceed with proper segregation from other users