import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";

export function ResearchMarkdown({ source }: { source: string }) {
  return (
    <div className="research-prose font-mono text-sm leading-relaxed text-foreground/90">
      <ReactMarkdown
        remarkPlugins={[remarkGfm]}
        components={{
          h1: ({ children }) => (
            <h1 className="font-display text-3xl md:text-4xl text-matrix text-glow tracking-wide mt-2 mb-6 border-b border-matrix/30 pb-3">
              {children}
            </h1>
          ),
          h2: ({ children }) => (
            <h2 className="font-display text-2xl text-matrix mt-10 mb-4 flex items-center gap-2">
              <span className="text-matrix-dim">▌</span>
              {children}
            </h2>
          ),
          h3: ({ children }) => (
            <h3 className="font-display text-lg text-matrix-glow mt-6 mb-3 uppercase tracking-widest">
              {children}
            </h3>
          ),
          h4: ({ children }) => (
            <h4 className="font-display text-base text-matrix mt-4 mb-2 uppercase tracking-wider">
              {children}
            </h4>
          ),
          p: ({ children }) => <p className="my-3 text-foreground/85">{children}</p>,
          a: ({ children, href }) => (
            <a
              href={href}
              target={href?.startsWith("http") ? "_blank" : undefined}
              rel="noreferrer noopener"
              className="text-matrix underline decoration-matrix/40 underline-offset-2 hover:text-glow hover:decoration-matrix transition-all"
            >
              {children}
            </a>
          ),
          ul: ({ children }) => (
            <ul className="my-3 ml-5 list-none space-y-1.5">{children}</ul>
          ),
          ol: ({ children }) => (
            <ol className="my-3 ml-6 list-decimal space-y-1.5 marker:text-matrix">{children}</ol>
          ),
          li: ({ children }) => (
            <li className="relative pl-4 before:absolute before:left-0 before:top-2 before:h-1 before:w-1 before:bg-matrix before:shadow-[0_0_4px_var(--color-matrix)]">
              {children}
            </li>
          ),
          strong: ({ children }) => (
            <strong className="text-matrix-glow font-semibold">{children}</strong>
          ),
          em: ({ children }) => <em className="text-matrix-dim italic">{children}</em>,
          hr: () => (
            <hr className="my-8 border-0 h-px bg-gradient-to-r from-transparent via-matrix/40 to-transparent" />
          ),
          blockquote: ({ children }) => (
            <blockquote className="my-4 border-l-2 border-matrix/60 bg-matrix/5 px-4 py-2 italic text-foreground/75">
              {children}
            </blockquote>
          ),
          code: ({ children, className }) => {
            const isBlock = className?.includes("language-");
            if (isBlock) {
              return (
                <code className="block bg-black/60 border border-matrix/30 rounded-sm p-4 text-xs text-matrix overflow-x-auto whitespace-pre">
                  {children}
                </code>
              );
            }
            return (
              <code className="px-1.5 py-0.5 bg-matrix/10 border border-matrix/20 rounded-sm text-matrix-glow text-[0.85em]">
                {children}
              </code>
            );
          },
          pre: ({ children }) => <pre className="my-4">{children}</pre>,
          table: ({ children }) => (
            <div className="my-5 overflow-x-auto border border-matrix/30 rounded-sm">
              <table className="w-full text-xs">{children}</table>
            </div>
          ),
          thead: ({ children }) => (
            <thead className="bg-matrix/10 border-b border-matrix/40">{children}</thead>
          ),
          th: ({ children }) => (
            <th className="px-3 py-2 text-left font-display text-matrix uppercase tracking-wider text-[0.75rem]">
              {children}
            </th>
          ),
          td: ({ children }) => (
            <td className="px-3 py-2 border-t border-matrix/15 text-foreground/80 align-top">
              {children}
            </td>
          ),
        }}
      >
        {source}
      </ReactMarkdown>
    </div>
  );
}
