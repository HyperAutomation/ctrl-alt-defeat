import { createFileRoute, Link } from "@tanstack/react-router";
import { MatrixRain } from "@/components/MatrixRain";
import { ResearchMarkdown } from "@/components/ResearchMarkdown";
import { ArrowLeft } from "lucide-react";
import planContent from "@/content/ai-plan.md?raw";

export const Route = createFileRoute("/ai-plan")({
  head: () => ({
    meta: [
      { title: "AI Plan — SORA Approval Document Generator" },
      {
        name: "description",
        content:
          "Design plan v1.1 for the SORA Approval Document Generator — a CAA/MAA joint workbench for live BVLOS autonomous swarm trials.",
      },
      {
        property: "og:title",
        content: "AI Plan — SORA Approval Document Generator",
      },
      {
        property: "og:description",
        content:
          "Design plan v1.1 for the SORA Approval Document Generator — a CAA/MAA joint workbench for live BVLOS autonomous swarm trials.",
      },
    ],
  }),
  component: AiPlanPage,
});

function AiPlanPage() {
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
      <section className="relative z-10 max-w-5xl mx-auto px-6 pt-16 pb-8">
        <div className="space-y-5 float-up">
          <div className="font-mono text-sm text-matrix-dim">
            <span className="text-matrix">$</span> cat ./ai-plan --doc=SORA_Approval_Generator_Plan_v1_1
          </div>

          <div className="flex flex-wrap items-center gap-3 text-[10px] uppercase tracking-widest">
            <span className="px-2 py-1 border border-matrix/40 text-matrix/80 rounded-sm bg-matrix/5">Draft v1.1</span>
            <span className="px-2 py-1 border border-matrix/40 text-matrix/80 rounded-sm bg-matrix/5">Plan-before-implementation</span>
            <span className="px-2 py-1 border border-matrix/40 text-matrix/80 rounded-sm bg-matrix/5">23 April 2026</span>
            <span className="px-2 py-1 border border-matrix/40 text-matrix/80 rounded-sm bg-matrix/5">Author · Sentinel</span>
          </div>

          <h1 className="font-display text-4xl md:text-6xl leading-[0.95] tracking-tight">
            <span className="block text-foreground">SORA APPROVAL</span>
            <span className="block text-matrix text-glow-strong">DOCUMENT GENERATOR</span>
            <span className="block text-foreground text-2xl md:text-3xl mt-2 text-muted-foreground">— Design Plan v1.1</span>
          </h1>

          <p className="max-w-3xl text-base md:text-lg text-muted-foreground leading-relaxed">
            Approach (not yet implementation) for a generator that ingests a SORA / Operating Safety Case submission pack and produces a structured decision record aligned to AC1–AC8 of the parent CAA/MAA Joint Approval Workbench user story.
          </p>
        </div>
      </section>

      {/* WIKI BODY */}
      <section className="relative z-10 max-w-5xl mx-auto px-6 pb-20">
        <article className="float-up">
          <div className="mb-4 flex items-center gap-2 text-[0.7rem] uppercase tracking-widest text-matrix-dim font-display">
            <Link to="/" className="hover:text-matrix">
              ~/wiki
            </Link>
            <span>/</span>
            <span className="text-matrix">ai-plan.md</span>
          </div>

          <div className="border border-matrix/30 rounded-sm bg-background/50 backdrop-blur-sm p-6 md:p-10 border-glow">
            <ResearchMarkdown source={planContent} />
          </div>
        </article>
      </section>
    </div>
  );
}
