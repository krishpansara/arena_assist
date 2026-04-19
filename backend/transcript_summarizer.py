import re
import json
import backend.llm as llm

async def generate_transcript_insights(raw_transcript: str) -> dict:
    if llm.gemini_model is None:
        raise RuntimeError("❌ Gemini LLM not initialised. Check GEMINI_API_KEY.")

    print("🚀 Starting transcript analysis...")

    prompt = f"""
    Analyze the following transcript from an event session. I need you to extract a summary, key points, keywords, and provide a clean version of the transcript (fixing grammar and punctuation where obvious, but keeping the original meaning).
    
    Format your response EXACTLY as a valid JSON object matching this structure:
    {{
      "summary": "A short 1-2 sentence summary of the session",
      "key_points": ["Key point 1", "Key point 2"],
      "keywords": ["Keyword1", "Keyword2"],
      "clean_transcript": "The cleaned up transcript text"
    }}

    Raw Transcript:
    \"\"\"
    {raw_transcript}
    \"\"\"
    """

    try:
        response = await llm.gemini_model.generate_content_async(prompt)
        
        text = response.text
        if not text:
            raise ValueError("Empty response from Gemini")

        clean_json = re.sub(r"```json|```", "", text).strip()
        data = json.loads(clean_json)
        print("✅ Transcript insights generated successfully.")
        return data

    except Exception as e:
        print(f"❌ Error generating AI insights in Python: {e}")
        raise
