import os
from contextlib import asynccontextmanager
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from dotenv import load_dotenv

# Load .env FIRST before any module reads os.getenv()
load_dotenv()

from backend.scraper import scrape_event_website
# from backend.llm import synthesize_event_data, init_llm
# from backend.llm import synthesize_event_data, generate_transcript_insights, init_llm
from backend.llm import init_llm
from backend.event_analyzer import synthesize_event_data
from backend.transcript_summarizer import generate_transcript_insights
from backend.database import init_firestore, save_event_to_firestore


# -- Lifespan (replaces deprecated @app.on_event) -----------------------------

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    try:
        init_llm()
    except ValueError as e:
        print(f"[LLM] WARNING: {e}")
    init_firestore()
    yield
    # Shutdown (nothing to clean up for now)


app = FastAPI(
    title="Arena Assist - Event Analyzer API",
    version="1.0.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


# -- Models -------------------------------------------------------------------

class AnalyzeRequest(BaseModel):
    url: str        # URL to analyze
    type: str = "url" # "url" | "name"


class TranscriptRequest(BaseModel):
    transcript: str


class AnalyzeResponse(BaseModel):
    status: str
    doc_id: str | None
    data: dict


# -- Endpoints ----------------------------------------------------------------

@app.get("/")
def health_check():
    return {"status": "Arena Assist API is running", "version": "1.0.0"}


@app.post("/api/v1/analyze", response_model=AnalyzeResponse)
async def analyze_event(req: AnalyzeRequest):
    """
    Main pipeline: URL -> Scrape -> Gemini LLM Synthesis -> Firestore -> Response
    """

    print("recahed")
    
    if req.type == "name":
        raise HTTPException(
            status_code=400,
            detail="Search by event name is not yet supported. Please paste the direct event URL.",
        )

    url = req.url.strip()
    if not url.startswith("http"):
        url = "https://" + url

    # Step 1: Scrape
    print(f"\n[SCRAPER] Fetching: {url}")
    try:
        raw_text = await scrape_event_website(url)
    except Exception as e:
        raise HTTPException(status_code=502, detail=f"Failed to fetch the event website: {e}")

    if not raw_text or len(raw_text) < 100:
        raise HTTPException(
            status_code=422,
            detail="Page returned too little content. It may require JavaScript rendering.",
        )

    print(f"[SCRAPER] Got {len(raw_text):,} characters.")

    # Step 2: LLM Synthesis
    print("[LLM] Sending to Gemini...")
    try:
        synthesized = await synthesize_event_data(raw_text, url)
    except Exception as e:
        print("❌ LLM ERROR:", str(e))
        raise HTTPException(status_code=500, detail=f"LLM synthesis failed: {e}")

    # Step 3: Persist to Firestore
    doc_id = await save_event_to_firestore(synthesized, source_url=url)

    print(f"[API] Done - event: {synthesized.get('event_name', 'Unknown')}")

    return AnalyzeResponse(status="success", doc_id=doc_id, data=synthesized)


@app.post("/api/v1/transcript/insights")
async def get_transcript_insights(req: TranscriptRequest):
    """
    Calls Gemini to extract insights from a raw transcript.
    """
    if not req.transcript.strip():
        raise HTTPException(status_code=400, detail="Transcript cannot be empty.")

    try:
        insights = await generate_transcript_insights(req.transcript)
        return {"status": "success", "data": insights}
    except Exception as e:
        print("❌ TRANSCRIPT LLM ERROR:", str(e))
        raise HTTPException(status_code=500, detail=f"Failed to generate insights: {e}")


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
