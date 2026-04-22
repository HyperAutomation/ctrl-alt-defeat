import { createFileRoute, Link } from "@tanstack/react-router";
import { MatrixRain } from "@/components/MatrixRain";
import { TerminalCard } from "@/components/TerminalCard";
import {
  Plane,
  ShieldCheck,
  Radio,
  Network,
  Map,
  Brain,
  FileSignature,
  AlertTriangle,
  Users,
  Target,
  ArrowLeft,
  CheckCircle2,
  XCircle,
} from "lucide-react";

export const Route = createFileRoute("/user-story")({
  head: () => ({
    meta: [
      { title: "AI User Story — CAA/MAA Joint Approval Workbench" },
      {
        name: "description",
        content:
          "Visual user story: an assurance-grounded joint Approval Workbench for live BVLOS autonomous swarm flight trials.",
      },
      {
        property: "og:title",
        content: "AI User Story — CAA/MAA Joint Approval Workbench",
      },
      {
        property: "og:description",
        content:
          "Visual user story: an assurance-grounded joint Approval Workbench for live BVLOS autonomous swarm flight trials.",
      },
    ],
  }),
  component: UserStoryPage,
});

const personas = [
  { tag: "PRIMARY", role: "MAA Lead Inspector", desc: "Chairs the joint review panel; signs the decision record.", icon: ShieldCheck },
  { tag: "CO-PRIMARY", role: "CAA Inspector (AAA + FOI)", desc: "Airspace integration, third-party risk, CAP 1616.", icon: Plane },
  { tag: "SECONDARY", role: "Delivery / Operating Duty Holder", desc: "Owns residual safety risk once Permit issued.", icon: Users },
  { tag: "SECONDARY", role: "RAISO (JSP 936 Pt 1)", desc: "Accountable for AI-assisted onboard decision-making.", icon: Brain },
  { tag: "SECONDARY", role: "Range Safety Officer", desc: "Owns live trial execution on the day.", icon: Target },
  { tag: "SECONDARY", role: "Independent Technical Advisor", desc: "MAA-CTS / QinetiQ / DAIC — autonomy specialism.", icon: Network },
];

const acceptance = [
  { id: "AC1", title: "Submission completeness & clause coverage", icon: FileSignature, summary: "Identify required artefacts, map to RA 1600/2300, DEFSTAN 00-970 Pt9, CAP 722/A/B. Produce a red/amber/green coverage matrix with page-level pointers." },
  { id: "AC2", title: "SORA / operational risk assessment", icon: AlertTriangle, summary: "Verify GRC, ARC, M1–M3 mitigations, derived SAIL, and all 24 OSOs. Any unmet OSO blocks a green rating without explicit panel rationale." },
  { id: "AC3", title: "Detect and Avoid evidence", icon: Radio, summary: "Sensor performance, closure geometries, Well Clear derivation, ASTM F3442 / EUROCAE ED-267 alignment. Tested envelope must enclose operational envelope." },
  { id: "AC4", title: "C2 link & loss-of-link behaviour", icon: Network, summary: "Link budget, latency, RF/GNSS resilience, crypto posture. Loss-of-link behaviours that need swarm consensus post-loss are flagged high-risk." },
  { id: "AC5", title: "Swarm: emergent behaviour & containment", icon: Brain, summary: "Simulation + live-flight coverage of the collective state space. Geofencing at agent and swarm level. Extrapolation triggers panel decision." },
  { id: "AC6", title: "Airspace integration & CAP 1616", icon: Map, summary: "NOTAM, electronic conspicuity, TDA/TRA validity, third-party risk over inhabited areas. Out-of-volume legs cannot turn green." },
  { id: "AC7", title: "AI / autonomy assurance posture", icon: Brain, summary: "AMLAS / SACE-aligned case with ODD, data provenance, drift monitoring. JSP 936 Pt 1 RAISO sign-off. Meaningful Human Control explicit at every layer." },
  { id: "AC8", title: "Decision record, conditions & triggers", icon: FileSignature, summary: "Structured record: regulatory basis, evidence, residual risk, ALARP, conditions, review triggers, signatures. Every claim traceable to artefact + paragraph." },
];

const inScope = [
  "Ingestion of submission pack",
  "Clause-level cross-check vs regulatory anchors",
  "Gap & ambiguity flagging",
  "AI/autonomy assurance posture review",
  "DAA evidence assessment",
  "Swarm envelope & emergent-behaviour challenge",
  "Airspace & third-party risk review",
  "Drafting structured decision record",
];

