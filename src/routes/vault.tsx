import { createFileRoute, useNavigate, Link } from "@tanstack/react-router";
import { useCallback, useEffect, useRef, useState } from "react";
import { MatrixRain } from "@/components/MatrixRain";
import { TerminalCard } from "@/components/TerminalCard";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { useAuth } from "@/hooks/useAuth";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";
import {
  Upload,
  Download,
  Trash2,
  Share2,
  FolderPlus,
  LogOut,
  File as FileIcon,
  Copy,
} from "lucide-react";

export const Route = createFileRoute("/vault")({
  head: () => ({
    meta: [
      { title: "Vault // CTRL-ALT-DEFEAT.UK" },
      { name: "description", content: "Secure team file repository." },
      { name: "robots", content: "noindex, nofollow" },
    ],
  }),
  component: VaultPage,
});

interface FileRow {
  id: string;
  name: string;
  storage_path: string;
  size_bytes: number;
  mime_type: string | null;
  category_id: string | null;
  uploaded_by: string;
  created_at: string;
}

interface CategoryRow {
  id: string;
  name: string;
  description: string | null;
}

function formatBytes(b: number) {
  if (b < 1024) return `${b} B`;
  if (b < 1024 * 1024) return `${(b / 1024).toFixed(1)} KB`;
  if (b < 1024 * 1024 * 1024) return `${(b / 1024 / 1024).toFixed(1)} MB`;
  return `${(b / 1024 / 1024 / 1024).toFixed(2)} GB`;
}

