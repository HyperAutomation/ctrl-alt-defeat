import { createFileRoute, Link } from "@tanstack/react-router";
import { useEffect, useState } from "react";
import { MatrixRain } from "@/components/MatrixRain";
import { TerminalCard } from "@/components/TerminalCard";
import { Button } from "@/components/ui/button";
import { supabase } from "@/integrations/supabase/client";
import { Download, AlertTriangle } from "lucide-react";

export const Route = createFileRoute("/share/$token")({
  head: () => ({
    meta: [
      { title: "Shared file // CTRL-ALT-DEFEAT.UK" },
      { name: "robots", content: "noindex, nofollow" },
    ],
  }),
  component: SharePage,
});

interface ResolvedFile {
  name: string;
  size_bytes: number;
  mime_type: string | null;
  signedUrl: string;
}

function SharePage() {
  const { token } = Route.useParams();
  const [state, setState] = useState<"loading" | "ok" | "error">("loading");
  const [error, setError] = useState("");
  const [file, setFile] = useState<ResolvedFile | null>(null);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const { data: link, error: linkErr } = await supabase
        .from("share_links")
        .select("file_id, expires_at")
        .eq("token", token)
        .maybeSingle();

      if (cancelled) return;
      if (linkErr || !link) {
        setError("This share link is invalid or has expired.");
        setState("error");
        return;
      }
      if (link.expires_at && new Date(link.expires_at) < new Date()) {
        setError("This share link has expired.");
        setState("error");
        return;
      }

      const { data: fileRow, error: fErr } = await supabase
        .from("files")
        .select("name, storage_path, size_bytes, mime_type")
        .eq("id", link.file_id)
        .maybeSingle();

      if (cancelled) return;
      if (fErr || !fileRow) {
        setError("File no longer exists.");
        setState("error");
        return;
      }

      const { data: signed, error: sErr } = await supabase.storage
        .from("team-files")
        .createSignedUrl(fileRow.storage_path, 300);
      if (cancelled) return;
      if (sErr || !signed) {
        setError("Failed to generate download link.");
        setState("error");
        return;
      }

      setFile({
        name: fileRow.name,
        size_bytes: fileRow.size_bytes,
        mime_type: fileRow.mime_type,
        signedUrl: signed.signedUrl,
      });
      setState("ok");
    })();
    return () => {
      cancelled = true;
    };
  }, [token]);

  return (
    <div className="min-h-screen relative crt-flicker">
      <MatrixRain />
      <nav className="relative z-20 border-b border-matrix/20 backdrop-blur-md bg-background/40">
        <div className="max-w-6xl mx-auto px-6 py-4">
          <Link to="/" className="flex items-center gap-2 font-display">
            <span className="text-matrix text-glow text-xl">▌</span>
            <span className="text-foreground tracking-widest text-sm">CTRL-ALT-DEFEAT.UK</span>
          </Link>
        </div>
      </nav>

      <section className="relative z-10 max-w-md mx-auto px-6 pt-20">
        <TerminalCard title="./resolve --token">
          {state === "loading" && (
            <div className="font-mono text-matrix-dim text-sm animate-pulse text-center py-10">
              [ resolving secure handshake... ]
            </div>
          )}
          {state === "error" && (
            <div className="text-center py-6 space-y-3">
              <AlertTriangle className="w-10 h-10 mx-auto text-destructive" />
              <div className="font-mono text-sm text-destructive">{error}</div>
            </div>
          )}
          {state === "ok" && file && (
            <div className="space-y-5">
              <div className="font-mono text-xs text-matrix-dim">▸ asset ready</div>
              <div className="border border-matrix/30 rounded-sm p-4 bg-background/40 space-y-1">
                <div className="font-mono text-foreground break-all">{file.name}</div>
                <div className="text-xs text-matrix-dim font-mono">
                  {(file.size_bytes / 1024).toFixed(1)} KB · {file.mime_type ?? "unknown"}
                </div>
              </div>
              <Button
                asChild
                className="w-full bg-matrix text-primary-foreground hover:bg-matrix-glow font-display tracking-widest uppercase text-sm rounded-sm pulse-glow"
              >
                <a href={file.signedUrl} download={file.name}>
                  <Download className="w-4 h-4" /> Download
                </a>
              </Button>
              <p className="text-xs font-mono text-matrix-dim text-center">
                [ link valid for 5 minutes ]
              </p>
            </div>
          )}
        </TerminalCard>
      </section>
    </div>
  );
}