const outOfScope = [
  "Issuing the MPTF itself (human signature)",
  "Autonomous clearance of live flight",
  "Displacement of Duty Holder accountability",
  "Displacement of RAISO sign-off",
  "Automated redaction of safety evidence",
  "Cross-border approvals outside UK",
];

const anchors = [
  { code: "RA 1000", desc: "MAA Regulatory Principles · Duty Holder construct (RA 1020)" },
  { code: "RA 1600", desc: "RPAS airworthiness, operation, training" },
  { code: "RA 2325 / 2335", desc: "Flight Test Permits · Flight Test & Evaluation" },
  { code: "DEFSTAN 00-970 Pt 9", desc: "Design requirements for RPAS" },
  { code: "CAP 722 / 722A / 722B", desc: "UAS ops · operating safety cases · BVLOS" },
  { code: "CAP 1616", desc: "Airspace Change Process" },
  { code: "JARUS SORA v2.5", desc: "Specific Operations Risk Assessment · 24 OSOs" },
  { code: "JSP 936 Part 1", desc: "Dependable AI in Defence · RAISO accountability" },
  { code: "AMLAS / SACE", desc: "AI/ML & Autonomy assurance — University of York / CfAA" },
  { code: "ASTM F3442 / EUROCAE ED-267", desc: "DAA technical framework" },
  { code: "AOP-15 · Article 36", desc: "Where weapons are carried on the swarm" },
];

const nfrs = [
  { k: "Traceability", v: "Every clause resolves to the publication revision in force on review date." },
  { k: "Audit", v: "Immutable log of every panel action; export read-only PDF on close." },
  { k: "Classification", v: "OFFICIAL-SENSITIVE → SECRET → STRAP, with no cross-class egress." },
  { k: "Latency", v: "Coverage matrix < 10 min; AI flags < 30 min; full review ≤ 2 working days." },
  { k: "Explainability", v: "Plain engineering English — never model internals." },
  { k: "Accessibility", v: "WCAG 2.2 AA inspector UI." },
  { k: "Resilience", v: "Workbench outage never blocks an in-progress live trial." },
  { k: "Data sovereignty", v: "UK sovereign infrastructure; no cloud egress without authorisation." },
];

const risks = [
  { r: "Automation bias among inspectors", m: "Override-first UI · mandatory panel deliberation · calibration audits." },
  { r: "Regulatory drift between MAA and CAA", m: "Shared clause library under joint config control · quarterly alignment." },
  { r: "Over-reliance on simulation for emergent behaviour", m: "Explicit live-flight coverage matrix · mandatory extrapolation flags." },
  { r: "Classification handling breach", m: "Class-aware pipeline · marking enforcement · two-person review on downgrade." },
  { r: "Third-party risk underestimation", m: "CAA FOI review gate on every non-segregated leg." },
  { r: "Scope creep into MPTF issuance", m: "Workbench stops at the draft decision record — signature stays human." },
];

