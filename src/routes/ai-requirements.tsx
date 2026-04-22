import { createFileRoute, Link } from "@tanstack/react-router";
import { useMemo, useState } from "react";
import { MatrixRain } from "@/components/MatrixRain";
import { TerminalCard } from "@/components/TerminalCard";
import { ArrowLeft, AlertTriangle, CheckCircle2, FileSearch, BookOpen, ListChecks, ScrollText } from "lucide-react";
import report from "@/content/requirements-report.json";

export const Route = createFileRoute("/ai-requirements")({
  head: () => ({
    meta: [
      { title: "AI Requirements — DeFOSPAM Validation Report" },
      {
        name: "description",
        content:
          "DeFOSPAM requirements validation report for the CAA Swarm BVLOS user stories — glossary, business stories, scenarios and findings.",
      },
      { property: "og:title", content: "AI Requirements — DeFOSPAM Validation Report" },
      {
        property: "og:description",
        content:
          "DeFOSPAM requirements validation report for the CAA Swarm BVLOS user stories — glossary, business stories, scenarios and findings.",
      },
    ],
  }),
  component: AIRequirementsPage,
});

type Severity = "critical" | "major" | "minor";
type Principle = "D" | "F" | "O" | "S" | "P" | "A" | "M";

interface Finding {
  principle: Principle | string;
  severity: Severity | string;
  title: string;
  analyst: string;
  analyst_role: string;
  tag: string;
  confidence: string;
  sections: { h: string; body: string }[];
}

interface Story {
  gap: boolean;
  title: string;
  story: string;
  trace: string;
}

interface Scenario {
  n: string;
  feature: string;
  scenario: string;
  given: string;
  when: string;
  then: string;
}

interface GlossaryEntry {
  term: string;
  def: string;
  status: string;
}

const PRINCIPLE_LABELS: Record<string, string> = {
  ALL: "All",
  D: "D — Definitions",
  F: "F — Features",
  O: "O — Outcomes",
  S: "S — Scenarios",
  P: "P — Prediction",
  A: "A — Ambiguity",
  M: "M — Missing",
};

const SEVERITY_STYLES: Record<string, string> = {
  critical: "border-destructive/60 text-destructive",
  major: "border-yellow-500/60 text-yellow-400",
  minor: "border-matrix/60 text-matrix",
};

