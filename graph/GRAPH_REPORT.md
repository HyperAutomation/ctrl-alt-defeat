# Graph Report - ./swarm  (2026-04-22)

## Corpus Check
- 5 files · ~167,612 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 196 nodes · 200 edges · 27 communities detected
- Extraction: 66% EXTRACTED · 34% INFERRED · 0% AMBIGUOUS · INFERRED: 68 edges (avg confidence: 0.82)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_CAP 722A Operating Safety Case|CAP 722A Operating Safety Case]]
- [[_COMMUNITY_Military Air System Operations|Military Air System Operations]]
- [[_COMMUNITY_Remote Pilot Competence Framework|Remote Pilot Competence Framework]]
- [[_COMMUNITY_Military Flying Authority Chain|Military Flying Authority Chain]]
- [[_COMMUNITY_UAS Technical Description|UAS Technical Description]]
- [[_COMMUNITY_Environmental Standards & Def Stans|Environmental Standards & Def Stans]]
- [[_COMMUNITY_Aircrew Qualifications & Currency|Aircrew Qualifications & Currency]]
- [[_COMMUNITY_Avionics Safety & Data Bus|Avionics Safety & Data Bus]]
- [[_COMMUNITY_Payload EMC & NBC Protection|Payload EMC & NBC Protection]]
- [[_COMMUNITY_Sense-and-Avoid & Range Safety|Sense-and-Avoid & Range Safety]]
- [[_COMMUNITY_Post-Crash Management (Withdrawn)|Post-Crash Management (Withdrawn)]]
- [[_COMMUNITY_Electronics & PCB Standards|Electronics & PCB Standards]]
- [[_COMMUNITY_Landing Energy Absorber System|Landing Energy Absorber System]]
- [[_COMMUNITY_RPAS Crew & Workload|RPAS Crew & Workload]]
- [[_COMMUNITY_Flight Termination System|Flight Termination System]]
- [[_COMMUNITY_FTS Interference Resistance|FTS Interference Resistance]]
- [[_COMMUNITY_DRACAS Reliability Database|DRACAS Reliability Database]]
- [[_COMMUNITY_Military Aviation Register|Military Aviation Register]]
- [[_COMMUNITY_Defence AI Org Structure|Defence AI Org Structure]]
- [[_COMMUNITY_ML & Dependable AI|ML & Dependable AI]]
- [[_COMMUNITY_RA 2355 Parachuting (Withdrawn)|RA 2355 Parachuting (Withdrawn)]]
- [[_COMMUNITY_C2 Data Link (Subpart H)|C2 Data Link (Subpart H)]]
- [[_COMMUNITY_Human Factors (Def Stan 00-250)|Human Factors (Def Stan 00-250)]]
- [[_COMMUNITY_Approved Lubricants (Def Stan 01-5)|Approved Lubricants (Def Stan 01-5)]]
- [[_COMMUNITY_DAP119A Publications Series|DAP119A Publications Series]]
- [[_COMMUNITY_BS 381C Colour Standard|BS 381C Colour Standard]]
- [[_COMMUNITY_Open Category UAS|Open Category UAS]]

## God Nodes (most connected - your core abstractions)
1. `2300 Series (Operation of Aircraft)` - 22 edges
2. `FLY 2000 Series Regulatory Articles` - 14 edges
3. `JSP 936 Part 1 - Dependable AI in Defence (Directive)` - 11 edges
4. `2100 Series (Aircrew Qualifications and Competency)` - 9 edges
5. `Recognised Assessment Entity for Remote Pilot Competence RAE(PC)` - 9 edges
6. `Operating Safety Case (OSC)` - 8 edges
7. `UAS OSC Volume 2 - UAS Description` - 7 edges
8. `UK FW.U1481b Payload Reconfiguration EMC` - 6 edges
9. `Subpart I - UAV Control Station` - 6 edges
10. `MOD AI Ethical Principles` - 6 edges

## Surprising Connections (you probably didn't know these)
- `Meaningful Human Control` --semantically_similar_to--> `Operating Safety Case (OSC)`  [INFERRED] [semantically similar]
  swarm/JSP936_Part1.md → swarm/cap722a_edition_2.md
- `Ethical Principle: Bias and Harm Mitigation` --semantically_similar_to--> `Safety Risk Assessment Process (SRAP)`  [INFERRED] [semantically similar]
  swarm/JSP936_Part1.md → swarm/cap722a_edition_2.md
- `Robotic and Autonomous Systems (RAS)` --semantically_similar_to--> `UAS OSC Volume 2 - UAS Description`  [INFERRED] [semantically similar]
  swarm/JSP936_Part1.md → swarm/cap722a_edition_2.md
