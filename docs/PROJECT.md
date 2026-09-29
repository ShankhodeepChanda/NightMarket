# Night Market — Project Overview

**Version:** 0.1.0 (Phase 0 — Foundation)  
**Status:** Initial setup complete  
**Target Platform:** Android (primary), iOS (future)  
**Last Updated:** 2026-09-30

## What is Night Market?

Night Market is a comprehensive mobile application designed for college students. It combines three major systems into a unified digital campus ecosystem:

### 1. 🛒 Marketplace
Students can buy and sell products within their college community. Think eBay/Amazon patterns adapted for campus life — textbooks, electronics, furniture, course materials, etc.

### 2. 🎓 College Community
- Colleges and their clubs
- Campus events and announcements
- Event registration and reminders
- College-specific feeds

### 3. 💼 Student Skills Marketplace
- Students offer services and skills (design, coding, tutoring, photography, etc.)
- Job posting system where students can hire each other
- Portfolio showcase
- Reviews and reputation system

## Core Philosophy

Night Market is **not** three separate apps bundled together. It's a unified student ecosystem where:
- One student profile connects all three areas
- Reputation carries across marketplace, community, and skills
- The same account can be a buyer, seller, freelancer, client, event attendee, and club member

## Technology Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | Flutter + Dart |
| **Backend** | Firebase (Auth, Firestore, Storage, Cloud Messaging) |
| **Primary Platform** | Android |
| **Future Platform** | iOS (via the same Flutter codebase) |
| **Version Control** | Git + GitHub |
| **IDE** | VS Code |

## Current Status (Phase 0)

✅ Project initialized  
✅ Package renamed from `first_app` to `night_market`  
✅ Application ID: `com.nightmarket.app`  
✅ Architecture established (features/, core/, app/)  
✅ Material 3 theme configured  
✅ Bottom navigation scaffold (5 tabs)  
✅ Git repository initialized  
✅ Documentation structure created  

**What works right now:**
- App builds successfully
- Bottom navigation between 5 main sections
- Light/dark theme support
- Placeholder pages for all major features

**What doesn't exist yet:**
- Firebase integration
- Authentication
- Any actual features (marketplace, community, skills)
- Database models
- Real data

## Next Steps

Refer to `ROADMAP.md` for the complete development plan.

The immediate next phase is **Phase 1 — Design System**, where we'll establish the complete visual language before building features.

## Key Project Files

- `CLAUDE.md` — Instructions for Claude Code
- `docs/ARCHITECTURE.md` — Technical architecture
- `docs/ROADMAP.md` — Development milestones
- `docs/FEATURES.md` — Feature status tracker
- `lib/app/app.dart` — Application entry point and navigation
