# Feature: Submission Readiness & Gate Control
# Business Goal: GOAL-001 Build Defensible Approval Throughput
# Quality gate ensuring minimal viable evidence before assessment commences

@applicant @intake @regression @F04 @REQ001 @GOAL-001
Feature: Submission Readiness & Gate Control
  As a CAA intake team
  I want to verify that complete submissions meet minimum quality standards
  So that SORA assessors receive evidence bundles that are credible, traceable, and defence-ready

  Background:
    Given case status is INTAKE_COMPLETE
    And clause library v2.1 is current
    And Thorough Gate reviewer role exists

  @critical
  Scenario: Readiness gate blocks SORA progression on quality defects
    Given case has all mandatory artefacts present
    And Thorough Gate reviewer detects ConOps lacking crew workload analysis
    When reviewer initiates quality assessment
    Then case transitions to RETURN_FOR_CLARIFICATION
    And feedback specifies required additional analysis sections
    And estimated re-review timeline is provided

  @major
  Scenario Outline: Quality criterion evaluation matrix
    Given <operation_type> submission in INTAKE_COMPLETE status
    And <criterion> is evaluated per clause library
    When Thorough Gate reviewer assesses <criterion>
    Then outcome is <gate_status>
    And reason recorded in case history

    Examples:
      | operation_type      | criterion                              | gate_status              |
      | PDRA-01 VLOS        | ConOps describes nominal behaviour      | PASS → SORA_READY        |
      | PDRA-01 VLOS        | Risk Register missing worst-case       | BLOCK → RETURN_FOR_CLAIM |
      | BVLOS Swarm         | Swarm decision architecture incomplete  | BLOCK → RETURN_FOR_CLAIM |
      | BVLOS Swarm         | DAA evidence present and traced        | PASS → SORA_READY        |

  @major
  Scenario: Duty holder accountability gate
    Given Safety Case submitted with Duty Holder Declaration section
    When Thorough Gate reviewer verifies signature requirements
    And signature is present, dated, and notarized
    Then organisational accountability gate PASSES
    And case eligible for SORA assessment progression

  @minor
  Scenario: Evidence traceability spot-check
    Given case contains 15+ artefacts across 8 document types
    When Thorough Gate spot-checks 3 randomly selected clauses
    And verifies each clause has at least 1 mapped evidence artefact
    Then traceability sample audit completes
    And case readiness status APPROVED
