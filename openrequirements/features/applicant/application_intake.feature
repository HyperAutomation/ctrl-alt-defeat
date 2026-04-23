# Feature: Application Intake & Case Opening
# Business Goal: GOAL-001 Build Defensible Approval Throughput
# Establishes case record and enables completeness validation workflow

@applicant @intake @smoke @F01 @REQ001 @GOAL-001
Feature: Application Intake & Case Opening
  As a CAA case officer
  I want to accept Operational Authorisation packs from trial applicants
  So that valid cases are opened in a traceable, auditable manner per CAP 722D standards

  Background:
    Given the clause library version is pinned to 2.1
    And CAA case officer system is operational
    And applicant identity is verified against CAA approved operators list

  @critical @smoke
  Scenario: Complete pack submission opens case successfully
    Given Edinburgh Napier University has assembled a complete PDRA-01 VLOS pack
    When the applicant submits the Operational Authorisation pack to the CAA intake system
    Then a unique case identifier is generated within 30 seconds
    And case status transitions to INTAKE_SUBMITTED
    And case officer receives automated notification
    And submission timestamp is recorded in audit log

  @major @regression
  Scenario Outline: Multi-operator submission with operation type classification
    Given applicant <operator> submits pack for <operation_type>
    When the system performs intake validation
    Then case opens with classification <operation_class>
    And applicable clauses from clause library v2.1 are pinned to case

    Examples:
      | operator                  | operation_type     | operation_class |
      | Edinburgh Napier          | PDRA-01 VLOS       | VLOS-Single     |
      | CTRL-ALT-DEFEAT           | BVLOS Swarm        | BVLOS-Multi     |
      | UK MOD trial programme    | BVLOS Swarm (Sec)  | BVLOS-Class     |

  @major
  Scenario: Applicant pack submitted with duplicate case number rejected
    Given case ABC-2026-001 exists in system
    When applicant attempts to resubmit with same case identifier
    Then system rejects submission with error message
    And notifies applicant to use unique case identifier
    And audit log records rejection attempt
