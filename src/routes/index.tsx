import { createFileRoute, Link } from "@tanstack/react-router";
import { useState } from "react";
import { MatrixRain } from "@/components/MatrixRain";
import { TerminalCard } from "@/components/TerminalCard";
import { GithubIcon } from "@/components/GithubIcon";
import { DeckViewer } from "@/components/DeckViewer";
import { useAuth } from "@/hooks/useAuth";
import { Lock, FolderLock } from "lucide-react";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "CTRL-ALT-DEFEAT.UK — Hackathon Team" },
      { name: "description", content: "We test the simulation. UK hackathon team building open-source tools at the edge of reality." },
      { property: "og:title", content: "CTRL-ALT-DEFEAT.UK — Hackathon Team" },
      { property: "og:description", content: "We test the simulation. UK hackathon team building open-source tools at the edge of reality." },
    ],
  }),
  component: Index,
});

const team = [
  { handle: "neo_void", role: "Full-Stack Architect", desc: "Bends TypeScript like spoons.", glyph: "01" },
  { handle: "trinity_x", role: "AI / ML Engineer", desc: "Trains models that dream.", glyph: "02" },
  { handle: "morpheus.sh", role: "Infra & DevOps", desc: "Lives inside the kernel.", glyph: "03" },
  { handle: "oracle_dev", role: "Design Engineer", desc: "Sees the UI before you do.", glyph: "04" },
];

const projects = [
  {
    name: "ctrl-alt-defeat",
    tagline: "Main project repo — AI-assisted system testing toolkit & mission control.",
    stack: ["TypeScript", "React", "Vite"],
    repo: "https://github.com/HyperAutomation/ctrl-alt-defeat",
    stars: "—",
    primary: true,
  },
  {
    name: "ado-mcp",
    tagline: "MCP server for Azure DevOps — bringing ADO directly to your AI agents.",
    stack: ["MCP", "Azure DevOps", "TypeScript"],
    repo: "https://github.com/HyperAutomation/ado-mcp",
    stars: "0",
  },
  {
    name: "Figma-MCP",
    tagline: "MCP server providing Figma layout context to AI coding agents like Cursor.",
    stack: ["MCP", "Figma", "AI"],
    repo: "https://github.com/HyperAutomation/Figma-MCP",
    stars: "1",
  },
  {
    name: "boa-constrictor",
    tagline: "C# Screenplay Pattern for Web UI & REST API test automation.",
    stack: ["C#", ".NET", "Selenium"],
    repo: "https://github.com/HyperAutomation/boa-constrictor",
    stars: "1",
  },
  {
    name: "healenium-web",
    tagline: "Self-healing library for Selenium Web-based tests.",
    stack: ["Java", "Selenium", "ML"],
    repo: "https://github.com/HyperAutomation/healenium-web",
    stars: "1",
  },
  {
    name: "Selenium-Machine-Learning",
    tagline: "Machine learning experiments with Selenium and TensorFlow.",
    stack: ["Python", "TensorFlow", "Selenium"],
    repo: "https://github.com/HyperAutomation/Selenium-Machine-Learning",
    stars: "1",
  },
  {
    name: "evosuite",
    tagline: "Automated generation of JUnit test suites for Java classes.",
    stack: ["Java", "JUnit", "EvoSuite"],
    repo: "https://github.com/HyperAutomation/evosuite",
    stars: "0",
  },
  {
    name: "playwright",
    tagline: "Node.js library to automate Chromium, Firefox & WebKit with one API.",
    stack: ["TypeScript", "Node.js", "E2E"],
    repo: "https://github.com/HyperAutomation/playwright",
    stars: "3",
  },
];

