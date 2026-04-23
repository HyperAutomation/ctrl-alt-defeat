@phase-7 @PSRQ
Feature: Live drift detection and continuous re-qualification for in-service monitoring
  As an In-Service Monitor
  I want to detect distribution drift on ODD environment variables and trigger automated re-qualification
  So that operational safety is maintained and model performance SLO breaches are caught within 2 hours

  Background:
    Given the USV perception stack is deployed to operational service post-qualification
    And the PSRQ programme gate for Phase 7 is active
    And drift monitors are live on ≥3 ODD environment variables (sea state, visibility, illumination)
    And model snapshot and re-qualification pipeline is automated and ready

  @critical @smoke @REQ-013 @SCEN-013
  Scenario Outline: Detect sea-state drift and trigger SLO alert
    Given live deployment with statistical drift monitoring on sea-state (Beaufort scale inferred from radar spectral moments)
    When observed sea state drifts from SIL 2 training envelope (Beaufort <train_min>–<train_max>) to measured Beaufort <observed> for >1 hour
    Then the drift detector computes P-value < 0.05 (Kolmogorov–Smirnov test vs. training distribution)
    And an automatic alert is issued: Re-qualification required; model performance SLO at risk
    And model snapshot is captured and re-qualification checkpoint is triggered within <alert_latency> minutes

    Examples:
      | train_min | train_max | observed | alert_latency |
      | 2         | 4         | 5        | 5             |
      | 2         | 3         | 4        | 5             |

  @critical @REQ-013 @SCEN-014
  Scenario Outline: Issue SLO-yellow and SLO-red escalation for visibility drift
    Given deployment monitoring 3 ODD variables (visibility, sea state, illumination) with SLO ±<slo_margin>% from baseline
    When visibility mean drifts from <baseline> m to <observed> m (at <confidence>% CI confidence interval boundary)
    Then the system issues an SLO-yellow alert indicating marginal breach
    And if the drift persists for ><slo_red_duration> hours, escalates to SLO-red and triggers model snapshot checkpoint
    And escalation event is logged with timestamp, environment readings, and confidence intervals

    Examples:
      | slo_margin | baseline | observed | confidence | slo_red_duration |
      | 10         | 300      | 310      | 95         | 2                |
      | 10         | 200      | 185      | 95         | 2                |
      | 15         | 400      | 460      | 90         | 3                |

  @critical @REQ-013 @SCEN-015
  Scenario: Log human override when operator continues operation during SLO-red alert
    Given drift monitor has issued SLO-red alert (sea state Beaufort 5 detected)
    When the on-watch engineer acknowledges alert but continues USV operation without retrain or rollback
    Then the system logs the human override and raises an Article 36 compliance exception
    And the operation is flagged for post-mission safety review and regulatory reporting
    And event details (time, sea state, model confidence, override justification) are recorded in audit log
    And finding is escalated to Safety Engineer with priority HIGH

  @critical @REQ-014
  Scenario: Auto-update evidence store on model lineage change
    Given model lineage tracked end-to-end: code commit (hash ABC123) → training data version → hyperparameters → model snapshot
    When a new model version is promoted to operational service
    Then MLOps system automatically cascades evidence-store updates: AMLAS activities 1–6 re-generated with new model metadata
    And evidence store automatically updated within <update_latency> minutes of model promotion
    And no manual evidence-store drift; continuous re-qualification pipeline executes in <pipeline_latency> hours

    Examples:
      | update_latency | pipeline_latency |
      | 60             | 6                |
      | 90             | 8                |

  @critical @REQ-013
  Scenario: Complete Phase 7 in-service monitoring gate with drift-monitor sign-off
    Given drift monitors live for ≥1 week in operational service; zero false-alarm alerts; all SLO breaches correctly detected
    When the in-service monitor and safety engineer jointly review drift-monitor telemetry
    Then Phase 7 In-Service Monitoring gate is closed; drift monitor approved for continuous long-term operation
    And monitoring SLA agreed: <99.5% uptime, <5% false-alarm rate, <2 hour alert-to-escalation latency
    And re-qualification automation tested successfully: model snapshot → re-training → evidence-bundle update → 6-hour cycle verified
    And final sign-off issued; model enters sustained-operations phase

  @major @REQ-013
  Scenario: Escalate to safety engineer when drift monitor SLO breach unresolved
    Given SLO-red alert issued for sea state Beaufort 5 (ODD boundary); drift persists >3 hours
    When re-qualification pipeline executed but new model still shows <88% mAP (SLO target: ≥92%)
    Then model rollback is triggered; previous baseline model restored to operational service
    And emergency escalation issued to Safety Engineer with severity CRITICAL
    And incident report filed: new model inadequate; root-cause analysis and remediation plan required before next promotion

  @critical @REQ-013
  Scenario: Monitor multi-variable drift interactions during extended operation
    Given in-service monitors track: visibility, sea state, illumination, wind speed, sensor calibration drift across 6 months of continuous operation
    When environment-variable correlations reveal systematic shift: visibility decreasing (trend -5 m/week) while wind speed increasing (trend +0.5 Beaufort/month)
    Then drift detector identifies multi-variable interaction: combined effect exceeds single-variable SLO tolerance
    And alert escalates to Safety Engineer: non-stationary environment may require ODD re-characterization
    And recommendation issued: sample new sea-trial data at edge ODD conditions (low visibility + high sea state) to re-anchor model confidence
    And finding is flagged for Phase 1 ODD refinement in next model release cycle