- `Operational Design Domain (ODD)` --semantically_similar_to--> `UAS OSC Volume 2 - UAS Description`  [INFERRED] [semantically similar]
  swarm/JSP936_Part1.md → swarm/cap722a_edition_2.md
- `International Humanitarian Law (IHL)` --semantically_similar_to--> `Operational Risk Assessment (ORA)`  [AMBIGUOUS] [semantically similar]
  swarm/JSP936_Part1.md → swarm/cap722a_edition_2.md

## Hyperedges (group relationships)
- **RPAS Category Framework (Open, S1, S2, Certified)** — fly2000seriesprint_2026_03_31_open_category_rpas, fly2000seriesprint_2026_03_31_s1_category_rpas, fly2000seriesprint_2026_03_31_s2_rpas, fly2000seriesprint_2026_03_31_certified_rpas [EXTRACTED 0.90]
- **Military Flying Authority Chain** — fly2000seriesprint_2026_03_31_maa, fly2000seriesprint_2026_03_31_director_maa, fly2000seriesprint_2026_03_31_aviation_duty_holder, fly2000seriesprint_2026_03_31_accountable_manager_military_flying [EXTRACTED 0.90]
- **Flight Clearance Mechanisms in Defence Air Environment** — fly2000seriesprint_2026_03_31_defence_air_environment, fly2000seriesprint_2026_03_31_release_to_service, fly2000seriesprint_2026_03_31_military_permit_to_fly [EXTRACTED 0.90]
- **Payload EMC Compliance Standards** — 970_9_uk_fw_u1481b, 970_9_stanag_4145, 970_9_aectp_250, 970_9_aectp_500, 970_9_def_stan_59_411 [EXTRACTED 0.90]
- **Command and Control Link Safety Flow** — 970_9_uk_fw_u1601c, 970_9_fmeca, 970_9_rpas_hazard_log, 970_9_def_stan_00_56 [EXTRACTED 0.90]
- **NBC and LASER Protection Regime** — 970_9_uk_rw_601c, 970_9_def_stan_08_4, 970_9_def_stan_08_41, 970_9_stanag_4360 [EXTRACTED 0.90]
- **JSP 936 Five MOD AI Ethical Principles** — jsp936_part1_human_centricity, jsp936_part1_responsibility, jsp936_part1_understanding, jsp936_part1_bias_harm_mitigation, jsp936_part1_reliability [EXTRACTED 1.00]
- **CAP 722A OSC Three-Volume Structure** — cap722a_edition_2_ops_manual, cap722a_edition_2_uas_description, cap722a_edition_2_safety_risk_assessment [EXTRACTED 1.00]
- **UK UAS Specific Category Authorisation Framework** — cap722b_fifthedition_specific_category, cap722a_edition_2_osc, cap722b_fifthedition_uk_sora, cap722b_fifthedition_sail [INFERRED 0.85]

## Communities

### Community 0 - "CAP 722A Operating Safety Case"
Cohesion: 0.09
Nodes (28): Air Accidents Investigation Branch (AAIB), As Low As Reasonably Practicable (ALARP), CAP 795 Safety Management System Guidance, Emergency Response Plan (ERP), UAS OSC Volume 1 - Operations Manual, Operational Risk Assessment (ORA), Operating Safety Case (OSC), Pre-Defined Risk Assessment (PDRA) (+20 more)

### Community 1 - "Military Air System Operations"
Cohesion: 0.1
Nodes (25): Certified Remotely Piloted Air Systems, 2300 Series (Operation of Aircraft), RA 2301 - Responsibility for an Air System, RA 2302 - Responsibilities when Operating or Employed on an Air System, RA 2305 - Supervision of Flying, RA 2306 - Authorization of Flights, RA 2307 - Rules of the Air, RA 2309 - Flight Procedures: General (+17 more)

### Community 2 - "Remote Pilot Competence Framework"
Cohesion: 0.1
Nodes (22): A2 Certificate of Competency, UK Civil Aviation Authority (CAA), General VLOS Certificate (GVC), Operational Authorisation, Performance-Based Oversight (PBO), Practical Flight Assessor (PFA), Practical Flight Instructor (PFI), Recognised Assessment Entity for Remote Pilot Competence RAE(PC) (+14 more)

### Community 3 - "Military Flying Authority Chain"
Cohesion: 0.12
Nodes (17): Accountable Manager (Military Flying), Aviation Duty Holder, Defence Air Environment, Director MAA, FLY 2000 Series Regulatory Articles, Military Aviation Authority (MAA), MAA Regulatory Publications, Military Permit to Fly (+9 more)

