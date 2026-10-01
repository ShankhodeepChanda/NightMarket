# Night Market — Development Roadmap

**Last Updated:** 2026-09-30

---

## Release Milestones

```
v0.1  ← Phase 0     (Foundation)                    ✅ COMPLETE
v0.2  ← Phase 3     (Authentication)                ✅ COMPLETE
v0.3  ← Phase 4     (Profiles)
v0.4  ← Phase 6     (Marketplace Foundation)
v0.5  ← Phase 7     (Marketplace Discovery)
v0.6  ← Phase 9     (Marketplace Messaging)
v0.7  ← Phase 10-11 (Community + Events)
v0.8  ← Phase 13-15 (Skills Marketplace)
v0.9  ← Phase 17-18 (Reputation + Notifications)
v0.10 ← Phase 20-21 (Moderation + Security)
v1.0  ← Phase 24    (Android MVP Release)        🎯 TARGET
v2.0  ← Phase 25    (iOS Support)
```

---

## Phase 0 — Project Foundation ✅

**Status:** Complete  
**Date:** 2026-09-30

- [x] Flutter environment verified
- [x] Android SDK installed
- [x] Package renamed to `night_market`
- [x] Architecture established
- [x] Material 3 theme configured
- [x] Bottom navigation implemented
- [x] Documentation created
- [x] Git initialized (pending)
- [x] First commit (pending)

**Deliverable:** Blank but properly structured app that builds successfully.

---

## Phase 1 — Design System

**Status:** Complete  
**Date:** 2026-09-30

### Goals
- Finalize color palette and spacing constants
- Design product card component
- Design event card component  
- Design profile card component
- Create loading states (skeleton loaders)
- Create empty states per feature
- Create error states
- Establish image guidelines

### Deliverables
- Complete design tokens in `core/constants/`
- Reusable card widgets in `core/widgets/`
- Updated `DESIGN_SYSTEM.md`

---

## Phase 2 — Basic App Shell

**Status:** Complete  
**Date:** 2026-09-30

### Goals
- Splash screen
- Onboarding flow (first launch)
- Navigation polish

### Deliverables
- Professional first-launch experience
- Smooth transitions

---

## Phase 3 — Authentication

**Status:** Complete  
**Date:** 2026-09-30

### Goals
- Firebase project setup
- Firebase Authentication integration
- Email/password auth
- Sign up flow with validation
- Login flow
- Password reset
- Auth state persistence
- Protected routes

### Deliverables
- Working authentication system
- User model in Firestore
- Auth service in `core/services/`

**Blockers:** None

---

## Phase 4 — User Profile

**Status:** Complete  
**Date:** 2026-10-01

### Goals
- Profile creation on first login
- Profile editing
- Profile picture upload (Firebase Storage)
- College selection
- Skills tagging
- Bio

### Deliverables
- Complete user profile functionality
- Profile page fully functional

**Dependencies:** Phase 3 (Authentication)

---

## Phase 5 — Home Page

**Status:** Planned  
**Estimated Duration:** 2-3 sessions

### Goals
- Search bar (functional)
- Personalized feed sections
- Trending marketplace items
- Upcoming campus events
- Students offering services

### Deliverables
- Dynamic home page with real data

**Dependencies:** Phases 6, 10, 13 (needs data from those features)

---

## Phase 6 — Marketplace Foundation

**Status:** Planned  
**Estimated Duration:** 4-5 sessions

### Goals
- Product model
- Create listing flow
- Image upload (multiple images)
- Category selection
- Price input with validation
- Condition selection
- Publish listing

### Deliverables
- Sellers can create marketplace listings
- Listings stored in Firestore
- Images stored in Firebase Storage

**Dependencies:** Phase 3 (Authentication)

---

## Phase 7 — Marketplace Discovery

**Status:** Planned  
**Estimated Duration:** 4-5 sessions

### Goals
- Product feed with pagination
- Search functionality
- Filters (category, price, condition)
- Sorting options
- Product details page
- Seller profile view
- Save/bookmark listings

### Deliverables
- Buyers can discover and view products

**Dependencies:** Phase 6

---

## Phase 8 — Marketplace Seller Features

**Status:** Planned  
**Estimated Duration:** 2-3 sessions

### Goals
- My Listings page
- Edit listing
- Delete listing
- Mark as sold/reserved
- Listing analytics (views, saves)

### Deliverables
- Sellers can manage their listings

**Dependencies:** Phases 6-7

---

## Phase 9 — Marketplace Messaging

**Status:** Planned  
**Estimated Duration:** 4-5 sessions

### Goals
- Conversation model
- Message model
- Real-time messaging (Firestore streams)
- "Message Seller" button
- Conversation list
- Image sharing in chat

### Deliverables
- Buyers and sellers can communicate

**Dependencies:** Phases 6-7

---

## Phase 10 — Community Foundation

**Status:** Planned  
**Estimated Duration:** 3-4 sessions

### Goals
- College model
- Club model
- College list
- Club list and details
- Follow/join club

### Deliverables
- Community structure established

**Dependencies:** Phase 3

---

## Phase 11 — Events

**Status:** Planned  
**Estimated Duration:** 3-4 sessions

### Goals
- Event model
- Event list with filtering
- Event details page
- Register for event
- Event reminders
- Calendar integration

### Deliverables
- Students can discover and register for events

**Dependencies:** Phase 10

---

## Phase 12 — Club Management

**Status:** Planned  
**Estimated Duration:** 3-4 sessions

### Goals
- Create club (admin only)
- Edit club
- Create event
- Publish announcements
- View registrations
- Authorization system for club admins

