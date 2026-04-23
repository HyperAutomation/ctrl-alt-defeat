"""FastAPI entrypoint — Applicant-mode REST + SSE surface.

Endpoints mirror the hackathon-cut surface in the design doc §7:

    POST   /workspace                     create an Applicant workspace
    POST   /workspace/{id}/evidence       multipart upload of artefacts
    POST   /workspace/{id}/review         trigger the Applicant workflow
    GET    /workspace/{id}/events         SSE per-executor progress stream
    GET    /workspace/{id}/feedback       latest Operator Feedback Report
    GET    /workspace/{id}/readiness      readiness gauges snapshot

Workspaces are keyed by ID; the workspace directory is the mode-isolation
seam that would separate Applicant and Regulator modes in a full build.
"""
from __future__ import annotations

import asyncio
import json
import shutil
import uuid
from datetime import datetime, timezone
from pathlib import Path

from fastapi import FastAPI, HTTPException, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from sse_starlette.sse import EventSourceResponse

from workflow import Submission, build_applicant_workflow
from workflow.schemas import Document

_WORKSPACES_ROOT = Path(__file__).parent / "_workspaces"
_WORKSPACES_ROOT.mkdir(exist_ok=True)


app = FastAPI(title="SORA Approval Generator (Applicant mode)")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


class CreateWorkspaceRequest(BaseModel):
    operation_type: str
    airspace: str
    regulator: str = "JOINT"  # CAA / MAA / JOINT


class WorkspaceState:
    """In-memory workspace record. For the hackathon cut only — a real build
    persists this to sovereign storage under configuration control."""

    def __init__(self, wid: str, req: CreateWorkspaceRequest) -> None:
        self.id = wid
        self.created_at = datetime.now(tz=timezone.utc)
        self.request = req
        self.dir = _WORKSPACES_ROOT / wid
        self.dir.mkdir(parents=True, exist_ok=True)
        self.uploads: list[Path] = []
        self.last_submission: Submission | None = None
        self.event_queue: asyncio.Queue[dict] = asyncio.Queue(maxsize=256)
        self.running: bool = False


_workspaces: dict[str, WorkspaceState] = {}


def _get(wid: str) -> WorkspaceState:
    ws = _workspaces.get(wid)
    if ws is None:
        raise HTTPException(status_code=404, detail=f"Workspace {wid} not found")
    return ws


@app.post("/workspace")
async def create_workspace(req: CreateWorkspaceRequest) -> dict:
    wid = uuid.uuid4().hex[:12]
    ws = WorkspaceState(wid, req)
    _workspaces[wid] = ws
    return {
        "workspace_id": wid,
        "created_at": ws.created_at.isoformat(),
        "operation_type": req.operation_type,
        "airspace": req.airspace,
        "regulator": req.regulator,
    }


@app.post("/workspace/{wid}/evidence")
async def upload_evidence(wid: str, files: list[UploadFile]) -> dict:
    ws = _get(wid)
    saved: list[str] = []
    for f in files:
        dst = ws.dir / (f.filename or f"upload-{uuid.uuid4().hex}.bin")
        with dst.open("wb") as out:
            shutil.copyfileobj(f.file, out)
        ws.uploads.append(dst)
        saved.append(dst.name)
    return {"workspace_id": wid, "saved": saved}


def _build_submission(ws: WorkspaceState) -> Submission:
    docs = [
        Document(
            document_id=p.name,
            filename=p.name,
            mime_type="text/markdown" if p.suffix == ".md" else "text/plain",
            sections=[],
        )
        for p in ws.uploads
    ]
    return Submission(
        submission_id=uuid.uuid4().hex[:12],
        workspace_id=ws.id,
        operation_type=ws.request.operation_type,
        airspace=ws.request.airspace,
        regulator=ws.request.regulator,  # type: ignore[arg-type]
        documents=docs,
    )


async def _emit(ws: WorkspaceState, event_type: str, payload: dict) -> None:
    try:
        ws.event_queue.put_nowait(
            {
                "event": event_type,
                "data": json.dumps({"ts": datetime.now(tz=timezone.utc).isoformat(), **payload}),
            }
        )
    except asyncio.QueueFull:
        pass  # drop-if-full; keep the run liveness from blocking on the stream


@app.post("/workspace/{wid}/review")
async def trigger_review(wid: str) -> dict:
    ws = _get(wid)
    if not ws.uploads:
        raise HTTPException(status_code=400, detail="No evidence uploaded")
    if ws.running:
        raise HTTPException(status_code=409, detail="Review already in progress")
    ws.running = True
    asyncio.create_task(_run_review(ws))
    return {"workspace_id": wid, "status": "started"}


async def _run_review(ws: WorkspaceState) -> None:
    submission = _build_submission(ws)
    workflow = build_applicant_workflow()
    await _emit(ws, "workflow.started", {"submission_id": submission.submission_id})
    try:
        # MAF workflow streaming API — yields ExecutorEvents. We surface a
        # minimal projection of each event via SSE so the UI can light up the
        # readiness-gauge panels as each executor completes.
        async for event in workflow.run_stream(submission):  # type: ignore[attr-defined]
            et = type(event).__name__
            payload = {"executor_id": getattr(event, "executor_id", None), "kind": et}
            await _emit(ws, "workflow.event", payload)

            # Capture the final output when the binder yields.
            out = getattr(event, "output", None)
            if isinstance(out, Submission):
                ws.last_submission = out
        if ws.last_submission is None:
            # Fallback for runtimes that expose only run() instead of run_stream().
            ws.last_submission = await workflow.run(submission)  # type: ignore[attr-defined]
        await _emit(ws, "workflow.complete", {"submission_id": submission.submission_id})
    except Exception as exc:  # pragma: no cover -- surfaced to UI for demo
        await _emit(ws, "workflow.error", {"error": str(exc)})
    finally:
        ws.running = False


@app.get("/workspace/{wid}/events")
async def stream_events(wid: str):
    ws = _get(wid)

    async def gen():
        while True:
            try:
                evt = await asyncio.wait_for(ws.event_queue.get(), timeout=15.0)
                yield evt
            except asyncio.TimeoutError:
                yield {"event": "keepalive", "data": "{}"}

    return EventSourceResponse(gen())


@app.get("/workspace/{wid}/feedback")
async def get_feedback(wid: str) -> dict:
    ws = _get(wid)
    if ws.last_submission is None or ws.last_submission.feedback is None:
        raise HTTPException(status_code=404, detail="No feedback report yet — run /review first")
    return ws.last_submission.feedback.model_dump(mode="json")


@app.get("/workspace/{wid}/readiness")
async def get_readiness(wid: str) -> dict:
    ws = _get(wid)
    if ws.last_submission is None or ws.last_submission.feedback is None:
        raise HTTPException(status_code=404, detail="No readiness snapshot yet — run /review first")
    return ws.last_submission.feedback.readiness.model_dump(mode="json")
