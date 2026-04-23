@Version: 1
@LastUpdated: 2026-04-22 15:18:58.765067+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 4f496c46-d523-40cd-beb2-e55b8c5e7bcf
@TestID: REQ020
@Persona: general

Scenario: Incorrect Creation of T&E Documentation Set
	Given the trial supervisor is responsible for creating a range safety/trials documentation set
	When the trial supervisor fails to create test plans, flight test cards, post-flight reports and trial reports as part of the T&E activity
	Then some or all required documents are missing
	And they do not address both safe execution of flight trials and ability to achieve trial objectives