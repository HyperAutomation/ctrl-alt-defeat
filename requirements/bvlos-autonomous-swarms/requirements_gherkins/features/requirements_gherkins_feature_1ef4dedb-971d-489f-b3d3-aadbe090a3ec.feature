# Version: 1
# LastUpdated: 2026-04-22 14:27:53.403369+00:00
# Requirement Description: As a CAA spectrum specialist I want authorised monitored C2 and inter-vehicle links so that link loss is survivable and non-interfering.

@REQ006
Feature: C2 Link Survivability

@PositiveFlow
Scenario: Authorized Monitored C2 Link
	Given the CAA spectrum specialist is authorized and has access to the system
	When the CAA spectrum specialist authorizes a monitored C2 link
	Then the C2 link functions correctly

@PositiveFlow
Scenario: Functioning Inter-Vehicle Links
	Given the inter-vehicle links are established
	When the inter-vehicle links function without loss or interference
	Then no link loss or interference is detected

@NegativeFlow
Scenario: Non-Functioning C2 Link
	Given the CAA spectrum specialist has authorized a monitored C2 link
	When the C2 link does not function correctly
	Then an emergency recovery function is triggered and the aircraft returns to home

@NegativeFlow
Scenario: Harmful Interference
	Given the RPAS data links are established
	When harmful interference occurs on the RPAS data links
	Then pairing, encryption, and backup link mechanisms protect the data links
