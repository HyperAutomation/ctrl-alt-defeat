"""REQ001–REQ020 catalogue walker (plan §14).

REQs are the CAA pack-level view beneath AC1–AC8. Walked for every
submission; absent-by-default quartet (REQ017–REQ020) is surfaced even when
the applicant did not address them.
"""
from __future__ import annotations

import csv
import json
from pathlib import Path

from workflow.schemas import REQVerdict, Submission, Verdict


_REPO_ROOT = Path(__file__).resolve().parents[2]
_CSV_PATH = _REPO_ROOT / "requirements" / "bvlos-autonomous-swarms" / "requirements.csv"
_NORMALISED_PATH = Path(__file__).resolve().parents[1] / "knowledge" / "req_catalogue.json"


def load_req_catalogue() -> list[dict]:
    """Load the catalogue. Prefer the normalised JSON if present; otherwise
    normalise from the repo CSV on the fly so tests work without a bootstrap step.
    """
    if _NORMALISED_PATH.exists():
        return json.loads(_NORMALISED_PATH.read_text())
    return _normalise_from_csv()


def _normalise_from_csv() -> list[dict]:
    out: list[dict] = []
    with _CSV_PATH.open() as f:
        reader = csv.reader(f)
        next(reader, None)  # header
        for row in reader:
            if len(row) < 3:
                continue
            out.append({
                "req_id": row[0].strip(),
                "name": row[1].strip(),
                "description": row[2].strip(),
            })
    return out


def save_normalised_catalogue() -> Path:
    """Used by bootstrap scripts; not called at runtime."""
    _NORMALISED_PATH.parent.mkdir(parents=True, exist_ok=True)
    _NORMALISED_PATH.write_text(json.dumps(_normalise_from_csv(), indent=2))
    return _NORMALISED_PATH


# -----------------------------------------------------------------------------
# Heuristic per-REQ checker. Real implementation delegates to the Regulatory
# Mapper + Classifier; this scaffold uses simple keyword evidence for the
# twin-sample regression to light up the correct gauges.
# -----------------------------------------------------------------------------

_REQ_KEYWORDS: dict[str, list[str]] = {
    "REQ001": ["accountable manager", "named applicant", "operator:"],
    "REQ002": ["SORA v2.5", "JARUS v2.5", "swarm OSO"],
    "REQ003": ["ConOps", "ODD", "operational design domain"],
    "REQ004": ["CAP 1616", "TDA", "NOTAM"],
    "REQ005": ["geofence", "containment"],
    "REQ006": ["C2 link budget", "link budget", "crypto"],
    "REQ007": ["DO-365", "F3442", "detect and avoid"],
    "REQ008": ["emergent behaviour", "swarm architecture"],
    "REQ009": ["AMLAS", "SACE", "ML assurance"],
    "REQ010": ["meaningful human control", "MHC", "take-over"],
    "REQ011": ["flight termination", "independent termination"],
    "REQ012": ["DPIA", "MOR", "occurrence report"],
    "REQ013": ["insurance", "ground survey"],
    "REQ014": ["GVC", "competency", "currency"],
    "REQ015": ["apportionment", "CAA/MAA liaison"],
    "REQ016": ["phased build-up", "phased trial"],
    "REQ017": ["community consultation", "public engagement", "CAP 1616"],
    "REQ018": ["classification custodian", "CAP 722H", "JSP 440"],
    "REQ019": ["noise", "environmental impact", "battery fire"],
    "REQ020": ["lessons learned", "close-out", "post-trial"],
}


def _verdict(submission: Submission, req_id: str) -> tuple[Verdict, str]:
    hay = " ".join(
        (s.text or "").lower()
        for d in submission.documents
        for s in d.sections
    )
    keywords = [k.lower() for k in _REQ_KEYWORDS.get(req_id, [])]
    hits = sum(1 for k in keywords if k in hay)
    if hits == 0:
        return "red", f"No evidence found for {req_id}."
    if hits < len(keywords):
        return "amber", f"Partial evidence for {req_id} ({hits}/{len(keywords)} keywords)."
    return "green", f"Evidence present for {req_id}."


def check_req(req_id: str, submission: Submission, catalogue_entry: dict) -> REQVerdict:
    verdict, rationale = _verdict(submission, req_id)
    return REQVerdict(
        req_id=req_id,
        name=catalogue_entry["name"],
        verdict=verdict,
        rationale=rationale,
    )


def walk_catalogue(submission: Submission) -> list[REQVerdict]:
    catalogue = load_req_catalogue()
    return [check_req(entry["req_id"], submission, entry) for entry in catalogue]
