@phase-5 @PSRQ
Feature: Targeted physical trials and real-world ODD boundary validation
  As a Sea-Trial Manager
  I want to validate synthetic model generalization on real-world ODD boundary conditions
  So that sim-to-real gap is quantified and model fitness for operational deployment is confirmed

  Background:
    Given the USV perception stack is under formal qualification
    And the PSRQ programme gate for Phase 5 is active
    And model has passed Phase 4 system-layer HIL evaluation
    And real-world trial conditions are scheduled and weather-dependent

  @critical @smoke @REQ-010 @SCEN-010
  Scenario Outline: Execute targeted physical trial with weather-state validation
    Given a targeted sea trial planned for <num_trials> trials covering ODD boundary conditions: visibility <visibility_range>, sea state <sea_state_range>, <weather_condition>
    When the trial manager executes real-world testing on actual vessel with candidate model
    Then model accuracy on real-world ODD-boundary conditions is within <accuracy_threshold>% of synthetic validation
    And sim-to-real gap is quantified and documented with root-cause analysis
    And trial telemetry (vessel position, target detections, sensor measurements) is logged and archived

    Examples:
      | num_trials | visibility_range | sea_state_range | weather_condition        | accuracy_threshold |
      | 3          | 50–200 m         | Beaufort 3–4    | fog, light rain          | 5                  |
      | 2          | 200–500 m        | Beaufort 2–3    | clear, calm seas         | 3                  |
      | 3          | 100–300 m        | Beaufort 4–5    | overcast, moderate wind  | 7                  |

  @critical @REQ-010
  Scenario: Validate model accuracy on unseen coastal trial data
    Given model qualified at 92% mAP in synthetic/HIL testing; deployed to real vessel for UK coastal waters trial
    When the verification engineer evaluates the model on 5000 real detections from three UK sea-trial exercises
    Then measured accuracy is 89% mAP (within 5% of synthetic baseline)
    And no critical failures (>5 second false-negative windows) are observed
    And sim-to-real gap analysis identifies lighting angle and water-surface reflection as minor contributors
    And trial outcome is approved for Phase 6 safety case gate

  @critical @REQ-010
  Scenario: Measure model performance under live weather variation
    Given three targeted sea trials executed in North Sea off Aberdeen under variable conditions
    When real-world weather varies across declared ODD range: visibility 150–450 m, sea state Beaufort 2–5, illumination clear to overcast
    Then model maintains ≥88% mAP across all real-world ODD conditions
    And environment-variable drift (visibility, sea state, illumination) is monitored and logged
    And no unplanned handovers to human operator occur; all autonomous decisions remain safe
    And weather-state validation report is submitted to Safety Case Author

  @major @REQ-010
  Scenario: Flag new failure mode discovered in real-world trial
    Given model has completed 2 sea trials with 89% mAP; third trial in heavily trafficked shipping lane planned
    When real-world traffic density exceeds training envelope (>10 vessels in 5 km radius) and visibility drops to 120 m
    Then model detects previously unseen failure mode: false negatives on small fishing vessels at long range
    And failure is documented with video evidence and root-cause analysis linking to ODD boundary extension
    And ODD domain is revised to exclude high-traffic scenarios until model retraining is completed
    And Phase 5 gate is held pending model update and re-validation

  @critical @REQ-010
  Scenario: Reconcile synthetic vs. real sensor calibration differences
    Given synthetic HIL training data used radar with 0.5° beamwidth; real vessel radar has 0.75° beamwidth
    When the verification engineer compares real vs. synthetic detections on identical encounter geometry
    Then systematic range-resolution differences are identified (±50 m on small targets)
    And synthetic data generation is refined with real sensor characteristics; model is retrained
    And re-validation on third trial confirms <3% accuracy improvement and sim-to-real alignment
    And calibration update is recorded in evidence store with model version link

  @critical @REQ-010
  Scenario: Complete Phase 5 gate sign-off with tri-trial validation
    Given three successful sea trials completed: North Sea calm, North Sea heavy weather, Channel shipping-lane trial
    When all three trials show model accuracy ≥88%, zero critical failures, and environmental conditions within declared ODD
    Then Phase 5 Real-World Validation gate is closed; model approved for Phase 6 safety case generation
    And consolidated trial report (3 trials, >15,000 real detections, weather/traffic variance logged) is archived
    And sim-to-real gap quantified and documented; traceability linked to ODD coverage evidence
    And green light issued to Safety Case Author for Phase 6 evidence bundle assembly