### Deliverables
- Club admins can manage their clubs

**Dependencies:** Phases 10-11

---

## Phase 13 — Skills Marketplace

**Status:** Planned  
**Estimated Duration:** 4-5 sessions

### Goals
- Service profile creation
- Skills tagging
- Pricing and availability
- Browse services
- Student profile pages

### Deliverables
- Students can offer services

**Dependencies:** Phase 4

---

## Phase 14 — Job Posting

**Status:** Planned  
**Estimated Duration:** 3-4 sessions

### Goals
- Job post model
- Create job post
- Job feed with filters
- Job details page
- Search jobs

### Deliverables
- Students can post job requests

**Dependencies:** Phase 13

---

## Phase 15 — Applications

**Status:** Planned  
**Estimated Duration:** 3-4 sessions

### Goals
- Application model
- Apply to job
- View applications (for job poster)
- Accept/reject applications
- Application status tracking

### Deliverables
- Complete hiring workflow

**Dependencies:** Phase 14

---

## Phase 16 — Portfolio

**Status:** Planned  
**Estimated Duration:** 2-3 sessions

### Goals
- Portfolio item model
- Add portfolio items
- Portfolio gallery
- Display portfolio on profile
- Portfolio on service listings

### Deliverables
- Students can showcase their work

**Dependencies:** Phase 13

---

## Phase 17 — Reputation System

**Status:** Planned  
**Estimated Duration:** 3-4 sessions

### Goals
- Review model
- Leave review after transaction
- View reviews on profile
- Rating aggregation
- Review validation (must have actual interaction)

### Deliverables
- Trust and reputation system

**Dependencies:** Phases 8, 15

---

## Phase 18 — Notifications

**Status:** Planned  
**Estimated Duration:** 3-4 sessions

### Goals
- Firebase Cloud Messaging setup
- In-app notification system
- Push notifications
- Notification preferences

### Deliverables
- Real-time notifications for key events

**Dependencies:** Multiple features

---

## Phase 19 — Search

**Status:** Planned  
**Estimated Duration:** 3-4 sessions

### Goals
- Unified search across features
- Search suggestions
- Search filters
- Search results by category

### Deliverables
- Global search functionality

**Dependencies:** Phases 7, 11, 14

---

## Phase 20 — Moderation & Safety

**Status:** Planned  
**Estimated Duration:** 4-5 sessions

### Goals
- Report content/users
- Block users
- Moderation queue
- Admin dashboard
- Content filters

### Deliverables
- Safety and moderation tools

**Dependencies:** All major features

**Critical:** Must exist before public release

---

## Phase 21 — Security Review

**Status:** Planned  
**Estimated Duration:** 3-4 sessions

### Goals
- Audit Firestore security rules
- Audit Storage security rules
- Input validation review
- Authentication security
- Rate limiting
- Penetration testing

### Deliverables
- Secure application

**Dependencies:** All features

**Critical:** Must complete before release

---

## Phase 22 — Testing

**Status:** Ongoing (per-phase)  
**Estimated Duration:** 5-7 sessions

### Goals
- Unit tests for models and repositories
- Widget tests for key components
- Integration tests for critical flows
- Manual testing of all features

### Deliverables
- Comprehensive test coverage

**Dependencies:** All features

---

## Phase 23 — Performance Optimization

**Status:** Planned  
**Estimated Duration:** 2-3 sessions

### Goals
- Image optimization and caching
- Firestore query optimization
- Pagination everywhere
- Build size optimization
- Startup time optimization

### Deliverables
- Fast, responsive app

**Dependencies:** All features

---

## Phase 24 — Android Release 🎯

**Status:** Planned  
**Estimated Duration:** 4-6 sessions

### Goals
- Application ID finalized
- Release signing configured
- Store listing created
- Privacy policy published
- Terms of service published
- Screenshots and promotional materials
- Internal testing track
- Closed beta testing
- Production release to Google Play

### Deliverables
- **Night Market v1.0 on Google Play Store**

**Dependencies:** All previous phases

---

## Phase 25 — iOS Preparation

**Status:** Future  
**Estimated Duration:** 5-8 sessions

### Goals
- Xcode project configuration
- iOS-specific UI adjustments
- TestFlight beta
- App Store submission
- iOS release

### Deliverables
- Night Market on iOS App Store

**Dependencies:** v1.0 Android release

---

## Post-v1.0 Features (Future)

- Payment integration (Razorpay/Stripe)
- Advanced recommendations (ML-based)
- In-app purchases (premium features)
- Analytics dashboard
- College verification system
- Advanced search (Algolia)
- Video support
- Audio messaging
- Group chats
- Campus map integration

---

## Estimated Timeline

**Conservative estimate:**

- Phases 0-10: ~30-40 sessions
- Phases 11-20: ~30-40 sessions
- Phases 21-24: ~15-20 sessions

**Total to Android MVP:** ~75-100 development sessions

**If working 2-3 sessions per week:** 6-9 months to v1.0

---

## Success Metrics (Post-Launch)

- [ ] 100+ active users in first month
- [ ] 500+ marketplace listings
- [ ] 50+ campus events posted
- [ ] 25+ student services offered
- [ ] Average rating 4.0+ on Play Store
- [ ] < 1% crash rate

---

## Key Decisions Ahead

- **Phase 6:** State management choice (Riverpod/Provider)
- **Phase 7:** Routing package (go_router likely)
- **Phase 9:** Real-time chat architecture
- **Phase 18:** Notification strategy
- **Phase 24:** Pricing model (free initially, monetization later)
