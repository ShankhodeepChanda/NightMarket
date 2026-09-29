# Architecture

**Last Updated:** 2026-09-30  
**Version:** 0.1.0

## Overview

Night Market follows a **feature-oriented architecture** with clear separation between:
- Application-level configuration (`app/`)
- Shared infrastructure (`core/`)
- Business features (`features/`)

This structure supports incremental development and maintains future iOS compatibility.

## Directory Structure

```
lib/
├── main.dart                         # Application entry point
├── app/                              # App-level configuration
│   ├── app.dart                      # Root widget + navigation scaffold
│   ├── router/
│   │   └── app_router.dart           # Route definitions
│   └── theme/
│       ├── app_theme.dart            # Material 3 theme configuration
│       └── app_colors.dart           # Brand color constants
├── core/                             # Shared infrastructure
│   ├── constants/
│   │   └── app_constants.dart        # App-wide constants
│   ├── widgets/
│   │   └── placeholder_page.dart     # Reusable placeholder widget
│   ├── services/                     # (Future: Firebase, API clients)
│   ├── utils/                        # (Future: helpers, formatters)
│   └── errors/                       # (Future: error handling)
├── features/                         # Business features
│   ├── home/
│   │   └── pages/
│   │       └── home_page.dart
│   ├── marketplace/
│   │   └── pages/
│   │       └── marketplace_page.dart
│   ├── community/
│   │   └── pages/
│   │       └── community_page.dart
│   ├── skills/
│   │   └── pages/
│   │       └── skills_page.dart
│   └── profile/
│       └── pages/
│           └── profile_page.dart
└── shared/                           # (Future: cross-feature models/widgets)
```

## Navigation Architecture

**Current:** Simple scaffold with `IndexedStack` + `BottomNavigationBar`.

Five main sections accessible via persistent bottom navigation:
- 🏠 **Home** — personalized feed
- 🛒 **Market** — marketplace
- 🎓 **Community** — colleges, clubs, events
- 💼 **Skills** — student services
- 👤 **Profile** — user profile

**Future:** Named routes via `app_router.dart` will handle deep navigation within each section.

## Theme System

Material 3 with dynamic color schemes generated from a seed color (`AppColors.seedColor`).

- Light and dark themes
- System theme mode detection
- Brand colors defined in `app_colors.dart`
- Consistent component styling (cards, inputs, buttons)

Theme configured in `app_theme.dart`, applied globally via `MaterialApp`.

## Feature Structure (Future)

Each feature will eventually follow:

```
features/<feature>/
├── pages/              # UI screens
├── widgets/            # Feature-specific widgets
├── models/             # Data models
├── repositories/       # Data access layer
└── services/           # Feature-specific logic
```

## Data Flow (Planned)

```
UI (Pages/Widgets)
     ↓
Repositories (data access)
     ↓
Firebase (Firestore, Auth, Storage)
```

State management approach TBD — will be decided when implementing the first stateful feature (likely authentication).

## Firebase Integration (Planned)

Services to be added in `core/services/`:
- `firebase_service.dart` — initialization
- `auth_service.dart` — authentication
- `firestore_service.dart` — database access
- `storage_service.dart` — file uploads

## Platform-Specific Code

Android-specific code isolated to:
- `android/` directory
- MainActivity: `com.nightmarket.app.MainActivity`

iOS-specific code will be isolated to:
- `ios/` directory
- AppDelegate (when iOS support is added)

**Goal:** 99% of `lib/` should be platform-agnostic.

## Key Architectural Decisions

| Decision | Rationale |
|----------|-----------|
| Feature-oriented structure | Each feature is self-contained; easier to navigate as the project grows |
| Material 3 | Modern, accessible design system; good defaults |
| No routing package yet | Simple navigation sufficient for Phase 0; will add `go_router` or similar when needed |
| No state management package yet | Will choose based on actual complexity when features are built |
| Firebase backend | Rapid development, authentication built-in, scales well for MVP |
| Android-first | Smaller initial scope; iOS via Flutter later with minimal code changes |

## Anti-Patterns to Avoid

❌ Don't put everything in `main.dart`  
❌ Don't mix business logic into UI widgets  
❌ Don't couple features to each other directly  
❌ Don't put platform-specific code in `lib/` without clear isolation  
❌ Don't add dependencies "just in case"  

## Next Architectural Milestones

1. **Phase 2** — Add authentication flow
2. **Phase 4** — Establish repository pattern for Firestore
3. **Phase 6** — Implement state management (decide on approach)
4. **Phase 9** — Add real-time messaging architecture
