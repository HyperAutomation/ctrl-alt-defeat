# Local dev on Windows ARM64

`@cloudflare/vite-plugin` depends on **workerd**, which does not publish a
`win32-arm64` build. Its postinstall script fails with:

```
Error: Unsupported platform: win32 arm64 LE
```

Without the workerd binary, anything that boots the Cloudflare runtime is
blocked — at minimum `npm run build`, `npm run preview`, and local wrangler
commands. `npm run dev` *may* work (the `@lovable.dev/vite-tanstack-config`
wrapper marks the Cloudflare plugin as build-only) but is untested on ARM64.
Node, Playwright, and `neo4j-driver` are fine natively on ARM64 — only the
Cloudflare runtime is blocked.

## Option 1 — develop inside WSL2 (recommended)

WSL runs x64 Linux, where workerd works unmodified.

```powershell
wsl --install -d Ubuntu          # once, from an elevated PowerShell
```

Then inside the Ubuntu shell:

```bash
# install node 22 (nvm or corepack, whichever you prefer)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
exec $SHELL
nvm install 22 && nvm use 22

# clone into the WSL filesystem, NOT /mnt/c (FS perf)
git clone https://github.com/HyperAutomation/ctrl-alt-defeat.git ~/ctrl-alt-defeat
cd ~/ctrl-alt-defeat
npm ci
npm run dev    # http://localhost:5173
```

VS Code's **Remote - WSL** extension lets you edit the WSL copy from Windows.

## Option 2 — install on Windows ARM64 without workerd

If you only need to work on UI/content (no Cloudflare runtime features), install
with postinstall scripts disabled:

```bash
npm install --ignore-scripts
```

`npm run build` / `preview` will still fail. If `npm run dev` also fails on
your machine, run Playwright against a deployed preview URL via
`PLAYWRIGHT_BASE_URL`:

```bash
PLAYWRIGHT_SKIP_WEBSERVER=1 PLAYWRIGHT_BASE_URL=https://<preview>.pages.dev npx playwright test
```

## Option 3 — wait for upstream

Track [cloudflare/workerd #67](https://github.com/cloudflare/workerd/issues/67)
for native Windows ARM64 support.
