import { createFileRoute, Link, notFound } from "@tanstack/react-router";
import { ResearchMarkdown } from "@/components/ResearchMarkdown";
import { getEntry, RESEARCH } from "@/content/research";
import { ArrowLeft, ArrowRight } from "lucide-react";

export const Route = createFileRoute("/research/$slug")({
  loader: ({ params }) => {
    const entry = getEntry(params.slug);
    if (!entry) throw notFound();
    return { entry };
  },
  head: ({ loaderData }) => {
    if (!loaderData) return { meta: [] };
    const { entry } = loaderData;
    return {
      meta: [
        { title: `${entry.title} — AI Research` },
        { name: "description", content: entry.blurb },
        { property: "og:title", content: `${entry.title} — AI Research` },
        { property: "og:description", content: entry.blurb },
      ],
    };
  },
  component: ResearchArticle,
  notFoundComponent: () => (
    <div className="border border-matrix/30 rounded-sm bg-background/40 p-8 text-center">
      <p className="font-display text-matrix text-glow text-2xl">404 — article not found</p>
      <Link to="/research" className="mt-4 inline-block text-xs text-matrix-dim hover:text-matrix uppercase tracking-widest">
        ← Back to index
      </Link>
    </div>
  ),
});

function ResearchArticle() {
  const { entry } = Route.useLoaderData();
  const idx = RESEARCH.findIndex((e) => e.slug === entry.slug);
  const prev = idx > 0 ? RESEARCH[idx - 1] : null;
  const next = idx < RESEARCH.length - 1 ? RESEARCH[idx + 1] : null;

  return (
    <article className="float-up">
      <div className="mb-4 flex items-center gap-2 text-[0.7rem] uppercase tracking-widest text-matrix-dim font-display">
        <Link to="/research" className="hover:text-matrix">
          ~/research
        </Link>
        <span>/</span>
        <span className="text-matrix">{entry.slug}.md</span>
      </div>

      <div className="border border-matrix/30 rounded-sm bg-background/50 backdrop-blur-sm p-6 md:p-10 border-glow">
        <ResearchMarkdown source={entry.content} />
      </div>

      {/* Prev / Next */}
      <div className="mt-6 grid grid-cols-2 gap-4">
        {prev ? (
          <Link
            to="/research/$slug"
            params={{ slug: prev.slug }}
            className="group border border-matrix/30 rounded-sm bg-background/40 p-4 hover:border-matrix transition-all"
          >
            <div className="flex items-center gap-2 text-[0.65rem] uppercase tracking-widest text-matrix-dim">
              <ArrowLeft className="w-3 h-3" />
              Previous
            </div>
            <div className="mt-1 font-display text-sm text-matrix group-hover:text-glow truncate">
              {prev.title}
            </div>
          </Link>
        ) : (
          <div />
        )}
        {next ? (
          <Link
            to="/research/$slug"
            params={{ slug: next.slug }}
            className="group border border-matrix/30 rounded-sm bg-background/40 p-4 hover:border-matrix transition-all text-right"
          >
            <div className="flex items-center justify-end gap-2 text-[0.65rem] uppercase tracking-widest text-matrix-dim">
              Next
              <ArrowRight className="w-3 h-3" />
            </div>
            <div className="mt-1 font-display text-sm text-matrix group-hover:text-glow truncate">
              {next.title}
            </div>
          </Link>
        ) : (
          <div />
        )}
      </div>
    </article>
  );
}
