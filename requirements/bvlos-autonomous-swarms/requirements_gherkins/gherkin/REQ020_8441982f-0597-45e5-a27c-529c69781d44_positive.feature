@Version: 1
@LastUpdated: 2026-04-22 15:18:58.548036+00:00
@GroupID: d2d7a3f3-976c-405c-8391-bece26e631bf
@Requirement: 4f496c46-d523-40cd-beb2-e55b8c5e7bcf
@TestID: REQ020
@Persona: general

Scenario: Correct Use of T&E Qualifications in Annexes B and C
	Given the T&E qualifications are defined below: Class A Test Pilot (TP), Long Course Test Pilot graduate of Empire Test Pilot School, United States Navy Test Pilot School, United States Air Force Test Pilot School, L’Ecole du Personnel Navigant d’Essais et de Reception
	And the T&E qualifications are used in Annexes B and C
	When a user accesses Annexes B and C to find the defined T&E qualifications
	Then the Class A Test Pilot (TP) qualification is found
	And other listed qualifications are also present in Annexes B and C