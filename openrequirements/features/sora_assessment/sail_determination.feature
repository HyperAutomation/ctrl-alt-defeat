# Feature: SAIL Determination & Evidence Adequacy
# Business Goal: GOAL-002 Assure Swarm-Aware Safety Assessment
# Map operational risks to assurance levels and evaluate evidence sufficiency

@sora_assessment @F03 @REQ002 @GOAL-002
Feature: SAIL Determination & Evidence Adequacy
  As a SORA assessor
  I want to determine Specific Assurance and Integrity Level (SAIL) based on risk profile
  So that evidence requirements are proportionate and defence-ready against regulatory scrutiny

  Background:
    Given JARUS SORA v2.5 methodology applied
    And case status is SORA_READY or RETURN_FOR_CLARIFICATION with new evidence

  @critical @smoke
  Scenario: SAIL-I determination for low-risk single VLOS
    Given Edinburgh Napier PDRA-01 VLOS operation:
      | Single aircraft                      |
      | VLOS with crew direct visual contact |
      | Manual control at all times          |
      | Geofenced 500m radius                |
      | Daylight hours only                  |
    When SORA assessment completes
    Then SAIL determination = SAIL-I
    And OSO (Operational Safety Objectives) include:
      | Ground risk mitigation via geofence        |
      | Airborne risk via manual crew control      |
      | No autonomy evidence required              |

  @major
  Scenario: SAIL-III determination triggers AMLAS requirement
    Given CTRL-ALT-DEFEAT BVLOS Swarm with:
      | 5x aircraft autonomous swarm      |
      | ML-based de-confliction algorithm |
      | C2 link with single-point failure |
    When SORA assessment determines SAIL-III required
    Then OSO include:
      | Assurance Case for Machine Learning (AMLAS) required |
      | Frozen model manifest with training data provenance  |
      | Off-distribution detection capability                |
    And feedback: submit ML assurance case for review

  @major
  Scenario: Evidence adequacy gate blocks premature progression
    Given case with SAIL-III determination
    And applicant submits partial ConOps lacking loss-of-separation cascade analysis
    When assessor performs evidence sufficiency review
    Then assessment transitions to RETURN_FOR_CLARIFICATION
    And specific evidence gaps identified:
      | Section 4.2: Multi-agent separation logic (incomplete)       |
      | Section 5.1: Emergent formation boundaries (not addressed)   |
    And re-submission deadline: 21 days
