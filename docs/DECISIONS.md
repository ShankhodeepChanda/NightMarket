# Architectural Decisions

**Purpose:** Record key technical and design decisions with their context and rationale.

---

## ADR-001: Feature-Oriented Architecture

**Date:** 2026-09-30  
**Status:** Accepted

### Context

Need to structure the Flutter codebase to support incremental development of three major systems (Marketplace, Community, Skills) while maintaining clarity and avoiding a monolithic structure.

### Decision

Adopt a feature-oriented architecture:
```
lib/
├── app/          # App-level configuration
├── core/         # Shared infrastructure
├── features/     # Business features (home, marketplace, community, skills, profile)
└── shared/       # Cross-feature models/widgets (future)
```

Each feature is self-contained with its own pages, widgets, models, and repositories.

### Rationale

- **Scalability**: As features grow, boundaries remain clear
- **Parallel development**: Multiple features can be built simultaneously
- **Maintainability**: Easy to locate code related to specific features
- **Testing**: Features can be tested in isolation

### Alternatives Considered

1. **Flat structure** (everything in `lib/`) — rejected: becomes unmaintainable beyond 10-15 files
2. **Layer-based** (ui/, data/, domain/) — rejected: spreads related code across directories

---

## ADR-002: Material 3 Design System

**Date:** 2026-09-30  
**Status:** Accepted

### Context

Need a design system that:
- Provides good defaults
- Supports light/dark modes
- Is accessible
- Has modern aesthetics
- Doesn't require extensive custom styling initially

### Decision

Use Material 3 (Material You) with `ColorScheme.fromSeed`.

Seed color: `#4F46E5` (deep indigo)  
Accent: `#F59E0B` (amber)

### Rationale

- Material 3 is Flutter's default — well-integrated, well-documented
- Automatic color harmonization from seed color
- Built-in accessibility (contrast, touch targets)
- Dynamic theming built-in
- Reduces design decisions needed in early phases

### Alternatives Considered

1. **Custom design system from scratch** — rejected: too much upfront work
2. **Cupertino (iOS-style)** — rejected: Android-first approach
3. **Third-party UI kit** — rejected: introduces dependency, learning curve

---

## ADR-003: No State Management Package (Yet)

**Date:** 2026-09-30  
**Status:** Accepted (Revisit in Phase 4-6)

### Context

Flutter has many state management options: Provider, Riverpod, Bloc, GetX, MobX, etc.

### Decision

Use vanilla `StatefulWidget` and `setState` initially. Defer state management decision until we have real stateful features.

### Rationale

- Current Phase 0 has no complex state
- Premature abstraction is wasteful
- Actual feature complexity will inform the right choice
- Easy to refactor later with clear patterns

### When to Revisit

When implementing:
- Authentication (persistent user state)
- Real-time data (Firestore streams)
- Complex forms with validation
- Cross-feature data sharing

### Likely Future Choice

Riverpod or Provider — both well-supported, idiomatic Flutter.

---

## ADR-004: Firebase Backend

**Date:** 2026-09-30  
**Status:** Accepted

### Context

Need a backend for:
- Authentication
- Database (users, products, events, messages)
- File storage (images)
- Push notifications
- Real-time updates

### Decision

Use Firebase (Auth, Firestore, Storage, Cloud Messaging).

### Rationale

- **Rapid development**: No custom backend needed
- **Authentication built-in**: Email/password, Google, college email verification
- **Real-time**: Firestore streams for messaging, notifications
- **Scalability**: Handles growth automatically
- **Cost**: Free tier sufficient for MVP, pay-as-you-grow
- **Flutter integration**: Official `firebase_core`, `cloud_firestore` packages

### Alternatives Considered

1. **Supabase** — rejected: less mature Flutter support
2. **Custom Node.js/Express backend** — rejected: too much infrastructure work
3. **Appwrite** — rejected: self-hosting complexity

### Trade-offs

**Pros:**
- Fast to prototype
- No server management
- Built-in security rules

