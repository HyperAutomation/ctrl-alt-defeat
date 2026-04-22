import { createFileRoute, Link } from "@tanstack/react-router";
import { MatrixRain } from "@/components/MatrixRain";

export const Route = createFileRoute("/ai-context")({
  head: () => ({
    meta: [
      { title: "AI Context Graph — CTRL-ALT-DEFEAT.UK" },
      { name: "description", content: "Interactive force-directed graph of AI context — 196 nodes, 200 edges across 27 communities." },
      { property: "og:title", content: "AI Context Graph — CTRL-ALT-DEFEAT.UK" },
      { property: "og:description", content: "Interactive force-directed graph of AI context — 196 nodes, 200 edges across 27 communities." },
    ],
  }),
  component: AiContextPage,
});

function AiContextPage() {
  return (
    <div className="min-h-screen relative overflow-hidden crt-flicker flex flex-col">
      <MatrixRain />

      <nav className="relative z-20 border-b border-matrix/20 backdrop-blur-md bg-background/40 shrink-0">
        <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
          <Link to="/" className="flex items-center gap-2 font-display hover:text-matrix transition-colors">
            <span className="text-matrix text-glow text-xl">▌</span>
            <span className="text-foreground tracking-widest text-sm">CTRL-ALT-DEFEAT.UK</span>
          </Link>
          <Link
            to="/"
            className="text-xs uppercase tracking-widest text-matrix hover:text-matrix-glow transition-colors font-display"
          >
            ← back to base
          </Link>
        </div>
      </nav>

      <section className="relative z-10 max-w-6xl w-full mx-auto px-6 pt-10 pb-4 shrink-0">
        <div className="text-matrix-dim text-sm font-mono mb-2">// ./graphify --render</div>
        <h1 className="font-display text-4xl md:text-5xl text-foreground tracking-tight">
          AI <span className="text-matrix text-glow">CONTEXT</span>
        </h1>
        <p className="text-sm text-muted-foreground mt-3 max-w-2xl">
          Interactive force-directed graph — 196 nodes · 200 edges · 27 communities. Click nodes to inspect, search to locate, click legend to filter.
        </p>
      </section>

      <section className="relative z-10 max-w-6xl w-full mx-auto px-6 pb-10 flex-1 min-h-0">
        <div className="border border-matrix/40 rounded-md overflow-hidden bg-card/40 backdrop-blur-sm h-[75vh]">
          <iframe
            src="/ai-context/graph.html"
            title="AI Context Graph"
            className="w-full h-full border-0"
          />
        </div>
      </section>
    </div>
  );
}
