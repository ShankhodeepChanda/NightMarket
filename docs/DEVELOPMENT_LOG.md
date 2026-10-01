# Development Log

**Purpose:** Session-by-session record of what was built, decisions made, and issues encountered.

---

## Session 1 — 2026-09-30

**Phase:** Phase 0 — Project Foundation

### Environment Setup

- Verified Flutter 3.47.5 installed
- Verified Dart 3.13.4 installed
- Installed Android Studio
- Installed Android SDK 36.0.0
- Installed Android SDK Command-line Tools
- Accepted Android licenses
- Confirmed Android toolchain fully operational

### Project Transformation

Starting state:
- Default Flutter counter template
- Named `first_app`
- Package `com.example.first_app`

Completed:
1. ✅ Renamed package `first_app` → `night_market` in `pubspec.yaml`
2. ✅ Updated application ID `com.example.first_app` → `com.nightmarket.app`
3. ✅ Updated Android namespace to `com.nightmarket.app`
4. ✅ Renamed Android activity package from `com.example.first_app` to `com.nightmarket.app`
5. ✅ Moved `MainActivity.kt` to new package directory
6. ✅ Updated app labels to "Night Market"
7. ✅ Updated web manifest and metadata

### Architecture Established

Created feature-oriented structure:
```
lib/
├── main.dart
├── app/
│   ├── app.dart (with bottom navigation)
│   ├── router/app_router.dart
│   └── theme/
│       ├── app_theme.dart
│       └── app_colors.dart
├── core/
│   ├── constants/app_constants.dart
│   └── widgets/placeholder_page.dart
└── features/
    ├── home/pages/home_page.dart
    ├── marketplace/pages/marketplace_page.dart
    ├── community/pages/community_page.dart
    ├── skills/pages/skills_page.dart
    └── profile/pages/profile_page.dart
```

### Theme System

- Material 3 configured
- Seed color: `#4F46E5` (deep indigo)
- Accent color: `#F59E0B` (amber)
- Light + dark themes with system detection
- Bottom navigation styled

### Navigation

- Persistent bottom navigation bar
- 5 main tabs: Home, Market, Community, Skills, Profile
- Uses `IndexedStack` to preserve state across tab switches
- Each tab shows placeholder page with icon and description

### Documentation Created

- ✅ `CLAUDE.md` — project instructions for Claude Code
- ✅ `docs/PROJECT.md` — project overview
- ✅ `docs/ARCHITECTURE.md` — technical architecture
- ✅ `docs/DATABASE.md` — planned Firestore schema
- ✅ `docs/FEATURES.md` — feature status tracker
- ✅ `docs/DESIGN_SYSTEM.md` — theme and design tokens
- ✅ `docs/SECURITY.md` — security considerations

### Files Modified

**Configuration:**
- `pubspec.yaml`
- `android/app/build.gradle.kts`
- `android/app/src/main/AndroidManifest.xml`
- `web/index.html`
- `web/manifest.json`

**Code:**
- `lib/main.dart`
- Created 11 new Dart files in proper structure
- Moved `MainActivity.kt` to new package location

### Decisions Made

| Decision | Rationale |
|----------|-----------|
| Transform in place vs. fresh project | Keep current directory, avoid session switch |
| Material 3 | Modern, accessible, good defaults |
| Feature-oriented structure | Scalability, clear boundaries |
| No routing package yet | Simple navigation sufficient for Phase 0 |
| Indigo + amber color scheme | Modern, trustworthy, student-friendly |
| Bottom navigation | Standard mobile pattern, always accessible |

### Issues Encountered

1. **Android SDK missing** — resolved by installing Android Studio
2. **cmdline-tools missing** — resolved via SDK Manager
3. **Folder still named `first_app`** — acceptable; Flutter package name is what matters

### What Works Now

✅ App compiles  
✅ Bottom navigation between 5 tabs  
✅ Placeholder pages for all features  
✅ Light/dark theme support  
✅ Material 3 styling  

### What Doesn't Exist Yet

❌ Firebase integration  
❌ Authentication  
❌ Any real features  
❌ Database models  
❌ Tests  

### Next Session Goals

1. Update `.gitignore` for Firebase files
2. Initialize Git repository
3. Create first commit
4. Run `flutter pub get`
5. Run `flutter analyze` — verify zero errors
6. Build for web or run on emulator — verify app launches
7. Complete Phase 0 verification

### Time Spent

Approximately 30-40 minutes of active implementation.

---

## Session 6 — 2026-10-01

**Phase:** Phase 4 — User Profile

