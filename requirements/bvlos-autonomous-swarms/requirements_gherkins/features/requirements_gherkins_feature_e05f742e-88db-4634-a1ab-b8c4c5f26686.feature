# Version: 1
# LastUpdated: 2026-04-22 14:57:50.972322+00:00
# Requirement Description: As a CAA/MAA liaison I want a signed apportionment so that regulatory ownership is gap-free.

@REQ015
Feature: Signed Apportionment Management

@PositiveFlow
Scenario: CAA Accepts Remote Pilot Experience
	Given a CAA/MAA liaison is present
	And given the remote pilot has equivalent remote pilot experience accrued outside of the competence framework
	When the remote pilot submits their personal logbook to demonstrate their experience
	Then the CAA accepts the remote pilot's experience for initial PFA qualification

@PositiveFlow
Scenario: CAA Assesses Impartiality
	Given a trainer or assessor is involved in the assessment activities
	When they are free of any pressure and incentive that could affect their judgement or results of their assessments
	Then the CAA ensures impartiality

@PositiveFlow
Scenario: CAA Approves Variation
	Given an Entity submits an application for a variation
	When they demonstrate to the CAA before implementing the change that it will continue to comply with the requirements of the RAE(PC) scheme after implementation
	Then the CAA approves the variation

@PositiveFlow
Scenario: CAA Approves Change in Entity Ownership
	Given a change in Entity ownership
	When the change is considered significant and requires an approval by the CAA
	Then the CAA approves the change in Entity ownership

@PositiveFlow
Scenario: CAA Accepts DA for Participant Flying a Civil Registered Aircraft
	Given an FDD at an MAA-regulated event
	When the FDD accepts a DA for a Participant flying a civil registered Aircraft where the DA would allow the Participant to breach any part of this RA. In such cases, the FDD should identify the areas where the display routine is not compliant with MAA Regulatory Publications (MRP) and inform the HoE
	Then the HoE assesses any additional risk caused by non-compliance and ensures that this Risk is ALARP and Tolerable

@NegativeFlow
Scenario: CAA Withdraws Remote Pilot Experience Provision
	Given a CAA/MAA liaison is present
	When the remote pilot submits their personal logbook to demonstrate their experience outside of competence framework after the provision has been withdrawn by amending policy
	Then the CAA does not accept the remote pilot's experience for initial PFA qualification

@NegativeFlow
Scenario: CAA Assesses Financial Incentives
	Given a trainer or assessor is involved in the assessment activities
	When they have financial incentive that could affect their judgement or results of their assessments
	Then the CAA does not accept the results of their assessments

@NegativeFlow
Scenario: CAA Rejects Variation
	Given an Entity submits an application for a variation
	When they fail to demonstrate to the CAA before implementing the change that it will continue to comply with the requirements of the RAE(PC) scheme after implementation
	Then the CAA rejects the variation

@NegativeFlow
Scenario: CAA Rejects Change in Entity Ownership
	Given a change in Entity ownership
	When the change is not considered significant and does not require an approval by the CAA
	Then the CAA rejects the change in Entity ownership

@NegativeFlow
Scenario: CAA Rejects DA for Participant Flying a Civil Registered Aircraft
	Given an FDD at an MAA-regulated event
	When the FDD does not accept a DA for a Participant flying a civil registered Aircraft where the DA would allow the Participant to breach any part of this RA. In such cases, the FDD should identify the areas where the display routine is not compliant with MAA Regulatory Publications (MRP) and inform the HoE
	Then the HoE does not assess any additional risk caused by non-compliance