### Community 4 - "UAS Technical Description"
Cohesion: 0.16
Nodes (15): Article 11 UK Reg (EU) 2019/947, Command and Control (C2) Link, CAP 722D Abbreviations Master Glossary, Command Unit (CU), Detect and Avoid (DAA), CAP 722A Second Edition - Operating Safety Cases, Light UAS Operator Certificate (LUC), UAS OSC Volume 2 - UAS Description (+7 more)

### Community 5 - "Environmental Standards & Def Stans"
Cohesion: 0.18
Nodes (12): AECTP 100-500 Series Environmental Guidelines, Def Stan 00-3, Def Stan 00-35 Environmental Handbook, Def Stan 00-970 Part 9/13, Def Stan 08-4 Nuclear Weapons Effects, Def Stan 08-41 Chemical Biological Hardening, JSP 482, Section 2 - Fixed Wing Compliance (+4 more)

### Community 6 - "Aircrew Qualifications & Currency"
Cohesion: 0.28
Nodes (9): 2100 Series (Aircrew Qualifications and Competency), RA 2101 - Aircrew Qualifications, RA 2102 - Aircrew Competence in Role, RA 2103 - Currency and Continuation Training, RA 2115 - Aircraft Commanders, RA 2120 - Pilot's Instrument Rating Scheme, RA 2125 - Aircrew Instructors and Examiner Training, RA 2130 - Survival Equipment, Drills and Training (+1 more)

### Community 7 - "Avionics Safety & Data Bus"
Cohesion: 0.25
Nodes (9): Def Stan 00-18 Avionic Data Transmission, Def Stan 00-56 Safety Management, Failure Modes Effects and Criticality Analysis (FMECA), IEC TS 62239-1 Avionics Process Management, RPAS Hazard Log, RPAS Safety Case, UK FW.1431a Radio and Radar Installations, UK FW.U1601c Launcher Link Inhibition (+1 more)

### Community 8 - "Payload EMC & NBC Protection"
Cohesion: 0.22
Nodes (9): AECTP-250, AECTP-500, Def Stan 00-970 Part 1, Def Stan 07-85, Def Stan 59-411, STANAG 4145, UK FW.U1481a Payload Signature Integration, UK FW.U1481b Payload Reconfiguration EMC (+1 more)

### Community 9 - "Sense-and-Avoid & Range Safety"
Cohesion: 0.22
Nodes (9): Controlled Flight Into Terrain (CFIT), IFF Transponder, MOD (PTL), Range Safety Authority, Sense and Avoid, TCAS II, UK FW.U1601b Link Capacity 30% Spare, UK FW.U1603a CFIT Avoidance (+1 more)

### Community 10 - "Post-Crash Management (Withdrawn)"
Cohesion: 0.25
Nodes (8): JSP 800 Volume 2, Manual of Aircraft Post Crash Management, RA 1410, RA 1430, 2400 Series (Administrative Elements), RA 2401 - Documents and Records, RA 2425 - Aircraft Accidents, Forced Landings or Incidents, RA 2435 - HMRC Requirements (Withdrawn)

### Community 11 - "Electronics & PCB Standards"
Cohesion: 0.33
Nodes (6): BS EN 60194 Printed Board Design, BS EN 61086-3-1 Conformal Coating, Def Stan 59-113, Electro Static Sensitive Devices (ESSD), IPC 2221B, UK RW.610a Electrical Bonding Protection

### Community 12 - "Landing Energy Absorber System"
Cohesion: 0.4
Nodes (5): Landing Energy Absorber System (LEAS), RPAS Requirements Specification, UK RW.471a Landing Energy Absorber System, USAR 301 Structural Requirements, USAR 613 Strength Factors

### Community 13 - "RPAS Crew & Workload"
Cohesion: 0.67
Nodes (3): RPAV Commander, RPAV Pilot, Workload Analysis

### Community 14 - "Flight Termination System"
Cohesion: 1.0
Nodes (2): Flight Termination System (FTS), UK FW.U1412a Flight Termination Safety

### Community 15 - "FTS Interference Resistance"
Cohesion: 1.0
Nodes (2): Clause UK 1353b, UK FW.U1412b Flight Termination Interference Resistance

### Community 16 - "DRACAS Reliability Database"
Cohesion: 1.0
Nodes (2): Def Stan 00-40, DRACAS Database

### Community 17 - "Military Aviation Register"
Cohesion: 1.0
Nodes (2): MAP RA1100 Series, Military Aviation Register (MAR)

### Community 18 - "Defence AI Org Structure"
Cohesion: 1.0
Nodes (2): Defence AI Centre (DAIC), Defence AI and Autonomy Unit (DAU)

### Community 19 - "ML & Dependable AI"
Cohesion: 1.0
Nodes (2): Dependable AI Concept, Machine Learning (ML)

