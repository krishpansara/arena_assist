import os
import json
import asyncio
import re
from groq import AsyncGroq
import google.generativeai as genai
from pydantic import BaseModel, Field
from typing import List, Optional


# -- Pydantic models -----------------------------------------------------------

# OLD MODELS (Commented for reference)
# class SpeakerInfo(BaseModel):
#     name: str
#     title: Optional[str] = None
#     company: Optional[str] = None

# class BudgetEstimate(BaseModel):
#     total: str = Field(description="Estimated total cost, e.g. 'INR 8000 - 12000'")
#     breakdown: dict[str, str] = Field(
#         description="Dict mapping cost category (ticket, travel, hotel, food) to estimated value"
#     )

# NEW MODELS (Active)
class SpeakerInfo(BaseModel):
    name: str
    topic: str
    bio: str


class SessionInfo(BaseModel):
    title: str
    time: str
    speaker: str


class BudgetEstimate(BaseModel):
    tickets: str
    travel: str
    total_estimate: str


class EventAnalysisResult(BaseModel):
    event_name: str
    date: str
    location: str
    latitude: float = Field(description="Latitude of the venue location")
    longitude: float = Field(description="Longitude of the venue location")
    event_type: str = Field(description="Classification of event: 'stadium' (for sports/concerts) or 'workshop' (for educational/tech)")
    price: str
    description: str
    speakers: List[SpeakerInfo]
    sessions: List[SessionInfo]
    budget: BudgetEstimate
    checklist: List[str] = Field(
        description="Packing/prep checklist based on the event (e.g., Laptop, Business casuals)"
      )


# -- Global clients -------------------------------------------------------------

groq_client: AsyncGroq | None = None
gemini_model: genai.GenerativeModel | None = None


def init_llm():
    global groq_client, gemini_model
    
    # Initialize Groq
    groq_key = os.getenv("GROQ_API_KEY")
    if groq_key:
        try:
            groq_client = AsyncGroq(api_key=groq_key)
            print("✅ [LLM] Groq client initialized successfully.")
        except Exception as e:
            print("❌ [LLM INIT ERROR - Groq]:", str(e))
    else:
        print("⚠️ [LLM] GROQ_API_KEY not found in environment.")

    # Initialize Gemini
    gemini_key = os.getenv("GEMINI_API_KEY")
    if gemini_key:
        try:
            genai.configure(api_key=gemini_key)
            # Using 1.5-flash as it's the current stable model
            gemini_model = genai.GenerativeModel('gemini-1.5-flash')
            print("✅ [LLM] Gemini client initialized successfully.")
        except Exception as e:
            print("❌ [LLM INIT ERROR - Gemini]:", str(e))
    else:
        print("⚠️ [LLM] GEMINI_API_KEY not found in environment.")


# -- Core synthesis function ---------------------------------------------------

async def synthesize_event_data(raw_text: str, event_url: str) -> dict:
    if groq_client is None:
        raise RuntimeError("❌ Groq LLM not initialised. Check GROQ_API_KEY.")

    print("🚀 Starting event synthesis...")

    # --- your fixed prompt, schema‑explicit ---

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

    try:
        response = await groq_client.chat.completions.create(
            messages=[
                {"role": "system", "content": system_msg},
                {"role": "user", "content": prompt},
            ],
            model="llama-3.1-8b-instant",  # ✅ current Groq model
            response_format={"type": "json_object"},
        )
        print("✅ Response received from Groq.")

        content = response.choices[0].message.content

        if not content:
            raise ValueError("Empty response content from LLM.")

        print("📦 Raw LLM response (preview):", content[:500])

        # Strip any accidental ```json ``` or ``` wrappers
        clean_text = re.sub(r"```json|```", "", content).strip()

        # --- optional safeguard: inject missing ending brace if needed (for some LLM quirks)
        if clean_text.count("{") > clean_text.count("}"):
            clean_text += "}"

    except Exception as e:
        print("❌ API CALL / RESPONSE PROCESSING FAILED:", str(e))
        raise

    # --- JSON parsing with richer debug info ---

    try:
        data = json.loads(clean_text)
        print("✅ JSON parsed successfully.")
        print("🔍 Keys received from LLM:", list(data.keys()))
        return data

    except Exception as e:
        print("❌ JSON PARSE ERROR")
        print("⚠️ Raw LLM Output:", clean_text)
        raise