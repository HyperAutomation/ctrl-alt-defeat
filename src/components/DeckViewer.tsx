import { useEffect, useState, useCallback } from "react";
import { Dialog, DialogContent, DialogTitle } from "@/components/ui/dialog";
import { ChevronLeft, ChevronRight, X, Maximize2 } from "lucide-react";

// Eagerly import all slide images so Vite bundles & fingerprints them.
// Using import.meta.glob avoids one import line per slide and keeps order.
const slideModules = import.meta.glob<{ default: string }>(
  "../assets/deck/slide-*.jpg",
  { eager: true },
);

const slides = Object.entries(slideModules)
  .sort(([a], [b]) => {
    const na = parseInt(a.match(/slide-(\d+)/)?.[1] ?? "0", 10);
    const nb = parseInt(b.match(/slide-(\d+)/)?.[1] ?? "0", 10);
    return na - nb;
  })
  .map(([, mod]) => mod.default);

const TOTAL_SLIDES = slides.length;

interface DeckViewerProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export function DeckViewer({ open, onOpenChange }: DeckViewerProps) {
  const [index, setIndex] = useState(0);

  const next = useCallback(() => setIndex((i) => Math.min(i + 1, TOTAL_SLIDES - 1)), []);
  const prev = useCallback(() => setIndex((i) => Math.max(i - 1, 0)), []);

  useEffect(() => {
    if (!open) return;
    const handler = (e: KeyboardEvent) => {
      if (e.key === "ArrowRight" || e.key === " ") next();
      if (e.key === "ArrowLeft") prev();
    };
    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [open, next, prev]);

  useEffect(() => {
    if (open) setIndex(0);
  }, [open]);

  const requestFullscreen = () => {
    const el = document.getElementById("deck-stage");
    if (el?.requestFullscreen) el.requestFullscreen();
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-[98vw] sm:max-w-[95vw] md:max-w-6xl w-[98vw] h-[95vh] p-0 bg-background border-matrix/40 border shadow-[0_0_40px_rgba(0,255,65,0.15)] flex flex-col overflow-hidden">
        <DialogTitle className="sr-only">AI for UK MOD Test &amp; Evaluation — Deck Viewer</DialogTitle>

        {/* Terminal header */}
        <div className="flex items-center justify-between px-4 py-2 border-b border-matrix/30 bg-card/60 font-mono text-xs shrink-0">
          <div className="flex items-center gap-2 text-matrix-dim min-w-0">
            <span className="w-2 h-2 rounded-full bg-matrix animate-pulse shrink-0" />
            <span className="uppercase tracking-widest truncate">
              ./deck --load ai_mod_t&amp;e_executive_summary.pptx
            </span>
          </div>
          <div className="flex items-center gap-3 text-matrix-dim shrink-0">
            <button
              onClick={requestFullscreen}
              className="hover:text-matrix transition-colors"
              aria-label="Fullscreen"
            >
              <Maximize2 className="w-4 h-4" />
            </button>
            <button
              onClick={() => onOpenChange(false)}
              className="hover:text-matrix transition-colors"
              aria-label="Close"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Stage — flex-1 so it shrinks to fit available height */}
        <div
          id="deck-stage"
          className="relative bg-black flex items-center justify-center select-none flex-1 min-h-0 overflow-hidden"
        >
          {slides.map((src, i) => (
            <img
              key={src}
              src={src}
              alt={`Slide ${i + 1}`}
              draggable={false}
              className={`absolute inset-0 w-full h-full object-contain transition-opacity duration-300 ${
                i === index ? "opacity-100" : "opacity-0 pointer-events-none"
              }`}
            />
          ))}

          {/* Prev/Next overlay buttons */}
          <button
            onClick={prev}
            disabled={index === 0}
            aria-label="Previous slide"
            className="absolute left-3 top-1/2 -translate-y-1/2 p-2 rounded-sm border border-matrix/40 bg-background/70 text-matrix hover:bg-matrix/10 hover:border-matrix transition-all disabled:opacity-20 disabled:cursor-not-allowed z-10"
          >
            <ChevronLeft className="w-6 h-6" />
          </button>
          <button
            onClick={next}
            disabled={index === TOTAL_SLIDES - 1}
            aria-label="Next slide"
            className="absolute right-3 top-1/2 -translate-y-1/2 p-2 rounded-sm border border-matrix/40 bg-background/70 text-matrix hover:bg-matrix/10 hover:border-matrix transition-all disabled:opacity-20 disabled:cursor-not-allowed z-10"
          >
            <ChevronRight className="w-6 h-6" />
          </button>
        </div>

        {/* Footer: thumbnails + counter */}
        <div className="border-t border-matrix/30 bg-card/60 px-4 py-3 shrink-0">
          <div className="flex items-center justify-between mb-3 font-mono text-xs">
            <div className="text-matrix-dim">
              <span className="text-matrix">$</span> slide{" "}
              <span className="text-matrix">{String(index + 1).padStart(2, "0")}</span> /{" "}
              {String(TOTAL_SLIDES).padStart(2, "0")}
            </div>
            <div className="text-matrix-dim hidden md:block uppercase tracking-widest">
              ← → to navigate · esc to close
            </div>
          </div>
          <div className="flex gap-2 overflow-x-auto pb-1">
            {slides.map((src, i) => (
              <button
                key={src}
                onClick={() => setIndex(i)}
                aria-label={`Go to slide ${i + 1}`}
                className={`relative shrink-0 rounded-sm overflow-hidden border transition-all ${
                  i === index
                    ? "border-matrix shadow-[0_0_12px_rgba(0,255,65,0.5)]"
                    : "border-matrix/20 opacity-60 hover:opacity-100 hover:border-matrix/60"
                }`}
                style={{ width: 80, height: 45 }}
              >
                <img src={src} alt="" className="w-full h-full object-cover" draggable={false} />
                <span className="absolute bottom-0 right-0 px-1 text-[9px] font-mono bg-background/80 text-matrix">
                  {i + 1}
                </span>
              </button>
            ))}
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
