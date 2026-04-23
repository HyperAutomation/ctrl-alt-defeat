# Version: 1
# LastUpdated: 2026-04-22 14:10:17.128500+00:00
# Requirement Description: As a CAA SORA assessor I want swarm-aware SORA evidence so that I can set SAIL and OSO requirements defensibly.

@REQ002
Feature: Swarmaware SORA Evidence Management

@PositiveFlow
Scenario: Assessor sets SAIL and OSO requirements with swarm-aware SORA evidence
	Given the CAA assessor has access to a UAS operational authorization application
	And given the assessor is using swarm-aware SORA evidence
	When the assessor reviews the provided swarm-aware SORA evidence
	And when the assessor sets SAIL and OSO requirements based on that evidence
	Then the assessor can set SAIL and OSO requirements defensibly

@PositiveFlow
Scenario: Assessor sets BVLOS requirements with swarm-aware SORA evidence
	Given the CAA assessor has access to a UAS operational authorization application for BVLOS operations
	And given the assessor is using swarm-aware SORA evidence
	When the assessor reviews the provided swarm-aware SORA evidence
	And when the assessor sets BVLOS requirements based on that evidence
	Then the assessor can set BVLOS requirements defensibly

@PositiveFlow
Scenario: Assessor sets SA/GR requirements with swarm-aware SORA evidence
	Given the CAA assessor has access to a UAS operational authorization application for operations with specific air and ground risks
	And given the assessor is using swarm-aware SORA evidence
	When the assessor reviews the provided swarm-aware SORA evidence
	And when the assessor sets SA/GR requirements based on that evidence
	Then the assessor can set SA/GR requirements defensibly

@PositiveFlow
Scenario: Assessor sets RSM requirements with swarm-aware SORA evidence
	Given the CAA assessor has access to a UAS operational authorization application for operations with robust safety measures
	And given the assessor is using swarm-aware SORA evidence
	When the assessor reviews the provided swarm-aware SORA evidence
	And when the assessor sets RSM requirements based on that evidence
	Then the assessor can set RSM requirements defensibly

@NegativeFlow
Scenario: Assessor fails to set SAIL and OSO requirements with invalid swarm-aware SORA evidence
	Given the CAA assessor has access to a UAS operational authorization application
	And given the assessor is using invalid or incomplete swarm-aware SORA evidence
	When the assessor reviews the provided invalid or incomplete swarm-aware SORA evidence
	And when the assessor attempts to set SAIL and OSO requirements based on that evidence
	Then the assessor cannot set SAIL and OSO requirements defensibly

@NegativeFlow
Scenario: Assessor fails to set BVLOS requirements with invalid swarm-aware SORA evidence
	Given the CAA assessor has access to a UAS operational authorization application for BVLOS operations
	And given the assessor is using invalid or incomplete swarm-aware SORA evidence
	When the assessor reviews the provided invalid or incomplete swarm-aware SORA evidence
	And when the assessor attempts to set BVLOS requirements based on that evidence
	Then the assessor cannot set BVLOS requirements defensibly

@NegativeFlow
Scenario: Assessor fails to set SA/GR requirements with invalid swarm-aware SORA evidence
	Given the CAA assessor has access to a UAS operational authorization application for operations with specific air and ground risks
	And given the assessor is using invalid or incomplete swarm-aware SORA evidence
	When the assessor reviews the provided invalid or incomplete swarm-aware SORA evidence
	And when the assessor attempts to set SA/GR requirements based on that evidence
	Then the assessor cannot set SA/GR requirements defensibly

@NegativeFlow
Scenario: Assessor fails to set RSM requirements with invalid swarm-aware SORA evidence
	Given the CAA assessor has access to a UAS operational authorization application for operations with robust safety measures
	And given the assessor is using invalid or incomplete swarm-aware SORA evidence
	When the assessor reviews the provided invalid or incomplete swarm-aware SORA evidence
	And when the assessor attempts to set RSM requirements based on that evidence
	Then the assessor cannot set RSM requirements defensibly