### Completed
- [x] Created `UserProfile` model (`models/user_profile.dart`) with `fromMap`/`toMap`, `copyWith`, `initials`
- [x] Created `ProfileService` singleton with mock injection (`services/profile_service.dart`)
- [x] Updated `ProfilePage` with `FutureBuilder`, `LoadingSkeleton`, `ErrorState`, `ProfileCard`, setup prompt
- [x] Created `EditProfilePage` with name/college/bio fields, skills chips (max 5), image picker preview, save actions
- [x] Added `MockProfileService`, `MockAuthServiceWithUser`, `FakeFirebaseUser` test helpers
- [x] Wrote 6 profile page widget tests and 13 edit profile widget tests
- [x] Fixed `widget_test.dart` legacy failure by adding mock instances
- [x] Updated documentation (`ARCHITECTURE.md`, `DEVELOPMENT_LOG.md`, `ROADMAP.md`)
- [x] `flutter analyze` clean, `flutter test`: 31/31 passing

### Code Changes
- Modified: `docs/ARCHITECTURE.md`, `test/widget_test.dart`
- Created: `lib/features/profile/models/user_profile.dart`, `lib/features/profile/services/profile_service.dart`, `lib/features/profile/pages/edit_profile_page.dart`
- Updated: `lib/features/profile/pages/profile_page.dart`
- Created test helpers: `test/helpers/mock_profile_service.dart`, `test/helpers/mock_auth_service_with_user.dart`, `test/helpers/fake_firebase_user.dart`
- Created tests: `test/features/profile/pages/profile_page_test.dart`, `test/features/profile/pages/edit_profile_page_test.dart`

### Decisions Made
| Decision | Rationale |
|----------|-----------|
| Singleton + mock injector for ProfileService | Keeps widget tests isolated from Firebase SDK |
| `FutureBuilder` on ProfilePage | Clean reactive loading/error/loaded states |
| Skills capped at 5 | Matches design spec, prevents overflow |
| `copyWith` on UserProfile | Easy immutable updates in edit flow |

### Issues Encountered
1. `widget_test.dart` failed due to `ProfileService` initializing Firebase — resolved by adding mock instances in setUp
2. Off-screen taps in `SingleChildScrollView` — resolved with `tapVisible()` using `ensureVisible()`
3. `use_null_aware_elements` lint on `photoUrl` — resolved by assigning outside literal

### What's Still Broken
❌ None — Phase 4 fully verified.

### Next Session Goals
- Do not proceed to Phase 5 until explicitly instructed.
- Update `ROADMAP.md` to mark Phase 4 complete.

---

## Template for Future Sessions

```markdown
## Session N — YYYY-MM-DD

**Phase:** Phase X — Feature Name

### Goals
- Goal 1
- Goal 2

### Completed
- [x] Task 1
- [x] Task 2

### Code Changes
- Modified: file1, file2
- Created: file3, file4

### Decisions Made
| Decision | Rationale |
|----------|-----------|
| ... | ... |

### Issues Encountered
1. **Issue description** — resolution

### What Works Now
✅ Feature X
✅ Feature Y

### What's Still Broken
❌ Issue A
❌ Issue B

### Next Session Goals
- Goal 1
- Goal 2
```

## Session 2-3 — 2026-09-30

**Phase:** Phase 1 — Design System

### Completed
- [x] Extracted design components into core/constants/design_tokens.dart
- [x] Built reusable components (LoadingSkeleton, EmptyState, ErrorState)
- [x] Built core card widgets (ProductCard, EventCard, ProfileCard)

### Code Changes
- Modified: pubspec.yaml
- Created: lib/core/widgets/card_wrappers.dart, design_tokens.dart, empty_state.dart, error_state.dart, etc.

### What Works Now
✅ Centralized Design System using Semantic Colors and Spacings

---

## Session 4 — 2026-09-30

**Phase:** Phase 2 — Basic App Shell

### Completed
- [x] Developed SplashPage
- [x] Developed OnboardingPage with multiple pages and shared preferences to detect first startup
- [x] Complete Widget test coverage for Splash and Onboarding

### Code Changes
- Created: splash_page.dart, onboarding_page.dart
- Created: tests for the new flows

---

## Session 5 — 2026-09-30

**Phase:** Phase 3 — Authentication

### Completed
- [x] Setup Firebase core dependencies
- [x] Developed AuthService as a singleton with mock capabilities for tests
- [x] UI implementation for LoginPage, RegisterPage, ForgotPasswordPage
- [x] Integrated AuthGate for stream-based routing
- [x] Replaced routing flows in Splash and Onboarding to land correctly at AuthGate
- [x] Comprehensive testing strategy without needing actual Firebase connection

### Code Changes
- Modified: main.dart, splash_page_test.dart, onboarding_page_test.dart, widget_test.dart
- Created: lib/app/auth_gate.dart, lib/core/services/auth_service.dart, lib/features/auth/...
- Created: 	est/helpers/mock_auth_service.dart, 	est/features/auth/pages/auth_pages_test.dart

### Decisions Made
| Decision | Rationale |
|----------|-----------|
| AuthService with mock injector | Isolates widget tests from running actual platform channels |
| AuthGate as routing root | Easiest reactive model to ensure user state pushes correct screens |

### What Works Now
✅ Complete auth UI navigation flows
✅ Testable UI layer with mock injection
✅ Solid widget test coverage