function Index() {
  const { session } = useAuth();
  const [deckOpen, setDeckOpen] = useState(false);
  return (
    <div className="min-h-screen relative overflow-x-hidden crt-flicker">
      <DeckViewer open={deckOpen} onOpenChange={setDeckOpen} />
      <MatrixRain />

      {/* NAV */}
      <nav className="relative z-20 border-b border-matrix/20 backdrop-blur-md bg-background/40">
        <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
          <div className="flex items-center gap-2 font-display">
            <span className="text-matrix text-glow text-xl">▌</span>
            <span className="text-foreground tracking-widest text-sm">CTRL-ALT-DEFEAT.UK</span>
          </div>
          <div className="hidden md:flex items-center gap-8 text-xs uppercase tracking-widest text-muted-foreground">
            <button type="button" onClick={() => setDeckOpen(true)} className="hover:text-matrix transition-colors glitch uppercase tracking-widest">~/mission</button>
            
            <a href="#repos" className="hover:text-matrix transition-colors glitch">~/REPOS</a>
            <Link to="/research" className="hover:text-matrix transition-colors glitch">~/research</Link>
            
          </div>
          <Link
            to={session ? "/vault" : "/login"}
            className="flex items-center gap-2 px-3 py-1.5 border border-matrix/50 rounded-sm text-xs text-matrix hover:bg-matrix/10 hover:border-glow transition-all font-display uppercase tracking-widest"
          >
            {session ? <FolderLock className="w-4 h-4" /> : <Lock className="w-4 h-4" />}
            {session ? "vault" : "secure access"}
          </Link>
        </div>
      </nav>

      {/* HERO */}
      <section className="relative z-10 max-w-6xl mx-auto px-6 pt-24 pb-32">
        <div className="space-y-8 float-up">
          <div className="font-mono text-sm text-matrix-dim">
            <span className="text-matrix">$</span> ./initialize --team=ctrl-alt-defeat --region=uk --year=2026
          </div>

          <h1 className="font-display text-5xl md:text-7xl lg:text-8xl leading-none tracking-tight">
            <span className="block text-foreground">WE TEST</span>
            <span className="block text-matrix text-glow-strong">THE AGENTS.</span>
          </h1>

          <div className="max-w-2xl text-lg text-muted-foreground leading-relaxed">
            <p className="typewriter inline-block">
              A UK hackathon collective helping apply Artificial Intelligence for System Testing
            </p>
          </div>

          <div className="flex flex-wrap gap-4 pt-4">
            <a
              href="https://github.com/HyperAutomation/ctrl-alt-defeat"
              target="_blank"
              rel="noopener noreferrer"
              className="group inline-flex items-center gap-3 px-6 py-3 bg-matrix text-primary-foreground font-display tracking-widest text-sm uppercase rounded-sm pulse-glow hover:bg-matrix-glow transition-colors"
            >
              <span>~/REPOS</span>
            </a>
            <Link
              to="/user-story"
              className="inline-flex items-center gap-3 px-6 py-3 border border-matrix/50 text-matrix font-display tracking-widest text-sm uppercase rounded-sm hover:bg-matrix/10 transition-colors glitch"
            >
              ► AI User Story
            </Link>
            <Link
              to="/ai-requirements"
              className="inline-flex items-center gap-3 px-6 py-3 border border-matrix/50 text-matrix font-display tracking-widest text-sm uppercase rounded-sm hover:bg-matrix/10 transition-colors glitch"
            >
              ► AI Requirements
            </Link>
            <Link
              to="/research"
              className="inline-flex items-center gap-3 px-6 py-3 border border-matrix/50 text-matrix font-display tracking-widest text-sm uppercase rounded-sm hover:bg-matrix/10 transition-colors glitch"
            >
              ► AI Research
            </Link>
            <button
              type="button"
              onClick={() => setDeckOpen(true)}
              className="inline-flex items-center gap-3 px-6 py-3 border border-matrix/50 text-matrix font-display tracking-widest text-sm uppercase rounded-sm hover:bg-matrix/10 transition-colors glitch"
            >
              ► AI Mission Deck
            </button>
            <a
              href="/WDR-AIAssurance-Guide.pdf"
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-3 px-6 py-3 border border-matrix/50 text-matrix font-display tracking-widest text-sm uppercase rounded-sm hover:bg-matrix/10 transition-colors glitch"
            >
              ► AI Assurance
            </a>
          </div>

          <div className="grid grid-cols-3 gap-4 pt-12 max-w-xl">
            {[
              { n: "12", l: "Hackathons" },
              { n: "9", l: "Wins" },
              { n: "8.2k", l: "★ on GitHub" },
            ].map((s) => (
              <div key={s.l} className="border-l-2 border-matrix pl-4">
                <div className="font-display text-3xl md:text-4xl text-matrix text-glow">{s.n}</div>
                <div className="text-xs uppercase tracking-widest text-muted-foreground mt-1">{s.l}</div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* MISSION */}
      <section id="mission" className="relative z-10 max-w-6xl mx-auto px-6 py-20">
        <TerminalCard title="cat ./mission.txt">
          <pre className="text-matrix font-mono text-sm md:text-base leading-relaxed whitespace-pre-wrap">
{`> Welcome to the Matrix

  We build software like it's a heist.
  48 hours. No sleep. Real shipping.

  Our weapons: open source, type safety,
  edge runtimes, and an unhealthy amount
  of caffeine.

  Every project below is MIT licensed.
  Fork it. Break it. Ship something better.

> _`}
          </pre>
        </TerminalCard>
      </section>

      {/* REPOS */}
      <section id="repos" className="relative z-10 max-w-6xl mx-auto px-6 py-20">
        <div className="mb-12 flex items-end justify-between flex-wrap gap-4">
          <div>
            <div className="text-matrix-dim text-sm font-mono mb-2">// ls ./projects</div>
            <h2 className="font-display text-4xl md:text-5xl text-foreground tracking-tight">
              OPEN <span className="text-matrix text-glow">REPOS</span>
            </h2>
          </div>
          <div className="text-xs uppercase tracking-widest text-muted-foreground">
            {projects.length} repositories — all MIT
          </div>
        </div>

        <div className="grid md:grid-cols-2 gap-5">
          {projects.map((p, i) => (
            <a
              key={p.name}
              href={p.repo}
              target="_blank"
              rel="noreferrer"
              className={`group relative block bg-card/60 backdrop-blur-sm border ${p.primary ? "border-matrix border-glow md:col-span-2" : "border-matrix/30"} rounded-md p-6 hover:border-matrix hover:border-glow transition-all hover:-translate-y-1 overflow-hidden float-up`}
              style={{ animationDelay: `${i * 80}ms` }}
            >
              {/* corner glyph */}
              <div className="absolute -top-6 -right-6 font-display text-7xl text-matrix/5 group-hover:text-matrix/15 transition-colors">
                {String(i + 1).padStart(2, "0")}
              </div>

              <div className="flex items-start justify-between gap-3 mb-3">
                <div className="flex items-center gap-2 font-display text-xl text-matrix">
                  <span className="text-matrix-dim">›</span>
                  <span className="glitch">{p.name}</span>
                </div>
                <div className="flex items-center gap-1 text-xs text-matrix-dim">
                  <span>★</span> {p.stars}
                </div>
              </div>

              <p className="text-sm text-foreground/80 leading-relaxed mb-5">{p.tagline}</p>

              <div className="flex items-center justify-between flex-wrap gap-3">
                <div className="flex flex-wrap gap-1.5">
                  {p.stack.map((s) => (
                    <span
                      key={s}
                      className="text-[10px] uppercase tracking-widest px-2 py-1 border border-matrix/30 text-matrix/80 rounded-sm bg-matrix/5"
                    >
                      {s}
                    </span>
                  ))}
                </div>
                <div className="flex items-center gap-2 text-xs text-matrix group-hover:text-matrix-glow transition-colors">
                  <GithubIcon className="w-4 h-4" />
                  <span className="uppercase tracking-widest">view repo →</span>
                </div>
              </div>
            </a>
          ))}
        </div>
      </section>

      {/* CONTACT */}
      <section id="contact" className="relative z-10 max-w-6xl mx-auto px-6 py-24">
            <TerminalCard title="./contact --establish-connection">
          <div className="space-y-6 font-mono">
            <div className="text-matrix">
              <span className="text-matrix-dim">root@ctrl-alt-defeat:~$</span> echo "let's build something"
            </div>
            <h3 className="font-display text-3xl md:text-5xl text-foreground">
              JOIN THE <span className="text-matrix text-glow">RESISTANCE</span>
            </h3>
            <p className="text-muted-foreground max-w-xl">
              Hackathons, sponsorships, collabs, or just to say hi — open a channel.
            </p>
            <div className="flex flex-wrap gap-3 pt-2">
              <a
                href="mailto:crew@ctrl-alt-defeat.uk"
                className="inline-flex items-center gap-3 px-5 py-3 bg-matrix text-primary-foreground font-display tracking-widest text-sm uppercase rounded-sm hover:bg-matrix-glow transition-colors"
              >
                ► crew@ctrl-alt-defeat.uk
              </a>
              <a
                href="https://github.com/HyperAutomation"
                target="_blank"
                rel="noreferrer"
                className="inline-flex items-center gap-2 px-5 py-3 border border-matrix/50 text-matrix font-display tracking-widest text-sm uppercase rounded-sm hover:bg-matrix/10 transition-colors"
              >
                <GithubIcon className="w-4 h-4" /> /HyperAutomation
              </a>
            </div>
          </div>
        </TerminalCard>
      </section>

      {/* FOOTER */}
      <footer className="relative z-10 border-t border-matrix/20 mt-12">
        <div className="max-w-6xl mx-auto px-6 py-6 flex flex-wrap items-center justify-between gap-3 text-xs text-matrix-dim font-mono">
          <div>© 2026 CTRL-ALT-DEFEAT.UK — There is no spoon.</div>
          <div className="flex items-center gap-2">
            <span className="w-2 h-2 rounded-full bg-matrix animate-pulse" />
            <span>system online · uplink stable</span>
          </div>
        </div>
      </footer>
    </div>
  );
}