function VaultPage() {
  const { user, loading, signOut } = useAuth();
  const navigate = useNavigate();
  const fileInput = useRef<HTMLInputElement>(null);

  const [categories, setCategories] = useState<CategoryRow[]>([]);
  const [files, setFiles] = useState<FileRow[]>([]);
  const [activeCategory, setActiveCategory] = useState<string | "all">("all");
  const [uploading, setUploading] = useState(false);
  const [newCatOpen, setNewCatOpen] = useState(false);
  const [newCatName, setNewCatName] = useState("");
  const [shareOpen, setShareOpen] = useState(false);
  const [shareUrl, setShareUrl] = useState("");

  useEffect(() => {
    if (!loading && !user) navigate({ to: "/login" });
  }, [loading, user, navigate]);

  const loadData = useCallback(async () => {
    const [catRes, fileRes] = await Promise.all([
      supabase.from("categories").select("*").order("name"),
      supabase.from("files").select("*").order("created_at", { ascending: false }),
    ]);
    if (catRes.error) toast.error(catRes.error.message);
    else setCategories(catRes.data ?? []);
    if (fileRes.error) toast.error(fileRes.error.message);
    else setFiles(fileRes.data ?? []);
  }, []);

  useEffect(() => {
    if (user) loadData();
  }, [user, loadData]);

  const handleUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const fileList = e.target.files;
    if (!fileList || !user) return;
    setUploading(true);
    try {
      for (const file of Array.from(fileList)) {
        const path = `${user.id}/${Date.now()}_${file.name}`;
        const { error: upErr } = await supabase.storage
          .from("team-files")
          .upload(path, file, { contentType: file.type });
        if (upErr) {
          toast.error(`Upload failed: ${upErr.message}`);
          continue;
        }
        const { error: insErr } = await supabase.from("files").insert({
          name: file.name,
          storage_path: path,
          size_bytes: file.size,
          mime_type: file.type || null,
          category_id: activeCategory === "all" ? null : activeCategory,
          uploaded_by: user.id,
        });
        if (insErr) toast.error(insErr.message);
      }
      toast.success("Upload complete.");
      await loadData();
    } finally {
      setUploading(false);
      if (fileInput.current) fileInput.current.value = "";
    }
  };

  const handleDownload = async (f: FileRow) => {
    const { data, error } = await supabase.storage
      .from("team-files")
      .createSignedUrl(f.storage_path, 60);
    if (error || !data) {
      toast.error(error?.message ?? "Download failed");
      return;
    }
    const a = document.createElement("a");
    a.href = data.signedUrl;
    a.download = f.name;
    a.click();
  };

  const handleDelete = async (f: FileRow) => {
    if (!confirm(`Delete ${f.name}?`)) return;
    const { error: stErr } = await supabase.storage.from("team-files").remove([f.storage_path]);
    if (stErr) toast.error(stErr.message);
    const { error } = await supabase.from("files").delete().eq("id", f.id);
    if (error) toast.error(error.message);
    else {
      toast.success("File purged.");
      await loadData();
    }
  };

  const handleShare = async (f: FileRow) => {
    const token = crypto.randomUUID().replace(/-/g, "");
    const { error } = await supabase.from("share_links").insert({
      file_id: f.id,
      token,
      created_by: user!.id,
      expires_at: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString(),
    });
    if (error) {
      toast.error(error.message);
      return;
    }
    const url = `${window.location.origin}/share/${token}`;
    setShareUrl(url);
    setShareOpen(true);
  };

  const handleNewCategory = async () => {
    if (!newCatName.trim() || !user) return;
    const { error } = await supabase.from("categories").insert({
      name: newCatName.trim(),
      created_by: user.id,
    });
    if (error) toast.error(error.message);
    else {
      toast.success("Category created.");
      setNewCatName("");
      setNewCatOpen(false);
      await loadData();
    }
  };

  const filtered =
    activeCategory === "all" ? files : files.filter((f) => f.category_id === activeCategory);

  if (loading || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="font-mono text-matrix text-glow animate-pulse">
          [ decrypting session... ]
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen relative crt-flicker">
      <MatrixRain />

      {/* NAV */}
      <nav className="relative z-20 border-b border-matrix/20 backdrop-blur-md bg-background/60">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
          <Link to="/" className="flex items-center gap-2 font-display">
            <span className="text-matrix text-glow text-xl">▌</span>
            <span className="text-foreground tracking-widest text-sm">CTRL-ALT-DEFEAT.UK / VAULT</span>
          </Link>
          <div className="flex items-center gap-4">
            <span className="hidden sm:inline text-xs font-mono text-matrix-dim">
              {user.email}
            </span>
            <Button
              size="sm"
              variant="outline"
              onClick={() => signOut()}
              className="border-matrix/40 text-matrix hover:bg-matrix/10 font-mono text-xs uppercase tracking-widest"
            >
              <LogOut className="w-3 h-3" /> logout
            </Button>
          </div>
        </div>
      </nav>

      <section className="relative z-10 max-w-7xl mx-auto px-6 py-10">
        <div className="mb-8">
          <div className="text-matrix-dim text-sm font-mono mb-2">// ls -la ./vault</div>
          <h1 className="font-display text-4xl md:text-5xl text-foreground tracking-tight">
            TEAM <span className="text-matrix text-glow">VAULT</span>
          </h1>
          <p className="text-muted-foreground text-sm mt-2 font-mono">
            {files.length} encrypted asset{files.length === 1 ? "" : "s"} · {categories.length}{" "}
            categor{categories.length === 1 ? "y" : "ies"}
          </p>
        </div>

        <TerminalCard title="./vault --interactive">
          {/* Toolbar */}
          <div className="flex flex-wrap items-center gap-3 mb-6">
            <Select value={activeCategory} onValueChange={(v) => setActiveCategory(v)}>
              <SelectTrigger className="w-48 bg-background/60 border-matrix/30 text-matrix font-mono">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-matrix/30">
                <SelectItem value="all">▸ all files</SelectItem>
                {categories.map((c) => (
                  <SelectItem key={c.id} value={c.id}>
                    ▸ {c.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>

            <Dialog open={newCatOpen} onOpenChange={setNewCatOpen}>
              <DialogTrigger asChild>
                <Button
                  size="sm"
                  variant="outline"
                  className="border-matrix/40 text-matrix hover:bg-matrix/10 font-mono text-xs uppercase tracking-widest"
                >
                  <FolderPlus className="w-3 h-3" /> new folder
                </Button>
              </DialogTrigger>
              <DialogContent className="bg-card border-matrix/40">
                <DialogHeader>
                  <DialogTitle className="font-display text-matrix">
                    Create category
                  </DialogTitle>
                </DialogHeader>
                <Input
                  placeholder="e.g. firmware-builds"
                  value={newCatName}
                  onChange={(e) => setNewCatName(e.target.value)}
                  className="font-mono bg-background/60 border-matrix/30 text-matrix"
                />
                <Button
                  onClick={handleNewCategory}
                  className="bg-matrix text-primary-foreground hover:bg-matrix-glow font-display tracking-widest uppercase text-sm"
                >
                  ► Create
                </Button>
              </DialogContent>
            </Dialog>

            <div className="flex-1" />

            <input
              ref={fileInput}
              type="file"
              multiple
              hidden
              onChange={handleUpload}
            />
            <Button
              onClick={() => fileInput.current?.click()}
              disabled={uploading}
              className="bg-matrix text-primary-foreground hover:bg-matrix-glow font-display tracking-widest uppercase text-sm rounded-sm pulse-glow"
            >
              <Upload className="w-4 h-4" /> {uploading ? "uploading..." : "upload"}
            </Button>
          </div>

          {/* Files */}
          {filtered.length === 0 ? (
            <div className="border border-dashed border-matrix/30 rounded-sm p-12 text-center font-mono text-matrix-dim">
              <FileIcon className="w-10 h-10 mx-auto mb-3 opacity-50" />
              [ vault is empty — initiate first upload ]
            </div>
          ) : (
            <div className="space-y-2">
              {filtered.map((f) => {
                const cat = categories.find((c) => c.id === f.category_id);
                const isOwner = f.uploaded_by === user.id;
                return (
                  <div
                    key={f.id}
                    className="group flex flex-wrap items-center gap-3 p-3 border border-matrix/20 rounded-sm bg-background/40 hover:border-matrix/60 hover:bg-matrix/5 transition-all"
                  >
                    <FileIcon className="w-4 h-4 text-matrix shrink-0" />
                    <div className="flex-1 min-w-0">
                      <div className="font-mono text-sm text-foreground truncate">
                        {f.name}
                      </div>
                      <div className="text-xs text-matrix-dim font-mono mt-0.5 flex flex-wrap gap-2">
                        <span>{formatBytes(f.size_bytes)}</span>
                        <span>·</span>
                        <span>{new Date(f.created_at).toLocaleDateString()}</span>
                        {cat && (
                          <>
                            <span>·</span>
                            <span className="text-matrix">[{cat.name}]</span>
                          </>
                        )}
                      </div>
                    </div>
                    <div className="flex items-center gap-1">
                      <Button
                        size="icon"
                        variant="ghost"
                        onClick={() => handleDownload(f)}
                        className="text-matrix hover:bg-matrix/15 hover:text-matrix-glow"
                        aria-label="Download"
                      >
                        <Download className="w-4 h-4" />
                      </Button>
                      <Button
                        size="icon"
                        variant="ghost"
                        onClick={() => handleShare(f)}
                        className="text-matrix hover:bg-matrix/15 hover:text-matrix-glow"
                        aria-label="Share"
                      >
                        <Share2 className="w-4 h-4" />
                      </Button>
                      {isOwner && (
                        <Button
                          size="icon"
                          variant="ghost"
                          onClick={() => handleDelete(f)}
                          className="text-destructive hover:bg-destructive/15"
                          aria-label="Delete"
                        >
                          <Trash2 className="w-4 h-4" />
                        </Button>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </TerminalCard>
      </section>

      {/* Share dialog */}
      <Dialog open={shareOpen} onOpenChange={setShareOpen}>
        <DialogContent className="bg-card border-matrix/40">
          <DialogHeader>
            <DialogTitle className="font-display text-matrix text-glow">
              ► Public share link
            </DialogTitle>
          </DialogHeader>
          <p className="text-xs font-mono text-matrix-dim">
            Expires in 7 days. Anyone with this link can download.
          </p>
          <div className="flex gap-2">
            <Input
              readOnly
              value={shareUrl}
              className="font-mono bg-background/60 border-matrix/30 text-matrix text-xs"
            />
            <Button
              onClick={() => {
                navigator.clipboard.writeText(shareUrl);
                toast.success("Link copied.");
              }}
              className="bg-matrix text-primary-foreground hover:bg-matrix-glow"
            >
              <Copy className="w-4 h-4" />
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
