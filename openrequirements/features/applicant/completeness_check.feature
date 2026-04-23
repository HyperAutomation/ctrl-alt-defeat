# Feature: Pack Completeness Validation
# Business Goal: GOAL-001 Build Defensible Approval Throughput
# Automated detection of required artefacts before substantive review

@applicant @intake @smoke @F02 @REQ001 @GOAL-001
Feature: Pack Completeness Validation
  As a CAA automated system
  I want to validate that all mandatory artefacts are present and correctly formatted
  So that applicants receive immediate feedback on missing elements before formal assessment begins

  Background:
    Given the Artefact Detector service is operational
    And clause library v2.1 defines mandatory artefacts per operation type
    And completeness timeout is set to 10 minutes

  @critical @smoke
  Scenario: Complete PDRA-01 VLOS pack transitions to assessment
    Given Edinburgh Napier University submits PDRA-01 VLOS pack containing:
      | ConOps v2.2                     |
      | Personnel & Training Manual     |
      | Safety Case                     |
      | Risk Register                   |
      | Aircraft Technical Data         |
      | Insurance Certificate (GBP 10M) |
      | Ground Survey                   |
      | Environmental Assessment        |
    When Artefact Detector runs on submission
    Then all 8 artefact types flagged GREEN within 10 minutes
    And case status transitions to INTAKE_COMPLETE
    And case gates to Phase 1 SORA Assessment

  @critical @smoke
  Scenario: Sparse BVLOS Swarm pack missing swarm-specific sections
    Given CTRL-ALT-DEFEAT submits BVLOS Swarm trial pack (5x RigiTech Eiger, Spadeadam)
    And SORA document lacks swarm-specific multi-agent hazard analysis sections
    And ML Model Manifest is absent
    When Artefact Detector scans submission
    Then SORA artefact flagged AMBER with coaching note
    And ML Model Manifest flagged RED with blocking note
    And case status set to RETURN_FOR_CLARIFICATION
    And structured feedback generated specifying swarm-aware requirements

  @major @regression
  Scenario Outline: Mandatory signature verification
    Given applicant submits pack with <document> section
    And <document> requires <duty_role> signature
    When completeness checker validates signature field
    Then <result> with message <feedback>

    Examples:
      | document            | duty_role            | result                         | feedback                            |
      | Safety Case         | Duty Holder          | RETURN_FOR_CLARIFICATION       | Signature field blank, obtain sign |
      | ConOps              | Operational Manager  | RETURN_FOR_CLARIFICATION       | Signature field blank, obtain sign |
      | Risk Register       | Safety Officer       | AMBER (acceptable if notarized) | Digital signature acceptable       |

  @major
  Scenario: Pack resubmission after clarification request accepted
    Given applicant previously received RETURN_FOR_CLARIFICATION feedback
    And applicant resubmits pack with 7 days of original request
    When Artefact Detector runs on resubmission
    Then previously missing artefacts now flagged GREEN
    And case transitions to INTAKE_COMPLETE
    And case history records resubmission cycle

  @minor
  Scenario: Oversized submission rejected with guidance
    Given applicant submits pack with total size > 5 GB
    When intake system performs size validation
    Then submission rejected with error message
    And applicant guided to split submission into logical groups
