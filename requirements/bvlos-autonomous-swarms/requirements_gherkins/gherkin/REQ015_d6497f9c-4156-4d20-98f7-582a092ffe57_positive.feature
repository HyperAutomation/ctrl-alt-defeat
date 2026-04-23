@Version: 1
@LastUpdated: 2026-04-22 14:57:50.903383+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: bca53a7d-a026-4baf-a9f2-a330482a5a37
@TestID: REQ015
@Persona: general

Scenario: CAA Accepts DA for Participant Flying a Civil Registered Aircraft
	Given an FDD at an MAA-regulated event
	When the FDD accepts a DA for a Participant flying a civil registered Aircraft where the DA would allow the Participant to breach any part of this RA. In such cases, the FDD should identify the areas where the display routine is not compliant with MAA Regulatory Publications (MRP) and inform the HoE
	Then the HoE assesses any additional risk caused by non-compliance and ensures that this Risk is ALARP and Tolerable