### Community 20 - "RA 2355 Parachuting (Withdrawn)"
Cohesion: 1.0
Nodes (1): RA 2355 - Static Line and Freefall Parachuting (Withdrawn)

### Community 21 - "C2 Data Link (Subpart H)"
Cohesion: 1.0
Nodes (1): Subpart H - Command and Control Data Link

### Community 22 - "Human Factors (Def Stan 00-250)"
Cohesion: 1.0
Nodes (1): Def Stan 00-250 Human Factors

### Community 23 - "Approved Lubricants (Def Stan 01-5)"
Cohesion: 1.0
Nodes (1): Def Stan 01-5 Approved Lubricants

### Community 24 - "DAP119A Publications Series"
Cohesion: 1.0
Nodes (1): DAP119A-0601 Series

### Community 25 - "BS 381C Colour Standard"
Cohesion: 1.0
Nodes (1): BS 381C Colour Standard

### Community 26 - "Open Category UAS"
Cohesion: 1.0
Nodes (1): Open Category (UAS)

## Ambiguous Edges - Review These
- `International Humanitarian Law (IHL)` → `Operational Risk Assessment (ORA)`  [AMBIGUOUS]
  swarm/JSP936_Part1.md · relation: semantically_similar_to

## Knowledge Gaps
- **112 isolated node(s):** `Director MAA`, `Aviation Duty Holder`, `Accountable Manager (Military Flying)`, `Defence Air Environment`, `Release To Service` (+107 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Flight Termination System`** (2 nodes): `Flight Termination System (FTS)`, `UK FW.U1412a Flight Termination Safety`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `FTS Interference Resistance`** (2 nodes): `Clause UK 1353b`, `UK FW.U1412b Flight Termination Interference Resistance`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `DRACAS Reliability Database`** (2 nodes): `Def Stan 00-40`, `DRACAS Database`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Military Aviation Register`** (2 nodes): `MAP RA1100 Series`, `Military Aviation Register (MAR)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Defence AI Org Structure`** (2 nodes): `Defence AI Centre (DAIC)`, `Defence AI and Autonomy Unit (DAU)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `ML & Dependable AI`** (2 nodes): `Dependable AI Concept`, `Machine Learning (ML)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `RA 2355 Parachuting (Withdrawn)`** (1 nodes): `RA 2355 - Static Line and Freefall Parachuting (Withdrawn)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `C2 Data Link (Subpart H)`** (1 nodes): `Subpart H - Command and Control Data Link`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Human Factors (Def Stan 00-250)`** (1 nodes): `Def Stan 00-250 Human Factors`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Approved Lubricants (Def Stan 01-5)`** (1 nodes): `Def Stan 01-5 Approved Lubricants`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `DAP119A Publications Series`** (1 nodes): `DAP119A-0601 Series`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `BS 381C Colour Standard`** (1 nodes): `BS 381C Colour Standard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Open Category UAS`** (1 nodes): `Open Category (UAS)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `International Humanitarian Law (IHL)` and `Operational Risk Assessment (ORA)`?**
  _Edge tagged AMBIGUOUS (relation: semantically_similar_to) - confidence is low._
- **Why does `FLY 2000 Series Regulatory Articles` connect `Military Flying Authority Chain` to `Military Air System Operations`, `Post-Crash Management (Withdrawn)`, `Aircrew Qualifications & Currency`?**
  _High betweenness centrality (0.068) - this node is a cross-community bridge._
- **Why does `2300 Series (Operation of Aircraft)` connect `Military Air System Operations` to `Military Flying Authority Chain`?**
  _High betweenness centrality (0.057) - this node is a cross-community bridge._
- **Why does `Operating Safety Case (OSC)` connect `CAP 722A Operating Safety Case` to `Remote Pilot Competence Framework`, `UAS Technical Description`?**
  _High betweenness centrality (0.053) - this node is a cross-community bridge._
- **Are the 21 inferred relationships involving `2300 Series (Operation of Aircraft)` (e.g. with `RA 2301 - Responsibility for an Air System` and `RA 2302 - Responsibilities when Operating or Employed on an Air System`) actually correct?**
  _`2300 Series (Operation of Aircraft)` has 21 INFERRED edges - model-reasoned connections that need verification._
- **Are the 8 inferred relationships involving `2100 Series (Aircrew Qualifications and Competency)` (e.g. with `RA 2101 - Aircrew Qualifications` and `RA 2102 - Aircrew Competence in Role`) actually correct?**
  _`2100 Series (Aircrew Qualifications and Competency)` has 8 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Director MAA`, `Aviation Duty Holder`, `Accountable Manager (Military Flying)` to the rest of the system?**
  _112 weakly-connected nodes found - possible documentation gaps or missing edges._