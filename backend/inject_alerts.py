import os
import sys
from datetime import datetime, timezone
from database import init_firestore

def inject_mock_alerts():
    db = init_firestore()
    if not db:
        print("Firestore not initialized.")
        return

    # Get all users (or we can just target a specific one if known)
    users_ref = db.collection("users")
    users = users_ref.limit(10).get()

    if not users:
        print("No users found in Firestore. Creating a dummy user for testing.")
        dummy_user = users_ref.document("test_user_123")
        dummy_user.set({"email": "test@example.com"})
        users = [dummy_user.get()]

    alerts = [
        {
            "title": "Event Starting Soon!",
            "message": "The main event will begin in exactly one hour. Please find your seats.",
            "type": "eventStarting",
            "isRead": False,
            "timestamp": datetime.now(timezone.utc)
        },
        {
            "title": "Restroom Wait Times",
            "message": "Lines for the East Wing restrooms are currently very short.",
            "type": "success",
            "isRead": False,
            "timestamp": datetime.now(timezone.utc)
        },
        {
            "title": "Merchandise Sale",
            "message": "Last call for merchandise! 20% off all remaining items in the North Concourse.",
            "type": "warning",
            "isRead": False,
            "timestamp": datetime.now(timezone.utc)
        },
    ]

    for user_doc in users:
        user_id = user_doc.id
        print(f"Injecting alerts for User ID: {user_id}")
        alerts_col = users_ref.document(user_id).collection("alerts")
        
        for alert in alerts:
            alerts_col.add(alert)
    
    print("Mock alerts injected successfully!")

if __name__ == "__main__":
    inject_mock_alerts()
