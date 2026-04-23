# Version: 1
# LastUpdated: 2026-04-22 15:07:30.272470+00:00
# Requirement Description: No user story covers community consultation press/media handling or prior-notification to landowners. Strongly implied by CAP 1616 and GDPR but absent.

@REQ017
Feature: Community Consultation Management

@PositiveFlow
Scenario: Community Consultation - Positive Case
	Given a user is planning an operation in a community area
	When the user initiates press/media handling or prior-notification to landowners as required by CAP 1616 and GDPR
	Then the system correctly handles press/media requests and notifies landowners

@PositiveFlow
Scenario: Airspace Restrictions - Positive Case
	Given a user is planning an operation in restricted airspace
	When the user obtains necessary permissions and adheres to airspace restrictions
	Then the system correctly identifies and enforces airspace restrictions

@PositiveFlow
Scenario: Industrial Sites - Positive Case
	Given a user is planning an operation near an industrial site
	When the user assesses and mitigates risks associated with operations near industrial sites or activities such as live firing, gas venting, high-intensity radio transmissions
	Then the system correctly identifies and manages risks associated with operations near industrial sites

@NegativeFlow
Scenario: Community Consultation - Negative Case
	Given a user is planning an operation in a community area
	When the user does not initiate press/media handling or prior-notification to landowners as required by CAP 1616 and GDPR
	Then the system fails to handle press/media requests and does not notify landowners

@NegativeFlow
Scenario: Airspace Restrictions - Negative Case
	Given a user is planning an operation in restricted airspace
	When the user does not obtain necessary permissions or disregards airspace restrictions
	Then the system fails to identify and enforce airspace restrictions

@NegativeFlow
Scenario: Industrial Sites - Negative Case
	Given a user is planning an operation near an industrial site
	When the user does not assess or mitigate risks associated with operations near industrial sites or activities such as live firing, gas venting, high-intensity radio transmissions
	Then the system fails to identify and manage risks associated with operations near industrial sites
