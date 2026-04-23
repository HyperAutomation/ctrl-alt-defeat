# Feature: Security Classification Custodianship
# Business Goal: GOAL-009 Manage Classified MOD Evidence
# Handling of MOD-sensitive evidence per CAP 722H and JSP 440

@classification @F20 @REQ018 @GOAL-009 @K8
Feature: Security Classification & MOD Evidence Handling
  As a CAA Classification Review Officer (CRO)
  I want to handle MOD-classified evidence safely
  So that classified MOD trials can proceed without security compromise

  Background:
    Given Classification Review Officer role established
    Given CAP 722H (MOD Cooperation) and JSP 440 (MOD Security) are operative standards
    And secure evidence pool (Classification-restricted access) is configured
    And classified trial evidence segregated from OFFICIAL-only evidence

  @critical
  Scenario: Classification detection and escalation
    Given hypothetical MOD trial applicant submits evidence package
    And package contains SECRET optical sensor specifications
    And envelope marked OFFICIAL-SENSITIVE but document body lacks SECRET header
    When Artefact Detector scans classification metadata
    And ML classifier scores document as SECRET with 85% confidence
    Then case escalates to Classification Review Officer automatically
    And document segregated to secure-access pool
    And SORA assessment proceeds on OFFICIAL docs only
    And SECRET docs reviewed by cleared subset (CRO + MAA Air Safety Officer only)
    And decision record redacted for unclassified disclosure

  @critical
  Scenario: Classification-aware evidence segregation workflow
    Given case with mixed OFFICIAL and SECRET documents
    And CRO assigned security clearance verification
    When CRO reviews evidence
    Then CRO can access:
      | All OFFICIAL-tier documents (no restriction)        |
      | All SECRET documents (SC or higher clearance)       |
      | Redacted summary of SECRET findings for case record |
    And unclassified personnel can access:
      | OFFICIAL documents only                             |
      | Case decision record (redacted summary)             |
      | NOT the underlying SECRET evidence                  |

  @major
  Scenario Outline: Classification tier handling matrix
    Given document marked as <classification_tier>
    And <reviewer_clearance> clearance held by reviewer
    When reviewer attempts to access document
    Then access outcome is <access_status>

    Examples:
      | classification_tier | reviewer_clearance | access_status |
      | OFFICIAL            | Any                | ALLOW         |
      | OFFICIAL-SENSITIVE  | Any                | ALLOW (need-to-know) |
      | SECRET              | SC (Security Cleared)| ALLOW         |
      | SECRET              | None               | DENY          |
      | TOP SECRET          | Any (CAA)          | DENY (MOD-only) |

  @major
  Scenario: Decision record redaction for unclassified disclosure
    Given case with SECRET SORA assessment
    And decision is APPROVE_WITH_CONDITIONS
    When decision record published to applicant
    Then published version includes:
      | Unclassified approval outcome              |
      | Unclassified conditions (operational rules) |
      | NOT the underlying SECRET technical rationale |
    And full SECRET version retained in sealed archive
    And applicant can appeal based on published unclassified version

  @major
  Scenario: MOD program liaison during classification review
    Given MOD trial with classified sensor specifications
    When CRO identifies classification ambiguities
    Then CRO can escalate to MOD classification officer for clarification
    And MOD classifies document officially via CAP 722H process
    And CRO records MOD classification authority in case history
    And classification determination becomes binding for trial duration
