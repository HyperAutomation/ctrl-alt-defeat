@Version: 1
@LastUpdated: 2026-04-22 15:18:58.460182+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 4f496c46-d523-40cd-beb2-e55b8c5e7bcf
@TestID: REQ020
@Persona: general

Scenario: Correct Post-Trial Evidence Preservation and Authorization Close-Out
	Given the trial supervisor is responsible for ensuring post-trial evidence preservation and authorisation close-out
	And the T&E Activity has been carried out safely iaw the direction of the T&E Approvals Board
	When the trial supervisor documents the lessons-learned evidence preservation and initiates the authorization close-out process
	Then the post-trial lessons-learned evidence is preserved correctly
	And the authorisation close-out process is completed successfully