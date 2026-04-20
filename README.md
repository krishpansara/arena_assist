<div align="center">

<img src="https://img.shields.io/badge/Google%20Prompt%20Wars-Hackathon%202026-4285F4?style=for-the-badge&logo=google&logoColor=white" />

# 🏟️ Arena Assist

### *Smart Event Experience System — Built for Thousands. Designed for Every Individual.*

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-1.0.0-009688?style=flat-square&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%2B%20Auth-FFCA28?style=flat-square&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Google Cloud Run](https://img.shields.io/badge/Cloud%20Run-Deployed-4285F4?style=flat-square&logo=googlecloud&logoColor=white)](https://cloud.google.com/run)
[![Gemini AI](https://img.shields.io/badge/Gemini-AI%20Powered-8E75B2?style=flat-square&logo=google&logoColor=white)](https://ai.google.dev)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

> **A real-time, AI-powered platform that transforms large-scale sporting and cultural events into safe, navigable, and seamlessly coordinated experiences — from gate entry to emergency evacuation.**

</div>

---

## 🎯 The Problem

Large events — sports finals, music festivals, university summits — host tens of thousands of attendees simultaneously. The operational reality is harsh:

| Challenge | Impact |
|---|---|
| 🚦 Crowd bottlenecks at gates & concessions | Long waits, missed moments |
| 🗺️ No real-time indoor navigation | Attendees lost, late arrivals |
| 🚨 Slow emergency response (manual coordination) | Safety risk at scale |
| 📡 Zero situational awareness for organizers | Reactive, not proactive decisions |
| 🎤 No centralized insight from event content | Missed engagement opportunities |

> *Google Prompt Wars 2026 — Problem Statement: "Design a solution that improves the physical event experience for attendees at large-scale sporting venues."*

---

## 💡 The Solution

Arena Assist is a **full-stack smart event platform** combining real-time crowd intelligence, AI-driven insights, and an emergency-grade safety layer — all surfaced through a polished Flutter mobile app.

```
User enters event URL / name → AI scrapes & synthesizes event details →
Event loads with live crowd map → Smart navigation routes attendees →
AI monitors crowd density in real time → SOS available at one tap →
Organizers see it all in a unified dashboard
```

---

## ✨ Feature Breakdown


### 🗺️ Venue Navigation & Crowd Heatmaps
- Interactive floor map with live crowd density overlays (grid-based heatmap)
- Turn-by-turn routing that avoids dense zones
- Geocoded venue locations via Nominatim — no hardcoded coordinates

### 🚨 Safety & SOS Emergency System
- **One-tap SOS** triggers an alert with the attendee's real-time GPS coordinates
- Live location sharing streamed to event security
- SOS active overlay with pulsing visual feedback
- Evacuation routing surfaced automatically during emergencies

### 🤖 AI Event Analyzer (Gemini-Powered)
- Paste any event URL → backend scrapes + Gemini synthesizes structured event data
- Extracts: speakers, schedule, venue details, session summaries
- Uploaded automatically to Firestore for the app to consume

### 🎙️ Live Transcript Insights
- Speech-to-text capture during sessions
- Gemini generates key takeaways, action items, and summaries in real time

### 📢 Alerts & Push Notifications
- Organizer-pushed crowd alerts and announcements
- Inject emergency or informational alerts into the live feed

### 🚌 Transport Coordination
- Nearby transport options surfaced for post-event crowd dispersal
- Reduces exit congestion by staggering departure recommendations

### 📊 Event Budget Tracker
- Per-event spend tracking scoped to the organizer profile
- Visual breakdowns of budget categories

### 🍔 Food & Facility Crowd Tracking
- Real-time occupancy at concession stands and restrooms
- Helps attendees choose the shortest queue

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Flutter App (Client)                 │
│  Feature-First + Clean Architecture + Riverpod          │
│                                                         │
│  auth │ venue_map │ safety │ event_analyzer │ alerts    │
│     │ transport │ workshop │ transcript │ budget        │
└──────────────────┬──────────────────────────────────────┘
                   │ HTTPS / REST
        ┌──────────▼─────────────────────────┐
        │        FastAPI Backend             │
        │       (Cloud Run / Docker)         │
        │                                    │
        │       /api/v1/analyze              │
        │      /api/v1/transcript            |
        |   /api/v1/transcript/insights      │
        └─────────────────┬──────────────────┘
                          │
          ┌───────────────▼─────────────────┐
          │         Google Services         │
          │                                 │
          │  Firebase Auth  │  Firestore    │
          │  Gemini AI      │  Cloud Run    │
          └─────────────────────────────────┘
```

**State Management:** Riverpod (providers + async notifiers)  
**Navigation:** GoRouter with nested routes & guards  
**Architecture:** Feature-first, Clean Architecture (Data → Domain → Presentation)

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| **Mobile Frontend** | Flutter 3.x (Dart) | Cross-platform UI |
| **State Management** | Riverpod 2.x | Reactive, testable state |
| **Navigation** | GoRouter | Declarative routing |
| **Backend API** | FastAPI (Python) | Event analysis pipeline |
| **LLM** | Gemini (`google-generativeai`) + Groq | AI synthesis & transcripts |
| **Auth** | Firebase Authentication | Secure user identity |
| **Database** | Cloud Firestore | Real-time NoSQL data |
| **Maps** | flutter_map + Nominatim geocoding | Venue navigation |
| **Location** | Geolocator + permission_handler | Live GPS tracking |
| **Scraping** | HTTPX + BeautifulSoup4 | Event data extraction |
| **Containerisation** | Docker | Backend portability |
| **Deployment** | Google Cloud Run | Serverless backend |

---

## 📁 Project Structure

```
arena_assist/
├── lib/
│   ├── core/
│   │   ├── router/         # GoRouter configuration
│   │   ├── theme/          # Design system & tokens
│   │   └── providers/      # Global providers
│   └── features/
│       ├── auth/           # Firebase Auth flow
│       ├── venue_map/      # Interactive map + heatmap
│       ├── safety/         # SOS + emergency overlay
│       ├── event_analyzer/ # AI event synthesis UI
│       ├── alerts/         # Push alerts feed
│       ├── transport/      # Transport options
│       ├── workshop/       # Speaker sessions & bios
│       ├── transcript/     # Speech-to-text insights
│       ├── food/           # Facility crowd tracking
│       ├── budget/         # Event budget tracker
│       └── profile/        # User profile & settings
│
└── backend/
    ├── main.py             # FastAPI app + endpoints
    ├── scraper.py          # HTTPX + BeautifulSoup scraper
    ├── event_analyzer.py   # Gemini synthesis pipeline
    ├── llm.py              # LLM client + prompt engineering
    ├── transcript_summarizer.py  # Session insight generation
    ├── database.py         # Firestore integration
    ├── inject_alerts.py    # Alert injection utility
    └── requirements.txt
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.x`
- Python `3.11+`
- Firebase project with Firestore & Auth enabled
- Gemini API key (Google AI Studio)

### 1. Clone the Repository

```bash
git clone https://github.com/krishpansara/arena-assist.git
cd arena-assist
```

### 2. Flutter Frontend

```bash
# Install dependencies
flutter pub get

# Copy environment file
cp .env.example .env
# Fill in your Firebase / API keys

# Run on device
flutter run
```

### 3. FastAPI Backend

```bash
cd backend

# Create and activate virtual environment
python -m venv venv
venv\Scripts\activate        # Windows
# source venv/bin/activate   # macOS / Linux

# Install dependencies
pip install -r requirements.txt

# Configure environment
cp .env.example .env
# Set GEMINI_API_KEY, GROQ_API_KEY, FIREBASE service account path

# Start development server
uvicorn backend.main:app --reload --port 8000
```

API docs available at `http://localhost:8000/docs`

### 4. Docker (Backend)

```bash
docker build -t arena-assist-backend ./backend
docker run -p 8000:8000 --env-file backend/.env arena-assist-backend
```

---

## 🔌 API Reference

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/` | Health check |
| `POST` | `/api/v1/analyze` | Analyze event URL → Gemini synthesis → Firestore |
| `POST` | `/api/v1/transcript/insights` | Generate AI insights from a session transcript |

### Example — Analyze Event

```bash
curl -X POST http://localhost:8000/api/v1/analyze \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example-event.com", "type": "url"}'
```

**Response:**
```json
{
  "status": "success",
  "doc_id": "firestore-document-id",
  "data": {
    "event_name": "...",
    "venue": "...",
    "speakers": [...],
    "sessions": [...]
  }
}
```

---

## 🔐 Privacy & Security

- 📍 **Location tracking is event-scoped** — GPS is only active while within an active event session
- 🔒 **Firebase Auth** handles all identity — no passwords stored server-side
- 🛡️ **Data in transit encrypted** via HTTPS on all endpoints
- ✅ **Explicit user consent** required before location permissions are granted
- 🔑 All secrets managed via `.env` — never committed to version control

---

## 🗺️ Feature Scope

### ✅ Currently Implemented

| Domain | Feature | Details |
|---|---|---|
| **Auth** | Email & role-based login | Firebase Auth, organizer vs attendee roles |
| **Auth** | Onboarding flow | Verify access screen + role selection |
| **Event Discovery** | AI Event Analyzer | Paste URL → Gemini scrapes & synthesizes event data into Firestore |
| **Event Discovery** | Event detail display | Schedule, speakers, venue info auto-populated from AI pipeline |
| **Navigation** | Venue map | Interactive flutter_map with Nominatim geocoding |
| **Navigation** | Turn-by-turn routing | Avoids crowd-dense zones |
| **Crowd Intelligence** | Grid-based crowd heatmap | Visual density overlay on venue map |
| **Safety** | One-tap SOS | Triggers alert with real-time GPS coordinates |
| **Safety** | SOS active overlay | Pulsing visual feedback during emergency |
| **Safety** | Live location sharing | GPS streamed to event security |
| **AI Insights** | Session transcript capture | Speech-to-text during live sessions |
| **AI Insights** | Gemini transcript summarizer | Key takeaways & action items generated post-session |
| **Alerts** | Push alert feed | Organizer-injected crowd & emergency alerts |
| **Transport** | Post-event transport info | Nearby options surfaced for exit dispersal |
| **Workshop** | Speaker sessions & bios | Session list with speaker profile navigation |
| **Food & Facilities** | Facility crowd tracking | Occupancy indicators for concessions & restrooms |
| **Budget** | Event budget tracker | Per-event spend tracking with category breakdowns |
| **Profile** | User profile & settings | Account management, preferences |

---

### 🔭 Future Implementation Scope

#### Near-Term (Next Sprint)

| Feature | Description | Complexity |
|---|---|---|
| **WebSocket live crowd streaming** | Replace polling with real-time crowd density push updates | Medium |
| **Smart exit staggering** | AI recommends staggered departure times to reduce exit crush | Medium |
| **Offline-first sync** | Cache critical event data locally for low-signal environments | Medium |
| **Organizer web dashboard** | A web UI for event managers to monitor crowd, push alerts & view analytics | High |

#### Mid-Term

| Feature | Description | Complexity |
|---|---|---|
| **ML crowd prediction** | Predict bottlenecks 10–30 min ahead using historical density patterns | High |
| **Smart gate routing** | Dynamically assign attendees to least-congested entry points at arrival | High |
| **Evacuation route engine** | Auto-surface optimal exit paths during SOS / emergency scenarios | High |
| **Group location sharing** | Friends can share live location with each other inside the venue | Medium |
| **Multi-event support** | Support concurrent events with isolated data and maps per venue | Medium |

#### Long-Term Vision

| Feature | Description | Complexity |
|---|---|---|
| **Venue digital twin** | 3D indoor map with real-time overlay of crowd, services, and alerts | Very High |
| **Predictive concession management** | AI-driven restocking alerts for food stalls based on crowd flow | High |
| **Accessibility routing** | Dedicated navigation paths for differently-abled attendees | Medium |
| **Post-event sentiment analysis** | Analyze attendee feedback + transcripts to score event quality | Medium |
| **Cross-venue analytics platform** | Aggregated insights for event organizers across multiple venues | High |

---

## 🏆 Hackathon Context

> **Google Prompt Wars 2026** — *Physical Event Experience Track*
>
> Problem Statement: *"Design a solution that improves the physical event experience for attendees at large-scale sporting venues. The system should address challenges such as crowd movement, waiting times, and real-time coordination, while ensuring a seamless and enjoyable experience."*

Arena Assist was architected and built end-to-end during this hackathon, targeting real operational pain points at scale.

---

## 👨‍💻 Author

**Krish Pansara**

[![GitHub](https://img.shields.io/badge/GitHub-krishpansara-181717?style=flat-square&logo=github)](https://github.com/krishpansara)

---

<div align="center">

*Built with ❤️ for Google Prompt Wars 2026*

</div>
