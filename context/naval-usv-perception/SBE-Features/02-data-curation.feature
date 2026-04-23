@phase-2 @PSRQ
Feature: Data curation and synthetic augmentation for ODD coverage
  As a Data Engineer
  I want to ingest real sensor logs and generate synthetic data for rare conditions
  So that ODD coverage reaches ≥95% without prohibitive physical trials

  Background:
    Given the USV perception stack is under formal qualification
    And the PSRQ programme gate for Phase 2 is active
    And classified maritime sensor datasets are available (AUVLAB, MOD sea-trial archives)

  @critical @smoke @REQ-002 @SCEN-026
  Scenario: Ingest real sensor logs and catalogue with provenance
    Given raw real sensor dataset with 50,000 frames from radar, IR, visual and LiDAR sensors across 20 sea trials
    When the data engineer runs ingestion process: format conversion, calibration metadata extraction, QA checks
    Then 500 GB of data is processed into 50k curated frames with linked provenance and sensor calibration records
    And metadata is versioned in DVC; all frames remain classified and access-controlled via MOD security controls

  @critical @REQ-003 @SCEN-004
  Scenario Outline: Generate synthetic augmentation for rare weather conditions
    Given a curated set of <num_seeds> real naval sensor logs (radar echoes, IR video from real sensor dataset)
    When the test architect requests <augmentation_factor>× synthetic augmentation for <conditions>
    Then generative model produces <synthetic_count> physically plausible synthetic frames with logged provenance
    And each synthetic image is linked to its parent real frame and transformation parameters
    And synthetic data is tagged with ODD environment conditions it represents

    Examples:
      | num_seeds | augmentation_factor | conditions                       | synthetic_count |
      | 1000      | 10                  | fog, rain, night modes          | 10000           |
      | 500       | 5                   | heavy fog (visibility <100 m)    | 2500            |
      | 300       | 3                   | night + rain + sensor occlusion | 900             |

  @critical @REQ-003 @SCEN-006
  Scenario: Inpaint occluded radar sector while preserving physics
    Given a real radar frame with a 60° sector masked due to antenna null
    When the synthetic augmentation method is tasked to plausibly fill the occluded sector while preserving physics
    Then the inpainted frame maintains Doppler and range coherence with the rest of the scene
    And the generated sector is flagged as synthetic and excluded from ground-truth labelling
    And provenance chain records the inpainting operation and parent frame ID

  @major @REQ-003 @SCEN-005
  Scenario: Reject synthetic data lacking certified provenance
    Given a batch of 5000 synthetic images generated offline from an uncertified model snapshot
    When the evidence curator attempts to import them into the qualification dataset
    Then the process rejects the batch and reports: synthetic-data-provenance-unverified
    And the curator must re-generate the batch with full lineage tracking enabled
    And rejection reason is logged in the evidence store with severity MAJOR

  @critical @REQ-002
  Scenario: Validate synthetic-to-real accuracy gap below threshold
    Given 10,000 synthetic frames generated from 1,000 real AUVLAB seeds covering fog, rain, and night conditions
    When the verification engineer measures model accuracy on synthetic vs. held-out real test set
    Then synthetic-to-real accuracy gap is <3% on target detection metrics (mAP, recall)
    And gap validation report is signed off and linked to ODD coverage evidence
    And synthetic data is approved for Phase 3 model-layer evaluation
