import { createFileRoute, Link } from "@tanstack/react-router";
import { useMemo, useState } from "react";
import { MatrixRain } from "@/components/MatrixRain";
import { TerminalCard } from "@/components/TerminalCard";
import { ArrowLeft, ShieldAlert, Activity, FileSearch, Layers, Gauge } from "lucide-react";
import report from "@/content/stress-report.json";

export const Route = createFileRoute("/ai-stress")({
  head: () => ({
    meta: [
      { title: "AI Stress-Test — CAA BVLOS UAS Swarm" },
      {
        name: "description",
        content:
          "DTFEA stress-test report for CAA BVLOS UAS Swarm operational authorisation — 5 pillars, per-requirement decision matrix and 100 analyst findings.",
      },
      { property: "og:title", content: "AI Stress-Test — CAA BVLOS UAS Swarm" },
      {
        property: "og:description",
        content:
          "DTFEA stress-test report for CAA BVLOS UAS Swarm operational authorisation — 5 pillars, per-requirement decision matrix and 100 analyst findings.",
      },
    ],
  }),
  component: AIStressPage,
});

type Verdict = "proceed" | "trial_pilot" | "not_suitable";
type Severity = "critical" | "major" | "minor";

interface Pillar {
  letter: string;
  name: string;
  analyst: string;
  score: string;
  status: string;
  detail: string;
}

interface MatrixRow {
  req: string;
  name: string;
  verdict: string;
  value: string;
  risk: string;
  gap: string;
  score: string;
  reason: string;
}

interface Finding {
  n: string;
  req: string;
  pillar: string;
  analyst: string;
  severity: string;
  conf: string;
  title: string;
  analysis: string;
  recommendation: string;
}

interface Summary {
  verdict: string;
  verdictLabel: string;
  verdictNote: string;
  requirements: number;
  findings: number;
  proceed: number;
  trial_pilot: number;
  not_suitable: number;
  generated: string;
  subject: string;
  method: string;
}

const VERDICT_LABEL: Record<string, string> = {
  all: "All",
  proceed: "✅ Proceed",
  trial_pilot: "⚠️ Pilot only",
  not_suitable: "❌ Not suitable",
};

const VERDICT_CHIP: Record<string, string> = {
  proceed: "border-matrix/60 text-matrix bg-matrix/5",
  trial_pilot: "border-yellow-500/60 text-yellow-400 bg-yellow-500/5",
  not_suitable: "border-destructive/60 text-destructive bg-destructive/5",
};

const SEV_LABEL: Record<string, string> = {
  all: "All",
  critical: "Critical",
  major: "Major",
  minor: "Minor",
};

const SEV_STYLES: Record<string, string> = {
  critical: "border-destructive/60 text-destructive",
  major: "border-yellow-500/60 text-yellow-400",
  minor: "border-matrix/60 text-matrix",
};

const STATUS_COLOR: Record<string, string> = {
  fail: "text-destructive",
  warn: "text-yellow-400",
  pass: "text-matrix",
};

