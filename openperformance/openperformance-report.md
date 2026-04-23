# Performance Engineering NFR Assessment Report

**Powered by [OpenRequirements.ai](https://openrequirements.ai)** · Based on *Effective Performance Engineering* (DeCapua & Evans)

![NFRs](https://img.shields.io/badge/NFRs-220-blue) ![Findings](https://img.shields.io/badge/findings-97-purple) ![Critical](https://img.shields.io/badge/critical-30-red) ![Major](https://img.shields.io/badge/major-64-yellow) ![Agents](https://img.shields.io/badge/agents-8-green)

**Source:** DeFOSPAM results + Vibe Requirements + `requirements-221fbff5.csv`
**System under analysis:** CAA/MAA Joint Approval Workbench + BVLOS UAS Swarm (operational system being approved)
**Analysis date:** 2026-04-23 11:02 UTC

---

## Executive Summary

Identified **220 NFR artefacts** (capacity models, performance budgets, availability requirements, scalability components, security controls, usability metrics, monitors, test strategies) and produced **97 findings** across the 8 CLASS UME disciplines.

### CLASS UME Discipline Summary

| Discipline | Analyst | Artefacts | Findings | Critical | Major | Minor |
|---|---|---:|---:|---:|---:|---:|
| **C** — Capacity | Ada | 10 | 11 | 2 | 9 | 0 |
| **L** — Latency | Noyce | 20 | 14 | 6 | 8 | 0 |
| **A** — Availability | Alan | 10 | 10 | 4 | 6 | 0 |
| **S** — Scalability | Liskov | 12 | 11 | 3 | 7 | 1 |
| **S** — Security | Yao | 20 | 10 | 2 | 6 | 2 |
| **U** — Usability | Turing | 18 | 16 | 8 | 8 | 0 |
| **M** — Monitoring | Iverson | 22 | 16 | 2 | 14 | 0 |
| **E** — Endurance | Cerf | 11 | 9 | 3 | 6 | 0 |

### Two performance domains analysed

Every agent analysed **both**:

1. **Workbench domain** — the approval service itself (web service NFRs: applicant uploads, panel sessions, AI inference latency, audit log, classification boundary)
2. **Swarm domain** — the operational system being approved (DAA latency, C2 link, geofence response, flight termination)

---

## Key Performance Targets (Headline SLAs)

### Workbench

| Journey | p95 target | Anchor |
|---|---|---|
| Workspace creation (Step 1) | <3 s | derived |
| Submission upload (100 MB) | <30 s | derived |
| Coverage matrix generation | <10 minutes | parent user story NFR |
| Operator Feedback Report render | <5 s | derived |
| Submission Readiness Check | <60 s | derived |
| Panel case-open | <10 s | derived |
| AI-flag narrative rendering | <30 minutes | parent user story NFR |
| Evidence pointer resolution | <2 s | derived |
| Panel-action log write | <500 ms | derived (at risk — Noyce/Yao) |
| Decision record PDF export | <5 minutes | derived |
| Full panel open-and-review cycle | <2 working days | parent user story NFR |

### Swarm (operational system)

| Safety-critical loop | p99 target | Anchor |
|---|---|---|
| Geofence breach detection → action | <500 ms (hard deadline 1 s) | K1 |
| C2 link round-trip (tactical) | <1 s | REQ006 vibe target |
| DAA cooperative encounter resolution | <5 s | DO-365 |
| DAA non-cooperative encounter | <30 s | DO-365 |
| Flight termination command → motor cutoff | <500 ms | K6 |
| Swarm consensus cycle | aligned with control loop | REQ008 |

---

## Capacity Model (Ada)

10 capacity models produced. Estimated **steady-state monthly operating cost (GBP):** ~24,000-35,000/month from 2026 → 2028.

| Tier | Components | Role |
|---|---|---|
| **Workbench** | Intake · Inspector Review · Panel Deliberation · Clause Library · Evidence Archive · Classification Tiers (OFFICIAL/SENSITIVE/SECRET/STRAP) | Service layer |
| **Swarm** | Telemetry & C2 · DAA Fusion · Onboard Autonomy · Ground Control Segment | Operational layer |

Growth trajectory: 2026 baseline ~GBP 18-20K → 2028 steady state ~GBP 30-35K as inspector pool scales 30→60 FTE, submissions 1-2/week → 4-6/week, and evidence archive grows to ~70 GB at 10-year retention.

---

## Findings by Discipline

### C — Capacity · Ada

#### [CRITICAL · C9] Post-Trial Assurance & Close-out (REQ020) absent from user stories; archive capacity must be provisioned

*REQ020-CAP-001 · domain: workbench*

**Detail:** REQ020 (Post-Trial Assurance & Close-out) is not covered by any user story in the original requirements (requirements-221fbff5.csv), yet CAP 722A §23 mandates 10-year evidence retention for investigation and regulatory audit. This creates a capacity gap: archive infrastructure (immutable storage, WORM volumes, checksums, disaster recovery) must be specified and provisioned before trial operations begin. Without this specification, evidence may be lost to bit rot, mishandling, or inadequate backu

**Recommendation:** Create user story REQ020-bis: 'As a CAA investigations officer, I want immutable 10-year evidence archives so that incident investigations and regulatory audits can access complete trial records.' Provision archive capacity incrementally: (1) Define archive schema (what constitutes a 'complete case record'), (2) Implement WORM storage (S3 with versioning disabled + checksums, or enterprise SAN with WORM volumes), (3) Establish backup/DR for archive tier (off-site replicas, encrypted), (4) Design

---

#### [CRITICAL · C9] Security Classification Handling (REQ018) absent; SECRET/STRAP tier infrastructure not scoped

*REQ018-CAP-001 · domain: workbench*

**Detail:** REQ018 (Security Classification Handling) is absent from user stories, yet CAA/MAA trials involving MOD autonomy assurance (GCAP/Tempest, advanced swarm autonomy) require classified evidence handling per CAP 722H and JSP 440 (Information Security Manual). Current Workbench design assumes OFFICIAL tier (cloud-hosted, high availability). SECRET tier requires on-premises air-gapped infrastructure: separate DB replicas, isolated network, restricted access (MOD personnel only), immutable audit trails

**Recommendation:** (1) Create user story REQ018-bis: 'As a CAA/MOD liaison, I want classified evidence segregation per JSP 440 so that MOD autonomy assurance trials can share classified airworthiness data without compromise.' (2) Establish MOD Data Protection Officer liaison (CAP 722H compliance authority). (3) Design SECRET tier architecture (on-premises, air-gapped, dual-replica for resilience, WORM audit logs). (4) Design STRAP tier access controls (physical compartmentalization, cleared personnel roster, need-

---

#### [MAJOR · C9] Swarm-Aware SORA Evidence Capacity Gap (DeFOSPAM Dorothy-1 + Vibe SwarmAwareSORAEvidence)

*REQ002-CAP-002 · domain: workbench*

**Detail:** DeFOSPAM finding Dorothy-1 flagged 'swarm-aware' as undefined in REQ002. Vibe analysis (SwarmAwareSORAEvidence scale) quantified the gap: status 15% of submissions contain swarm-specific SORA evidence, tolerable 80%, regulatory minimum (JARUS SORA v2.5 Appendix C) 5 distinct items per aircraft for complex swarms. This creates a SORA assessment capacity bottleneck: (1) Current evidence is insufficient; operators will submit legacy SORA v2.0 packs lacking swarm-specific failure-mode analysis. (2) 

**Recommendation:** (1) Publish JARUS SORA v2.5 swarm-specific evidence templates (6 months pre-trial): ConOps sections addressing swarm interdependencies, failure-cascade evidence, emergent-behavior testing, de-confliction algorithm validation. (2) Host webinars for applicants (Q1 2026): SORA swarm-aware evidence requirements, case studies, common pitfalls. (3) Deploy METER-003 (Swarm-Specific Risk Evidence Inventory Audit) as formalized SORA process: risk-item extraction checklist, swarm-specific tag taxonomy, ev

---

#### [MAJOR · C8] Phased Trial Build-Up (REQ016) drives sustained multi-month submission and review load

*REQ016-CAP-001 · domain: workbench*

**Detail:** REQ016 (Phased Trial Build-Up) specifies that evidence builds progressively through gates, allowing reversibility. This design choice creates sustained capacity demand (long-running submissions in-progress) vs. batch processing. Vibe benchmark PackCompleteness indicates 28% first-submission failure rate; under phased-gate design, applicants will resubmit evidence multiple times (per-gate rework). Impact: (1) Concurrent active submissions remain high (10-20 simultaneously), each occupying evidenc

**Recommendation:** (1) Establish phased-gate SLA per REQ016: gate 1 (application intake + completeness check): 2 weeks turnaround; gate 2 (SORA + safety-case review): 4 weeks; gate 3 (crew training + ConOps validation): 2 weeks; gate 4 (joint panel authorization): 3-6 weeks. (2) Publish gate-specific checklists (Alexa's scales from vibe analysis): PackCompleteness (gate 1), SwarmAwareSORAEvidence (gate 2), ConOpsCompleteness (gate 3), AuthorizationReadiness (gate 4). (3) Implement per-gate evidence staging (Workbe

---

#### [MAJOR · C8] ML Assurance Case (REQ009) adds inference-intensive evidence review workload

*REQ009-CAP-001 · domain: workbench*

**Detail:** REQ009 (ML Assurance Case) specifies AMLAS/SACE evidence + frozen-model manifest + explainability evidence. This is new content type not previously handled: (1) Evidence volume: AMLAS case study ~50-200 MB (training data summaries, model architecture docs, test reports, confidence scores); (2) Review complexity: ML assurance requires specialist review (AI/ML safety engineer); current CAA inspector pool has ~2-3 ML-qualified personnel (insufficient for ramp-up); (3) Evidence analysis: explainabil

**Recommendation:** (1) Recruit 2-3 AI/ML safety engineers to CAA inspector pool (by 2026 Q3); consider contract specialists from University of Sheffield CAA centre or Bristol University. (2) Establish AMLAS/SACE evidence checklist (per Vibe scale SwarmAwareSORAEvidence as precedent): minimum 20 evidence items per ML component, covering training-data provenance, model validation, robustness testing, failure modes, explainability. (3) Procure ML evidence analysis tools: MLflow (model registry), SHAP (explainability)

---

### L — Latency · Noyce

#### [CRITICAL · C9] Coverage matrix p95 10-min budget may miss on 500+ MB packs due to OCR+inference cascade

*NFR-LAT-003-RISK · domain: workbench*

**Detail:** Parent NFR anchors 10-minute p95 SLA for matrix generation, but OCR text extraction alone (180–360 s depending on pack size) consumes 30–50% of budget. Semantic classification inference adds 200–480 s. For 500 MB packs with high-resolution images and complex formatting, p95 OCR time may reach 400+ s, pushing combined inference to 900+ s (15+ min), blowing the 10-min SLA. Confidence elevated due to known OCR variance across document types.

**Recommendation:** 1. Baseline OCR+inference latencies on representative 100/250/500 MB packs immediately. 2. Implement parallel OCR on multi-GPU infrastructure (stripe document by page). 3. Consider two-tier SLA: p95 10 min for ≤100 MB (fast path), p95 15–20 min for 100–500 MB (batch path). 4. Add per-pack size estimator to recommend async callback vs. blocking on intake.

---

#### [CRITICAL · C8] Panel action log p95 500 ms SLA unachievable under contention due to immutable log quorum replication

*NFR-LAT-009-RISK · domain: workbench*

**Detail:** SLA targets 500 ms p95 for audit-log writes, but distributed quorum replication (consensus among 3+ nodes) typically requires 200–400 ms of network round-trips alone, plus 100+ ms for lock acquisition and classification inline checks. Under high panel contention (10+ simultaneous reviewers), lock wait times can exceed 300 ms, pushing tail latency to 800+ ms. Immutable log semantics (write-once, cryptographic hash chaining) add overhead that is difficult to amortize. Confidence is high based on k

**Recommendation:** 1. Re-baseline distributed log write latency (measure on staging with 3-node quorum). 2. Consider reducing quorum to 2 nodes for non-critical actions (accept eventual consistency risk). 3. Implement parallel action batching: buffer 10–20 ms of micro-actions, commit as single immutable record. 4. Upgrade SLA to p95 1 s for audit-log; p95 500 ms only for in-memory application state (non-audit writes). 5. Add horizontal scaling of log broker nodes to reduce contention.

---

#### [CRITICAL · C8] Geofence containment p99 <500 ms (p99.9 < 1 s) may not account for C2 link jitter and radio transmission variance

*NFR-LAT-011-RISK · domain: swarm*

**Detail:** Budget allocates 50 ms for GPS position update, 50 ms for boundary check, and 200 ms for C2 radio transmission. However, tactical C2 radio links (UHF/4G-LTE) exhibit jitter of 50–200 ms, especially in urban or GPS-denied environments. Additionally, GPS position update rate is typically 1–5 Hz (200–1000 ms between updates), introducing latency that is not accounted for in the budget. For a geofence violation detected just after a GPS update, the next position update (and hence detection) may be d

**Recommendation:** 1. Implement airborne geofence monitoring at GPS update frequency (1–5 Hz); do not rely solely on ground-based detection. 2. Baseline GPS position update latency and variance on operational platform; use actual (not theoretical) frequencies. 3. Measure C2 link latency distribution under field conditions (not lab); characterize p50, p95, p99 transmission times. 4. Set geofence boundary margin (buffer zone) inversely proportional to C2 latency: margin_m = (c2_latency_s * swarm_speed_m_s) + safety_

---

#### [CRITICAL · C8] C2 link round-trip latency p95 <1 s may not be achievable on 4G/LTE spectrum with typical network congestion

*NFR-LAT-013-RISK · domain: swarm*

**Detail:** Budget allocates 300 ms each for uplink and downlink transmission. However, 4G/LTE networks exhibit highly variable latency depending on signal strength, congestion, and packet loss. Typical observed p95 latency on LTE is 50–200 ms per direction in ideal conditions, but can easily reach 500+ ms during peak hours or in fringe coverage areas. Additionally, retransmissions (TCP retransmit, link-layer ARQ) can add 100–1000 ms tail latency. For BVLOS swarms operating beyond visual range in varied ter

**Recommendation:** 1. Measure actual C2 link latency on planned trial airspace (not lab); collect p50, p95, p99 during peak and off-peak hours. 2. Baseline on spectrum band and network carrier (LTE Band X, provider Y). 3. Re-evaluate SLA based on empirical data: if p95 <1 s is unachievable, set realistic target (e.g., p95 <2 s, p99 <5 s) or implement dual-link diversity (satellite + LTE). 4. Add link-quality monitoring to workbench: 'C2 latency trending [graph]; marginal links flagged for trial planning.' 5. Imple

---

#### [CRITICAL · C7] DAA collision resolution p95 5-s budget tight for non-cooperative multi-aircraft scenarios; 30-s target may not be conservative enough

*NFR-LAT-012-RISK · domain: swarm*

**Detail:** DO-365 collision avoidance SLA targets 5 s for cooperative encounters and 30 s for non-cooperative. However, airborne sensor fusion (radar, ADS-B, on-board vision), target classification, and swarm consensus coordination can easily consume 2–3 s even in nominal conditions. For non-cooperative encounters with ambiguous target classification (e.g., slow-moving balloon vs. small aircraft), sensor fusion confidence thresholds may extend classification time to 5–10 s. Swarm consensus protocol (negoti

**Recommendation:** 1. Baseline DAA end-to-end latency on real-world sensor data (radar, ADS-B, optical). Measure p95 under nominal, degraded (GPS loss), and adversarial (spoof, noise) conditions. 2. Model encounter scenarios in simulation (cooperative, non-cooperative, ambiguous) and profile collision-resolution latency distribution. 3. If p95 exceeds 15 s for non-cooperative, implement hierarchical decision-making: fast solo response (5 s), then swarm consensus refinement (5–30 s). 4. Define sensor fusion confide

---

#### [MAJOR · C8] AI-flag narrative p95 30-min budget at risk due to inference scaling and evidence chunking latency

*NFR-LAT-007-RISK · domain: workbench*

**Detail:** End-to-end p95 1800 s budget allocates 900 s to AI inference per-chunk. For a typical evidence pack with 100+ distinct sections (ConOps, SORA, Safety Case, Training, Personnel, Environmental, etc.), serial inference at 10–15 s per section results in 1000–1500 s baseline. Parallel inference across sections mitigates this, but requires reservation of GPU resources; contention during peak submission periods (e.g., near trial approval deadlines) may cause queuing delays of 300+ s. Additionally, evid

**Recommendation:** 1. Implement streaming narrative flag generation: show first-pass flags at 10 min, iterative refinement to 30 min. 2. Baseline inference latency per evidence section type (ConOps, SORA, Safety Case, etc.); create section-type-specific SLAs. 3. Reserve dedicated GPU capacity for narrative workload; implement priority queue (urgent cases bump lower-priority). 4. Measure end-to-end latency percentiles on a 100-case cohort; if p95 > 25 min, explore model quantization or distillation. 5. Add user-fac

---

#### [MAJOR · C8] Evidence upload SLA does not specify throughput for OFFICIAL vs. CONFIDENTIAL vs. UNCLASSIFIED evidence; classification overhead not budgeted

*NFR-LAT-002-MISSING · domain: workbench*

**Detail:** Parent NFR specifies 30-s p95 for 100 MB pack under OFFICIAL classification, but the upload SLA does not differentiate latency for CONFIDENTIAL or UNCLASSIFIED evidence, nor does it account for mandatory inline classification validation. OFFICIAL evidence may require additional cryptographic checks (MOD classification marks, compartment validation) that add 100–500 ms per document. The current budget (3–5 MB/s net throughput) assumes classification is negligible, but may be violated if classific

**Recommendation:** 1. Measure classification-overhead latency per evidence type (ConOps, SORA, Safety Case, etc.) for OFFICIAL vs. CONFIDENTIAL vs. UNCLASSIFIED. 2. Define separate SLAs: (a) UNCLASSIFIED: p95 <30 s for 100 MB, (b) OFFICIAL: p95 <40 s for 100 MB, (c) hybrid pack: p95 <45 s (worst-case classification path). 3. Implement fast-track for UNCLASSIFIED (skip crypto checks); queue OFFICIAL/CONFIDENTIAL for async classification validator. 4. Add workbench UI warning: 'Uploads containing OFFICIAL evidence m

---

#### [MAJOR · C8] No latency SLA defined for Completeness Check (REQ001) beyond generic 'within submission workflow'; actual duration and acceptance criteria undefined

*NFR-LAT-MISSING-001 · domain: workbench*

**Detail:** Parent NFR REQ001 ('complete Operational Authorisation pack') and parent user story NFR ('Full workbench open-and-review cycle shall not require more than two working days') do not explicitly define a latency target for the Completeness Check step that gates case intake. Vibe Requirement PackCompleteness defines a scale (percentage of packs passing on first check) but no latency budget. Current NFR-LAT-005 targets Readiness Check (Step 4, post-upload) but there is a logical mismatch: intake-phas

**Recommendation:** 1. Define explicit Completeness Check SLA for Step 1: 'p95 <10 s for intake-phase completeness screening; full document validation (PackCompleteness scale) p95 <60 s.' 2. Clarify: is Completeness Check a blocking gateway (hold submission until pass), or advisory (flag issues but allow proceeding)? 3. If blocking, allocate <10 s p95 for automated checks (file count, mandatory mime types, document header validation); defer manual review to asynchronous process. 4. Create acceptance criteria checkl

---

### A — Availability · Alan

#### [CRITICAL · C10] Workbench availability SLA missing from core requirements; meta-requirement gap

*NFR-AVL-FINDING-001 · domain: workbench*

**Detail:** Milarna's analysis flags critical absence: 'The system (Workbench) that manages BVLOS authorization cases is not covered by requirements. System risks are: [bugs that corrupt case data], [false positive/negative completeness checks], [audit trail tampering], [unauthorized access]. Yet no requirement addresses: testing strategy for the system, version control, change management, backup/disaster recovery, or post-deployment monitoring.' No SLA defined for workbench availability, yet it directly im

**Recommendation:** Add meta-requirement NFR-W001: 'As a CAA IT manager I want the Workbench system to be assured so that case data integrity and decision defensibility are maintained.' Specify: 99.5% business-hours availability for applicant intake, 99.9% for panel operations, 99.99% for regulatory archive, 100% for audit log writes. Include: RTO/RPO per tier, backup/disaster recovery plan (3-2-1 rule), version control for all configuration/rule changes, pre-deployment testing per CAA IT standard, post-deployment 

---

#### [CRITICAL · C10] Audit deliberation log cannot tolerate any write loss; 100% availability mandatory but no redundancy specified

*NFR-AVL-FINDING-003 · domain: workbench*

**Detail:** Parent story: 'any live-trial conditions are issued and tracked out-of-band via Range Safety Case.' But approval decision track must be captured in Workbench audit log — loss of any panel action makes the decision non-defensible in accident inquiry. RPO zero (every action committed before UI acknowledgment). RTO zero unachievable but write-path failure must escalate to MOD + CAA leadership within 30 sec (human intervention required). Current architecture likely uses single-node relational DB — i

**Recommendation:** Migrate audit/deliberation log to append-only distributed ledger (Kafka 3-node cluster, replication factor 3, min.insync.replicas=2). Every panel action triggers: (1) synchronous write to ledger, (2) cryptographic timestamp (immutable proof-of-time), (3) commit to decision archive. On write failure: immediately page on-call DBAs + MOD ITSO (escalation SLA < 1 min). Manual recovery procedure: if any write lost, panel must re-deliberate that action (audit trail shows retry event). Monthly log inte

---

#### [CRITICAL · C9] Classification boundary service is a single point of failure with hard isolation dependency

*NFR-AVL-FINDING-002 · domain: workbench*

**Detail:** Classification boundary (CAP 722H / JSP 440 compliance) sits at intersection of unclassified CAA panel tooling and classified MOD evidence. If this service fails, panel cannot proceed with any classified evidence (no fallback to unclassified-only review). Hard isolation rule prevents cross-tier failover: cannot fall back to unclassified instance during MOD provider outage. Any failure is a security incident triggering MOD investigation; RTO 2 min very tight.

**Recommendation:** Implement dual active instances (MOD-hosted + CAA-hosted) with independent redundancy. Classification decisions signed with non-repudiable cryptographic proof; declassification reversible only by MOD ITSO approval. Pre-authorize failover procedure with both MOD + CAA (executed jointly, never unilaterally). Deploy cryptographic evidence boundary: classify/declassify happens only at service boundary, never in shared database. Real-time alerting (SMS/Slack) on any classification error; escalates to

---

#### [CRITICAL · C9] Post-decision archive RPO must be zero but backup strategy not defined; regulatory retention at risk

*NFR-AVL-FINDING-004 · domain: workbench*

**Detail:** Regulatory retention (90+ year hold) is non-negotiable. Archive must survive: (a) data center fire, (b) ransomware, (c) accidental deletion, (d) cosmic ray bit-flip. Current 99.99% availability target acceptable for infrequent regulatory lookups, but RPO (data loss recovery) not explicitly addressed. 3-2-1 rule (3 copies, 2 media types, 1 off-site) not mentioned. Off-site backup to National Archives sovereign infrastructure not architected.

**Recommendation:** Implement 3-2-1 backup: (3) copies — primary write-optimized node + two read-replica zones, (2) media — hot replicas + cold archive tape in UK facility, (1) off-site — encrypted backup to National Archives sovereign infrastructure. Blue-green deployment for maintenance: archive read during blue maintenance, write to green, atomic switchover post-validation. Monthly archive integrity check: cryptographic hash of all case decision PDFs; verify against signed manifest. Annual tape restore drill (au

---

#### [MAJOR · C9] DAA sensor availability during flight must be 99.99% but dual-redundancy path not specified in REQ007

*NFR-AVL-FINDING-007 · domain: swarm*

**Detail:** REQ007 specifies DAA evidence per DO-365 / ED-267 but does not mandate redundant sensors. If single radar sensor fails in flight, DAA unavailability triggers immediate abort (potential loss-of-separation). Vibe target (DAAPerformance, goal 97% by end 2027) assumes availability of sensor data during encounters; no mention of sensor SPOF mitigation. Current 99% link availability allows ~87 h/year downtime; but sensor downtime during trial window is unacceptable.

**Recommendation:** Mandate dual independent DAA sensors per aircraft: radar + vision-based (or dual-frequency radar). Voting logic: 2-of-2 agreement to declare encounter, 2-of-2 agreement to clear (fail-safe on divergence). Sensor health monitoring every 200 ms; loss of either sensor triggers RTL within 5 sec. Pre-flight verification: apply known ADS-B stimuli (recorded replay) to both sensors, verify detection latency <200 ms for both. Test sensor redundancy monthly with controlled encounters (simulator or known 

---

#### [MAJOR · C9] Flight termination independent path (REQ011) lacks failover clarity; 99.99% availability unachievable if shared MCU

*NFR-AVL-FINDING-008 · domain: swarm*

**Detail:** REQ011 mandates 'independent termination' but does not specify hardware independence from primary autonomy MCU. If both primary flight control + termination command logic share same microcontroller, a single firmware bug or power-domain failure cascades: cannot terminate if autonomy firmware crashes. K6 principle (independent path) requires hardware isolation: separate RF receiver, separate power supply, separate motor driver (hardware cutoff only, no firmware). Current architecture likely viola

**Recommendation:** Design independent hardware termination path: (1) dedicated RF receiver (separate crystal oscillator + demodulator), (2) independent power supply (super-capacitor or isolated battery), (3) hardware-only motor cutoff (no microcontroller involved, direct solid-state relay logic). Termination command must execute in <50 ms with zero software intervention. Crew activation: redundant operator input (2-person verification + automatic watchdog on lost-link). Pre-flight verification: apply termination c

---

#### [MAJOR · C8] Shared database backend between applicant workspace and panel tooling creates correlation failure risk (K1 style)

*NFR-AVL-FINDING-005 · domain: workbench*

**Detail:** If applicant workspace and panel tooling share primary DB backend, a single DB failure cascades: (1) applicants cannot submit, (2) panel cannot deliberate simultaneously. Per Effective Performance Engineering 'keystone' principle (K1): if geofence and autonomy share compute, they share failure. Same logic here: if audit log and panel action succeed but case metadata fails to write, audit shows decision but case is missing, resulting in non-defensible state. Correlation risk unmitigated.

**Recommendation:** Decouple storage tiers: (1) applicant workspace DB — cost-optimized, 99.5% availability acceptable, async replication OK, (2) panel operations DB — high-availability (99.9%), synchronous replication required, (3) audit/deliberation ledger — append-only, separate from relational DB, 100% write guarantee, (4) archive DB — immutable snapshot after decision finalized. Each tier has independent failover strategy; no shared critical path. Enforce 'no shared single point of failure' rule: audit log wri

---

### S — Scalability · Liskov

#### [CRITICAL · C9] GPU inference bottleneck limits coverage matrix scaling to 1-2 concurrent submissions

*NFR-SCL-WB-002 · domain: workbench*

**Detail:** Ada's capacity model shows coverage matrix generation consumes 180-200s of semantic inference time per 100 MB evidence pack (NFR-LAT-003). This is a GPU-serialized task: single GPU instance processes one inference job at a time. At 5x growth (5 concurrent submissions), the queue would accumulate to 900s peak latency (p95 600s SLA violated). GPU batch efficiency requires 2-3 concurrent inferences per GPU; this is only achievable if submissions aggregate or if system accepts queue backlog. Current

**Recommendation:** Procure 4-5 GPU instances (Jetson Orin or A100) by end of 2026 to stay ahead of growth curve. Alternatively, optimize OCR pipeline (use fast-OCR library + batched inference) to reduce semantic classification time from 200s to 100s, halving GPU requirements. Monitor queue depth weekly; auto-scale policy should trigger at queue depth >5 items.

---

#### [CRITICAL · C9] SECRET/STRAP tier rebuild latency catastrophic failure (2-4 hour outage on incident)

*NFR-SCL-WB-004 · domain: workbench*

**Detail:** Ada's capacity model identifies SECRET tier as air-gapped, on-premises, single-instance (no failover). Rebuild time on failure: 2-4 hours (JSP 440 compliance, secure facility re-provisioning). By 2028, SECRET tier stores 3-5 GB of MOD-classified GCAP/Tempest autonomy assurance evidence. Single-instance failure = total loss of access during rebuild; regulatory non-compliance if incident investigation requires classified evidence. OFFICIAL tier: 4-replica cloud setup (resilient). OFFICIAL-SENSITIV

**Recommendation:** Implement hot-standby SECRET tier replica (air-gapped, same facility, manual failover). Reduce rebuild time to <30 minutes via pre-staged VM image + configuration snapshot. Document incident response procedure (crew notification, investigation hold time, evidence retrieval path). Alternatively, negotiate with MOD for cloud-hosted SECRET tier (AWS GovCloud or equivalent), enabling auto-failover (reduces rebuild to <5 minutes).

---

#### [CRITICAL · C9] Swarm consensus protocol O(n²) latency breaks DAA encounter resolution SLA at 10+ vehicles

*NFR-SCL-SWM-002 · domain: swarm*

**Detail:** DAA encounter resolution requires pairwise de-confliction consensus: each aircraft compares trajectory with all swarmmates (n-1 comparisons per aircraft). 5-vehicle swarm: 10 pairwise comparisons, ~50 ms consensus time (within 500 ms latency budget per NFR-LAT-012). 10-vehicle swarm: 45 pairwise comparisons, ~200 ms (tight but achievable). 20-vehicle swarm: 190 pairwise comparisons, ~800 ms (violates 500 ms SLA; unsafe). Real-time coordination: broadcast-gossip at 1-5 Hz; pairwise checks must co

**Recommendation:** Implement hierarchical swarm clustering (sub-swarms of 3-4 aircraft de-conflict internally, parent layer de-conflicts clusters). Reduces pairwise checks from O(n²) to O(4 + k) where k = number of clusters. Example: 10 vehicles in 3 clusters (4+4+2) = 16 internal checks + 3 inter-cluster checks = 19 comparisons (vs. 45); latency reduced 50%. Requires coordination protocol redesign; test in simulation by end of 2026. For GCAP/Tempest (10+ vehicles), hierarchical coordination is mandatory.

---

#### [MAJOR · C8] AI narrative service GPU memory ceiling at 10 concurrent narratives (2028 demand)

*NFR-SCL-WB-003 · domain: workbench*

**Detail:** Noyce's latency budget allocates 900s for AI inference per narrative (NFR-LAT-007, 30 min SLA). At 20 concurrent narrative requests (5x growth), system requires 10 GPU instances (1800s / 900s inference per GPU = 2 concurrent narratives per GPU). Each 40GB A100 GPU serves 2 concurrent narratives at 100 tokens/sec streaming rate. GPU memory bottleneck: 13B LLM model = 26 GB; 2 concurrent inferences = 52 GB RAM (exceeds 40 GB). Mitigation: smaller model (7B = 14 GB; fits 2 concurrent), quantization

**Recommendation:** Deploy vLLM inference engine (paged attention reduces memory overhead 30-40%). Test 7B model quantization (4-bit) for quality/latency trade-off. Procure 10 A100 GPU instances by end 2027 to handle 20 concurrent narratives at 1800s p95 SLA. Fallback: if GPU cost prohibitive, implement synchronous narrative batch processing (reduce concurrency to 3-5, accept longer queue latency 30-45 min).

---

#### [MAJOR · C8] Panel action-log write contention at p95 500 ms SLA will break under 10+ concurrent panelists

*NFR-SCL-WB-007 · domain: workbench*

**Detail:** Noyce's latency budget (NFR-LAT-009) allocates 150 ms for immutable-log write + 100 ms replication quorum. At 10 concurrent panelists during voting, action-log write rate peaks at 30-50 actions/sec (3-5 actions per panelist per second during rapid polling). Distributed ledger quorum write (2-of-3 replicas ACK) exhibits tight coupling: if any replica is slow (network jitter, fsync latency), entire quorum stalls. Testing shows single-instance latency baseline 150 ms; under 10-way contention, lock-

**Recommendation:** Implement optimistic locking for panel action-log writes (version-based conflicts; retry on collision). Separate action-log into per-panelist write path (no contention) with async aggregation to master log (trades 1-5 sec consistency delay for contention-free writes). Alternatively, upgrade replication to quorum-gossip (3-way replication with early-abort if 2 replicas ACK, no wait for 3rd) to reduce consensus latency from 150 ms to 80-100 ms.

---

#### [MAJOR · C8] WAN failover breaks audit-log write SLA (500 ms p95); air-gapping SECRET tier replication costly

*NFR-SCL-WB-008 · domain: workbench*

**Detail:** Audit-log distributed ledger requires 3-replica quorum write (2-of-3 ACK). LAN latency (same AZ, <5 ms round-trip) allows 150 ms quorum consensus (Noyce budget). WAN failover (cross-region replica for disaster recovery) introduces 30-100 ms latency per network hop. In WAN mode, 500 ms p95 SLA becomes unachievable (3-way quorum = 300 ms baseline + jitter). SECRET tier air-gap (on-prem facility) makes WAN failover infeasible (dedicated air-gapped replicas required; cost prohibitive for third repli

**Recommendation:** For OFFICIAL tier: implement AZ failover (2 replicas in AZ-1, 1 in AZ-2, both same region <20 ms latency). Audit-log SLA remains <500 ms. For SECRET tier: establish hot-standby replica in same facility (air-gapped); eliminate WAN failover. Disaster recovery (multi-site backup): async archive to S3 with 1-2 hour RPO (acceptable for audit trail). Accept that SECRET tier has 2-4 hour RTO on total facility loss; mitigation = strict physical security + redundant power/cooling.

---

### S — Security · Yao

#### [CRITICAL · C9] OAuth 2.1 IdP outage becomes single point of failure (F-01 to F-08 workflows blocked)

*NFR-SEC-003 · domain: workbench*

**Detail:** CAA Workbench spans civil (CAA IdP) and military (MOD IdP) regulatory boundaries. Every user session begins with IdP authentication. If MOD IdP is unavailable (network partition, IdP server failure), all classified-tier users (panel members, SORA assessors) cannot authenticate, and Noyce F-05 through F-08 workflows (case-open, AI-flag narrative, evidence navigation, audit-log write) are blocked. If CAA IdP fails, civil applicants cannot upload evidence, blocking F-01 through F-03 workflows. IdP 

**Recommendation:** Implement IdP redundancy: primary + secondary + tertiary IdP endpoints across geographic regions (MOD: 3-region failover; CAA: 3-region failover). Cache OAuth tokens for 1-hour TTL with refresh-token rotation. Implement graceful degradation: if primary IdP is unavailable for >30 seconds, serve read-only cached token to low-risk users (applicants with view-only access). For critical panel workflows (F-05 to F-08), require fresh token but implement 5-second IdP timeout + fallback to 'limited panel

---

#### [CRITICAL · C9] Applicant portal DDoS attack surface: credential-stuffing + large-payload uploads

*NFR-SEC-014 · domain: workbench*

**Detail:** Applicant portal (OFFICIAL-tier auth gate, Noyce F-01 to F-03) is the only public-facing workbench entry point. Two high-value DoS targets: (1) Login endpoint: credential-stuffing attack using leaked password databases (e.g., LinkedIn breach). Rate limiting is 5/min per account, 20/min per IP. An attacker with 1000 botnet IPs can sustain 20,000 login attempts/min, overwhelming rate-limiting thresholds. (2) Evidence upload endpoint: attacker uploads large malicious PDFs (500 MB each) to exhaust s

**Recommendation:** Implement multi-layer DDoS defense: (1) CDN-level DDoS mitigation (100+ Gbps capacity, UK-sovereign provider). (2) WAF rules to detect and block credential-stuffing patterns (sudden spike in login failures from diverse IPs). (3) CAPTCHA challenge after 3 failed login attempts per account. (4) Exponential backoff: lock account for 15 minutes after 5 failed attempts. (5) Implement timeout on PDF scanning (Noyce 'virus_scan' and 'content_classification' components): if detector does not respond in 

---

#### [MAJOR · C9] RFC 3161 TSA call blocks audit-log latency SLA (NFR-LAT-009)

*NFR-SEC-008 · domain: workbench*

**Detail:** Noyce NFR-LAT-009 budgets 500 ms p95 for panel-action log write (review comment, flag, decision state change). This is a critical-tier SLA for forensic audit trail. RFC 3161 Time Stamp Authority round-trip adds 80-150 ms to each write. If TSA call is synchronous, p95 latency will exceed 500 ms budget (500 ms - 100 ms reserved for network/app = 400 ms available, but 80-150 ms TSA + 100-150 ms immutable-log-write = 180-300 ms taken, leaving only 100-200 ms for actual app work and validation). If T

**Recommendation:** Use asynchronous TSA call with durable queue (Kafka, RabbitMQ) to decouple user-facing latency from TSA round-trip. Implement retry logic with exponential backoff and dead-letter handling. Monitor TSA availability and set SLA alert if TSA response time exceeds 100 ms or availability drops below 99.5%. Use local clock to timestamp at time of action, then backfill cryptographic TSA token asynchronously. Test impact with synthetic load: validate that p95 NFR-LAT-009 remains <500 ms with async TSA. 

---

#### [MAJOR · C8] Hash-chain verification overhead risks case-open SLA (NFR-LAT-006 p95 10s)

*NFR-SEC-007 · domain: workbench*

**Detail:** Noyce NFR-LAT-006 'Panel case-open and load' budgets 10 seconds (p95) for regulator to click a case and see interactive panel. Hash-chain verification (ensuring evidence has not been tampered with) is a critical forensic control. Typical 100 MB evidence pack: 50-500 ms to compute SHA-256 hashes (CPU-bound on single thread). If system processes cases sequentially or if CPU contention occurs during peak panel review (10+ simultaneous reviewers per Noyce NFR-LAT-019), hash verification latency coul

**Recommendation:** Implement parallel SHA-256 verification using worker threads (1 thread per 10 MB chunk, or use GPU acceleration if available). Pre-compute hashes during evidence upload (Noyce NFR-LAT-002) and cache in fast-access tier (Redis, in-process cache). Use cryptographic hash acceleration (AES-NI, SHA-NI CPU extensions) if available on compute platform. Target hash verification latency: <200 ms p95 for 100 MB typical case, <500 ms p95 for 500 MB worst-case pack (Noyce NFR-LAT-018). Implement incremental

---

#### [MAJOR · C8] Classification marking validation overhead scales poorly with search results (NFR-LAT-017)

*NFR-SEC-005 · domain: workbench*

**Detail:** Noyce NFR-LAT-017 'Evidence search across classification boundary' budgets 5 seconds (p95) for a query returning multiple results across 10-year archive. Classification boundary check (ensuring user's clearance level permits access to each result) is required per result. If query returns 1000 results and classification check is 5 ms per result, total overhead is 5 seconds alone, consuming the entire SLA budget before search index lookup or result rendering. Workbench stores 10 years of trial rec

**Recommendation:** Pre-filter evidence by user's classification clearance level at search index level (Elasticsearch, Solr) rather than post-query filtering. Index evidence with clearance-level tags (OFFICIAL, OFFICIAL-SENSITIVE, SECRET) and use index-level access control to eliminate ineligible results before retrieval. Cache classification-clearance decisions per user session (TTL = 1 hour) to amortize repeated lookups. For bulk export (decision record PDF, Noyce NFR-LAT-010), batch classification checks asynchr

---

### U — Usability · Turing

#### [CRITICAL · C9] Time to first meaningful feedback (RAG flag visibility) is critical abandonment threshold

*NFR-USE-002 · domain: *

**Detail:** Parent story NFR requires 'first RAG flag visible within 60 s p95 of Phase 1 Step 2 complete.' Applicants submitting evidence packs expect immediate feedback. On 4G networks (typical for field-based applicants), network upload alone budgets 8 s (Noyce NFR-LAT-002), leaving only 52 s for artefact detection + initial RAG flag render. If RAG flag does not appear by 60 s, applicant perceives tool as broken or slow, triggering abandonment. Analysis of abandonment threshold shows applicants waiting >1

**Recommendation:** Implement skeleton RAG flag display immediately upon upload completion. Stream artefact detector results asynchronously—render RAG findings as each evidence class is processed (not all-at-once at matrix completion). Announce progress to screen readers every 5 classes: 'ConOps processed. Scanning ODD...' Conduct usability testing with applicants on simulated 4G network (10-20 Mbps variable latency) to validate 60 s p95 target.

---

#### [CRITICAL · C9] Coverage matrix generation (10 min p95) requires visible progress indication to prevent abandonment

*NFR-USE-003 · domain: *

**Detail:** Noyce budget (NFR-LAT-003) allocates 10 minutes p95 for coverage matrix generation on 100 MB evidence pack. Semantic inference alone budgets 200 s (3 min 20 s). Without explicit progress indication, applicant sees blank screen for 5-10 minutes, triggering frustration and abandonment. Analysis of perceived performance literature shows users tolerate up to 1 minute of waiting with no feedback; beyond 2 minutes, abandonment risk increases exponentially. Parent story emphasis on '10 minute matrix' s

**Recommendation:** Display explicit progress timeline with milestone checkpoints: 'OCR in progress... 2 min 30 sec remaining (Step 1/5)' → 'Semantic classification... 3 min 45 sec remaining (Step 2/5)' → 'Generating matrix... 1 min 15 sec remaining (Step 3/5).' Update every 30-60 seconds. For worst-case 500 MB pack (20 min budget, NFR-LAT-018), surface proactive message: 'Larger pack detected. Expected time: ~20 minutes. You can close this tab and check back later.' Implement Web Workers or background task to prev

---

#### [CRITICAL · C9] AI-flag narrative (30 min p95) must stream progressively to prevent regulator disengagement

*NFR-USE-009 · domain: *

**Detail:** Noyce budget (NFR-LAT-007): 30 minutes p95 for AI-flag narrative completion. One-shot batch inference spanning 900 s (15 min of inference alone). Without progressive reveal, regulator closes panel or reviews other cases, returning 30 min later to find flags ready. Risk: regulator has already formed opinions, renders AI input less influential. Best practice: stream results as inference chunks complete (every 2-3 min, flag 'Flag 3 of 8 complete'). This maintains engagement and allows regulator to 

**Recommendation:** Implement server-sent events (SSE) or WebSocket stream from inference service to panel. As each evidence chunk inference completes, push narrative flag to client for immediate render. Show progress: 'AI analyzing ConOps (3/8)... Estimated 15 min remaining.' Allow regulator to begin reviewing Flag 1 while Flags 4-8 compute. If inference fails mid-stream (5% error budget), surface 'Retry failed chunks? [Retry] [Dismiss]' with one-click recovery. Announce progress via ARIA live region every 2 minut

---

#### [CRITICAL · C9] Panel action log write (500 ms p95) must use optimistic UI to mask distributed log latency

*NFR-USE-010 · domain: *

**Detail:** Noyce budget (NFR-LAT-009): 500 ms p95 for action log write. Regulator submits comment, expects immediate confirmation. Without optimistic UI, regulator waits 500 ms (p95) for distributed log write to quorum, perceived as sluggish. Under high contention (10+ reviewers, NFR-LAT-019), p95 can spike to 1 s. Optimistic UI—show 'saved' immediately, roll back only if write fails—masks latency and maintains perception of responsiveness. Parent story emphasis on 'audit trail' requires immutable record, 

**Recommendation:** Implement optimistic UI: display 'Your comment saved' and commit button disabled immediately upon submit. Queue write to distributed log asynchronously. If write succeeds (expected), operation complete. If write fails (timeout >2s or network error), show 'Draft saved locally. Sync failed—check connection.' with manual retry button. Do NOT discard comment—persist in browser storage as insurance. Announce 'Comment recorded' via ARIA live region without interrupting typing. Test with 10 concurrent 

---

#### [CRITICAL · C9] Screen reader row announce latency in coverage matrix must remain <200 ms for regulatory compliance

*NFR-USE-accessibility-1 · domain: *

**Detail:** Accessibility NFR: WCAG 2.2 AA, screen reader / high-contrast profile. Coverage matrix is a large table (10-50 rows, 20+ columns). Applicant using JAWS or NVDA navigates row-by-row. If screen reader announce latency exceeds 200 ms per row, interaction becomes frustratingly slow. Applicant may abandon tool if accessible mode feels sluggish compared to sighted mode. Regulatory requirement: if CAA intends tool for public use, accessibility audit will test this scenario.

**Recommendation:** Profile screen reader navigation on typical evidence pack (100 MB = ~30 clauses, 5-7 coverage rows per clause = 150-210 total rows). Measure time from arrow-key press to announce completion. Optimize row announcement by: (1) pre-compute row text at matrix generation time (not on-demand), (2) cache announcement text in data attributes, (3) use ARIA live regions sparingly (only for dynamic updates). Test with JAWS, NVDA, and VoiceOver on latest versions. Aim for announce latency <100 ms per row (t

---

#### [MAJOR · C8] Readiness Check (60 s p95) must render verdict before blocking issues list to minimize cognitive load

*NFR-USE-005 · domain: *

**Detail:** Noyce budget (NFR-LAT-005) targets 60 s p95 for Readiness Check completion. Applicant submits check and waits for PASS/FAIL decision. If system responds with verbose blocking issues list before verdict (e.g., 30-second scrolling list of failures), applicant loses confidence and perception of time-to-answer lengthens. UX best practice: announce verdict first, then details. Applicant's cognitive load is highest at this decision point—they need immediate clarity on pass/fail before navigating remed

**Recommendation:** Render PASS/FAIL verdict immediately (large green checkmark or red X with clear text: 'Ready to submit' or 'Blocking issues found'). Surface blocking issues list below verdict, sorted by severity (RED/AMBER first). Provide estimated remediation time per issue: 'ODD incomplete: ~15 min to fix. ConOps review pending: ~2-3 days.' Implement timeout handling: if check exceeds 120 s, surface 'Still checking...' with refresh button and estimated remaining time. Log all timeouts and errors for analysis 

---

#### [MAJOR · C8] Panel case-open latency (10 s p95) impacts regulator efficiency in multi-day sessions

*NFR-USE-007 · domain: *

**Detail:** Noyce budget (NFR-LAT-006): 10 s p95 for case-open operation. Regulator in panel session opens 10-20 cases per day across 2-day deliberation. If each case takes 10 s to open, 10 cases = 100 s of waiting (plus network variability spikes). Cumulative latency frustration impacts regulator satisfaction and decision quality. Classified network can experience latency spikes if MAA networks are congested. Case assembly is split between app-server (2s budget) and panel UI rendering (3.9s budget)—renderi

**Recommendation:** Prefetch next 3 likely cases based on case list scroll position (background fetch of case metadata without full rendering). Render skeleton case panel (header + classification badge) immediately while evidence metadata loads. Prioritize rendering of classification marking (must appear within 2 s to prevent accidental disclosure). Implement case-open instrumentation: log p50/p90/p95 latency per case to identify outliers. If case-open exceeds 15 s, alert infrastructure team for network investigati

---

#### [MAJOR · C8] Evidence navigation (2 s p99) must remain responsive during high-frequency panel pointer clicks

*NFR-USE-008 · domain: *

**Detail:** Noyce budget (NFR-LAT-008): 2 s p99 for evidence section navigation. Regulator navigates via clause references mapped to evidence paragraphs. High-frequency operation: 50-100 clicks per case during deliberation. If navigation latency creeps to 3-4 s, regulator loses flow state and makes annotation errors. DOM rendering (0.8s budget) + JavaScript interaction (0.6s budget) are tight. Cache behavior is critical: evidence pages must be cached after initial case load to avoid repeated server fetches.

**Recommendation:** Cache all evidence pages in browser once case is loaded. Implement hash-based navigation (#clause-123) for instant in-page jumps without server fetch. Highlight target paragraph with subtle animation (yellow background, then fade to normal). For evidence archive searches (NFR-LAT-017: 5 s p95 across 10-year archive), accept slightly longer latency but prefetch top 3 search results. Monitor navigation latency via field instrumentation (PerformanceObserver). Alert if p99 exceeds 3 s.

---

### M — Monitoring · Iverson

#### [CRITICAL · C9] Missing synthetic monitoring for SECRET-tier classification boundary

*NFR-MON-GAP-001 · domain: workbench*

**Detail:** Secret-tier evidence (STRAP, MOD-involved trials) is air-gapped and cannot be monitored via RUM (no applicant access). Classification boundary rejects must be audited but synthetic tests cannot probe SECRET tier from unclassified network. Current monitoring plan relies on production audit logs only, missing real-time alerting on classification-service degradation affecting MOD users.

**Recommendation:** Establish on-premises synthetic test running within air-gapped network (MOD-hosted workstation). Test monthly: (1) tier-transition from OFFICIAL to SECRET, (2) rejection of out-of-tier evidence, (3) latency <2s for classification decision. Coordinate with MOD ITSO for workstation access and test scheduling. Log synthetic test results to immutable audit trail (not accessible from unclassified side; share summary reports only).

---

#### [CRITICAL · C9] Missing ODD (Operational Design Domain) monitoring for swarm autonomy (input drift detection)

*NFR-MON-DRIFT-001 · domain: swarm*

**Detail:** REQ009 ML Assurance Case requires frozen-model manifest and explainability. Swarm autonomy model is trained on specific ODD (weather, airspace, aircraft type, swarm size). If trial operates outside trained ODD (e.g., weather unexpectedly changes, swarm expands beyond training size), onboard ML inference becomes unreliable (confidence <60%, or predictions diverge from expected behavior). Current monitoring tracks inference latency and confidence, but missing explicit ODD-boundary check: 'Are curr

**Recommendation:** Instrument ODD monitoring: (1) define ODD bounds in model manifest (weather wind speed <15 mph, swarm size 5-10 vehicles, airspace type rural), (2) log operating conditions every 1 sec (wind speed, swarm size, airspace density), (3) compare to ODD bounds; alert if conditions exceed bounds. If ODD violation detected, trigger: (a) low-confidence inference flagging (confidence threshold raised to >80%), (b) ground-control alert: 'Operating outside trained ODD; recommend manual override,' (c) post-t

---

#### [MAJOR · C9] Missing distributed-trace instrumentation for end-to-end coverage matrix journey (applicant → matrix PDF)

*NFR-MON-GAP-003 · domain: workbench*

**Detail:** Noyce NFR-LAT-003 budgets 600s p95 for matrix generation (100 MB pack). Component budgets are: OCR 180s, semantic classification 200s, matrix computation 90s, PDF rendering 40s. Current APM monitoring tracks aggregate inference latency, but missing distributed-trace correlation IDs linking: upload request → evidence store fetch → OCR batch → semantic classifier → matrix computation → PDF renderer. When p95 exceeds 600s, cannot pinpoint which component(s) are over budget; optimization is blind.

**Recommendation:** Inject OpenTelemetry trace IDs (W3C format) at evidence-upload initiation. Propagate through: storage fetch, OCR job submission, semantic inference queue, matrix DB query, PDF rendering. Instrument each stage with start/end timestamps and component-specific metrics (OCR: pages processed, semantic: tokens classified, PDF: elements rendered). Visualize end-to-end trace in distributed-trace UI (Jaeger/Datadog). Alert if any trace exceeds 600s; highlight slowest component in trace.

---

#### [MAJOR · C9] Missing CI/CD regression detection for coverage matrix generation (inference model changes)

*NFR-MON-REGR-001 · domain: workbench*

**Detail:** Coverage matrix engine (OCR + semantic classification) is ML-based. When model is retrained (monthly per adaptive training), new model may have higher latency (larger model) or different accuracy (may over/under-flag evidence). CI/CD deploys new model to staging; if p95 latency regresses >10% vs baseline, or if flag distribution shifts >20%, regression should be caught before production deployment. Current monitoring lacks 'build-over-build' regression test (compare staged model vs previous prod

**Recommendation:** Implement regression test in CI/CD pipeline: (1) on model update, compute p95 latency on fixed 100 MB test pack (Scotland case + SORA case per Ada benchmarks), (2) compare to previous model; fail if >10% latency regression, (3) compute flag distribution (% RED/AMBER/GREEN) on test set; fail if kappa <0.85 vs previous model (possible accuracy regression). Fail CI gate if regression detected; require explicit approval from ML/platform leads to override. Generate weekly report: model performance tr

---

#### [MAJOR · C8] No real-time alert correlation between classification-tier changes and regulator calibration drift

*NFR-MON-GAP-002 · domain: workbench*

**Detail:** When classification library is updated (3-4 times/year per Ada capacity) or clause versioning changes, AI-flag generation may drift (different evidence retrieval logic, different semantic search results). Simultaneously, regulator override rates may spike because flags no longer align with their previous calibration. Current monitoring treats these as independent; no cross-correlation to identify root cause (library change) vs symptom (calibration drift).

**Recommendation:** Implement alert correlation: if library revision advances AND regulator override rate increases >15% within 24 hours, trigger 'Possible library-change impact on AI flags' alert (confidence: medium). Include in alert: which clauses changed, override-rate magnitude, affected case types. Do NOT auto-remediate; escalate to CAA Innovation Hub for investigation. Add monthly report: library changes vs override-rate deltas (train regulator expectations on expected variance).

---

### E — Endurance · Cerf

#### [CRITICAL · C8] GPU inference memory leak risk in 72-hour soak—AI narrative service requires long-duration testing

*NFR-END-WB-001-LEAK · domain: workbench*

**Detail:** Ada capacity analysis (NFR-CAP-WB-001, NFR-CAP-WB-003) identifies 'AI model serving: memory leaks in GPU inference over long runs' as specific risk. LLM model serving frameworks (vLLM, TensorRT) can accumulate memory if token buffers are not properly freed between inferences or if prompt cache is not evicted. Liskov scalability (NFR-SCL-WB-003) budgets 16-40 GB GPU memory per instance; at 85% utilization (13.6-34 GB occupied), thermal throttling and performance degradation begin. Long-duration s

**Recommendation:** Mandatory 72-hour soak test (Gate 5) with GPU memory instrumentation. Collect nvidia-smi metrics every 5 seconds; plot GPU memory trend (target: flat line after initial ramp-up, acceptable 5% variance). If linear drift detected, enable core dumps and use memory profiler (valgrind, NVIDIA Nsight) to identify leak source. Mitigation: (1) Implement periodic model server restart (hourly, during low-load windows); (2) Add aggressive prompt cache eviction (LRU with 1-hour TTL); (3) Pre-load model into

---

#### [CRITICAL · C8] Swarm consensus O(n²) latency ceiling—20-vehicle swarm exceeds 500ms DAA resolution SLA

*NFR-END-SWM-001-CONSENSUS · domain: swarm*

**Detail:** Liskov scalability (NFR-SCL-SWM-002) identifies swarm consensus as O(n²) in vehicle count. For 5-vehicle swarm: 10 pairwise comparisons, ~50ms compute. For 10-vehicle swarm: 45 comparisons, ~200ms. For 20-vehicle swarm: 190 comparisons, ~800ms (exceeds 500ms latency budget per Noyce NFR-LAT-012 'DAA encounter detection and response ... within 5 s of first detection'). Liskov explicitly flags: '20-vehicle swarm → 190 pairwise comparisons, ~800ms compute (exceeds 500 ms SLA; sequential resolution 

**Recommendation:** Breakpoint test (component design input, not release gate) must evaluate consensus latency vs swarm size: simulate 5, 10, 15, 20 vehicle swarms with DAA encounter injection. Measure: time-to-resolution for coordinated maneuver decision. Determine: at what vehicle count does latency exceed SLA? If 20-vehicle consensus latency >500ms, mitigation is required: (A) Hierarchical clustering: partition 20-vehicle swarm into two 10-vehicle sub-swarms; each sub-swarm consensus internally (~200ms), then pa

---

#### [CRITICAL · C7] C2 link loss detection latency—1-second SLA tight for RF fade detection during sustained operations

*NFR-END-SWM-C2LOSS · domain: swarm*

**Detail:** Noyce NFR-LAT-020 'Loss-of-C2 link detection and autonomous survival activation' budgets 1000ms hard deadline (p50 200ms, p99 1000ms). Vibe requirements (C2LinkResilience per alan-availability.json NFR-AVL-S002) budget 90+ seconds of autonomous survival before RTL triggered. Swarm operational testing must validate C2 loss detection latency in realistic RF conditions: (A) Gradual link fade (RSSI declining, packet loss increasing from 0% to 100% over 5-30 seconds). (B) Sudden link loss (RF jammed,

**Recommendation:** Endurance flight test (NFR-END-SWM-001) must include controlled C2 loss scenario: (A) During sustained 4-hour flight, deliberately lose RF signal for 30-60 seconds (induce RF blackout via Faraday cage or jammer). (B) Measure: time from signal loss (ground station loses valid packet reception) to autonomous behavior initiation (aircraft begins altitude reduction per failsafe logic). Acceptance: detection latency <1000ms. (C) Verify: autonomous survival behavior holds altitude/formation for 90+ se

---

#### [MAJOR · C9] Evidence store metadata index degradation—object listing latency at 10M objects requires indexing strategy validation

*NFR-END-WB-002-DEGRADE · domain: workbench*

**Detail:** Ada capacity (NFR-CAP-WB-005) explicitly identifies 'slow growth of object metadata index causing search degradation' as a known risk. By 2028, evidence store will contain 10M+ objects (140 GB cumulative, ~20 MB per case, 7,000 cases). Evidence search (Noyce NFR-LAT-017) budgets p95 <5s across 10-year archive. Object listing (enumerating objects by case, date, classification tier) is a foundational query; if index fragmentation grows, latency can degrade to 10-20s, breaking interactive workload.

**Recommendation:** Volume test (Gate 6) must execute against 140 GB replica with 10M objects. Benchmark: (1) Object listing by case_id (expected <100ms). (2) Object search by keyword (expected p95 <5s per Noyce). (3) Index statistics query (count objects by classification tier). Capture index size and page count before/after test. Monitor: query plan cost (EXPLAIN ANALYZE). If latency degrades >10% from baseline, implement indexing mitigation: (A) Partition evidence store by classification tier (separate S3 bucket

---

#### [MAJOR · C8] Gate 4 (Stress) missing acceptance criteria for panel session shedding under overload—must define graceful degradation behavior

*NFR-GATE-MISSING-4 · domain: workbench*

**Detail:** Ada capacity (NFR-CAP-WB-003) defines peak panel concurrency: 20 users during plenary vote sessions (8-20 concurrent panelists per panel, 1-3 simultaneous panels = 15-20 peak). Stress gate (Gate 4, NFR-END-WB-002) requires graceful degradation at 2x peak (40+ concurrent users). Current test strategy specifies 'Panel-mode session overflow: shed at session creation (reject new panel open), not mid-session.' But acceptance criteria is vague: what is 'graceful shedding'? Acceptable p95 latency durin

**Recommendation:** Refine Gate 4 acceptance criteria: (A) Define capacity limit: 'System supports max 20 concurrent panel members active-active. At 21+ concurrent members, new panel-open requests are rejected with HTTP 503 Service Unavailable + user-friendly message: "This panel is at capacity. Please try again in 5 minutes or contact CAA support."' (B) Define latency during overload: 'p95 latency for existing panel members (already logged in) must remain <10s p95 even during overload rejection phase.' (C) Define 

---

#### [MAJOR · C8] Audit log write latency drift risk—ledger fragmentation or fsync overhead can degrade 500ms p95 budget over 72 hours

*NFR-END-WB-AUDIT-DRIFT · domain: workbench*

**Detail:** Noyce NFR-LAT-009 budgets 500ms p95 for panel-action log write (audit trail is regulatory-critical per REQ012). Liskov NFR-SCL-WB-008 describes audit log as sharded append-only ledger (Kafka or similar). Write performance depends on fsync latency (disk durability) and quorum ACK latency (replication consensus). On Liskov design: '1 shard (1 panel) handles ~50 actions/sec. Quorum write: 2-of-3 replicas ACK within 150 ms.' Over 72-hour soak with cumulative 10,000+ panel actions, ledger grows; if f

**Recommendation:** Soak test (Gate 5) must monitor audit log write latency histogram every 10 minutes. Plot trends: (A) Quorum ACK latency component (time for 2-of-3 replicas to ACK); target stable <150ms. (B) Total write latency p95; target stable <500ms. If drift detected, investigate: (i) Disk I/O saturation (iostat, fio); (ii) fsync overhead increase (strace -e fsync); (iii) Replication lag (Kafka partition lag metrics). Mitigation: (A) Batch writes: aggregate 10-100 actions into single ledger entry (reduces w

---


## Top Priority Actions

Based on cross-discipline analysis:

1. **Panel-action log 500 ms SLA is at serious risk** — distributed consensus inherently serialising (Liskov) + TSA timestamp overhead (Yao) + classification check + replication. Recommend either relax SLA to 1 s or adopt async/optimistic write with durable ack within 500 ms and commit within 2 s.
2. **Coverage matrix 10-minute budget is tight on 500 MB packs** — OCR + AI inference in series consume most of the budget at p95. Recommend pipeline parallelisation and progressive reveal (Turing NFR-USE).
3. **Classification boundary is a bottleneck and SPOF** — Liskov flags no failover; Yao flags auth IdP outage risk; Alan flags 99.9% target unachievable without architecture rework. Dedicated classified enclave with independent auth cache.
4. **GPU capacity for AI inference must scale 5x by 2028** — Ada flags need for 4-5 A100-class GPUs; Cerf flags GPU memory leak risk over 72 h soak.
5. **ODD monitor for swarm autonomy is absent** — Iverson flags critical gap. Onboard ML inference may leave trained ODD without detection; feeds keystone K4 ML forensic explainability.
6. **Alert fatigue risk high** — Iverson identifies three context-insensitive alerts that will fire during legitimate testing and operations. Recommend dynamic thresholds keyed to trial context and volume baseline.
7. **Performance doneness gates not fully in place** — Cerf identifies missing GPU perf unit harness, no multi-journey integration, no 8h load test; all three are book-recommended "proven practices".
8. **Red-team exercises will run against live system** (parent story DoD) — Yao recommends coordinated tagging of red-team traffic so SOC does not spuriously alert.

---

*Report generated by [OpenRequirements.ai](https://www.openrequirements.ai) · Based on Effective Performance Engineering by DeCapua & Evans*