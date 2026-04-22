import type { ReactNode } from "react";

interface TerminalCardProps {
  title: string;
  children: ReactNode;
  className?: string;
}

export function TerminalCard({ title, children, className = "" }: TerminalCardProps) {
  return (
    <div className={`relative bg-card/70 backdrop-blur-sm border border-matrix/40 rounded-md border-glow scanlines overflow-hidden ${className}`}>
      <div className="flex items-center gap-2 px-4 py-2 border-b border-matrix/30 bg-matrix/5">
        <span className="w-2.5 h-2.5 rounded-full bg-destructive/70" />
        <span className="w-2.5 h-2.5 rounded-full bg-yellow-500/60" />
        <span className="w-2.5 h-2.5 rounded-full bg-matrix/80" />
        <span className="ml-3 text-xs text-matrix/70 font-mono tracking-wider uppercase">
          {title}
        </span>
      </div>
      <div className="p-6 relative z-10">{children}</div>
    </div>
  );
}
