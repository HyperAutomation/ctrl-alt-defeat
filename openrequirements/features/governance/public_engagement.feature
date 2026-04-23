# Feature: Public Engagement & Stakeholder Notification
# Business Goal: GOAL-010 Build Public Trust & Stakeholder Engagement
# Community consultation per CAP 1616 and GDPR compliance

@governance @F19 @REQ017 @GOAL-010
Feature: Public Engagement & Stakeholder Notification
  As a CAA community liaison
  I want to establish structured stakeholder engagement processes
  So that public concern is addressed, prior notification provided, and regulators have documented stakeholder alignment

  Background:
    Given trial location identified (e.g., Spadeadam, Edinburgh)
    And CAP 1616 (civil engagement) methodology applies
    And GDPR Data Protection Impact Assessment (DPIA) completed
    And public engagement plan required before Phase 1 flight ops

  @critical
  Scenario: Community notification plan for trial location
    Given Spadeadam trial proposed with public flight operations (non-classified phase)
    When public engagement plan drafted
    Then plan includes:
      | Landowner notification: MOD Spadeadam, local estates within 5km |
      | Local authority coordination: Dumfries & Galloway Council    |
      | Community briefing: village hall meeting with flight demo     |
      | Press engagement: local media briefing 1 week pre-flight      |
      | Complaint mechanism: dedicated hotline during trial           |
      | Feedback capture: satisfaction survey post-trial             |
    And plan submitted for CAA approval before flight ops commence

  @major
  Scenario Outline: Stakeholder notification timeline
    Given trial scheduled for <flight_start_date>
    When engagement plan executed
    Then notification occurs at <notification_time>
    And <stakeholder_group> receives <notification_type>

    Examples:
      | flight_start_date | notification_time     | stakeholder_group    | notification_type        |
      | 2026-03-20        | 2026-02-20 (4 weeks)  | Landowners nearby     | Written letter           |
      | 2026-03-20        | 2026-03-10 (1 week)   | Local authority       | Formal briefing          |
      | 2026-03-20        | 2026-03-15 (5 days)   | Community at large    | Press release + media    |
      | 2026-03-20        | 2026-03-19 (1 day)    | Emergency services    | NOTAM + phone alert      |

  @major
  Scenario: GDPR compliance for flight data and community records
    Given trial collects flight telemetry and community feedback
    When personal data processing identified
    Then Data Protection Impact Assessment documents:
      | Personal data collected: community feedback names, addresses  |
      | Processing purpose: community liaison and feedback capture   |
      | Retention period: 12 months post-trial (then anonymized)    |
      | Individuals' rights: request access, correction, deletion    |
      | Safeguards: secure storage, access controls, encryption      |
    And DPIA published for transparency (redacted for privacy)

  @major
  Scenario: Complaint mechanism during trial
    Given trial underway with active flight operations
    When community member observes unexpected noise or safety concern
    Then complaint process:
      | Complaint submitted via hotline or web portal          |
      | CAA acknowledges within 24 hours                      |
      | Investigation conducted within 3 working days         |
      | Applicant interviewed if complaint substantive        |
      | Feedback provided to complainant within 7 days        |
      | If safety concern substantiated: flight ops suspended |
    And complaint log retained for trial audit trail

  @major
  Scenario: Post-trial lessons-learned with stakeholders
    Given trial closure on 2026-06-15
    When post-trial community meeting held
    Then meeting agenda includes:
      | Trial outcomes: flights completed, incidents, lessons   |
      | Safety findings: any concerns or recommendations        |
      | Community feedback: noise, visual impact, overall view  |
      | Future trials: applicant's plans, community interests   |
      | Satisfaction assessment: survey of attendees            |
    And meeting minutes captured and archived in case record
