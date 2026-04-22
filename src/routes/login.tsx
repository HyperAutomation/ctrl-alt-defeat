import { createFileRoute, useNavigate, Link } from "@tanstack/react-router";
import { useEffect, useState, type FormEvent } from "react";
import { MatrixRain } from "@/components/MatrixRain";
import { TerminalCard } from "@/components/TerminalCard";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { useAuth } from "@/hooks/useAuth";
import { toast } from "sonner";

export const Route = createFileRoute("/login")({
  head: () => ({
    meta: [
      { title: "Secure Access // CTRL-ALT-DEFEAT.UK" },
      { name: "description", content: "Authenticate to access the team's secure file vault." },
      { property: "og:title", content: "Secure Access // CTRL-ALT-DEFEAT.UK" },
      { property: "og:description", content: "Sign in with @keysight.com email or Google SSO." },
    ],
  }),
  component: LoginPage,
});

function LoginPage() {
  const { session, loading, signInEmail, signUpEmail, signInWithGoogle } = useAuth();
  const navigate = useNavigate();
  const [busy, setBusy] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  useEffect(() => {
    if (!loading && session) {
      navigate({ to: "/vault" });
    }
  }, [loading, session, navigate]);

  const handleSubmit = async (mode: "in" | "up") => async (e: FormEvent) => {
    e.preventDefault();
    setBusy(true);
    const fn = mode === "in" ? signInEmail : signUpEmail;
    const { error } = await fn(email, password);
    setBusy(false);
    if (error) {
      toast.error(error);
      return;
    }
    toast.success(mode === "in" ? "Access granted." : "Account provisioned. Welcome.");
  };

  const handleGoogle = async () => {
    setBusy(true);
    const { error } = await signInWithGoogle();
    if (error) {
      toast.error(error);
      setBusy(false);
    }
  };

  return (
    <div className="min-h-screen relative overflow-hidden crt-flicker">
      <MatrixRain />

      <nav className="relative z-20 border-b border-matrix/20 backdrop-blur-md bg-background/40">
        <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
          <Link to="/" className="flex items-center gap-2 font-display">
            <span className="text-matrix text-glow text-xl">▌</span>
            <span className="text-foreground tracking-widest text-sm">CTRL-ALT-DEFEAT.UK</span>
          </Link>
          <Link to="/" className="text-xs uppercase tracking-widest text-muted-foreground hover:text-matrix transition-colors">
            ← back
          </Link>
        </div>
      </nav>

      <section className="relative z-10 max-w-md mx-auto px-6 pt-16 pb-24">
        <div className="mb-6 font-mono text-sm text-matrix-dim text-center">
          <span className="text-matrix">$</span> ./auth --secure --domain=keysight.com
        </div>
        <h1 className="font-display text-4xl text-foreground tracking-tight text-center mb-2">
          SECURE <span className="text-matrix text-glow">ACCESS</span>
        </h1>
        <p className="text-center text-muted-foreground text-sm mb-8 font-mono">
          Vault entry restricted to <span className="text-matrix">@keysight.com</span>
        </p>

        <TerminalCard title="./authenticate">
          <Tabs defaultValue="signin" className="w-full">
            <TabsList className="grid w-full grid-cols-2 bg-matrix/5 border border-matrix/20">
              <TabsTrigger value="signin" className="data-[state=active]:bg-matrix/20 data-[state=active]:text-matrix font-mono text-xs uppercase tracking-widest">
                Sign In
              </TabsTrigger>
              <TabsTrigger value="signup" className="data-[state=active]:bg-matrix/20 data-[state=active]:text-matrix font-mono text-xs uppercase tracking-widest">
                Register
              </TabsTrigger>
            </TabsList>

            {(["signin", "signup"] as const).map((mode) => (
              <TabsContent key={mode} value={mode} className="space-y-4 mt-6">
                <form onSubmit={handleSubmit(mode === "signin" ? "in" : "up")} className="space-y-4">
                  <div className="space-y-1.5">
                    <Label htmlFor={`${mode}-email`} className="font-mono text-xs text-matrix-dim uppercase tracking-widest">
                      ▸ email
                    </Label>
                    <Input
                      id={`${mode}-email`}
                      type="email"
                      required
                      placeholder="agent@keysight.com"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      className="font-mono bg-background/60 border-matrix/30 text-matrix focus-visible:ring-matrix focus-visible:border-matrix"
                    />
                  </div>
                  <div className="space-y-1.5">
                    <Label htmlFor={`${mode}-pw`} className="font-mono text-xs text-matrix-dim uppercase tracking-widest">
                      ▸ passphrase
                    </Label>
                    <Input
                      id={`${mode}-pw`}
                      type="password"
                      required
                      minLength={8}
                      placeholder="••••••••"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      className="font-mono bg-background/60 border-matrix/30 text-matrix focus-visible:ring-matrix focus-visible:border-matrix"
                    />
                  </div>
                  <Button
                    type="submit"
                    disabled={busy}
                    className="w-full bg-matrix text-primary-foreground hover:bg-matrix-glow font-display tracking-widest uppercase text-sm rounded-sm pulse-glow"
                  >
                    {busy ? "..." : mode === "signin" ? "► Decrypt Session" : "► Provision Identity"}
                  </Button>
                </form>
              </TabsContent>
            ))}
          </Tabs>

          <div className="relative my-6">
            <div className="absolute inset-0 flex items-center">
              <span className="w-full border-t border-matrix/20" />
            </div>
            <div className="relative flex justify-center text-xs uppercase tracking-widest">
              <span className="bg-card px-2 text-matrix-dim font-mono">or // SSO</span>
            </div>
          </div>

          <Button
            type="button"
            onClick={handleGoogle}
            disabled={busy}
            variant="outline"
            className="w-full border-matrix/40 text-matrix hover:bg-matrix/10 hover:text-matrix-glow font-display tracking-widest uppercase text-sm rounded-sm"
          >
            <svg className="w-4 h-4" viewBox="0 0 24 24" fill="currentColor">
              <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
              <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
              <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
              <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
            </svg>
            Continue with Google
          </Button>

          <p className="mt-6 text-center text-xs text-matrix-dim font-mono">
            [ end-to-end encrypted · domain-restricted · audit-logged ]
          </p>
        </TerminalCard>
      </section>
    </div>
  );
}
