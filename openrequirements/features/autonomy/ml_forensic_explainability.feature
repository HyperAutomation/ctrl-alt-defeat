# Feature: ML/AI Forensic Explainability
# Business Goal: GOAL-004 Assure Autonomous Decision-Making & Human Control
# Accident investigators must be able to reconstruct ML-based decisions post-incident

@autonomy @F10 @REQ009 @GOAL-004 @K4
Feature: ML/AI Forensic Explainability & Model Assurance
  As a CAA ML assurance officer
  I want to ensure that ML models used in swarm decision-making are forensically explainable
  So that accident investigators can reconstruct and understand model predictions after incidents

  Background:
    Given ML model is frozen (immutable) for trial duration
    And AMLAS (Assurance Case for ML in Autonomous Systems) prepared and accepted
    And training data, model weights, and decision logs are retained
    And case status is AUTONOMY_REVIEW in progress

  @critical @smoke
  Scenario: Frozen model manifest provides audit trail
    Given CTRL-ALT-DEFEAT swarm uses ML de-confliction model
    When model deployed to aircraft
    Then manifest document generated containing:
      | Model version identifier                     |
      | Training data provenance and freeze date     |
      | Hyperparameters (learning rate, epochs, etc) |
      | Architecture (layers, activation functions)  |
      | Expected input ranges per sensor             |
      | Expected output ranges per action class      |
      | Training accuracy and validation metrics     |
    And manifest published to case record before flight ops

  @critical
  Scenario: Post-incident model decision reconstruction
    Given accident investigation of swarm collision with ground obstruction
    And AAIB investigator requests decision forensics
    When investigator provides:
      | Flight state at collision: position, velocity, heading |
      | Sensor inputs at t=5ms before impact                   |
    Then forensic replay system reconstructs:
      | Model input features extracted from flight state      |
      | Forward inference through frozen model               |
      | Predicted de-confliction action (climb, hold, turn)  |
      | Confidence score of prediction                       |
      | Saliency map showing which inputs influenced decision |
    And investigator can determine whether model failure or sensor failure caused incident

  @major @regression
  Scenario Outline: AMLAS evidence coverage matrix
    Given ML model performs <function> in swarm decision path
    And <evidence_type> assurance case prepared
    When assessor reviews evidence
    Then <status> with <feedback>

    Examples:
      | function                         | evidence_type                              | status | feedback                       |
      | De-confliction (obstacle avoidance)| Formal verification of training set coverage| ACCEPT | Credible generalization bounds |
      | Formation control (consensus)    | Robustness testing with adversarial inputs | ACCEPT | Model stable under noise       |
      | Risk estimation (collision pred) | Out-of-distribution detection capability  | BLOCK  | OOD detector insufficient      |

  @major
  Scenario: Off-distribution detection requirement for ML
    Given ML model trained on nominal sensor ranges and environmental conditions
    And trial operational domain (ODD) defines valid sensor inputs
    When aircraft operates and sensors provide out-of-range input
    Then model must detect OOD condition and:
      | Trigger crew alert via C2 link                |
      | Fall back to manual crew control              |
      | Log OOD event in forensic trail               |
      | Not execute model-predicted action if OOD     |
    And fallback mechanism prevents OOD-induced accidents

  @major
  Scenario: Model decision logging during flight
    Given 5x swarm in autonomous flight with ML de-confliction
    When model executes decision (e.g., climb, turn, hold)
    Then every decision logged with:
      | Timestamp (microsecond precision)           |
      | Input feature vector from sensors           |
      | Model predicted action and confidence       |
      | Actual action executed by aircraft          |
      | Outcome (successful separation, etc)        |
    And logs retained post-flight for audit trail

  @major
  Scenario: AMLAS assurance case acceptance gate
    Given applicant submits AMLAS for 5-aircraft autonomous swarm
    When CAA ML assessor reviews assurance case
    Then assessor checks for:
      | Stakeholder needs (safety, explainability)                |
      | Model fitness (training data quality, validation metrics) |
      | Robustness (noise tolerance, adversarial testing)        |
      | Monitoring (performance tracking during flight)          |
      | Fallback (degraded behavior if model confidence low)     |
    And case is ACCEPTED or RETURN_FOR_CLARIFICATION