function AIStressPage() {
  const data = report as {
    summary: Summary;
    pillars: Pillar[];
    matrix: MatrixRow[];
    findings: Finding[];
  };

  const [verdictFilter, setVerdictFilter] = useState<string>("all");
  const [sevFilter, setSevFilter] = useState<string>("all");

  const verdictCounts = useMemo(() => {
    const c: Record<string, number> = { all: data.matrix.length, proceed: 0, trial_pilot: 0, not_suitable: 0 };
    for (const r of data.matrix) c[r.verdict] = (c[r.verdict] ?? 0) + 1;
    return c;
  }, [data.matrix]);

  const sevCounts = useMemo(() => {
    const c: Record<string, number> = { all: data.findings.length, critical: 0, major: 0, minor: 0 };
    for (const f of data.findings) c[f.severity] = (c[f.severity] ?? 0) + 1;
    return c;
  }, [data.findings]);

  const filteredMatrix = useMemo(
    () => (verdictFilter === "all" ? data.matrix : data.matrix.filter((r) => r.verdict === verdictFilter)),
    [verdictFilter, data.matrix],
  );

  const filteredFindings = useMemo(
    () => (sevFilter === "all" ? data.findings : data.findings.filter((f) => f.severity === sevFilter)),
    [sevFilter, data.findings],
  );

  const verdictBannerClass =
    data.summary.verdict === "proceed"
      ? "border-matrix/60 bg-matrix/5"
      : data.summary.verdict === "trial_pilot"
      ? "border-yellow-500/60 bg-yellow-500/5"
      : "border-destructive/60 bg-destructive/5";

  const verdictTextColor =
    data.summary.verdict === "proceed"
      ? "text-matrix"
      : data.summary.verdict === "trial_pilot"
      ? "text-yellow-400"
      : "text-destructive";

  return (
    <div className="min-h-screen relative overflow-x-hidden crt-flicker">
      <MatrixRain />

      {/* NAV */}
      <nav className="relative z-20 border-b border-matrix/20 backdrop-blur-md bg-background/40">
        <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
          <Link
            to="/"
            className="flex items-center gap-2 font-display text-matrix hover:text-matrix-glow transition-colors"
          >
            <ArrowLeft className="w-4 h-4" />
            <span className="text-glow text-xl">▌</span>
            <span className="tracking-widest text-sm">CTRL-ALT-DEFEAT.UK</span>
          </Link>
          <div className="text-xs uppercase tracking-widest text-muted-foreground font-mono">
            ./ai-stress --method=dtfea
          </div>
        </div>
      </nav>

      {/* HERO */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pt-16 pb-8 float-up">
        <div className="space-y-4">
          <div className="font-mono text-sm text-matrix-dim">
            <span className="text-matrix">$</span> ./stress-test --subject="caa-bvlos-uas-swarm"
          </div>
          <h1 className="font-display text-4xl md:text-6xl leading-none tracking-tight">
            <span className="block text-foreground">AI STRESS-TEST</span>
            <span className="block text-matrix text-glow-strong">{data.summary.subject}</span>
          </h1>
          <p className="max-w-3xl text-muted-foreground">
            <code className="text-matrix">{data.summary.method}</code> methodology · generated{" "}
            {data.summary.generated} · OpenRequirements.AI
          </p>
        </div>
      </section>

      {/* VERDICT BANNER */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-10">
        <div className={`border-2 rounded-sm p-6 backdrop-blur-sm ${verdictBannerClass}`}>
          <div className={`font-display text-3xl md:text-4xl text-glow ${verdictTextColor}`}>
            ❌ {data.summary.verdictLabel}
          </div>
          <div className="text-xs uppercase tracking-widest text-muted-foreground font-mono mt-3">
            {data.summary.verdictNote}
          </div>
        </div>
      </section>

      {/* SUMMARY CARDS */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-12">
        <SectionHeader icon={Gauge} label="// executive-summary" title="EXECUTIVE SUMMARY" />
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-3">
          {[
            { n: data.summary.requirements, l: "Requirements" },
            { n: data.summary.findings, l: "Findings" },
            { n: data.summary.proceed, l: "✅ Proceed", color: "text-matrix" },
            { n: data.summary.trial_pilot, l: "⚠️ Pilot only", color: "text-yellow-400" },
            { n: data.summary.not_suitable, l: "❌ Not suitable", color: "text-destructive" },
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

      {/* PILLARS */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-12">
        <SectionHeader icon={Layers} label="// dtfea" title="THE 5 STRESS-TEST PILLARS" />
        <TerminalCard title="cat ./pillars.json">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-3">
            {data.pillars.map((p) => (
              <div
                key={p.letter}
                className="bg-background/60 border border-matrix/30 rounded-sm p-4 hover:border-matrix transition-colors"
              >
                <div className="flex items-baseline gap-2">
                  <span className="font-display text-4xl text-matrix text-glow">{p.letter}</span>
                  <span className="font-display text-sm text-foreground">{p.name}</span>
                </div>
                <div className="text-[11px] uppercase tracking-widest text-muted-foreground font-mono mt-1">
                  {p.analyst}
                </div>
                <div className={`font-display text-2xl mt-2 ${STATUS_COLOR[p.status] ?? "text-matrix"}`}>
                  {p.score}
                </div>
                <div className="text-[10px] font-mono text-matrix-dim mt-1">{p.detail}</div>
              </div>
            ))}
          </div>
        </TerminalCard>
      </section>

      {/* DECISION MATRIX */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-12">
        <SectionHeader icon={Activity} label="// matrix" title="PER-REQUIREMENT DECISION MATRIX" />

        <div className="flex flex-wrap gap-2 mb-5">
          {(["all", "proceed", "trial_pilot", "not_suitable"] as const).map((v) => {
            const active = verdictFilter === v;
            return (
              <button
                key={v}
                type="button"
                onClick={() => setVerdictFilter(v)}
                className={`px-3 py-1.5 border rounded-sm text-[11px] uppercase tracking-widest font-display transition-colors ${
                  active
                    ? "bg-matrix text-primary-foreground border-matrix"
                    : "border-matrix/40 text-matrix hover:bg-matrix/10"
                }`}
              >
                {VERDICT_LABEL[v]}{" "}
                <span className={`ml-1 ${active ? "text-primary-foreground/70" : "text-matrix-dim"}`}>
                  {verdictCounts[v] ?? 0}
                </span>
              </button>
            );
          })}
        </div>

        <div className="bg-card/60 backdrop-blur-sm border border-matrix/30 rounded-sm overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="bg-matrix/10 border-b border-matrix/20">
                <tr className="text-left">
                  <Th>REQ</Th>
                  <Th>Name</Th>
                  <Th>Verdict</Th>
                  <Th className="text-right">Value</Th>
                  <Th className="text-right">Risk</Th>
                  <Th className="text-right">Gap</Th>
                  <Th className="text-right">Score</Th>
                  <Th>Reason</Th>
                </tr>
              </thead>
              <tbody className="divide-y divide-matrix/15">
                {filteredMatrix.map((r) => (
                  <tr key={r.req} className="hover:bg-matrix/5 transition-colors">
                    <td className="px-3 py-2.5 align-top">
                      <code className="text-matrix font-mono text-xs">{r.req}</code>
                    </td>
                    <td className="px-3 py-2.5 align-top text-foreground/90">{r.name}</td>
                    <td className="px-3 py-2.5 align-top">
                      <span
                        className={`px-2 py-0.5 border rounded-sm text-[10px] uppercase tracking-widest font-display whitespace-nowrap ${
                          VERDICT_CHIP[r.verdict] ?? "border-matrix/40 text-matrix"
                        }`}
                      >
                        {VERDICT_LABEL[r.verdict]}
                      </span>
                    </td>
                    <td className="px-3 py-2.5 align-top text-right font-mono text-matrix-dim">{r.value}</td>
                    <td className="px-3 py-2.5 align-top text-right font-mono text-matrix-dim">{r.risk}</td>
                    <td className="px-3 py-2.5 align-top text-right font-mono text-matrix-dim">{r.gap}</td>
                    <td className="px-3 py-2.5 align-top text-right font-mono text-destructive">{r.score}</td>
                    <td className="px-3 py-2.5 align-top text-foreground/75 text-xs">{r.reason}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </section>

      {/* FINDINGS */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pb-20">
        <SectionHeader icon={FileSearch} label="// findings" title="ANALYST FINDINGS" />

        <div className="flex flex-wrap gap-2 mb-6">
          {(["all", "critical", "major", "minor"] as const).map((s) => {
            const active = sevFilter === s;
            return (
              <button
                key={s}
                type="button"
                onClick={() => setSevFilter(s)}
                className={`px-3 py-1.5 border rounded-sm text-[11px] uppercase tracking-widest font-display transition-colors ${
                  active
                    ? "bg-matrix text-primary-foreground border-matrix"
                    : "border-matrix/40 text-matrix hover:bg-matrix/10"
                }`}
              >
                {SEV_LABEL[s]}{" "}
                <span className={`ml-1 ${active ? "text-primary-foreground/70" : "text-matrix-dim"}`}>
                  {sevCounts[s] ?? 0}
                </span>
              </button>
            );
          })}
        </div>

        <div className="space-y-4">
          {filteredFindings.map((f) => (
            <div
              key={f.n}
              className="bg-card/60 backdrop-blur-sm border border-matrix/30 rounded-sm overflow-hidden hover:border-matrix transition-colors"
            >
              <div className="flex items-start gap-4 p-5 border-b border-matrix/15 bg-matrix/5">
                <div className="w-11 h-11 rounded-full border-2 border-matrix/40 bg-background flex items-center justify-center font-display text-matrix text-sm shrink-0">
                  {f.pillar}
                </div>
                <div className="flex-1 min-w-0">
                  <div className="font-display text-foreground text-base leading-snug">{f.title}</div>
                  <div className="text-xs text-muted-foreground mt-1">
                    Pillar <span className="text-matrix">{f.pillar}</span> · Analyst{" "}
                    <span className="text-matrix">{f.analyst}</span>
                    <code className="ml-2 px-1.5 py-0.5 bg-background border border-matrix/20 rounded-sm text-[10px] text-matrix-dim">
                      {f.req}
                    </code>
                  </div>
                </div>
                <div className="flex flex-wrap gap-2 shrink-0 justify-end">
                  <span
                    className={`px-2 py-0.5 border rounded-sm text-[10px] uppercase tracking-widest font-display ${
                      SEV_STYLES[f.severity] ?? "border-matrix/50 text-matrix"
                    }`}
                  >
                    {f.severity}
                  </span>
                  <span className="px-2 py-0.5 border border-matrix/40 rounded-sm text-[10px] uppercase tracking-widest font-display text-matrix">
                    conf {f.conf}
                  </span>
                  <span className="px-2 py-0.5 border border-matrix/30 rounded-sm text-[10px] uppercase tracking-widest font-display text-matrix-dim">
                    #{f.n}
                  </span>
                </div>
              </div>
              <div className="p-5 space-y-3">
                <div>
                  <div className="text-[10px] uppercase tracking-widest text-muted-foreground mb-1">Analysis</div>
                  <div className="text-sm leading-relaxed text-foreground/85">{f.analysis}</div>
                </div>
                <div>
                  <div className="text-[10px] uppercase tracking-widest text-muted-foreground mb-1">
                    Recommendation
                  </div>
                  <div className="text-sm leading-relaxed bg-background/60 border border-matrix/30 rounded-sm p-3 text-matrix">
                    {f.recommendation}
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </section>

      <footer className="relative z-10 border-t border-matrix/20">
        <div className="max-w-6xl mx-auto px-6 py-6 flex flex-wrap items-center justify-between gap-3 text-xs text-matrix-dim font-mono">
          <div>© 2026 CTRL-ALT-DEFEAT.UK — DTFEA via OpenRequirements.AI</div>
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
  icon: typeof ShieldAlert;
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

function Th({ children, className = "" }: { children: React.ReactNode; className?: string }) {
  return (
    <th
      className={`px-3 py-2.5 text-[10px] uppercase tracking-widest text-matrix font-display whitespace-nowrap ${className}`}
    >
      {children}
    </th>
  );
}
