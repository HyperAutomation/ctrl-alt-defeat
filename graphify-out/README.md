# CAA/MAA Approval Workbench — Knowledge Graph

Self-contained knowledge graph built from the SORA approval workbench
documentation corpus. See `GRAPH_REPORT.md` for the full audit.

## Files

| File | Size | Purpose |
|---|---|---|
| `graph-offline.html` | 2.4 MB | **Host this.** Fully self-contained — vis.js is inlined, no CDN / network requests at runtime. |
| `graph.html` | 1.7 MB | Same graph but loads vis.js from unpkg.com (local-dev convenience only). |
| `graph.json` | 2.1 MB | Raw graph data (GraphRAG-ready). No absolute paths, safe to share. |
| `GRAPH_REPORT.md` | 32 KB | Plain-language audit: god nodes, surprises, communities, questions. |
| `manifest.json` | 6 KB | File list used to build this graph (for `/graphify --update` incremental runs). |
| `cost.json` | <1 KB | Token-cost telemetry across runs. |

## Stats

- **1,810 nodes · 4,923 edges · 112 communities · 7 hyperedges**
- **88.2× token reduction** vs. raw corpus (~1.38M naïve tokens → ~15.6K per query)

## External hosting

The only file you need is `graph-offline.html`. Drop it on any static host:

```bash
# GitHub Pages
cp graph-offline.html /path/to/pages/repo/index.html
git push

# Cloudflare Pages / Netlify / Vercel
# Just upload graph-offline.html as the single static asset.

# S3 / GCS static website
aws s3 cp graph-offline.html s3://<bucket>/index.html --content-type text/html
```

To expose the raw JSON alongside it (for GraphRAG consumers), upload
`graph.json` to the same origin and its URL becomes a stable GraphRAG
endpoint.

## Security notes

- **No auth.** Anyone with the URL can see the full graph. If the corpus
  is sensitive, put the host behind Cloudflare Access or equivalent.
- **No PII in node labels.** The extractor preserved only operator/role
  names explicitly named in the source docs (e.g. Accountable Managers).
  Review the communities under `AAIB Incident Investigations` if you
  need to redact named individuals before publishing.
- **Source filenames retained.** `source_file` fields are repo-relative,
  not absolute — they leak no local paths, but they do disclose the
  directory structure of the corpus.

## Rebuild / update

```bash
/graphify --update       # incremental — only re-extracts new/changed files
/graphify                # full rebuild
```

The `cache/` directory (gitignored) stores per-file extraction results so
`--update` runs skip unchanged files.
