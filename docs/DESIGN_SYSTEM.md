# Design System

**Last Updated:** 2026-09-30  
**Status:** Phase 1 complete — tokens, components, states, and image guidelines established

---

## Color System

### Brand Colors

Defined in `lib/app/theme/app_colors.dart`:

```dart
seedColor:   #4F46E5  // Deep indigo — primary brand color
accent:      #F59E0B  // Amber — highlights and CTAs
surfaceTint: #6366F1  // Lighter indigo — card overlays
```

### Material 3 Color Roles

Generated automatically from `seedColor` via `ColorScheme.fromSeed`:

**Light Mode:**
- Primary: derived from seed (`#4F46E5`)
- OnPrimary: contrasting text
- Secondary, Tertiary: harmonious variants
- Surface, Background: neutral tones
- Error: system red (`#B3261E`)

**Dark Mode:**
- Same roles, inverted luminance
- Follows system dark mode automatically (`ThemeMode.system`)

---

## Typography

**Font Family:** Roboto (system default, Material 3)

### Type Scale

| Token            | Usage                        |
|------------------|------------------------------|
| `displayLarge`  | Hero / landing headings      |
| `headlineMedium`| Section headers              |
| `titleLarge`     | Card titles, section titles  |
| `titleMedium`    | Subtitles, list item titles  |
| `bodyMedium`     | Body text                    |
| `bodySmall`      | Secondary info, captions     |
| `labelMedium`    | Tags, badges, meta info      |
| `labelSmall`     | Small tags, footnotes        |

**Future:** May add Inter or Poppins for brand distinction.

---

## Spacing (Standardized — Phase 1)

Centralized in `lib/core/constants/app_spacing.dart`:

```dart
class AppSpacing {
  AppSpacing._();
  static const double xs  = 4.0;
  static const double sm  = 8.0;
  static const double md  = 16.0;
  static const double lg  = 24.0;
  static const double xl  = 32.0;
  static const double xxl = 48.0;

  static const double pageHorizontal = md;   // 16
  static const double cardPadding     = md;   // 16
  static const double listItemSpacing = sm;   // 8
  static const double sectionSpacing   = lg;   // 24
}
```

---

## Corner Radius (Standardized — Phase 1)

Centralized in `lib/core/constants/app_radius.dart`:

```dart
class AppRadius {
  AppRadius._();
  static const double sm    = 8.0;   // Chips, tags, small buttons
  static const double md    = 12.0;  // Cards, inputs, standard surfaces
  static const double lg    = 16.0;  // Sheets, modals, large surfaces
  static const double circular = 9999.0; // Avatars, circular icons
}
```

---

## Elevation

Material 3 handles elevation automatically via `colorScheme.shadow` and surface tint.

- **Card elevation:** `1` (subtle shadow, no heavy elevation)
- **Button elevation:** Material defaults (`ElevatedButton`: 2, `FilledButton`: 1)

---

## Components (Phase 1 Implemented)

### Product Card
**File:** `lib/core/widgets/product_card.dart`

- Square thumbnail (`1.0` aspect ratio) with gradient placeholder
- Title (1 line, ellipsis), price (prominent, primary color)
- Condition tag (`surfaceContainerHighest`), location meta
- Tapable with `InkWell`

### Event Card
**File:** `lib/core/widgets/event_card.dart`

- Banner image (`16.0 / 9.0` aspect ratio) with gradient placeholder
- Event title (2 lines max), date/time (`tertiary` color), venue
- Footer: organizer (left) / attendee count (right)
- Tapable with `InkWell`

### Profile Card
**File:** `lib/core/widgets/profile_card.dart`

- Circular avatar (`80x80`, gradient with initials)
- Name (`titleMedium`), college (`bodySmall`)
- Skills chips (max 3 shown, `+N` overflow)
- Rating (`star_rounded`, `tertiary`) + review count
- Tapable with `InkWell`

---

## States (Phase 1 Implemented)

### Loading Skeleton
**File:** `lib/core/widgets/loading_skeleton.dart`

Custom shimmer loader with repeating gradient animation (`AnimationController`, `1500ms` duration). Factory constructors:

- `LoadingSkeleton.productCard()`
- `LoadingSkeleton.eventCard()`
- `LoadingSkeleton.profileCard()`

Uses theme `surfaceContainerHighest` ↔ `surfaceContainerHigh` colors.

### Empty State
**File:** `lib/core/widgets/empty_state.dart`

Contextual empty states with semantic factory constructors:

- `EmptyState.noMarketplaceListings()`
- `EmptyState.noEvents()`
- `EmptyState.noSavedItems()`
- `EmptyState.noSearchResults()`
- `EmptyState.noSkills()`

Includes icon (`primary` at `0.3` opacity), title (`titleLarge`), optional message (`bodyMedium`), and optional `FilledButton` action.

### Error State
**File:** `lib/core/widgets/error_state.dart`

