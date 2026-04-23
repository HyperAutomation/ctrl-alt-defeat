// Ingest graphify output (graph/graph.json) into Neo4j.
//
// Run:
//   node --env-file=graph/.env --experimental-strip-types scripts/ingest-graph.ts
//
// Expects NEO4J_URI / NEO4J_USERNAME / NEO4J_PASSWORD in the env. Idempotent —
// safe to re-run; MERGE semantics mean existing nodes/edges are updated in place.

import neo4j, { type Driver, type Session } from "neo4j-driver";
import { readFileSync } from "node:fs";

type RawNode = {
  id: string;
  label?: string;
  norm_label?: string | null;
  file_type?: string | null;
  source_file?: string | null;
  source_location?: string | null;
  source_url?: string | null;
  captured_at?: string | null;
  author?: string | null;
  contributor?: string | null;
  community?: number | null;
};

type RawLink = {
  source: string;
  target: string;
  relation?: string | null;
  confidence?: string | null;
  confidence_score?: number | null;
  source_file?: string | null;
  source_location?: string | null;
  weight?: number | null;
};

type RawHyperedge = {
  id: string;
  label?: string;
  relation?: string | null;
  confidence?: string | null;
  confidence_score?: number | null;
  source_file?: string | null;
  nodes: string[];
};

type GraphJson = {
  nodes: RawNode[];
  links: RawLink[];
  graph?: { hyperedges?: RawHyperedge[] };
};

const { NEO4J_URI, NEO4J_USERNAME, NEO4J_PASSWORD } = process.env;
if (!NEO4J_URI || !NEO4J_USERNAME || !NEO4J_PASSWORD) {
  console.error(
    "Missing NEO4J_URI / NEO4J_USERNAME / NEO4J_PASSWORD.\n" +
      "Run with: node --env-file=graph/.env --experimental-strip-types scripts/ingest-graph.ts",
  );
  process.exit(1);
}

const graph: GraphJson = JSON.parse(readFileSync("graph/graph.json", "utf8"));
const nodes = graph.nodes ?? [];
const links = graph.links ?? [];
const hyperedges = graph.graph?.hyperedges ?? [];

console.log(
  `Parsed: ${nodes.length} nodes, ${links.length} links, ${hyperedges.length} hyperedges`,
);

const driver: Driver = neo4j.driver(
  NEO4J_URI,
  neo4j.auth.basic(NEO4J_USERNAME, NEO4J_PASSWORD),
);

async function run(): Promise<void> {
  await driver.verifyConnectivity();
  console.log(`Connected to ${NEO4J_URI}`);

  const session: Session = driver.session();
  try {
    await session.run(
      "CREATE CONSTRAINT entity_id IF NOT EXISTS FOR (n:Entity) REQUIRE n.id IS UNIQUE",
    );
    await session.run(
      "CREATE CONSTRAINT hyperedge_id IF NOT EXISTS FOR (h:Hyperedge) REQUIRE h.id IS UNIQUE",
    );

    const nodeRows = nodes.map((n) => ({
      id: n.id,
      label: n.label ?? n.id,
      norm_label: n.norm_label ?? null,
      file_type: n.file_type ?? null,
      source_file: n.source_file ?? null,
      source_location: n.source_location ?? null,
      source_url: n.source_url ?? null,
      captured_at: n.captured_at ?? null,
      author: n.author ?? null,
      contributor: n.contributor ?? null,
      community: typeof n.community === "number" ? n.community : null,
    }));
    await session.executeWrite((tx) =>
      tx.run(
        `UNWIND $rows AS row
         MERGE (n:Entity {id: row.id})
         SET n.label = row.label,
             n.norm_label = row.norm_label,
             n.file_type = row.file_type,
             n.source_file = row.source_file,
             n.source_location = row.source_location,
             n.source_url = row.source_url,
             n.captured_at = row.captured_at,
             n.author = row.author,
             n.contributor = row.contributor,
             n.community = row.community`,
        { rows: nodeRows },
      ),
    );
    console.log(`  wrote ${nodeRows.length} :Entity nodes`);

    const linkRows = links.map((l) => ({
      source: l.source,
      target: l.target,
      relation: l.relation ?? "related",
      confidence: l.confidence ?? null,
      confidence_score:
        typeof l.confidence_score === "number" ? l.confidence_score : null,
      source_file: l.source_file ?? null,
      source_location: l.source_location ?? null,
      weight: typeof l.weight === "number" ? l.weight : null,
    }));
    await session.executeWrite((tx) =>
      tx.run(
        `UNWIND $rows AS row
         MATCH (s:Entity {id: row.source})
         MATCH (t:Entity {id: row.target})
         MERGE (s)-[r:RELATES {relation: row.relation}]->(t)
         SET r.confidence = row.confidence,
             r.confidence_score = row.confidence_score,
             r.source_file = row.source_file,
             r.source_location = row.source_location,
             r.weight = row.weight`,
        { rows: linkRows },
      ),
    );
    console.log(`  wrote ${linkRows.length} :RELATES edges`);

    const heRows = hyperedges.map((h) => ({
      id: h.id,
      label: h.label ?? h.id,
      relation: h.relation ?? null,
      confidence: h.confidence ?? null,
      confidence_score:
        typeof h.confidence_score === "number" ? h.confidence_score : null,
      source_file: h.source_file ?? null,
      nodes: h.nodes ?? [],
    }));
    await session.executeWrite((tx) =>
      tx.run(
        `UNWIND $rows AS row
         MERGE (h:Hyperedge {id: row.id})
         SET h.label = row.label,
             h.relation = row.relation,
             h.confidence = row.confidence,
             h.confidence_score = row.confidence_score,
             h.source_file = row.source_file
         WITH h, row
         UNWIND row.nodes AS nodeId
         MATCH (n:Entity {id: nodeId})
         MERGE (n)-[:PARTICIPATES_IN]->(h)`,
        { rows: heRows },
      ),
    );
    console.log(`  wrote ${heRows.length} :Hyperedge nodes`);

    const counts = await session.run(`
      CALL () { MATCH (e:Entity) RETURN count(e) AS entities }
      CALL () { MATCH ()-[r:RELATES]->() RETURN count(r) AS relates }
      CALL () { MATCH (h:Hyperedge) RETURN count(h) AS hyperedges }
      CALL () { MATCH ()-[p:PARTICIPATES_IN]->() RETURN count(p) AS participates }
      RETURN entities, relates, hyperedges, participates
    `);
    const row = counts.records[0];
    console.log("Verified counts:", {
      entities: row?.get("entities").toNumber(),
      relates: row?.get("relates").toNumber(),
      hyperedges: row?.get("hyperedges").toNumber(),
      participates: row?.get("participates").toNumber(),
    });
  } finally {
    await session.close();
  }
}

try {
  await run();
} catch (err) {
  console.error("Ingest failed:", err);
  process.exitCode = 1;
} finally {
  await driver.close();
}
