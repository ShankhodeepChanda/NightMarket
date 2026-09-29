# Known Issues

**Last Updated:** 2026-09-30  
**Purpose:** Track bugs, limitations, and technical debt

---

## Active Issues

### Issue #1: Folder Name Mismatch

**Severity:** Low  
**Status:** Accepted as limitation

**Description:**  
Project folder is still named `first_app` but the Flutter package is `night_market`.

**Impact:**  
- Cosmetic only
- No functional impact
- Might confuse developers initially

**Resolution:**  
Accepted — folder name doesn't affect Flutter functionality. Package name is what matters.

---

## Resolved Issues

None yet.

---

## Technical Debt

### TD-1: No State Management

**Created:** 2026-09-30  
**Priority:** Low (revisit in Phase 4-6)

Currently using vanilla `StatefulWidget`. Will need proper state management (Riverpod/Provider) when features become complex.

**When to address:** Phase 4-6 (authentication, real-time data)

---

### TD-2: No Routing Package

**Created:** 2026-09-30  
**Priority:** Low (revisit in Phase 5-7)

Using simple named routes. Will need `go_router` or similar when deep linking and complex navigation are required.

**When to address:** Phase 5-7 (marketplace, nested navigation)

---

### TD-3: Hardcoded Spacing Values

**Created:** 2026-09-30  
**Priority:** Low (address in Phase 1)

Spacing values are hardcoded. Should establish `AppSpacing` constants.

**When to address:** Phase 1 (design system)

---

## Platform-Specific Issues

None yet.

---

## Firebase Integration Issues

None yet (Firebase not integrated).

---

## Performance Issues

None yet.

---

## Security Issues

None yet (no security-sensitive features implemented).

---

## Template for New Issues

```markdown
### Issue #N: Title

**Severity:** Critical | High | Medium | Low  
**Status:** Open | In Progress | Resolved | Won't Fix  
**Created:** YYYY-MM-DD  
**Resolved:** YYYY-MM-DD (if resolved)

**Description:**  
What is the issue?

**Steps to Reproduce:**  
1. Step 1
2. Step 2

**Expected Behavior:**  
What should happen?

**Actual Behavior:**  
What actually happens?

**Impact:**  
Who is affected and how?

**Workaround:**  
Temporary solution (if any)

**Resolution:**  
How was it fixed? (if resolved)
```
