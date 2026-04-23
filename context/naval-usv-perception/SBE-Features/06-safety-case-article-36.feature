@phase-6 @PSRQ
Feature: AMLAS evidence bundle assembly and Article 36 legal review
  As a Safety Case Author
  I want to auto-generate GSN safety case and Article 36 evidence bundle from AMLAS activities
  So that regulatory compliance is demonstrable and operational release gate is satisfied

  Background:
    Given the USV perception stack is under formal qualification
    And the PSRQ programme gate for Phase 6 is active
    And all evidence from Phases 1–5 is archived and versioned
    And AMLAS activity evidence (requirements, test data, model cards, robustness bounds, drift logs) is complete

  @critical @smoke @REQ-011 @SCEN-016
  Scenario: Auto-generate GSN safety case with AMLAS goal-evidence linking
    Given complete AMLAS activity evidence: requirements, test data, model cards, robustness bounds, drift logs
    When the safety case author invokes auto-generation with evidence management tool and safety case generation tool
    Then a draft GSN tree is generated with top-level safety goal linked to 6 AMLAS activities
    And 95% of claimed sub-goals are supported by evidence; 5% flagged for manual justification
    And GSN diagram is exported with traceability links to underlying test evidence
    And draft safety case is submitted to Safety Case Author for human review and refinement

  @critical @REQ-011 @SCEN-017
  Scenario: Reject auto-generated GSN claim lacking system-layer context
    Given auto-generated GSN claim: 'Model robust under fog (activity 3.2 evidence)' lacks collision-avoidance context
    When the safety case author (human) reviews the claim and finds no link to system-layer HIL outcomes
    Then the human rejects the claim and requests manual refinement
    And the pipeline logs the rejection reason and re-tries generation with human-provided context hint
    And refined claim is re-generated with explicit link to Phase 4 HIL scenario outcomes

  @critical @REQ-012 @SCEN-016
  Scenario Outline: Export Article 36 evidence bundle with collision-avoidance traceability
    Given complete evidence assembled: perception robustness bounds (<robust_accuracy>% under <perturbation>), decision-layer logic, fail-safe mode validation
    When the legal reviewer exports collision-avoidance evidence bundles in machine-readable format
    Then Article 36 evidence bundle contains: <num_evidence_items> evidence items linked to collision-avoidance decisions
    And decision-layer traceability (perception input → collision-avoidance logic → helm command) is fully documented
    And fail-safe mode procedures and handover latency (<handover_seconds> seconds) are validated and recorded
    And Article 36 compliance checklist is completed and signed by Legal Reviewer

    Examples:
      | robust_accuracy | perturbation         | num_evidence_items | handover_seconds |
      | 87              | L-infinity ε=8/255   | 45                 | 5                |
      | 84              | realistic maritime   | 52                 | 6                |

  @critical @REQ-012
  Scenario: File regulatory compliance evidence for UK Defence legal review
    Given Article 36 evidence bundle assembled with collision-avoidance bounds and decision-layer justification
    When the legal reviewer submits compliance filing to UK Defence legal authority
    Then regulatory filing includes: (1) perception robustness under declared ODD, (2) collision-avoidance decision logic, (3) fail-safe handover procedures, (4) environmental boundary conditions
    And filing is marked for review by Defence AI Centre and Dstl legal team
    And review cycle tracked with expected sign-off within 10 working days

  @critical @REQ-011
  Scenario: Complete Phase 6 safety case gate with evidence approval
    Given GSN draft safety case generated with 95% goal-evidence coverage; human review completed and 5% manual claims added
    When the Safety Engineer and Legal Reviewer jointly approve the evidence bundle
    Then the Phase 6 Safety Case & Article 36 gate is closed
    And final GSN diagram is versioned in evidence store with all claims signed off
    And Article 36 compliance certificate is filed with Defence legal authority
    And green light issued to Deployment Authority for Phase 7 in-service monitoring setup

  @major @REQ-011
  Scenario: Flag missing evidence for unresolved GSN claims
    Given GSN safety case draft generated; 12% of sub-goals (vs. target 5%) flagged as unsupported
    When the Safety Case Author reviews unsupported claims and traces them to missing test evidence
    Then clusters of missing evidence are identified: (1) rare weather combinations (fog + night), (2) edge-case robustness bounds
    And recommendations are issued to Safety Engineer: re-run Phase 3 robustness testing with focused scenarios
    And Phase 6 gate remains open pending additional evidence generation and GSN refinement

  @critical @REQ-011
  Scenario: Link all Gherkin scenarios to GSN claims for traceability
    Given 28 Gherkin scenarios across 7 PSRQ phases; each tagged with @REQ-XXX and @SCEN-YYY
    When the traceability matrix is updated with mapping: requirement → test case (Gherkin) → GSN claim → evidence artefact
    Then 100% of declared ODD states are traceable from requirement atom → Gherkin scenario → test result → GSN claim
    And traceability matrix is approved by Certification Authority as evidence of complete coverage
    And final traceability report is archived with evidence bundle for regulatory audit
