import os
import firebase_admin
from firebase_admin import credentials, firestore
import re
from typing import List, Optional
from datetime import datetime, timezone

_db = None

def _parse_fee(price_str: str) -> tuple[bool, float | None]:
    """
    Parses a price string to determine if it is free and extracts the numeric value if any.
    Returns a tuple of (is_free, amount).
    """
    s = str(price_str).lower().strip()
    if any(x in s for x in ['free', 'complimentary', 'no cost', '0']):
        return True, 0.0

    match = re.search(r'[\d,]+\.?\d*', s)
    if match:
        try:
            return False, float(match.group().replace(',', ''))
        except ValueError:
            pass

    return False, None


def init_firestore():
    """
    Initializes the Firebase Admin SDK. Safe to call multiple times.
    Returns the Firestore client.
    """
    global _db
    if _db is not None:
        return _db

    service_account_path = os.getenv("FIREBASE_SERVICE_ACCOUNT_PATH", "serviceAccountKey.json")

    # If already initialized somehow, skip
    if not firebase_admin._apps:
        if os.path.exists(service_account_path):
            print(f"[DB] Using service account key at '{service_account_path}'.")
            cred = credentials.Certificate(service_account_path)
            firebase_admin.initialize_app(cred)
        else:
            print(f"[DB] Service account key not found at '{service_account_path}'. Falling back to default credentials (Cloud Run).")
            # This uses the default compute service account when running on GCP
            try:
                firebase_admin.initialize_app()
            except Exception as e:
                print(f"[DB] Failed to initialize with default credentials: {e}")
                return None

    _db = firestore.client()
    print("[DB] Firestore connected OK.")
    return _db


async def save_event_to_firestore(event_data: dict, source_url: str) -> str | None:
    """
    Saves analyzed event data to the 'analyzed_events' Firestore collection.
    Returns the document ID on success, or None if DB is not available.
    """
    db = init_firestore()
    if db is None:
        return None

    try:
        doc_ref = db.collection("analyzed_events").document()
        
        # Add fee logic
        price_str = event_data.get("price", "")
        is_free, amount = _parse_fee(price_str)
        event_data["isFree"] = is_free
        event_data["entryFee"] = amount
        
        payload = {
            **event_data,
            "source_url": source_url,
            "analyzed_at": datetime.now(timezone.utc).isoformat(),
        }
        doc_ref.set(payload)
        print(f"[DB] Event saved with ID: {doc_ref.id}")
        return doc_ref.id
    except Exception as e:
        print(f"[DB] Firestore save failed: {e}")
        return None

async def save_chat_message(user_id: str, event_id: str, role: str, content: str) -> bool:
    """
    Saves a single chat message to the 'chats' collection for a specific user.
    """
    db = init_firestore()
    if db is None:
        return False

    try:
        # Each user has a subcollection/document or we use a flat collection with user_id
        # Let's use a flat collection 'chats' with user_id for simplicity in queries
        db.collection("chats").add({
            "user_id": user_id,
            "event_id": event_id,
            "role": role,
            "content": content,
            "timestamp": datetime.now(timezone.utc),
        })
        return True
    except Exception as e:
        print(f"[DB] Failed to save chat message: {e}")
        return False


async def get_chat_history(user_id: str, event_id: str, limit: int = 10) -> List[dict]:
    """
    Retrieves the most recent chat messages for a user.
    """
    db = init_firestore()
    if db is None:
        return []

    try:
        docs = (
            db.collection("chats")
            .where(filter=firestore.FieldFilter("user_id", "==", user_id))
            .where(filter=firestore.FieldFilter("event_id", "==", event_id))
            .order_by("timestamp", direction=firestore.Query.DESCENDING)
            .limit(limit)
            .get()
        )

        history = []
        for doc in docs:
            data = doc.to_dict()
            history.append({
                "role": data["role"],
                "content": data["content"]
            })
        
        # Return in chronological order
        history.reverse()
        return history
    except Exception as e:
        print(f"[DB] Failed to fetch chat history: {e}")
        return []
