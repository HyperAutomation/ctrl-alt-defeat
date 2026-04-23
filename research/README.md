# UK MOD AI Use Cases for Defence Test & Evaluation

**A comprehensive research repository covering AI/ML applications across weapons qualification, fragmentation trials, and uncrewed autonomous systems testing (air, surface, subsurface, ground).**

**Status:** Research briefing (UK public-domain sources)
**Classification:** UNCLASSIFIED
**Compiled:** April 2026
**Scope:** UK MOD internal research reference

---

## Purpose

This repository consolidates open-source research on the application of artificial intelligence and machine learning across the UK Ministry of Defence's test and evaluation (T&E) enterprise. It is organised by domain and designed to support decisions on capability investment, research prioritisation, safety-case development, and engagement with Dstl, DE&S, the Defence AI Centre (DAIC), and NATO partners.

The work is deliberately UK-centric — citing JSP 520, JSP 936, DEFSTAN 00-970 Part 9, RA 1600, the UK Defence AI Strategy, NATO STANAGs, and named UK ranges, programmes and industrial actors — so it can serve as a starting point for MOD-aligned capability planning.

---

## Repository Structure

| Folder | Topic | Focus |
|--------|-------|-------|
| [01-weapons-qualification-s3/](01-weapons-qualification-s3/) | Weapons qualification & Safety and Suitability for Service (S3) | JSP 520, DEFSTAN 00-056/07-85, STANAG 4297/4439, DOSG/DOSR, AI for safety case generation, surrogate models, anomaly detection, active learning DoE |
| [02-fragmentation-trials/](02-fragmentation-trials/) | Fragmentation & arena trials | STANAG 2636/4496, pit/arena tests, flash X-ray (Scandiflash), PDV, AI for fragment detection, tracking, X-ray denoising, PINNs for blast fields, digital twins |
| [03-uav-testing/](03-uav-testing/) | Uncrewed Air Vehicle (UAV) testing | RA 1600, DEFSTAN 00-970 Part 9, DO-365, ASTM F3442, Protector RG Mk1, GCAP, Project Alvina, AMLAS, sense-and-avoid, swarming, SLAM |
| [04-uncrewed-maritime-ground/](04-uncrewed-maritime-ground/) | USV / UUV / UGV testing | Project CABOT, NavyX, Project Wilton, Cetus/Manta XLUUV, Project THESEUS, Robotic Platoon Vehicles, BUTEC, HORIBA MIRA, MASS Code of Practice |
| [05-cross-cutting-themes/](05-cross-cutting-themes/) | Policy, assurance, MLOps, ethics | JSP 936, Defence AI Strategy, AAIP/AMLAS/SACE, synthetic environments & digital twins, MLOps for defence, Article 36, meaningful human control |
| [GLOSSARY.md](GLOSSARY.md) | Abbreviations & acronyms | Defence, regulatory, and ML terminology used across the repo |

---

## How to Read This Repository

- **Start with [05-cross-cutting-themes](05-cross-cutting-themes/)** if you are new to UK defence AI governance — it frames every downstream domain chapter and covers JSP 936 and the assurance frameworks (AMLAS/SACE) that constrain the rest.
- **Jump directly to a domain chapter** if you are researching a specific programme (e.g. Protector → chapter 03, Cetus XLUUV → chapter 04, IM testing → chapter 01).
- Each domain chapter follows the same structure: regulatory/programmatic landscape → evidence classes → concrete AI use cases (with maturity/TRL assessment) → UK actors → references.

---

## Key Cross-Cutting Insights

1. **Assurance is lifecycle-wide, not a gate.** AMLAS and SACE (University of York) are the defensible UK methodologies for ML in autonomous systems; they replace single-point certification with continuous assurance from scoping to deployment. JSP 936 (Part 1 Directive, November 2024) mandates their principles across the MOD.

2. **Synthetic environments and digital twins are central.** Every domain in scope — weapons qualification through to USV/UGV — benefits from high-fidelity physics/sensor simulation (Isaac Sim, AirSim, VBS4, OneSAF, Unreal Engine), with domain randomisation to close sim-to-real gaps.

3. **Live trials remain the regulatory anchor.** AI is an accelerator and an efficiency multiplier, not a replacement. Bayesian design-of-experiments and active learning can reduce STANAG 4439 rounds or arena shots by 25–40 %, but DOSR, DOSG, MAA, and NATO standardisation bodies still require live-fire evidence and human sign-off.

4. **Explainability is a compliance requirement, not a nice-to-have.** Article 36 reviews, Responsible AI Senior Officer (RAISO) sign-off under JSP 936, and the UK's "meaningful human control" position at the UN CCW all require that autonomous system decisions be auditable post-hoc. SHAP, LIME, attention visualisation, and concept activation vectors all feature.

5. **Data is sovereign.** Federated learning and on-premise MLOps stacks (MLflow, DVC, Label Studio / CVAT on classified networks) are how the UK reconciles the Defence Data Framework with AUKUS and NATO collaboration.

6. **The UK ecosystem is federated.** Dstl, DAIC, DE&S, DASA, the MAA, MSIAC, the Centre for Assuring Autonomy (York), Cranfield, Turing Institute, BAE, QinetiQ, Leonardo, Thales, MBDA, GA-ASI, plus a growing SME tier (Adarga, Helsing, Mind Foundry, Faculty AI, Ripjar) together form the capability base.

---

## UK MOD Policy Anchors

- [UK Defence AI Strategy (June 2022)](https://assets.publishing.service.gov.uk/media/62a7543ee90e070396c9f7d2/Defence_Artificial_Intelligence_Strategy.pdf)
- [Ambitious, Safe, Responsible — Policy Statement (June 2022)](https://assets.publishing.service.gov.uk/media/62a9b1d1e90e07039e31b8cb/20220614-Ambitious_Safe_and_Responsible.pdf)
- [JSP 936 — Dependable Artificial Intelligence in Defence, Part 1 (November 2024)](https://www.gov.uk/government/publications/jsp-936-dependable-artificial-intelligence-ai-in-defence-part-1-directive)
- [Defence AI Playbook (January 2024)](https://assets.publishing.service.gov.uk/media/65bb75fa21f73f0014e0ba51/Defence_AI_Playbook.pdf)
- [Strategic Defence Review 2025](https://assets.publishing.service.gov.uk/media/683d89f181deb72cce2680a5/The_Strategic_Defence_Review_2025_-_Making_Britain_Safer_-_secure_at_home__strong_abroad.pdf)
- [Data Strategy for Defence](https://www.gov.uk/government/publications/data-strategy-for-defence/data-strategy-for-defence)
- [JSP 520 — OME Safety Management System (DSA 03.OME Part 1)](https://www.gov.uk/government/publications/jsp-520-uk-mods-ordnance-munitions-and-explosives-safety-management-system)

---

## Caveats

- All content is drawn from open sources. Classified Dstl, DOSG, MAA, or NATO RESTRICTED material is not included.
- Maturity / TRL assessments reflect public-domain evidence as of April 2026; internal MOD programmes may be further advanced but unpublished.
- Use case recommendations and pilot programme proposals are forward-looking and subject to engagement with Dstl, DOSR, the MAA, the DAIC, and the Defence AI and Autonomy Unit.
- Where content is speculative (e.g. internal MOD digital-twin maturity, unpublished Dstl work), it is flagged in-section.
