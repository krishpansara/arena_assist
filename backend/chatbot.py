import google.generativeai as genai
from typing import List, Dict
import os

def get_chatbot_response(message: str, history: List[Dict[str, str]], context: str) -> str:
    """
    Generate a response from Gemini using chat history and provided context.
    """
    model = genai.GenerativeModel('gemini-2.5-flash')
    
    # Construct the internal system prompt
    system_prompt = f"""You are 'Arena Assistant', a premium AI concierge for the Arena app. 
Your goal is to help users with quick info, suggestions, or answers about their events and workshops.

USER CONTEXT (Active Events/Workshops):
{context}

RULES:
1. Be concise, helpful, and professional.
2. If the context contains '[SCRAPED WEB CONTENT]', prioritize this information as it is fetched in real-time from the URL the user shared. Use it to answer questions about tickets, pricing, scheduling, and speakers.
3. If you don't know something from the context, be honest but try to suggest helpful alternatives.
4. Use a friendly, high-energy tone suitable for stadium and workshop environments.
5. If asked about locations, reference the user's specific section/seat if available in context.
"""

    # Format history for Gemini (Gemini uses 'user' and 'model' as roles)
    chat_session = model.start_chat(
        history=[
            {"role": "user" if m["role"] == "user" else "model", "parts": [m["content"]]}
            for m in history
        ]
    )

    # Intersperse system prompt as a precursor if history is empty, 
    # or just use it as system_instruction if the SDK supports it (preferred)
    # Re-init with system_instruction for cleaner logic
    model_with_instr = genai.GenerativeModel(
        model_name='gemini-2.5-flash',
        system_instruction=system_prompt
    )
    
    chat_session = model_with_instr.start_chat(
        history=[
            {"role": "user" if m["role"] == "user" else "model", "parts": [m["content"]]}
            for m in history
        ]
    )

    response = chat_session.send_message(message)
    return response.text