Friendly error messages with retry/action buttons:

- `ErrorState.networkError({onRetry})` — `wifi_off_rounded`
- `ErrorState.notFound({onGoBack})` — `search_off_rounded`
- `ErrorState.general({message?, onRetry})` — `error_outline_rounded`
- `ErrorState.accessDenied({onGoBack})` — `lock_outline_rounded`

Includes error icon (`48px`, `error` color), title (`titleLarge`, `error` color), message (`bodyMedium`, `onSurfaceVariant`), and optional `OutlinedButton.icon` action.

---

## Image Guidelines (Phase 1)

Centralized in `lib/core/constants/app_image_constants.dart`:

```dart
class AppImageConstants {
  static const double productAspectRatio   = 1.0;      // Square
  static const double productAspectRatioWide = 4.0 / 3.0;
  static const double eventAspectRatio      = 16.0 / 9.0; // Banner
  static const double profileAspectRatio    = 1.0;      // Square

  static const int maxProductImageSize  = 5 * 1024 * 1024;  // 5MB
  static const int maxEventImageSize     = 5 * 1024 * 1024;
  static const int maxProfileImageSize   = 2 * 1024 * 1024;  // 2MB

  static const int compressionQuality  = 85;
  static const int maxImageDimension    = 2048;
}
```

- Product thumbnails: square (`1.0`)
- Event banners: wide (`16:9`)
- Profile avatars: square (`1.0`), rendered as circular
- Max upload sizes enforced per feature type
- Compression quality: 85%
- Max dimension: 2048px

---

## Icons

**Icon Set:** Material Icons (included with Flutter)

| Feature       | Key Icons                 |
|---------------|---------------------------|
| Home          | `home_outlined`           |
| Marketplace   | `storefront_outlined`     |
| Community     | `school_outlined`         |
| Skills        | `work_outline`            |
| Profile       | `person_outline`          |
| Loading       | shimmer gradient (custom) |
| Empty         | `storefront_outlined`, etc.|
| Error         | `wifi_off_rounded`, etc.  |

---

## Accessibility

Material 3 provides:
- Sufficient color contrast (WCAG AA minimum)
- Touch target sizes (`48px` minimum for interactive elements)
- Screen reader support (`Semantics` widgets available)

**Phase 1 additions:**
- Semantic text labels on all cards (`InkWell` provides tap announcements)
- Clear icon + text pairing on buttons (`FilledButton.icon`, `OutlinedButton.icon`)

**Future improvements:**
- Explicit semantic labels for complex cards
- High contrast mode toggle
- Reduced motion support (`AnimationController` can respect `MediaQuery.disableAnimations`)
- Dynamic font scaling (`MediaQuery.textScaler`)

---

## Dark Mode

- Automatically generated from `ColorScheme.fromSeed` with `brightness: Brightness.dark`
- System preference detected via `ThemeMode.system`
- No manual toggle yet — follows OS setting
- All Phase 1 components use theme tokens (`colorScheme.primary`, `surfaceVariant`, etc.) to stay theme-aware

---

## Animation (Phase 1)

- **Skeleton shimmer:** `AnimationController` with `LinearGradient` repeat at `1500ms`
- **Default Material:** button ripples, card hover (desktop/web future)

**Future:** Page transitions (`PageRouteBuilder`), micro-interactions for key actions.

---

## Component Patterns (Implemented)

### Card Pattern (All Cards)
- `Card(clipBehavior: Clip.antiAlias, margin: EdgeInsets.zero)`
- `InkWell` for tap feedback
- Consistent `AppSpacing.md` (`16`) padding inside content areas
- Gradient placeholders instead of broken image links

### Button Pattern
- Primary: `FilledButton`
- Secondary: `OutlinedButton`
- Tertiary: `TextButton`
- Action buttons include icon + label pairing

---

## Phase 1 Deliverables Complete

| Deliverable                   | Status | File                        |
|-------------------------------|--------|-----------------------------|
| Spacing tokens                | ✅     | `app_spacing.dart`          |
| Radius tokens                 | ✅     | `app_radius.dart`           |
| Image constants               | ✅     | `app_image_constants.dart`  |
| Product card                  | ✅     | `widgets/product_card.dart` |
| Event card                    | ✅     | `widgets/event_card.dart`   |
| Profile card                  | ✅     | `widgets/profile_card.dart` |
| Loading skeleton              | ✅     | `widgets/loading_skeleton.dart` |
| Empty state                   | ✅     | `widgets/empty_state.dart`  |
| Error state                   | ✅     | `widgets/error_state.dart`  |
| Design documentation          | ✅     | `DESIGN_SYSTEM.md`           |

---

## Next Steps (Phase 2 Preview)

1. Integrate card components into actual feature pages (marketplace, events, skills)
2. Connect to Firebase data streams
3. Add image upload and validation against `AppImageConstants`
4. Implement theme mode toggle (manual dark/light override)
5. Add reduced-motion support
