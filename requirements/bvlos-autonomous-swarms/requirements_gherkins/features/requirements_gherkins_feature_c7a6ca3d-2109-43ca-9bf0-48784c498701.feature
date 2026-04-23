# Version: 1
# LastUpdated: 2026-04-22 14:50:26.985005+00:00
# Requirement Description: As a CAA authorisation officer I want insurance and a ground survey so that third-party risk is both transferable and factually grounded.

@REQ013
Feature: Insurance and Ground Survey

@PositiveFlow
Scenario: CAA Authorisation Officer Requests Insurance and Ground Survey - Positive Case
	Given the CAA authorization officer is logged in to the system
	When the CAA authorization officer requests insurance and ground survey for a UAS operation with acceptable risks
	Then the system returns an approval message indicating that both insurance and ground survey have been approved

@PositiveFlow
Scenario: CAA Authorisation Officer Requests Insurance and Ground Survey - Equivalent Experience
	Given the CAA authorization officer is logged in to the system
	When the CAA authorization officer requests insurance and ground survey for a UAS operation with equivalent remote pilot experience
	Then the system returns an approval message indicating that both insurance and ground survey have been approved based on the applicant's prior experience

@NegativeFlow
Scenario: CAA Authorisation Officer Requests Insurance and Ground Survey - Negative Case
	Given the CAA authorization officer is logged in to the system
	When the CAA authorization officer requests insurance and ground survey for a UAS operation with unacceptable risks
	Then the system returns an error message indicating that both insurance and ground survey have been denied due to high risk

@NegativeFlow
Scenario: CAA Authorisation Officer Requests Insurance and Ground Survey - Missing Documents
	Given the CAA authorization officer is logged in to the system
	When the CAA authorization officer requests insurance and ground survey for a UAS operation without providing required documents
	Then the system returns an error message indicating that all necessary documents must be provided before approval can be granted
