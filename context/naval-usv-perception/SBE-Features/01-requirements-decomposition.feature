@phase-1 @PSRQ
Feature: Requirements decomposition to testable conditions
  As a T&E Engineer
  I want to decompose ODD and safety requirements into testable atoms
  So that the PSRQ programme gate for Phase 1 is satisfied with traceable, measurable test conditions

  Background:
    Given the USV perception stack is under formal qualification
    And the PSRQ programme gate for Phase 1 is active
    And a requirements specification document is available in SRS format

  @critical @smoke @REQ-001 @SCEN-001
  Scenario: Decompose ODD visibility boundaries into test atoms
    Given an ODD requirement specifying visibility range 50–500 m, sea state Beaufort 2–4, and daylight-only operation
    When the T&E Engineer requests automated decomposition to testable conditions
    Then the process identifies 3 environment variable vectors (visibility, sea state, illumination)
    And each atom is versioned and linked to the parent ODD requirement ID
    And 3 visibility test atoms are created: {50 m, 200 m, 500 m}

  @critical @REQ-001 @SCEN-002
  Scenario Outline: Complete traceability matrix with full ODD-to-atom mapping
    Given ODD and safety requirements fully specified with <onemergency_vars> environment variables
    When the decomposition process processes all requirements
    Then traceability matrix shows 100% of declared ODD states mapped to test condition partitions
    And no gaps exist between requirement atoms and test design evidence
    And all atoms are linked to parent requirement IDs with versioning history

    Examples:
      | environment_vars | visibility_range | sea_state_range | illumination_values |
      | 3                | 50–500 m         | Beaufort 2–4    | daylight            |
      | 4                | 50–500 m         | Beaufort 2–5    | daylight, twilight  |
      | 5                | 50–500 m         | Beaufort 2–6    | daylight, twilight, night |

  @major @REQ-002 @SCEN-003
  Scenario: Flag incomplete environmental state coverage in ODD
    Given an ODD requirement silent on LiDAR vs. radar sensor selection trade-offs
    When the decomposition engine encounters incomplete environmental state coverage
    Then the process identifies incompleteness and requests human clarification on sensor-mode assumptions
    And decomposition pauses until the engineer provides the missing ODD variant
    And the gap is logged in the traceability matrix with severity MAJOR

  @critical @REQ-001
  Scenario: Extract testable condition partitions from named ODD requirement
    Given an ODD requirement named ODD-NAV-001 specifying 16 distinct ODD atoms across visibility, sea-state, and illumination dimensions
    When the decomposition engine partitions the ODD space into measurable, testable bins
    Then 16 requirement atoms are generated and catalogued
    And each atom is tagged with its ODD dimension (e.g., ODD-NAV-001-VIS-001, ODD-NAV-001-SEA-002)
    And the traceability matrix records the complete parent-to-atom lineage
