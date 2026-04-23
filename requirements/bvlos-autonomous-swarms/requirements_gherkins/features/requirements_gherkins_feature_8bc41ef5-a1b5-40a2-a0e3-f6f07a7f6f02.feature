# Version: 1
# LastUpdated: 2026-04-22 15:18:58.785966+00:00
# Requirement Description: No user story covers the post-trial lessons-learned evidence preservation and authorisation close-out.

@REQ020
Feature: Post Trial Evidence Preservation & Authorization Close Out

@PositiveFlow
Scenario: Correct Post-Trial Evidence Preservation and Authorization Close-Out
	Given the trial supervisor is responsible for ensuring post-trial evidence preservation and authorisation close-out
	And the T&E Activity has been carried out safely iaw the direction of the T&E Approvals Board
	When the trial supervisor documents the lessons-learned evidence preservation and initiates the authorization close-out process
	Then the post-trial lessons-learned evidence is preserved correctly
	And the authorisation close-out process is completed successfully

@PositiveFlow
Scenario: Correct Use of T&E Qualifications in Annexes B and C
	Given the T&E qualifications are defined below: Class A Test Pilot (TP), Long Course Test Pilot graduate of Empire Test Pilot School, United States Navy Test Pilot School, United States Air Force Test Pilot School, L’Ecole du Personnel Navigant d’Essais et de Reception
	And the T&E qualifications are used in Annexes B and C
	When a user accesses Annexes B and C to find the defined T&E qualifications
	Then the Class A Test Pilot (TP) qualification is found
	And other listed qualifications are also present in Annexes B and C

@PositiveFlow
Scenario: Correct Implementation of T&E Risk Management Processes
	Given the trial supervisor is responsible for implementing identification and risk management processes specific to T&E
	When the trial supervisor follows the identified and implemented risk management processes during a T&E activity
	Then the risks associated with the T&E activity are managed effectively
	And any issues or incidents are addressed promptly

@PositiveFlow
Scenario: Correct Creation of T&E Documentation Set
	Given the trial supervisor is responsible for creating a range safety/trials documentation set
	When the trial supervisor creates test plans, flight test cards, post-flight reports and trial reports as part of the T&E activity
	Then all required documents are created
	And they address both safe execution of flight trials and ability to achieve trial objectives

@NegativeFlow
Scenario: Incorrect Post-Trial Evidence Preservation and Authorization Close-Out
	Given the trial supervisor is responsible for ensuring post-trial evidence preservation and authorisation close-out
	And the T&E Activity has been carried out safely iaw the direction of the T&E Approvals Board
	When the trial supervisor fails to document the lessons-learned evidence preservation or initiate the authorization close-out process
	Then the post-trial lessons-learned evidence is not preserved correctly
	And the authorisation close-out process is not completed successfully

@NegativeFlow
Scenario: Incorrect Use of T&E Qualifications in Annexes B and C
	Given the T&E qualifications are defined below: Class A Test Pilot (TP), Long Course Test Pilot graduate of Empire Test Pilot School, United States Navy Test Pilot School, United States Air Force Test Pilot School, L’Ecole du Personnel Navigant d’Essais et de Reception
	And the T&E qualifications are not used in Annexes B and C
	When a user accesses Annexes B and C to find the defined T&E qualifications
	Then the Class A Test Pilot (TP) qualification is missing
	And other listed qualifications are not present in Annexes B and C

@NegativeFlow
Scenario: Incorrect Implementation of T&E Risk Management Processes
	Given the trial supervisor is responsible for implementing identification and risk management processes specific to T&E
	When the trial supervisor fails to follow the identified and implemented risk management processes during a T&E activity
	Then the risks associated with the T&E activity are not managed effectively
	And any issues or incidents are not addressed promptly

@NegativeFlow
Scenario: Incorrect Creation of T&E Documentation Set
	Given the trial supervisor is responsible for creating a range safety/trials documentation set
	When the trial supervisor fails to create test plans, flight test cards, post-flight reports and trial reports as part of the T&E activity
	Then some or all required documents are missing
	And they do not address both safe execution of flight trials and ability to achieve trial objectives
