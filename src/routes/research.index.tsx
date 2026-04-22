import { createFileRoute, Link } from "@tanstack/react-router";
import { RESEARCH } from "@/content/research";
import { ArrowRight, FileText } from "lucide-react";

export const Route = createFileRoute("/research/")({
  component: ResearchIndex,
});

function ResearchIndex() {
  return (
    <div className="float-up">
      <div className="border border-matrix/30 rounded-sm bg-background/40 backdrop-blur-sm p-6 mb-8">
        <div className="text-[0.7rem] uppercase tracking-widest text-matrix-dim font-display">
          $ cat /research/manifest.json
        </div>
        <p className="mt-3 text-sm text-foreground/85 leading-relaxed">
          A consolidated wiki of open-source research on{" "}
          <span className="text-matrix">artificial intelligence and machine learning</span> across
          the UK Ministry of Defence's test &amp; evaluation enterprise. Organised by domain to
          support capability investment, research prioritisation, safety-case development and
          engagement with Dstl, DE&amp;S, the Defence AI Centre and NATO partners.
        </p>
        <div className="mt-4 flex flex-wrap gap-2 text-[0.65rem] uppercase tracking-widest">
          {["JSP 520", "JSP 936", "AMLAS / SACE", "STANAGs", "DEFSTANs", "RA 1600"].map((t) => (
            <span
              key={t}
              className="px-2 py-1 border border-matrix/30 text-matrix-dim rounded-sm bg-matrix/5"
            >
              {t}
            </span>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {RESEARCH.map((entry, i) => (
          <Link
            key={entry.slug}
            to="/research/$slug"
            params={{ slug: entry.slug }}
            className="group block border border-matrix/30 rounded-sm bg-background/40 backdrop-blur-sm p-5 hover:border-matrix hover:border-glow transition-all float-up"
            style={{ animationDelay: `${i * 80}ms` }}
          >
            <div className="flex items-start justify-between gap-3 mb-2">
              <div className="flex items-center gap-2">
                <span className="font-display text-xs text-matrix-dim group-hover:text-matrix transition-colors">
                  [{entry.code}]
                </span>
                <FileText className="w-4 h-4 text-matrix/60 group-hover:text-matrix transition-colors" />
              </div>
              <ArrowRight className="w-4 h-4 text-matrix-dim group-hover:text-matrix group-hover:translate-x-1 transition-all" />
            </div>
            <h2 className="font-display text-lg text-matrix text-glow group-hover:tracking-wider transition-all">
              {entry.title}
            </h2>
            <p className="mt-2 text-xs text-muted-foreground leading-relaxed">{entry.blurb}</p>
            <div className="mt-3 flex flex-wrap gap-1.5">
              {entry.tags.map((t) => (
                <span
                  key={t}
                  className="text-[0.6rem] uppercase tracking-widest px-1.5 py-0.5 bg-matrix/10 text-matrix-dim border border-matrix/20 rounded-sm"
                >
                  {t}
                </span>
              ))}
            </div>
          </Link>
        ))}
      </div>
    </div>
  );
}
