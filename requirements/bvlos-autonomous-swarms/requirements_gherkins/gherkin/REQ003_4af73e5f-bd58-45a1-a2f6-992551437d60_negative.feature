@Version: 1
@LastUpdated: 2026-04-22 14:15:04.215476+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 66fd8664-6c8c-4fdd-b989-13adf036799f
@TestID: REQ003
@Persona: general

Scenario: OSC rejected
	Given applicants provide clear evidence that the Safety risks have been suitably mitigated but the CAA does not accept the OSC
	When the CAA rejects an OSC despite the provided evidence
	Then the applicant is informed of the reasons for rejection