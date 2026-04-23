# 02 — Fragmentation Trials

**AI/ML applications in UK MOD fragmentation characterisation and lethality assessment**

---

## Executive Summary

Fragmentation trials characterise warhead and munitions behaviour under detonation — measuring fragment mass distribution, velocity and spatial distribution to support lethality prediction, casing design and safe-separation distances. Modern trials generate terabytes of high-speed video, flash X-ray radiographs and sensor time-series per detonation. Manual analysis — fragment counting, silhouette interpretation, trajectory reconstruction, panel inspection — is labour-intensive and error-prone, and each arena shot costs £50k–£200k. AI/ML offers substantial near-term gains across detection, tracking, surrogate modelling, digital twins and automated reporting.

---

## 1. Purpose and Methodology

### 1.1 Objectives of Fragmentation Trials

- **Fragment mass distribution (FMD)** — binning by weight to distinguish anti-personnel (~1–50 g) vs anti-materiel (>50 g) populations.
- **Fragment velocity** — kinetic energy and penetration capability.
- **Spatial distribution** — directional bias, density patterns, dispersion geometry.
- **Lethality parameters** — effective fragment count, lethal radius, predicted casualty radius.

Feeds directly into:
- Weapon design optimisation (casing geometry, explosive fill, liner materials).
- Safety separation distances for storage and handling.
- Compliance with NATO IM protocols (STANAG 4496, 4589, 2920).

### 1.2 Standard Test Methods