**Cons:**
- Vendor lock-in (mitigated: data export available)
- Query limitations (no full-text search, no complex joins)
- Cost unpredictable at scale (mitigated: can optimize queries)

---

## ADR-005: Android-First, iOS Later

**Date:** 2026-09-30  
**Status:** Accepted

### Context

Limited development resources. Need to ship MVP quickly.

### Decision

Target Android initially. Add iOS support later via the same Flutter codebase.

### Rationale

- **Smaller scope**: One platform = faster MVP
- **Market fit validation**: Test with Android users first
- **Flutter's promise**: 90%+ code reuse for iOS
- **Cost**: Google Play ($25 one-time) vs. App Store ($99/year)

### iOS Compatibility Strategy

- Keep platform-specific code isolated (`android/`, `ios/` directories)
- Use Flutter's platform-agnostic APIs
- Test on iOS simulator periodically to catch incompatibilities early
- Document platform-specific decisions in this file

---

## ADR-006: Persistent Bottom Navigation

**Date:** 2026-09-30  
**Status:** Accepted

### Context

Need navigation between five major sections: Home, Marketplace, Community, Skills, Profile.

### Decision

Use persistent `BottomNavigationBar` with `IndexedStack` to preserve state across tabs.

### Rationale

- **Standard pattern**: Users understand bottom nav immediately
- **Accessibility**: Always reachable, no nested navigation to get back
- **State preservation**: `IndexedStack` keeps each tab's scroll position and state
- **Mobile-first**: Bottom nav is thumb-friendly on phones

### Alternatives Considered

1. **Drawer navigation** — rejected: requires extra tap, less discoverable
2. **Tab bar** (top) — rejected: awkward reach on large phones
3. **App bar tabs** — rejected: only fits 3-4 tabs comfortably

---

## ADR-007: No Routing Package (Yet)

**Date:** 2026-09-30  
**Status:** Accepted (Revisit in Phase 5-7)

### Context

Flutter has routing packages: `go_router`, `auto_route`, `beamer`.

### Decision

Use simple named routes via `MaterialApp.routes` initially.

### Rationale

- Current navigation is trivial (just bottom nav tabs)
- Named routes sufficient for Phase 0-4
- Routing packages add complexity and learning curve
- Deep linking not needed yet

### When to Revisit

When we need:
- Deep linking (e.g., `/product/abc123`)
- Complex nested navigation (e.g., product → seller → reviews)
- Web support (clean URLs)

### Likely Future Choice

`go_router` — official recommendation, declarative, supports deep linking.

---

## ADR-008: Git + GitHub

**Date:** 2026-09-30  
**Status:** Accepted

### Context

Need version control and backup.

### Decision

Use Git for version control, GitHub for remote hosting.

### Rationale

- **Standard**: Git is the industry standard
- **Free**: GitHub free tier sufficient
- **Integration**: Works with Claude Code, VS Code, CI/CD
- **Backup**: Code safe in the cloud

### Git Strategy

- Main branch: `main`
- Feature branches for major features (e.g., `feature/authentication`)
- Commit after each complete phase or major milestone
- No force pushes to `main`

---

## ADR-009: Transform Project In Place

**Date:** 2026-09-30  
**Status:** Accepted

### Context

Starting with a default `first_app` Flutter template. Could either:
1. Create new `night_market` project in new directory
2. Transform existing project in place

### Decision

Transform in place.

### Rationale

- Avoid switching Claude Code sessions
- Preserve existing setup and configuration
- Folder name (`first_app`) doesn't matter — Flutter package name does

### Trade-offs

**Pro:** No session disruption  
**Con:** Folder name doesn't match project name (acceptable)

---

## Template for Future ADRs

```markdown
## ADR-XXX: Decision Title

**Date:** YYYY-MM-DD  
**Status:** Proposed | Accepted | Rejected | Deprecated | Superseded by ADR-YYY

### Context
What is the issue or situation?

### Decision
What did we decide?

### Rationale
Why this decision?

### Alternatives Considered
What other options did we evaluate?

### Consequences
What are the trade-offs?

### When to Revisit
When should we reconsider this decision?
```