function AIRequirementsPage() {
  const data = report as {
    glossary: GlossaryEntry[];
    stories: Story[];
    scenarios: Scenario[];
    findings: Finding[];
  };

  const [filter, setFilter] = useState<string>("ALL");

  const counts = useMemo(() => {
    const c: Record<string, number> = { ALL: data.findings.length };
    for (const f of data.findings) c[f.principle] = (c[f.principle] ?? 0) + 1;
    return c;
  }, [data.findings]);

  const totals = useMemo(() => {
    const t = { critical: 0, major: 0, minor: 0 };
    for (const f of data.findings) {
      if (f.severity in t) t[f.severity as Severity] += 1;
    }
    return t;
  }, [data.findings]);

  const filteredFindings = useMemo(
    () => (filter === "ALL" ? data.findings : data.findings.filter((f) => f.principle === filter)),
    [filter, data.findings],
  );

  return (
    <div className="min-h-screen relative overflow-x-hidden crt-flicker">
      <MatrixRain />

      {/* NAV */}
      <nav className="relative z-20 border-b border-matrix/20 backdrop-blur-md bg-background/40">
        <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
          <Link to="/" className="flex items-center gap-2 font-display text-matrix hover:text-matrix-glow transition-colors">
            <ArrowLeft className="w-4 h-4" />
            <span className="text-glow text-xl">▌</span>
            <span className="tracking-widest text-sm">CTRL-ALT-DEFEAT.UK</span>
          </Link>
          <div className="text-xs uppercase tracking-widest text-muted-foreground font-mono">
            ./ai-requirements --report=defospam
          </div>
        </div>
      </nav>

      {/* HERO */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pt-16 pb-12 float-up">
        <div className="space-y-4">
          <div className="font-mono text-sm text-matrix-dim">
            <span className="text-matrix">$</span> cat ./reports/defospam-caa-swarm.json
          </div>
          <h1 className="font-display text-4xl md:text-6xl leading-none tracking-tight">
            <span className="block text-foreground">DeFOSPAM</span>
            <span className="block text-matrix text-glow-strong">REQUIREMENTS REPORT</span>
          </h1>
          <p className="max-w-3xl text-muted-foreground">
            Source: <code className="text-matrix">CAA_User_Stories_Swarm_BVLOS.docx (32 user stories)</code> · 7
            analysts · Timestamp 2026-04-22T00:00:00Z · Based on the Business Story Method by Paul Gerrard &amp; Susan
            Windsor.
          </p>
        </div>
      </section>

      {/* SUMMARY */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-12">
        <div className="grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-8 gap-3">
          {[
            { n: data.findings.length, l: "Findings" },
            { n: totals.critical, l: "Critical", color: "text-destructive" },
            { n: totals.major, l: "Major", color: "text-yellow-400" },
            { n: totals.minor, l: "Minor", color: "text-matrix" },
            { n: 7, l: "Analysts" },
            { n: 17, l: "Features" },
            { n: data.scenarios.length, l: "Scenarios" },
            { n: data.glossary.length, l: "Glossary" },
          ].map((s) => (
            <div
              key={s.l}
              className="bg-card/60 border border-matrix/30 rounded-sm p-4 text-center backdrop-blur-sm"
            >
              <div className={`font-display text-3xl text-glow ${s.color ?? "text-matrix"}`}>{s.n}</div>
              <div className="text-[10px] uppercase tracking-widest text-muted-foreground mt-1">{s.l}</div>
            </div>
          ))}
        </div>
      </section>

      {/* GLOSSARY */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-12">
        <SectionHeader icon={BookOpen} label="// glossary" title="PROPOSED GLOSSARY" />
        <TerminalCard title="cat ./glossary.md">
          <div className="divide-y divide-matrix/15">
            {data.glossary.map((g) => (
              <div key={g.term} className="py-3 grid md:grid-cols-[180px_1fr_100px] gap-3 items-start">
                <div className="font-display text-matrix text-glow tracking-wider">{g.term}</div>
                <div className="text-sm text-foreground/85 leading-relaxed">{g.def}</div>
                <div
                  className={`flex items-center gap-1.5 text-[10px] uppercase tracking-widest font-mono ${
                    g.status === "verified" ? "text-matrix" : "text-yellow-400"
                  }`}
                >
                  {g.status === "verified" ? (
                    <CheckCircle2 className="w-3.5 h-3.5" />
                  ) : (
                    <AlertTriangle className="w-3.5 h-3.5" />
                  )}
                  {g.status}
                </div>
              </div>
            ))}
          </div>
        </TerminalCard>
      </section>

      {/* STORIES */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-12">
        <SectionHeader icon={ScrollText} label="// stories" title="BUSINESS STORIES" />
        <div className="grid md:grid-cols-2 gap-4">
          {data.stories.map((s, i) => (
            <div
              key={i}
              className={`bg-card/60 backdrop-blur-sm border rounded-sm p-5 ${
                s.gap ? "border-yellow-500/50" : "border-matrix/30"
              }`}
            >
              <div
                className={`font-display text-sm uppercase tracking-widest mb-2 ${
                  s.gap ? "text-yellow-400" : "text-matrix"
                }`}
              >
                {s.title}
              </div>
              <p className="text-sm text-foreground/85 italic border-l-2 border-matrix/40 pl-3 leading-relaxed">
                {s.story}
              </p>
              {s.trace && (
                <div className="mt-3 text-[11px] font-mono text-matrix-dim">
                  <span className="text-muted-foreground">traces →</span> {s.trace}
                </div>
              )}
            </div>
          ))}
        </div>
      </section>

      {/* SCENARIOS */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-12">
        <SectionHeader icon={ListChecks} label="// scenarios" title="GIVEN / WHEN / THEN" />
        <div className="space-y-3">
          {data.scenarios.map((sc) => (
            <div
              key={sc.n}
              className="bg-card/60 backdrop-blur-sm border border-matrix/30 rounded-sm p-5"
            >
              <div className="flex items-baseline justify-between gap-3 flex-wrap mb-3">
                <div className="font-display text-matrix text-glow">
                  <span className="text-matrix-dim mr-2">#{sc.n}</span>
                  {sc.scenario}
                </div>
                <div className="text-[11px] uppercase tracking-widest text-muted-foreground font-mono">
                  {sc.feature}
                </div>
              </div>
              <div className="grid md:grid-cols-3 gap-3 text-sm">
                <GwtBlock label="GIVEN" body={sc.given} />
                <GwtBlock label="WHEN" body={sc.when} />
                <GwtBlock label="THEN" body={sc.then} />
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* FINDINGS */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-20">
        <SectionHeader icon={FileSearch} label="// findings" title="ANALYST FINDINGS" />

        <div className="flex flex-wrap gap-2 mb-6">
          {(["ALL", "D", "F", "O", "S", "P", "A", "M"] as const).map((p) => {
            const active = filter === p;
            return (
              <button
                key={p}
                type="button"
                onClick={() => setFilter(p)}
                className={`px-3 py-1.5 border rounded-sm text-[11px] uppercase tracking-widest font-display transition-colors ${
                  active
                    ? "bg-matrix text-primary-foreground border-matrix"
                    : "border-matrix/40 text-matrix hover:bg-matrix/10"
                }`}
              >
                {PRINCIPLE_LABELS[p]}{" "}
                <span className={`ml-1 ${active ? "text-primary-foreground/70" : "text-matrix-dim"}`}>
                  {counts[p] ?? 0}
                </span>
              </button>
            );
          })}
        </div>

        <div className="space-y-4">
          {filteredFindings.map((f, i) => (
            <div
              key={i}
              className="bg-card/60 backdrop-blur-sm border border-matrix/30 rounded-sm overflow-hidden hover:border-matrix transition-colors"
            >
              <div className="flex items-start gap-4 p-5 border-b border-matrix/15 bg-matrix/5">
                <div className="w-11 h-11 rounded-full border-2 border-matrix/40 bg-background flex items-center justify-center font-display text-matrix text-sm shrink-0">
                  {f.analyst.slice(0, 2).toUpperCase()}
                </div>
                <div className="flex-1 min-w-0">
                  <div className="font-display text-foreground text-base leading-snug">{f.title}</div>
                  <div className="text-xs text-muted-foreground mt-1">
                    Found by <span className="text-matrix">{f.analyst}</span> — {f.analyst_role}
                    <code className="ml-2 px-1.5 py-0.5 bg-background border border-matrix/20 rounded-sm text-[10px] text-matrix-dim">
                      {f.tag}
                    </code>
                  </div>
                </div>
                <div className="flex flex-wrap gap-2 shrink-0">
                  <span
                    className={`px-2 py-0.5 border rounded-sm text-[10px] uppercase tracking-widest font-display ${
                      SEVERITY_STYLES[f.severity] ?? "border-matrix/50 text-matrix"
                    }`}
                  >
                    {f.severity}
                  </span>
                  {f.confidence && (
                    <span className="px-2 py-0.5 border border-matrix/40 rounded-sm text-[10px] uppercase tracking-widest font-display text-matrix">
                      {f.confidence}
                    </span>
                  )}
                  <span className="px-2 py-0.5 border border-matrix/30 rounded-sm text-[10px] uppercase tracking-widest font-display text-matrix-dim">
                    {f.principle}
                  </span>
                </div>
              </div>
              <div className="p-5 space-y-3">
                {f.sections.map((sec, j) => (
                  <div key={j}>
                    <div className="text-[10px] uppercase tracking-widest text-muted-foreground mb-1">{sec.h}</div>
                    <div
                      className={`text-sm leading-relaxed ${
                        sec.h.toLowerCase().includes("recommendation")
                          ? "bg-background/60 border border-matrix/30 rounded-sm p-3 text-matrix"
                          : "text-foreground/85"
                      }`}
                    >
                      {sec.body}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </section>

      <footer className="relative z-10 border-t border-matrix/20">
        <div className="max-w-6xl mx-auto px-6 py-6 flex flex-wrap items-center justify-between gap-3 text-xs text-matrix-dim font-mono">
          <div>© 2026 CTRL-ALT-DEFEAT.UK — DeFOSPAM via OpenRequirements.ai</div>
          <Link to="/" className="text-matrix hover:text-matrix-glow">
            ← return to root
          </Link>
        </div>
      </footer>
    </div>
  );
}

function SectionHeader({
  icon: Icon,
  label,
  title,
}: {
  icon: typeof BookOpen;
  label: string;
  title: string;
}) {
  return (
    <div className="mb-5">
      <div className="text-matrix-dim text-xs font-mono mb-1 flex items-center gap-2">
        <Icon className="w-3.5 h-3.5" /> {label}
      </div>
      <h2 className="font-display text-2xl md:text-3xl text-foreground tracking-tight">
        <span className="text-matrix text-glow">{title}</span>
      </h2>
    </div>
  );
}

function GwtBlock({ label, body }: { label: string; body: string }) {
  return (
    <div className="bg-background/60 border border-matrix/20 rounded-sm p-3">
      <div className="text-[10px] uppercase tracking-widest text-matrix mb-1 font-display">{label}</div>
      <div className="text-foreground/85 leading-relaxed">{body}</div>
    </div>
  );
}
