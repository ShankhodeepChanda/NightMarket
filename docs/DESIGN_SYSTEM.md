# Design System

**Last Updated:** 2026-09-30  
**Status:** Phase 0 foundation — colors and theme established

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
- Primary: derived from seed
- OnPrimary: contrasting text
- Secondary, Tertiary: harmonious variants
- Surface, Background: neutral tones
- Error: system red

**Dark Mode:**
- Same roles, inverted luminance
- Follows system dark mode automatically

---

## Typography

**Font Family:** Roboto (system default)

Material 3 text theme provides:
- `displayLarge` / `Medium` / `Small` — hero text
- `headlineLarge` / `Medium` / `Small` — section headers
- `titleLarge` / `Medium` / `Small` — card titles, subtitles
- `bodyLarge` / `Medium` / `Small` — body text
- `labelLarge` / `Medium` / `Small` — buttons, chips

**Future:** May add custom font (e.g., Inter, Poppins) for brand personality.

---

## Spacing

**Not yet standardized.** Currently using hardcoded values.

**Future Phase 1 goal:**

```dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}
```

---

## Corner Radius

**Current:** Cards use `12px` border radius.

**Future:** Standardize across components:
- Small (chips, tags): `8px`
- Medium (cards, inputs): `12px`
- Large (sheets, modals): `16px`
- Full (profile pictures, icon buttons): `circular`

---

## Elevation

Material 3 handles elevation automatically via `colorScheme.shadow` and surface tint.

**Current card elevation:** `1` (subtle)

---

## Components

### Cards

- Border radius: `12px`
- Elevation: `1`
- Padding: TBD in Phase 1
- Used for: products, events, profiles

### Buttons

Material 3 defaults:
- `ElevatedButton` — primary actions
- `FilledButton` — strong CTAs
- `OutlinedButton` — secondary actions
- `TextButton` — tertiary actions

### Input Fields

- `filled: true`
- Border: `OutlineInputBorder`
- Border radius: `12px`

### Bottom Navigation

- Type: `fixed` (labels always visible)
- Selected color: `primary`
- Unselected color: `onSurfaceVariant`

---

## Component Patterns (Future)

### Product Card

**To be designed in Phase 1:**
- Thumbnail image (square aspect ratio)
- Title (max 2 lines, ellipsis)
- Price (prominent)
- Category tag
- Seller name
- Optional: save/bookmark icon

### Event Card

**To be designed in Phase 1:**
- Banner image (16:9 aspect ratio)
- Event title
- Date and time
- Venue
- Club badge
- Registration status

### Profile Card / Student Card

**To be designed in Phase 1:**
- Profile picture (circular)
- Name
- College + course
- Skills chips
- Rating stars
- Optional: portfolio preview

---

## States

### Loading

Currently: `CircularProgressIndicator` (default Material)

**Future:** Custom skeleton loaders for cards.

### Empty

Currently: `PlaceholderPage` widget (icon + text)

**Future:** Contextual empty states per feature.

### Error

Currently: default error UI

**Future:** Friendly error messages with retry actions.

---

## Icons

**Icon Set:** Material Icons (included with Flutter)

**Key Icons Used:**
- `home_outlined` — Home
- `storefront_outlined` — Marketplace
- `school_outlined` — Community
- `work_outline` — Skills
- `person_outline` — Profile

**Future:** May add custom icons for specific features.

---

## Accessibility

Material 3 provides:
- Sufficient color contrast (WCAG AA minimum)
- Touch target sizes (48px minimum)
- Screen reader support via Semantics widgets

**Future improvements:**
- Explicit semantic labels
- High contrast mode
- Reduced motion support
- Font scaling support

---

## Dark Mode

Automatically generated from `ColorScheme.fromSeed` with `brightness: Brightness.dark`.

System preference detected via `ThemeMode.system`.

Users cannot manually toggle yet — follows OS setting.

---

## Animation

**Not yet standardized.**

Material 3 provides default transitions.

**Future:** Custom page transitions, micro-interactions for key actions.

---

## Imagery

**Not yet defined.**

**Future Phase 1:**
- Image aspect ratios (products, events, profiles)
- Placeholder images
- Image upload guidelines
- Image optimization requirements

---

## Next Steps (Phase 1)

1. Finalize spacing constants
2. Design product card component
3. Design event card component
4. Design profile card component
5. Design loading skeletons
6. Design empty states
7. Design error states
8. Establish image guidelines
