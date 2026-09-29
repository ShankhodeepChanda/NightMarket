# Database Schema (Planned)

**Status:** Not yet implemented  
**Last Updated:** 2026-09-30

This document outlines the planned Firestore database structure for Night Market.

## Collections Overview

```
users/
products/
colleges/
clubs/
events/
jobs/
applications/
portfolios/
reviews/
conversations/
messages/
notifications/
reports/
```

---

## Users Collection

**Path:** `users/{userId}`

```typescript
{
  uid: string,              // Firebase Auth UID
  email: string,
  name: string,
  profilePhoto: string?,    // Storage URL
  collegeId: string,        // Reference to colleges collection
  course: string,
  year: number,             // 1-4
  bio: string?,
  skills: string[],         // e.g., ["Web Development", "Photography"]
  interests: string[],
  createdAt: Timestamp,
  updatedAt: Timestamp,
  isVerified: boolean,      // Email verification status
  reputation: {
    marketplace: number,    // 0-5 rating
    skills: number,         // 0-5 rating
    totalReviews: number
  }
}
```

---

## Products Collection (Marketplace)

**Path:** `products/{productId}`

```typescript
{
  listingId: string,
  sellerId: string,         // Reference to users collection
  title: string,
  description: string,
  price: number,
  category: string,         // e.g., "Books", "Electronics", "Furniture"
  condition: string,        // "New", "Like New", "Good", "Fair"
  images: string[],         // Storage URLs
  collegeId: string,
  status: string,           // "ACTIVE", "RESERVED", "SOLD", "ARCHIVED"
  views: number,
  savedBy: string[],        // User IDs who saved this
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

**Indexes needed:**
- `collegeId + status + createdAt` (descending)
- `category + collegeId + status`
- `sellerId + status`

---

## Colleges Collection

**Path:** `colleges/{collegeId}`

```typescript
{
  collegeId: string,
  name: string,
  location: string,
  logo: string?,            // Storage URL
  coverImage: string?,
  website: string?,
  verified: boolean,
  memberCount: number,      // Computed field
  createdAt: Timestamp
}
```

---

## Clubs Collection

**Path:** `clubs/{clubId}`

```typescript
{
  clubId: string,
  collegeId: string,
  name: string,
  description: string,
  logo: string?,
  coverImage: string?,
  category: string,         // "Technical", "Cultural", "Sports", etc.
  socialLinks: {
    instagram?: string,
    twitter?: string,
    linkedin?: string,
    website?: string
  },
  admins: string[],         // User IDs with admin access
  members: string[],        // User IDs
  memberCount: number,
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

---

## Events Collection

**Path:** `events/{eventId}`

```typescript
{
  eventId: string,
  clubId: string,           // Reference to clubs
  collegeId: string,
  title: string,
  description: string,
  image: string?,           // Poster/banner
  startTime: Timestamp,
  endTime: Timestamp,
  venue: string,
  isOnline: boolean,
  registrationLink: string?,
  capacity: number?,
  registeredCount: number,
  registeredUsers: string[], // User IDs
  interestedUsers: string[], // User IDs who marked "interested"
  status: string,           // "UPCOMING", "ONGOING", "COMPLETED", "CANCELLED"
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

**Indexes needed:**
- `collegeId + startTime` (ascending)
- `clubId + startTime`
- `status + startTime`

---

## Jobs Collection (Skills Marketplace)

**Path:** `jobs/{jobId}`

```typescript
{
  jobId: string,
  creatorId: string,        // User who posted the job
  collegeId: string,
  title: string,
  description: string,
  skills: string[],         // Required skills
  budget: {
    min: number,
    max: number,
    currency: string        // "INR"
  },
  deadline: Timestamp,
  status: string,           // "OPEN", "IN_PROGRESS", "COMPLETED", "CLOSED"
  applicationsCount: number,
  selectedApplicant: string?, // User ID
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

---

## Applications Collection

**Path:** `applications/{applicationId}`

```typescript
{
  applicationId: string,
  jobId: string,
  applicantId: string,
  coverLetter: string,
  proposedPrice: number,
  estimatedDuration: string, // "1 week", "2-3 days", etc.
  status: string,           // "PENDING", "SHORTLISTED", "ACCEPTED", "REJECTED", "WITHDRAWN"
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

**Indexes needed:**
- `jobId + status`
- `applicantId + status`

---

## Portfolios Collection

**Path:** `portfolios/{portfolioId}`

```typescript
{
  portfolioId: string,
  userId: string,
  title: string,
  description: string,
  images: string[],
  technologies: string[],   // For technical work
  category: string,         // "Web Dev", "Design", "Photography", etc.
  externalLink: string?,
  featured: boolean,
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

---

## Reviews Collection

**Path:** `reviews/{reviewId}`

```typescript
{
  reviewId: string,
  reviewerId: string,       // Who wrote the review
  reviewedUserId: string,   // Who is being reviewed
  context: string,          // "MARKETPLACE_BUYER", "MARKETPLACE_SELLER", "SKILLS_CLIENT", "SKILLS_FREELANCER"
  relatedId: string?,       // Product ID or Job ID
  rating: number,           // 1-5
  comment: string?,
  aspects: {
    communication?: number, // 1-5
    reliability?: number,
    quality?: number
  },
  createdAt: Timestamp
}
```

---

## Conversations Collection

**Path:** `conversations/{conversationId}`

```typescript
{
  conversationId: string,
  participants: string[],   // User IDs (always 2 for MVP)
  context: {
    type: string,           // "MARKETPLACE", "SKILLS", "GENERAL"
    relatedId: string?      // Product ID or Job ID
  },
  lastMessage: string,
  lastMessageTime: Timestamp,
  lastMessageSenderId: string,
  unreadCount: {
    [userId: string]: number
  },
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

---

## Messages Subcollection

**Path:** `conversations/{conversationId}/messages/{messageId}`

```typescript
{
  messageId: string,
  senderId: string,
  text: string,
  image: string?,           // Storage URL
  readBy: string[],         // User IDs
  createdAt: Timestamp
}
```

---

## Notifications Collection

**Path:** `notifications/{notificationId}`

```typescript
{
  notificationId: string,
  userId: string,           // Recipient
  type: string,             // "NEW_MESSAGE", "APPLICATION_RECEIVED", "EVENT_REMINDER", etc.
  title: string,
  body: string,
  relatedId: string?,       // ID of related entity
  read: boolean,
  createdAt: Timestamp
}
```

**Indexes needed:**
- `userId + read + createdAt` (descending)

---

## Reports Collection (Moderation)

**Path:** `reports/{reportId}`

```typescript
{
  reportId: string,
  reporterId: string,
  reportedUserId: string?,
  reportedContentId: string?, // Product/Event/Job ID
  contentType: string,      // "USER", "PRODUCT", "EVENT", "JOB"
  reason: string,           // "SPAM", "SCAM", "HARASSMENT", "INAPPROPRIATE", "FAKE", "OTHER"
  description: string?,
  status: string,           // "PENDING", "UNDER_REVIEW", "RESOLVED", "DISMISSED"
  createdAt: Timestamp,
  resolvedAt: Timestamp?,
  resolvedBy: string?       // Admin user ID
}
```

---

## Security Rules (To Be Implemented)

All collections will have Firestore security rules enforcing:
- Authentication required
- College-based access control where appropriate
- User can only modify their own data
- Read access based on context (e.g., marketplace listings visible to college members)
- Admin-only access for moderation

---

## Notes

- All IDs are auto-generated by Firestore
- Timestamps use `FieldValue.serverTimestamp()`
- Arrays in Firestore have a 20,000 element limit — will need pagination strategies
- Some computed fields (counts) may need Cloud Functions for accuracy
- Images stored in Firebase Storage, only URLs in Firestore
