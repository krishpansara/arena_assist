import os
import firebase_admin
from firebase_admin import credentials, firestore
import re
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
    Returns the Firestore client, or None if the service account is missing.
    """
    global _db
    if _db is not None:
        return _db

    service_account_path = os.getenv("FIREBASE_SERVICE_ACCOUNT_PATH", "serviceAccountKey.json")

    if not os.path.exists(service_account_path):
        print(f"[DB] Service account key not found at '{service_account_path}'. Firestore saving is DISABLED.")
        return None

    if not firebase_admin._apps:
        cred = credentials.Certificate(service_account_path)
        firebase_admin.initialize_app(cred)

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
