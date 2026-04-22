import { createFileRoute, Link, Outlet, useLocation } from "@tanstack/react-router";
import { MatrixRain } from "@/components/MatrixRain";
import { RESEARCH } from "@/content/research";
import { BookOpen, ChevronRight } from "lucide-react";

export const Route = createFileRoute("/research")({
  head: () => ({
    meta: [
      { title: "AI Research — CTRL-ALT-DEFEAT.UK" },
      {
        name: "description",
        content:
          "Wiki-style knowledge base of UK MOD AI use cases across weapons qualification, fragmentation trials and uncrewed autonomous systems testing.",
      },
      { property: "og:title", content: "AI Research — CTRL-ALT-DEFEAT.UK" },
      {
        property: "og:description",
        content:
          "UK MOD AI/ML research briefing — JSP 936, AMLAS, STANAGs, surrogate models, PINNs, digital twins.",
      },
    ],
  }),
  component: ResearchLayout,
});

function ResearchLayout() {
  const location = useLocation();
  const activeSlug = location.pathname.split("/research/")[1] ?? "";

  return (
    <div className="min-h-screen relative overflow-x-hidden crt-flicker">
      <MatrixRain />

      {/* NAV */}
      <nav className="relative z-20 border-b border-matrix/20 backdrop-blur-md bg-background/60">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
          <Link to="/" className="flex items-center gap-2 font-display group">
            <span className="text-matrix text-glow text-xl group-hover:animate-pulse">▌</span>
            <span className="text-foreground tracking-widest text-sm">CTRL-ALT-DEFEAT.UK</span>
          </Link>
          <div className="hidden md:flex items-center gap-6 text-xs uppercase tracking-widest text-muted-foreground">
            <Link to="/" className="hover:text-matrix transition-colors glitch">
              ~/home
            </Link>
            <Link
              to="/research"
              activeOptions={{ exact: true }}
              activeProps={{ className: "text-matrix text-glow" }}
              className="hover:text-matrix transition-colors glitch"
            >
              ~/research
            </Link>
          </div>
        </div>
      </nav>

      <div className="relative z-10 max-w-7xl mx-auto px-4 md:px-6 py-8">
        {/* Section header */}
        <header className="mb-8 border-b border-matrix/20 pb-6">
          <div className="flex items-center gap-3 text-xs uppercase tracking-widest text-matrix-dim">
            <BookOpen className="w-3.5 h-3.5" />
            <span>knowledge_base / classified: UNCLASSIFIED</span>
          </div>
          <h1 className="mt-2 font-display text-3xl md:text-5xl text-matrix text-glow tracking-wider">
            AI&nbsp;RESEARCH
          </h1>
          <p className="mt-3 text-sm text-muted-foreground max-w-3xl">
            Wiki-style briefing on UK MOD applications of artificial intelligence and machine
            learning across defence test &amp; evaluation. Compiled from open-source UK
            public-domain sources.
          </p>
        </header>

        <div className="grid grid-cols-1 lg:grid-cols-[260px_1fr] gap-8">
          {/* Sidebar */}
          <aside className="lg:sticky lg:top-6 lg:self-start">
            <div className="border border-matrix/30 rounded-sm bg-background/40 backdrop-blur-sm p-4 border-glow">
              <div className="text-[0.7rem] uppercase tracking-widest text-matrix-dim mb-3 font-display">
                ~/articles
              </div>
              <nav className="flex flex-col gap-1">
                <SidebarLink to="/research" exact label="Index" code="--" activeSlug={activeSlug} matchEmpty />
                {RESEARCH.map((entry) => (
                  <SidebarLink
                    key={entry.slug}
                    to={`/research/${entry.slug}`}
                    label={entry.title}
                    code={entry.code}
                    activeSlug={activeSlug}
                    matchSlug={entry.slug}
                  />
                ))}
              </nav>
            </div>
          </aside>

          {/* Content */}
          <main className="min-w-0">
            <Outlet />
          </main>
        </div>
      </div>
    </div>
  );
}

function SidebarLink({
  to,
  label,
  code,
  activeSlug,
  matchEmpty,
  matchSlug,
  exact,
}: {
  to: string;
  label: string;
  code: string;
  activeSlug: string;
  matchEmpty?: boolean;
  matchSlug?: string;
  exact?: boolean;
}) {
  const isActive = matchEmpty ? activeSlug === "" : matchSlug === activeSlug;
  return (
    <Link
      to={to}
      activeOptions={exact ? { exact: true } : undefined}
      className={`group flex items-center gap-2 px-2 py-1.5 rounded-sm text-xs font-mono transition-all ${
        isActive
          ? "bg-matrix/15 text-matrix text-glow border-l-2 border-matrix"
          : "text-muted-foreground hover:text-matrix hover:bg-matrix/5 border-l-2 border-transparent"
      }`}
    >
      <span className="text-matrix-dim group-hover:text-matrix font-display w-6 shrink-0">
        {code}
      </span>
      <span className="truncate">{label}</span>
      <ChevronRight className="ml-auto w-3 h-3 opacity-0 group-hover:opacity-100 transition-opacity" />
    </Link>
  );
}
