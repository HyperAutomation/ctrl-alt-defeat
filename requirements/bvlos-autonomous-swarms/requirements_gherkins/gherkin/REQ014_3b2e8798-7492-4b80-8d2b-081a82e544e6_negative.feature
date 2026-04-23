@Version: 1
@LastUpdated: 2026-04-22 14:53:02.284477+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 5029e5fb-6750-44d5-ac21-af5c37b27e4f
@TestID: REQ014
@Persona: general

Scenario: Lack of Necessary Qualifications or Competencies (negative)
	Given the crew member's records show they do not meet all required qualifications and competencies
	When the CAA licensing inspector reviews the crew member's evidenced competency records
	Then the CAA licensing inspector cannot approve the crew member for flight operations