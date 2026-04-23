import { useEffect, useState } from "react";
import { X, ChevronLeft, ChevronRight } from "lucide-react";
import excelReq from "@/assets/gallery/excel-requirements.png";
import eggplant from "@/assets/gallery/eggplant-generator.png";
import devUiWorkflow from "@/assets/gallery/dev-ui-workflow.png";
import reqqaRequirements from "@/assets/gallery/reqqa-requirements.png";

type Shot = {
  src: string;
  title: string;
  caption: string;
  tag: string;
};

const shots: Shot[] = [
  {
    src: excelReq,
    title: "AI-Generated SRS Requirements",
    caption:
      "Claude generating SRS-SWARM functional requirements directly into Excel — autonomy, BVLOS, swarm trial config, all linked to verification methods.",
    tag: "excel · claude · requirements",
  },
  {
    src: eggplant,
    title: "Eggplant Generator — Gherkin from CAP 722",
    caption:
      "Auto-generated Gherkin user stories for CAA case officers, SORA assessors, safety reviewers and airspace regulators — sourced from CAP 722A/B context files.",
    tag: "eggplant · gherkin · CAA",
  },
  {
    src: devUiWorkflow,
    title: "SORA Approval — Applicant Workflow",
    caption:
      "Live Dev UI execution timeline of the SORA Approval workflow — operation_classifier fanning out to artefact_detector, regulatory_mapper and sora_evaluator, merging into decision_drafter and binder with full event trace.",
    tag: "dev ui · workflow · SORA",
  },
  {
    src: reqqaRequirements,
    title: "ReqQA — SQUAD-STATE Requirements List",
    caption:
      "Requirements QA workspace for User50 SQUAD-STATE — 30 mission-origin requirements with priority, hazard flags, R-D/R-F analysis columns and per-row Analyse / Generate Stories actions.",
    tag: "reqqa · requirements · QA",
  },
];

export function ScreenshotGallery() {
  const [openIdx, setOpenIdx] = useState<number | null>(null);

  useEffect(() => {
    if (openIdx === null) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpenIdx(null);
      if (e.key === "ArrowRight") setOpenIdx((i) => (i === null ? 0 : (i + 1) % shots.length));
      if (e.key === "ArrowLeft")
        setOpenIdx((i) => (i === null ? 0 : (i - 1 + shots.length) % shots.length));
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [openIdx]);

  const active = openIdx !== null ? shots[openIdx] : null;

  return (
    <>
      <div className="grid md:grid-cols-2 gap-5">
        {shots.map((s, i) => (
          <button
            key={s.src}
            type="button"
            onClick={() => setOpenIdx(i)}
            className="group relative block text-left bg-card/60 backdrop-blur-sm border border-matrix/30 rounded-md overflow-hidden hover:border-matrix hover:border-glow transition-all hover:-translate-y-1 float-up"
            style={{ animationDelay: `${i * 80}ms` }}
          >
            <div className="absolute top-2 left-2 z-10 font-mono text-[10px] uppercase tracking-widest px-2 py-1 bg-background/70 border border-matrix/40 text-matrix rounded-sm">
              {String(i + 1).padStart(2, "0")} · {s.tag}
            </div>
            <div className="relative aspect-video overflow-hidden bg-background">
              <img
                src={s.src}
                alt={s.title}
                loading="lazy"
                className="absolute inset-0 w-full h-full object-cover object-top group-hover:scale-[1.02] transition-transform duration-500"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-background/70 via-transparent to-transparent pointer-events-none" />
              <div className="absolute inset-0 ring-1 ring-inset ring-matrix/10 group-hover:ring-matrix/40 transition-colors pointer-events-none" />
            </div>
            <div className="p-5 border-t border-matrix/20">
              <div className="font-display text-lg text-matrix glitch mb-1">› {s.title}</div>
              <p className="text-sm text-foreground/75 leading-relaxed">{s.caption}</p>
              <div className="mt-3 text-[11px] uppercase tracking-widest text-matrix-dim group-hover:text-matrix transition-colors">
                ► expand · click to zoom
              </div>
            </div>
          </button>
        ))}
      </div>

      {active && (
        <div
          className="fixed inset-0 z-50 bg-background/90 backdrop-blur-md flex flex-col"
          onClick={() => setOpenIdx(null)}
        >
          <div className="flex items-center justify-between border-b border-matrix/20 px-6 py-3 font-mono text-xs text-matrix-dim">
            <span>
              <span className="text-matrix">$</span> open ./gallery/{String((openIdx ?? 0) + 1).padStart(2, "0")}.png
            </span>
            <button
              type="button"
              onClick={(e) => {
                e.stopPropagation();
                setOpenIdx(null);
              }}
              className="flex items-center gap-2 px-3 py-1 border border-matrix/40 text-matrix hover:bg-matrix/10 rounded-sm uppercase tracking-widest"
            >
              <X className="w-3.5 h-3.5" /> esc
            </button>
          </div>

          <div
            className="flex-1 flex items-center justify-center p-4 md:p-8 relative"
            onClick={(e) => e.stopPropagation()}
          >
            <button
              type="button"
              onClick={() =>
                setOpenIdx((i) => (i === null ? 0 : (i - 1 + shots.length) % shots.length))
              }
              className="absolute left-2 md:left-6 p-2 border border-matrix/40 text-matrix hover:bg-matrix/10 rounded-sm"
              aria-label="Previous"
            >
              <ChevronLeft className="w-5 h-5" />
            </button>

            <img
              src={active.src}
              alt={active.title}
              className="max-h-full max-w-full object-contain border border-matrix/40 shadow-[0_0_60px_rgba(0,255,120,0.15)]"
            />

            <button
              type="button"
              onClick={() => setOpenIdx((i) => (i === null ? 0 : (i + 1) % shots.length))}
              className="absolute right-2 md:right-6 p-2 border border-matrix/40 text-matrix hover:bg-matrix/10 rounded-sm"
              aria-label="Next"
            >
              <ChevronRight className="w-5 h-5" />
            </button>
          </div>

          <div
            className="border-t border-matrix/20 px-6 py-4 max-w-3xl mx-auto w-full"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="font-display text-xl text-matrix mb-1">› {active.title}</div>
            <p className="text-sm text-foreground/80">{active.caption}</p>
          </div>
        </div>
      )}
    </>
  );
}
