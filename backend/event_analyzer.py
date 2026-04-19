import re
from typing import List
from pydantic import BaseModel, Field

import backend.llm as llm
from backend.llm import SpeakerInfo, SessionInfo, BudgetEstimate, EventAnalysisResult


async def synthesize_event_data(raw_text: str, event_url: str) -> dict:
    if llm.groq_client is None:
        raise RuntimeError("❌ Groq LLM not initialised. Call init_llm() first.")

    print("🚀 Starting event synthesis...")

    prompt = f"""You are an expert Event Research Analyst. You will receive the raw text content
from an event website ({event_url}).

Your task is to return **ONLY** a JSON object that matches EXACTLY this schema:

{{
  "event_name": "<string>",
  "date": "<string>",
  "location": "<string>",
  "latitude": <float>,
  "longitude": <float>,
  "event_type": "stadium" | "workshop",
  "price": "<string>",
  "description": "<string>",
  "speakers": [
    {{
      "name": "<string>",
      "topic": "<string>",
      "bio": "<string>"
    }}
  ],
  "sessions": [
    {{
      "title": "<string>",
      "time": "<string>",
      "speaker": "<string>"
    }}
  ],
  "budget": {{
    "tickets": "<string>",
    "travel": "<string>",
    "total_estimate": "<string>"
  }},
  "checklist": ["<string>"]
}}

Rules:
- Do NOT add any keys not shown above.
- If a field is missing in the website text, use "Unknown" or "" or [] as appropriate.
- For **latitude** and **longitude**, try to find the actual coordinates for the specific venue. If not found, look up the general coordinates for the venue name/city.
- For **event_type**, use "stadium" for sports, matches, or stadium concerts. Use "workshop" for conferences, meetups, or classes.
- Do NOT include any markdown, explanations, or extra text — only the JSON object.
- Return ONLY the JSON and nothing else.

RAW WEBSITE TEXT (first 80,000 chars):
---
{raw_text[:80000]}
---
"""

    system_msg = (
        "You are an expert Event Research Analyst. "
        "You MUST return ONLY valid JSON matching the exact schema in the user message. "
        "No explanations, no markdown, no extra keys."
    )

    print("📡 Sending request to Groq API...")

    import json
    try:
        response = await llm.groq_client.chat.completions.create(
            messages=[
                {"role": "system", "content": system_msg},
                {"role": "user", "content": prompt},
            ],
            model="llama-3.1-8b-instant",
            response_format={"type": "json_object"},
        )
        print("✅ Response received from Groq.")

        content = response.choices[0].message.content

        if not content:
            raise ValueError("Empty response content from LLM.")

        print("📦 Raw LLM response (preview):", content[:500])

        clean_text = re.sub(r"```json|```", "", content).strip()

        if clean_text.count("{") > clean_text.count("}"):
            clean_text += "}"
            
        data = json.loads(clean_text)
        return data

    except Exception as e:
        print("❌ API CALL / RESPONSE PROCESSING FAILED:", str(e))
        raise