function UserStoryPage() {
  return (
    <div className="min-h-screen relative overflow-x-hidden crt-flicker">
      <MatrixRain />

      {/* NAV */}
      <nav className="relative z-20 border-b border-matrix/20 backdrop-blur-md bg-background/40">
        <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
          <Link to="/" className="flex items-center gap-2 font-display group">
            <span className="text-matrix text-glow text-xl">▌</span>
            <span className="text-foreground tracking-widest text-sm group-hover:text-matrix transition-colors">
              CTRL-ALT-DEFEAT.UK
            </span>
          </Link>
          <Link
            to="/"
            className="inline-flex items-center gap-2 px-3 py-1.5 border border-matrix/50 rounded-sm text-xs text-matrix hover:bg-matrix/10 transition-all font-display uppercase tracking-widest"
          >
            <ArrowLeft className="w-3.5 h-3.5" /> back
          </Link>
        </div>
      </nav>

      {/* HEADER */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pt-20 pb-12">
        <div className="space-y-6 float-up">
          <div className="font-mono text-sm text-matrix-dim">
            <span className="text-matrix">$</span> cat ./user-story --domain=caa-maa --topic=bvlos-swarm
          </div>

          <div className="flex flex-wrap items-center gap-3 text-[10px] uppercase tracking-widest">
            <span className="px-2 py-1 border border-matrix/40 text-matrix/80 rounded-sm bg-matrix/5">Draft</span>
            <span className="px-2 py-1 border border-matrix/40 text-matrix/80 rounded-sm bg-matrix/5">Hackathon backlog seed</span>
            <span className="px-2 py-1 border border-matrix/40 text-matrix/80 rounded-sm bg-matrix/5">April 2026</span>
            <span className="px-2 py-1 border border-matrix/40 text-matrix/80 rounded-sm bg-matrix/5">Author · Sentinel</span>
          </div>

          <h1 className="font-display text-4xl md:text-6xl lg:text-7xl leading-[0.95] tracking-tight">
            <span className="block text-foreground">CAA / MAA</span>
            <span className="block text-matrix text-glow-strong">JOINT APPROVAL</span>
            <span className="block text-foreground">WORKBENCH</span>
          </h1>

          <p className="max-w-3xl text-base md:text-lg text-muted-foreground leading-relaxed">
            Live BVLOS autonomous swarm flight trials sit at the intersection of three unsettled regulatory regimes. This is the user story for an assurance-grounded workbench that lets a joint review panel issue — or defensibly refuse — a Military Permit to Fly with traceable rationale at speed.
          </p>

          <div className="flex flex-wrap gap-2 text-[10px] uppercase tracking-widest text-muted-foreground">
            <span className="text-matrix-dim">audience:</span>
            <span>MAA RPAS Reg Branch</span>·
            <span>MAA-CTS</span>·
            <span>CAA AAA</span>·
            <span>CAA FOI</span>·
            <span>CAA Innovation Hub</span>·
            <span>Duty Holders</span>·
            <span>Range Safety</span>
          </div>
        </div>
      </section>

      {/* THE STORY — As / I want / So that */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 py-12">
        <div className="text-matrix-dim text-sm font-mono mb-4">// the story</div>
        <div className="grid md:grid-cols-3 gap-5">
          {[
            {
              k: "As",
              v: "a Lead Inspector in the UK MAA's RPAS Regulatory Branch — sitting on a joint review panel with CAA Airspace, ATM & Aerodromes and Flight Operations Inspectorate counterparts — responsible for granting or refusing a Military Permit to Fly and the associated Flight Trials Instruction for a BVLOS autonomous swarm operating across both segregated Danger Area and non-segregated airspace.",
            },
            {
              k: "I want",
              v: "an assurance-grounded joint Approval Workbench that ingests the safety case, JARUS SORA, AMLAS/SACE autonomy assurance, DAA evidence, C2 link analysis, swarm-behaviour envelope and CAP 1616 artefacts; cross-checks against RA 1000 / 1600 / 2300, DEFSTAN 00-970 Pt 9, CAP 722/A/B, JSP 936 Pt 1, and AOP-15 / Article 36; flags residual risk and weak traceability; and produces a structured decision record in engineering English.",
            },
            {
              k: "So that",
              v: "I can issue — or defensibly refuse — an MPTF for the live BVLOS swarm trial with confidence that ALARP has been demonstrated, that Meaningful Human Control and Duty Holder accountability are intact, that third-party airspace users and the public below are not exposed to unacceptable risk, and that a transparent audit trail exists for the RTSA, DASB, Ministers, and any future Service Inquiry or AAIB investigation.",
            },
          ].map((s) => (
            <div
              key={s.k}
              className="relative bg-card/60 backdrop-blur-sm border border-matrix/30 rounded-md p-6 hover:border-matrix/70 transition-all overflow-hidden"
            >
              <div className="absolute -top-4 -right-3 font-display text-5xl text-matrix/10 uppercase">
                {s.k}
              </div>
              <div className="font-display text-matrix text-sm uppercase tracking-widest mb-3">
                › {s.k}
              </div>
              <p className="text-sm text-foreground/85 leading-relaxed">{s.v}</p>
            </div>
          ))}
        </div>
      </section>

      {/* CONTEXT */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 py-12">
        <TerminalCard title="cat ./context.txt">
          <p className="text-sm md:text-base text-foreground/85 leading-relaxed font-mono">
            Autonomous swarm flight trials sit in the awkward intersection between three unsettled regulatory regimes:
            BVLOS in non-segregated airspace (CAA, CAP 722B), RPAS airworthiness and flight test (MAA, RA 1600 / 2335), and
            AI/autonomy assurance (JSP 936 Pt 1, AMLAS, SACE). No single rulebook covers a swarm cleanly. Approvals today
            are bespoke, slow, and consume senior-inspector bandwidth that the UK has too little of — particularly with the
            Protector RG Mk1 transition, GCAP/Tempest early airframe work, and Project Alvina's attritable-mass
            experimentation all converging through 2026–2028.
          </p>
        </TerminalCard>
      </section>

      {/* PERSONAS */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 py-12">
        <div className="mb-8">
          <div className="text-matrix-dim text-sm font-mono mb-2">// ls ./personas</div>
          <h2 className="font-display text-3xl md:text-4xl text-foreground tracking-tight">
            THE <span className="text-matrix text-glow">PANEL</span>
          </h2>
        </div>
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
          {personas.map((p) => {
            const Icon = p.icon;
            return (
              <div
                key={p.role}
                className="bg-card/60 backdrop-blur-sm border border-matrix/30 rounded-md p-5 hover:border-matrix hover:-translate-y-0.5 transition-all"
              >
                <div className="flex items-center justify-between mb-3">
                  <Icon className="w-5 h-5 text-matrix" />
                  <span className="text-[10px] uppercase tracking-widest text-matrix-dim border border-matrix/30 px-2 py-0.5 rounded-sm bg-matrix/5">
                    {p.tag}
                  </span>
                </div>
                <div className="font-display text-matrix text-base mb-1">{p.role}</div>
                <p className="text-xs text-muted-foreground leading-relaxed">{p.desc}</p>
              </div>
            );
          })}
        </div>
      </section>

      {/* SCOPE */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 py-12">
        <div className="mb-8">
          <div className="text-matrix-dim text-sm font-mono mb-2">// scope --boundary</div>
          <h2 className="font-display text-3xl md:text-4xl text-foreground tracking-tight">
            BOUNDARY <span className="text-matrix text-glow">CONDITIONS</span>
          </h2>
        </div>
        <div className="grid md:grid-cols-2 gap-5">
          <div className="bg-card/60 border border-matrix/40 rounded-md p-6">
            <div className="flex items-center gap-2 font-display text-matrix uppercase tracking-widest text-sm mb-4">
              <CheckCircle2 className="w-4 h-4" /> In scope
            </div>
            <ul className="space-y-2">
              {inScope.map((s) => (
                <li key={s} className="flex items-start gap-2 text-sm text-foreground/85">
                  <span className="text-matrix mt-1">›</span>
                  <span>{s}</span>
                </li>
              ))}
            </ul>
          </div>
          <div className="bg-card/60 border border-destructive/40 rounded-md p-6">
            <div className="flex items-center gap-2 font-display text-destructive uppercase tracking-widest text-sm mb-4">
              <XCircle className="w-4 h-4" /> Out of scope
            </div>
            <ul className="space-y-2">
              {outOfScope.map((s) => (
                <li key={s} className="flex items-start gap-2 text-sm text-foreground/85">
                  <span className="text-destructive mt-1">×</span>
                  <span>{s}</span>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </section>

      {/* ACCEPTANCE CRITERIA */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 py-12">
        <div className="mb-8">
          <div className="text-matrix-dim text-sm font-mono mb-2">// acceptance --given-when-then</div>
          <h2 className="font-display text-3xl md:text-4xl text-foreground tracking-tight">
            ACCEPTANCE <span className="text-matrix text-glow">CRITERIA</span>
          </h2>
          <p className="text-xs uppercase tracking-widest text-muted-foreground mt-2">
            8 criteria · liftable into a backlog or specification-by-example workshop
          </p>
        </div>
        <div className="grid md:grid-cols-2 gap-4">
          {acceptance.map((ac, i) => {
            const Icon = ac.icon;
            return (
              <div
                key={ac.id}
                className="relative bg-card/60 backdrop-blur-sm border border-matrix/30 rounded-md p-5 hover:border-matrix hover:border-glow transition-all overflow-hidden float-up"
                style={{ animationDelay: `${i * 60}ms` }}
              >
                <div className="absolute -top-5 -right-3 font-display text-6xl text-matrix/5">
                  {ac.id}
                </div>
                <div className="flex items-center gap-2 mb-3">
                  <Icon className="w-4 h-4 text-matrix" />
                  <span className="font-mono text-xs text-matrix-dim">{ac.id}</span>
                </div>
                <div className="font-display text-matrix text-base mb-2">{ac.title}</div>
                <p className="text-xs text-foreground/80 leading-relaxed">{ac.summary}</p>
              </div>
            );
          })}
        </div>
      </section>

      {/* NFRS */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 py-12">
        <div className="mb-8">
          <div className="text-matrix-dim text-sm font-mono mb-2">// non-functional --requirements</div>
          <h2 className="font-display text-3xl md:text-4xl text-foreground tracking-tight">
            NON-FUNCTIONAL <span className="text-matrix text-glow">REQS</span>
          </h2>
        </div>
        <div className="border border-matrix/30 rounded-md overflow-hidden bg-card/40 backdrop-blur-sm">
          {nfrs.map((n, i) => (
            <div
              key={n.k}
              className={`grid grid-cols-[160px_1fr] gap-4 px-5 py-3 text-sm ${i !== nfrs.length - 1 ? "border-b border-matrix/15" : ""}`}
            >
              <div className="font-display uppercase tracking-widest text-matrix text-xs pt-0.5">
                {n.k}
              </div>
              <div className="text-foreground/85">{n.v}</div>
            </div>
          ))}
        </div>
      </section>

      {/* ASSURANCE ANCHORS */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 py-12">
        <div className="mb-8">
          <div className="text-matrix-dim text-sm font-mono mb-2">// assurance --anchors</div>
          <h2 className="font-display text-3xl md:text-4xl text-foreground tracking-tight">
            REGULATORY <span className="text-matrix text-glow">ANCHORS</span>
          </h2>
        </div>
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
          {anchors.map((a) => (
            <div
              key={a.code}
              className="bg-card/60 border border-matrix/30 rounded-sm p-4 hover:border-matrix transition-colors"
            >
              <div className="font-display text-matrix text-sm mb-1 tracking-wide">
                {a.code}
              </div>
              <div className="text-xs text-muted-foreground leading-relaxed">{a.desc}</div>
            </div>
          ))}
        </div>
      </section>

      {/* RISKS */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 py-12">
        <div className="mb-8">
          <div className="text-matrix-dim text-sm font-mono mb-2">// risks --with-mitigations</div>
          <h2 className="font-display text-3xl md:text-4xl text-foreground tracking-tight">
            RISKS &amp; <span className="text-matrix text-glow">MITIGATIONS</span>
          </h2>
        </div>
        <div className="space-y-3">
          {risks.map((r) => (
            <div
              key={r.r}
              className="grid md:grid-cols-2 gap-0 border border-matrix/30 rounded-sm overflow-hidden bg-card/50 backdrop-blur-sm"
            >
              <div className="p-4 border-b md:border-b-0 md:border-r border-matrix/20 bg-destructive/5">
                <div className="flex items-center gap-2 text-[10px] uppercase tracking-widest text-destructive mb-1">
                  <AlertTriangle className="w-3 h-3" /> risk
                </div>
                <div className="text-sm text-foreground/90">{r.r}</div>
              </div>
              <div className="p-4">
                <div className="flex items-center gap-2 text-[10px] uppercase tracking-widest text-matrix mb-1">
                  <ShieldCheck className="w-3 h-3" /> mitigation
                </div>
                <div className="text-sm text-foreground/85">{r.m}</div>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* DEFINITION OF DONE */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 py-12">
        <TerminalCard title="cat ./definition-of-done.txt">
          <ul className="space-y-2 font-mono text-sm">
            {[
              "AC1–AC8 demonstrated end-to-end on a representative BVLOS swarm submission.",
              "Live joint MAA/CAA panel completed ≥ 1 approval without manual fallback.",
              "Decision record accepted by the Duty Holder without rework on structure or traceability.",
              "Independent assurance review (MAA-CTS / CAA Innovation Hub) signed off the Workbench's own assurance case.",
              "Independent red-team probe (automation bias · evidence-fabrication · classification leakage · prompt-injection) completed.",
              "Drift monitoring on the Workbench's AI components in place with owner assigned.",
              "UNCLASSIFIED lessons-learned note published for the wider UK aviation regulatory community.",
            ].map((d) => (
              <li key={d} className="flex items-start gap-3 text-foreground/85">
                <span className="text-matrix mt-1">▣</span>
                <span>{d}</span>
              </li>
            ))}
          </ul>
        </TerminalCard>
      </section>

      {/* FOOTER */}
      <footer className="relative z-10 border-t border-matrix/20 mt-12">
        <div className="max-w-6xl mx-auto px-6 py-6 flex flex-wrap items-center justify-between gap-3 text-xs text-matrix-dim font-mono">
          <div>© 2026 CTRL-ALT-DEFEAT.UK — There is no spoon.</div>
          <div className="flex items-center gap-2">
            <span className="w-2 h-2 rounded-full bg-matrix animate-pulse" />
            <span>user-story · loaded</span>
          </div>
        </div>
      </footer>
    </div>
  );
}