**Pit / Sandbox Tests.** Warhead detonated into a closed arena of sawdust, sand or Celotex; fragments recovered, sorted and weighed. Reference: ITOP 4-2-813; modern [STANAG 2636](https://nso.nato.int/nso/nsdd/listpromulg.html).

**Arena Fragmentation Tests (AFT).** Witness plates (Celotex, woolboard, synthetic materials) at fixed radii (5–20 m). Instrumentation: PHANTOM high-speed cameras (>10,000 fps, 38 ns exposure), recovered panels, screen sensors and flash X-ray.

**Flash X-Ray Imaging.** [Scandiflash](https://scandiflash.com/) systems via [Hadland Imaging](https://hadlandimaging.com/) — 80–1200 kV, 20–35 ns pulses, 1–4 mm focal spot. Multiple flashes reconstruct trajectory inside the expanding fragment cloud.

### 1.3 UK Test Ranges

| Range | Location | Use |
|-------|----------|-----|
| **Dstl Fort Halstead** | Kent | Explosives research, forensics — closed October 2022, migrated to Porton Down |
| **[MOD Pendine](https://www.qinetiq.com/en/pendine/)** | South Wales | 20.5 km² land, tunnel ranges, QinetiQ LTPA |
| **[MOD Shoeburyness](https://www.qinetiq.com/en/shoeburyness/)** | Essex | 7,500 acres + 35,000 acres tidal, 21 firing areas |
| **[MOD Eskmeals](https://www.t3e.uk/en-gb/sites-and-ranges/mod-eskmeals)** | Cumbria | Large-calibre proof, accuracy, hard-target, fragmentation |
| **[Cranfield COTEC](https://www.cranfield.ac.uk/Centres/Centre-for-Defence-Chemistry/Cranfield-Ordnance-Test-and-Evaluation-Centre)** | Salisbury Plain | Licensed arena ITOP 4-2-813 / STANAG 2636 trials |

### 1.4 Key Instrumentation

| Instrument | Type | Application |
|------------|------|-------------|
| PHANTOM high-speed cameras | Visible imaging | Fragment tracking, velocity |
| Scandiflash flash X-ray | Radiography | Interior fragmentation during expansion |
| [Photonic Doppler Velocimetry (PDV)](https://opg.optica.org/oe/fulltext.cfm?uri=oe-28-3-3864&id=426396) | Fibre-based laser | Surface/free-surface velocity (µm/ns resolution) |
| Doppler radar | Microwave | Long-range fragment-cloud velocity |
| Piezo pressure gauges | Blast | Overpressure time-series |
| Witness panels | Celotex, woolboard, steel | Fragment size/count (2D projection) |

### 1.5 Lethality Modelling Tools

- **AVAL** (Thales/QinetiQ) — lethality radius prediction (restricted).
- **ORCA** / **VAULT** (US DoD) — collateral damage and vulnerability (restricted).
- **MERCAT** (Dstl) — UK casualty estimation.
- **LS-DYNA**, **CTH** (Sandia), **ALE3D** (LLNL), **AUTODYN** — hydrocode simulation.

---

## 2. The Data Problem

A single arena test generates 10⁶+ video frames plus radiographs, sensor arrays and panel imagery. Labour-intensive manual processes dominate:

1. Fragment counting and mass binning (days per test).
2. Frame-by-frame trajectory analysis in high-speed video.
3. Radiograph interpretation for fragment identification.
4. Witness-panel penetration-hole analysis.
5. 50–200-page trial report synthesis.

Core data challenges: fragment overlap/occlusion, motion blur, X-ray noise and streak artefacts, 2D-to-mass inference, sparse sensor coverage, and asymmetric blast waves.

---

## 3. AI/ML Use Cases

### 3.1 Fragment Detection & Counting (High-Speed Video and Radiographs)

- **YOLO family (v5/v8/v9)** — real-time bounding-box detection; fast inference for frame-by-frame processing.
- **Mask R-CNN** — instance segmentation handles overlapping fragments via ROI Align.
- **Workflow:** annotate 500–2,000 arena frames (CVAT/Roboflow); augment with physics-rendered LS-DYNA synthetic data; link detections across frames via Hungarian-algorithm tracking.

**References.** [MDPI 2021 deep-learning fragment detection for AFT](https://www.mdpi.com/2076-3417/10/14/4744); [Faster R-CNN for AFT (Korea Inst.)](https://koreascience.or.kr/article/JAKO201929565689216.page); [Mask R-CNN architecture](https://ar5iv.labs.arxiv.org/html/1703.06870).

### 3.2 Fragment Mass Estimation from Silhouettes

- Silhouette features (area, perimeter, aspect ratio, circularity, Hu/Zernike moments) via UNet or Mask R-CNN masks.
- Regression: Gaussian Process (probabilistic, with prediction intervals), Random Forest / XGBoost (interpretable), MLP (non-linear).
- Training data from recovered-fragment photograph/weight pairs; augment with LS-DYNA synthetic shapes.
- GPR uncertainty bounds are critical for DOSG compliance reporting.

### 3.3 Fragment Velocity & Trajectory Reconstruction

- **Deep-learning optical flow** (RAFT, FlowNet2) for dense velocity fields on noisy imagery.
- **Transformer-based trackers** (e.g. "Trackformers") — [EPJC 2025](https://link.springer.com/article/10.1140/epjc/s10052-025-14156-3).
- **3D triangulation** using multi-camera arenas; bundle adjustment with ballistic-equation constraints.
- **Physics-informed trajectory fitting** rejects unphysical solutions.

### 3.4 Flash X-Ray Image Enhancement

- **Denoising:** DnCNN, U-Net VAE, GAN-based (DNGAN) for radiography.
- **Super-resolution:** SRGAN, ResNet/DenseNet upsamples 2–4×.
- **Artefact removal:** conditional GAN or PDE-based inpainting for streaks.
- **Time-series tracking:** multi-flash detection + Hungarian assignment; triangulation if multi-angle radiographs available.

**References.** [Deep-learning X-ray denoising (ScienceDirect)](https://www.sciencedirect.com/science/article/abs/pii/S0720048X23001493); [HRNet CT denoising](https://link.springer.com/article/10.2991/jaims.d.210428.001).

### 3.5 Blast-Wave & Pressure-Field Reconstruction from Sparse Sensors

**Physics-Informed Neural Networks (PINNs)** embed conservation laws (Euler equations, continuity, momentum) as soft constraints:

```
L = L_data + λ · L_physics
```

Network maps `u_θ(x, t) → P(x, y, z, t)` with automatic differentiation of PDE residuals. Supports uncertainty quantification via ensembles and handles Neumann/Dirichlet boundaries naturally. Sensitive to constitutive-model mismatch — validation against unused sensor data is mandatory.

**References.** [PINNs for wave and pressure (ScienceDirect)](https://www.sciencedirect.com/science/article/abs/pii/S0141118724003146); [AGU wave propagation](https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2021JB023120).

### 3.6 Surrogate Models for Lethality / Collateral Damage Prediction

- GP and neural-network surrogates mapping warhead parameters → lethality metrics (effective fragment count, lethal radius, V50).
- GPR for small datasets (50–500 simulations); neural nets for 10+ parameter spaces.
- **Multi-fidelity** combining simplified FEA with full hydrocode, plus Bayesian optimisation (Expected Improvement) for design exploration.

### 3.7 Bayesian DoE & Adaptive Sampling

Arena trials cost ~£50k–£200k per shot. Adaptive sampling strategies:
- Initial 3–5 shots at nominal; fit surrogate; pick next shot to maximise Expected Improvement / UCB / Information Gain.
- Multi-objective (lethality vs mass) and constrained optimisation (diameter, explosive mass).
- Documented 30–50 % trial reduction vs full-factorial DoE.

### 3.8 Digital Twins & Model Calibration

Paired hydrocode model + real-time/post-trial data feed. Calibration via **particle filter**, **Bayesian MCMC / variational inference** or **adjoint-gradient optimisation**. Observations include recovered FMD, PDV velocities, radiograph features (via CNN feature extraction) and pressure gauges.

**References.** [IEEE digital-twin calibration](https://ieeexplore.ieee.org/document/10838855/); [Cambridge Core continuous calibration](https://www.cambridge.org/core/journals/data-centric-engineering/article/continuous-calibration-of-a-digital-twin-comparison-of-particle-filter-and-bayesian-calibration-approaches/BE7304EFCB5006059184852E39EED19A).

### 3.9 LLM-Assisted Report Generation

RAG pipeline: structured trial metadata + AI-derived quantities + figure templates + STANAG-aware prompts → draft 50–200-page report with compliance statements. Studies in clinical-trial reporting show 50–75 % time reduction. Human review is mandatory — hallucination risk on standards, figures and compliance claims is unacceptable.

### 3.10 Unsupervised Morphological Clustering

- Structure-from-motion or 2D silhouette features per recovered fragment.
- GMM/Bayesian GMM (with BIC-based cluster count), DBSCAN, spectral clustering.
- Clusters map to lethality sub-types (flat splinter vs spheroidal chunk).

---

## 4. Maturity Summary

| Use case | TRL | Evidence |
|----------|-----|----------|
| Fragment detection (YOLO/Mask R-CNN) | 6–7 | MDPI 2021 AFT paper; Faster R-CNN |
| Optical-flow velocity | 5–6 | RAFT/FlowNet2 state-of-the-art |
| X-ray denoising (CNN/GAN) | 6–7 | Widely applied to medical/scientific radiography |
| PINNs | 5–6 | Growing academic interest; few defence publications |
| Surrogate models (GP/NN) | 7–8 | Well-established in aerospace/materials |
| Bayesian optimisation / DoE | 7–8 | Standard in automotive/pharma |
| Digital twins / data assimilation | 5–6 | Warhead-specific implementations not publicly disclosed |
| LLM report generation | 4–5 | Breakthroughs in clinical reporting; not yet ballistic-specific |
| Morphological clustering | 5–6 | Techniques mature; fragmentation datasets limited |

---

## 5. Actors

### UK
- **Dstl** (Platform Systems & Weapons Division; MERCAT).
- **Cranfield University CDE + COTEC** — MSc Guided Weapons, EOE; active warhead and fragmentation research.
- **QinetiQ** — MOD Pendine, Shoeburyness, Aberporth operator; High Explosive Formulation team; IM research; BROACH warhead partner.
- **MBDA** — missile/warhead integration (Meteor, Scalp, Storm Shadow).
- **Thales UK** — sensors, seekers, AVAL.
- **BAE Systems Global Combat Systems (Munitions)** — warhead development; SPEAR trials.

### International
- **US ARL**, **Sandia (CTH, PDV)**, **LLNL (ALE3D, high-speed imaging)**.
- **Imperial College London** — blast/shock wave research.
- **NATO STO AVT Panel** and **MSIAC**.

---

## 6. Assurance Considerations

### Reproducibility and Validation
AI-derived measurements must achieve inter-observer agreement, reference-standard validation (manual vs AI head-to-head on 10–20 arena tests), documented UQ (aleatoric + epistemic), and version-controlled traceability.

### DOSG / NATO Approval Pathway
1. **PoC** on archived AFT data from 3–5 previous trials.
2. **Validation trial** with parallel manual + AI measurement.
3. **Standardisation proposal** to NATO STO or UK MOD for STANAG/DefStan update.
4. **Operational acceptance.**

Indicative timeline: 18–24 months PoC to operational acceptance.

### Uncertainty Quantification
Aleatoric via probabilistic outputs; epistemic via ensemble disagreement. Final reports should include confidence intervals e.g. "Fragment count: 847 ± 23 (1σ)".

---

## 7. Recommendations

**Short-term (0–12 months).**
- Fragment detection PoC on archived AFT video (Dstl + Cranfield COTEC / QinetiQ), £150k–£250k.
- Flash X-ray denoising PoC on archived Scandiflash radiographs, £100k–£150k.

**Medium-term (1–2 years).**
- Validation trial series with parallel human + AI measurement, £500k–£800k.
- Digital-twin prototype integrating LS-DYNA + Bayesian calibration, £250k–£400k.
- Bayesian DoE retrospective study, £80k–£120k.

**Long-term (2–5 years).**
- Operational deployment, £200k–£300k/yr ops + development.

Total £1.5M–£2.5M over 5 years positions UK MOD as leader in AI-augmented weapons testing.

---

## 8. Key References

### NATO and Standards
- [NATO NSO database](https://nso.nato.int/nso/nsdd/listpromulg.html) — STANAG 2636, 4496, 4589
- [STANAG 4496 (GlobalSpec)](https://standards.globalspec.com/std/400994/stanag-4496)

### Published Research
- [Deep-learning fragment detection AFT (MDPI 2021)](https://www.mdpi.com/2076-3417/10/14/4744)
- [ML to predict warhead fragmentation in-flight (Larsen thesis 2022)](https://commons.erau.edu/edt/708/)
- [Expanding-warhead fragmentation (Thin-Walled Structures 2014)](https://www.sciencedirect.com/science/article/pii/S2214914714000415)
- [Warhead lethality multi-objective optimisation (IOP 2022)](https://iopscience.iop.org/article/10.1088/1742-6596/2219/1/012034)

### Instrumentation
- [PHANTOM high-speed ballistics](https://www.phantomhighspeed.com/applications/where/ballistics-and-range)
- [Scandiflash flash X-ray](https://hadlandimaging.com/scandiflash-flash-x-ray-systems/)
- [PDV (Tektronix)](https://www.tek.com/en/solutions/application/research/photonic-doppler-velocimetry)
