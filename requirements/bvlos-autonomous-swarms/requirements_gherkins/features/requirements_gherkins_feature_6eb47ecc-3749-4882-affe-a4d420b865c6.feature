# Version: 1
# LastUpdated: 2026-04-22 14:15:04.320988+00:00
# Requirement Description: As a CAA safety-case reviewer I want a clear ConOps and ODD so that I can judge nominal and worst-credible behaviour.

@REQ003
Feature: Concepts Of Operations And Operational Design Domain Evaluation

@PositiveFlow
Scenario: Clear ConOps and ODD provided
	Given a CAA safety-case reviewer is presented with clear ConOps and ODD for a UAS operation
	When the reviewer judges nominal and worst-credible behaviour based on the provided ConOps and ODD
	Then the reviewer can accurately judge nominal and worst-credible behaviour

@PositiveFlow
Scenario: CAA decision appealed
	Given a remote pilot is dissatisfied with the way an RAE has conducted their competency assessment
	When the pilot raises that issue with the CAA and requests a review of conduct of test or exam
	Then the CAA reviews the conduct of the test or exam

@PositiveFlow
Scenario: OSC accepted
	Given applicants provide clear evidence that the Safety risks have been suitably mitigated
	When the CAA accepts an OSC after reviewing the provided evidence
	Then the CAA confirms that the Safety risks are both tolerable and ALARP

@PositiveFlow
Scenario: Impartiality maintained
	Given trainers and assessors are free of any pressure or incentive that could affect their judgement or the results of their assessments
	When the remuneration of the persons involved in assessment activities is not affected by financial type incentives
	Then impartiality and avoiding conflicts of interest are ensured during assessment activities

@NegativeFlow
Scenario: Unclear ConOps and ODD provided
	Given a CAA safety-case reviewer is presented with unclear or incomplete ConOps and ODD for a UAS operation
	When the reviewer attempts to judge nominal and worst-credible behaviour based on the provided ConOps and ODD
	Then the reviewer cannot accurately judge nominal and worst-credible behaviour

@NegativeFlow
Scenario: CAA decision not appealed
	Given a remote pilot is dissatisfied with the way an RAE has conducted their competency assessment but does not raise that issue with the CAA
	When the pilot fails to request a review of conduct of test or exam
	Then the CAA's decision stands

@NegativeFlow
Scenario: OSC rejected
	Given applicants provide clear evidence that the Safety risks have been suitably mitigated but the CAA does not accept the OSC
	When the CAA rejects an OSC despite the provided evidence
	Then the applicant is informed of the reasons for rejection

@NegativeFlow
Scenario: Impartiality compromised
	Given trainers and assessors have financial incentives that could affect their judgement or the results of their assessments
	When the remuneration of the persons involved in assessment activities is affected by financial type incentives
	Then impartiality and avoiding conflicts of interest are not ensured during assessment activities
