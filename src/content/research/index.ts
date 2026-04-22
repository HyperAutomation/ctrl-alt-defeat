import overview from "./overview.md?raw";
import weapons from "./weapons-qualification-s3.md?raw";
import fragmentation from "./fragmentation-trials.md?raw";
import glossary from "./glossary.md?raw";

export type ResearchEntry = {
  slug: string;
  code: string;
  title: string;
  blurb: string;
  tags: string[];
  content: string;
};

export const RESEARCH: ResearchEntry[] = [
  {
    slug: "overview",
    code: "00",
    title: "Overview & Cross-Cutting Insights",
    blurb:
      "Index of UK MOD AI use cases across weapons qualification, fragmentation, UAV/USV/UUV/UGV and assurance frameworks.",
    tags: ["JSP 936", "Defence AI Strategy", "AMLAS", "SACE"],
    content: overview,
  },
  {
    slug: "weapons-qualification-s3",
    code: "01",
    title: "Weapons Qualification & S3",
    blurb:
      "AI/ML across the UK weapons qualification lifecycle — JSP 520, STANAG 4297/4439, surrogate models, anomaly detection and active learning DoE.",
    tags: ["JSP 520", "STANAG 4439", "Surrogates", "Active Learning"],
    content: weapons,
  },
  {
    slug: "fragmentation-trials",
    code: "02",
    title: "Fragmentation Trials",
    blurb:
      "AI in arena/pit testing, flash X-ray denoising, PINNs for blast fields, fragment detection, tracking and digital twins.",
    tags: ["STANAG 4496", "Flash X-ray", "PINNs", "Digital Twins"],
    content: fragmentation,
  },
  {
    slug: "glossary",
    code: "GL",
    title: "Glossary & Standards",
    blurb:
      "Abbreviations, NATO STANAGs, UK DEFSTANs, assurance terminology and named programmes referenced across the knowledge base.",
    tags: ["Glossary", "STANAGs", "DEFSTANs", "Programmes"],
    content: glossary,
  },
];

export const getEntry = (slug: string) => RESEARCH.find((e) => e.slug === slug);
