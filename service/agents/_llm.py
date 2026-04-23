"""Shared LLM wiring.

The hackathon cut uses Azure OpenAI / OpenAI via the Microsoft Agent Framework.
Import is lazy so the workflow graph compiles in test environments without
credentials — tools and non-LLM executors can still run.
"""
from __future__ import annotations

import os
from functools import lru_cache


@lru_cache(maxsize=1)
def get_chat_client():
    """Return an MAF ChatClient. Falls back to a stub in test mode.

    Env vars:
      - OPENAI_API_KEY (uses OpenAIChatClient)
      - AZURE_OPENAI_ENDPOINT + AZURE_OPENAI_API_KEY (uses AzureOpenAIChatClient)
      - SORA_SERVICE_STUB_LLM=1 (use a no-op stub; used by twin-sample regression)
    """
    if os.getenv("SORA_SERVICE_STUB_LLM") == "1":
        return _StubClient()

    if os.getenv("AZURE_OPENAI_ENDPOINT") and os.getenv("AZURE_OPENAI_API_KEY"):
        from agent_framework.azure import AzureOpenAIChatClient  # type: ignore
        return AzureOpenAIChatClient()

    if os.getenv("OPENAI_API_KEY"):
        from agent_framework.openai import OpenAIChatClient  # type: ignore
        return OpenAIChatClient()

    # Default to stub so graph compiles without external config.
    return _StubClient()


class _StubClient:
    """Returns deterministic empty responses. Used by tests + dry-run demos."""
    async def get_response(self, *args, **kwargs):
        from types import SimpleNamespace
        return SimpleNamespace(text="", messages=[])

    async def run(self, *args, **kwargs):
        return await self.get_response(*args, **kwargs)
