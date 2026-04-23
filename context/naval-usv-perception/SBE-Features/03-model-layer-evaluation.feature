@phase-3 @PSRQ
Feature: Model-layer accuracy, calibration, and adversarial robustness evaluation
  As a Verification Engineer
  I want to measure and document model-layer performance and robustness bounds
  So that AMLAS activities 1–4 are satisfied with measurable evidence for system-layer integration

  Background:
    Given the USV perception stack is under formal qualification
    And the PSRQ programme gate for Phase 3 is active
    And a candidate detection model is trained on real and synthetic sensor data

  @critical @smoke @REQ-004 @REQ-011 @SCEN-021
  Scenario Outline: Measure accuracy and calibration on held-out test sets
    Given a detection model trained on real sensor dataset + synthetic augmentation, evaluated on <test_set_size>-image held-out set
    When the verification engineer measures accuracy (<accuracy_metric>), precision, recall and calibration (ECE, MCE)
    Then the model achieves <mAP>% mAP, <precision>% precision, <recall>% recall, ECE=<ECE> (well-calibrated)
    And calibration report is logged; model approved for Phase 4 system integration
    And per-class and per-sensor-modality breakdown is recorded in evidence store

    Examples:
      | test_set_size | accuracy_metric | mAP  | precision | recall | ECE   |
      | 5000          | mAP             | 92   | 94        | 87     | 0.038 |
      | 3000          | mAP             | 89   | 91        | 85     | 0.044 |
      | 2000          | mAP             | 94   | 96        | 90     | 0.032 |

  @critical @REQ-011 @SCEN-022
  Scenario: Detect sim-to-real mismatch on novel coastal trial data
    Given model qualified at 92% mAP on held-out synthetic/real sensor dataset mix; deployed and tested on new sea-trial corpus
    When the verification engineer evaluates the model on 2000 images from a previously unseen UK coastal trial
    Then measured mAP drops to 71% due to novel lighting angle, tide-driven reflections, and pier occlusions
    And a critical sim-to-real mismatch is flagged; model retraining or ODD tightening is required
    And failure analysis is documented with root causes linked to ODD boundary conditions

  @critical @REQ-004 @SCEN-007
  Scenario: File robustness bounds for adversarial perturbations
    Given the detection model achieves 94% clean accuracy on ship class and 87% under L-infinity perturbation ε=8/255
    When the safety engineer runs adversarial testing framework and files the robustness bound in the evidence store
    Then a robustness certificate is generated stating the model tolerates 8/255 perturbation with 87% recall
    And the bound is linked to regulatory guidance (e.g., AMLAS activity 3.2)
    And robustness bound is approved by Safety Case Author before Phase 4 gate

  @critical @REQ-005 @SCEN-008
  Scenario Outline: Escalate safety finding when robust accuracy breaches SIL threshold
    Given the <object_class> class achieves <robust_accuracy>% robust accuracy under realistic maritime perturbations
    When the safety threshold (SIL 2 equivalent) requires ≥75% robust accuracy
    Then the process escalates the finding to a major safety exception and halts certification
    And the model owner must retrain or accept a reduced ODD domain (e.g., <restriction>)
    And escalation is logged with severity CRITICAL and requires safety engineer sign-off

    Examples:
      | object_class      | robust_accuracy | restriction                    |
      | small-boat (<5m)  | 62              | boats > 7 m only               |
      | fishing-vessel    | 68              | daylight-only operation        |
      | RIB (5–8m)        | 71              | sea state Beaufort 2–3 only    |

  @critical @REQ-005 @SCEN-009
  Scenario: Detect non-linear robustness degradation under compound adversarial conditions
    Given a small craft detection model qualified under fog (visibility 200 m) and separately under adversarial patches
    When the red-teamer applies both simultaneously (fog + 50-pixel adversarial patch on ship superstructure)
    Then the system detects non-linear robustness degradation: 72% (fog only) × 81% (patch only) ≠ measured 58%
    And a new compound-condition robustness bound is filed with interaction term documented
    And finding is escalated to Safety Case Author for ODD domain refinement

  @critical @REQ-006 @SCEN-027
  Scenario: Identify edge cases and brittleness via red-teaming
    Given the threat modeller runs red-teaming framework against the perception stack with scenario templates for spoofing, jamming and mimicry
    When red-teaming framework generates 50 adversarial maritime scenarios (e.g., radar ghost targets, visual mimicry of buoys as vessels)
    Then 50 scenarios execute; 8 scenarios successfully trigger false alarms or missed detections
    And each failure is documented with root cause and filed as a design gap for mitigation
    And red-team report is submitted to Safety Case Author with ODD revision recommendations

  @critical @REQ-007 @SCEN-024
  Scenario: Generate explainability report for model decision audit
    Given a small-boat detection failure on a fishing-vessel class: model confident (0.91) but incorrect
    When the certification authority generates explainability technique explanations for the misclassified image
    Then explainability technique surface map reveals the model relied on buoy-color features, not hull geometry
    And the finding triggers a retrain with weighted-focus on structural features; model re-qualified
    And explainability report is archived with per-sample and per-class aggregated summaries
