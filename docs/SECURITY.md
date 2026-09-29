# Security Considerations

**Last Updated:** 2026-09-30  
**Status:** Placeholder — to be implemented starting Phase 3

---

## Overview

This document outlines security considerations for Night Market. Most security implementation will occur during **Phase 21 — Security Review**, but security must be considered throughout development.

---

## Authentication & Authorization

### Planned Implementation (Phase 3+)

- Firebase Authentication for user identity
- Email/password authentication initially
- Email verification required before full access
- Secure password requirements (min length, complexity)
- Rate limiting on auth attempts
- Session management via Firebase tokens
- Automatic token refresh

### Authorization Levels

**Planned roles:**
- **Regular User** — can create listings, join clubs, post jobs
- **Club Admin** — can manage specific clubs they admin
- **Super Admin** — can moderate content across the platform (future)

---

## Data Security

### Firestore Security Rules (To Be Implemented)

**Principles:**
1. Default deny — only grant explicit access
2. Authenticate before read/write
3. Users can only modify their own data
4. College-based access control where appropriate
5. Validate data types and constraints server-side

**Example rule patterns:**

```javascript
// Users can only read/write their own profile
match /users/{userId} {
  allow read: if request.auth != null;
  allow write: if request.auth.uid == userId;
}

// Products visible to college members only
match /products/{productId} {
  allow read: if request.auth != null && 
    userBelongsToCollege(request.auth.uid, resource.data.collegeId);
  allow create: if request.auth != null && validateProduct();
  allow update, delete: if request.auth.uid == resource.data.sellerId;
}
```

### Firebase Storage Security Rules (To Be Implemented)

- Users can only upload to their own directories
- File size limits enforced
- Only image files allowed for user uploads
- Virus scanning via Cloud Functions (if budget allows)

---

## Input Validation

### Client-Side Validation (Phase-by-Phase)

All user inputs must be validated:
- Text fields: max length, no script tags
- Prices: positive numbers only
- Emails: valid format
- URLs: valid format, no `javascript:` protocol
- File uploads: type, size limits

### Server-Side Validation (Firestore Rules)

**Never trust client-side validation alone.**

Firestore rules will enforce:
- Required fields
- Data types
- String lengths
- Number ranges
- Enum values

---

## Secrets Management

### Current

❌ No secrets yet

### When Firebase is Added

✅ Firebase config goes in:
- `android/app/google-services.json` (Git-ignored)
- `ios/Runner/GoogleService-Info.plist` (Git-ignored)

✅ API keys:
- Use environment variables or `flutter_dotenv`
- Never commit to Git
- Different keys for dev/staging/prod

---

## Network Security

### HTTPS Only

Firebase enforces HTTPS automatically.

### API Security (When Applicable)

- All Firebase SDKs use secure connections
- No custom backend initially, so no API security needed yet
- Future: if we add Cloud Functions, use Firebase App Check

---

## User Privacy

### Data Collection

**What we collect:**
- Email (for authentication)
- Name, college, course, year (profile)
- User-generated content (listings, messages, reviews)
- Usage analytics (future)

**What we DON'T collect:**
- Location tracking (unless explicitly needed for a feature)
- Contacts
- Sensitive personal data

### GDPR/Privacy Compliance (Phase 24)

Before release:
- Privacy policy
- Terms of service
- Data deletion mechanism
- Export user data feature
- Cookie consent (for web version, if applicable)

---

## Content Moderation

### User-Generated Content Risks

- Spam listings
- Scam attempts
- Inappropriate images
- Harassment via messages
- Fake reviews

### Mitigation (Phase 20)

- Report button on all content
- User blocking
- Content review queue (manual initially)
- Automated filters (future)
- Account suspension mechanism

---

## Common Vulnerabilities to Avoid

### SQL Injection
✅ Not applicable — Firestore is NoSQL and parameterized by default

### XSS (Cross-Site Scripting)
✅ Flutter renders to native widgets, not HTML — XSS not applicable

### CSRF (Cross-Site Request Forgery)
✅ Firebase handles auth tokens securely

### Insecure Direct Object References
⚠️ **Must avoid:** Never trust client to send correct user IDs  
Always use `request.auth.uid` in Firestore rules

### Mass Assignment
⚠️ **Must avoid:** Validate which fields users can update

### Broken Authentication
⚠️ **Must implement:** Proper session management, token refresh

---

## File Upload Security

### Image Uploads (Phase 6+)

**Risks:**
- Executable files disguised as images
- Malicious metadata
- Extremely large files (DoS)

**Mitigations:**
- Client-side: check MIME type, file extension
- Firestore rules: enforce size limits
- Storage rules: restrict to image types
- Future: server-side image validation via Cloud Functions

---

## Rate Limiting

### To Prevent Abuse

- Firebase has built-in rate limiting for auth
- Firestore query limits prevent excessive reads
- Future: Cloud Functions rate limiting for sensitive operations

---

## Secure Coding Practices

### For Flutter Code

✅ Use `const` constructors where possible  
✅ Dispose controllers properly (prevents memory leaks)  
✅ Use `await` properly (no dangling promises)  
✅ Never log sensitive data  
✅ Use secure random for tokens (`Random.secure()`)  

### For Firestore

✅ Use transactions for critical updates  
✅ Never expose admin SDK keys  
✅ Batch writes for efficiency  
✅ Validate on server side  

---

## Third-Party Dependencies

### Current Dependencies

Review `pubspec.yaml` before adding any package:
- Check package popularity and maintenance
- Review security advisories
- Prefer official packages
- Audit dependencies regularly

### Future

Before production release:
- Run `flutter pub outdated`
- Check for known vulnerabilities
- Update dependencies to latest stable

---

## Testing

### Security Testing (Phase 22)

- Test auth flows (signup, login, logout, token expiry)
- Test Firestore rules (unit test rules)
- Test file upload restrictions
- Test input validation
- Penetration testing (manual or via service)

---

## Incident Response Plan (Future)

**If a security breach occurs:**

1. **Contain** — disable affected features
2. **Assess** — determine scope and impact
3. **Notify** — inform affected users
4. **Fix** — patch vulnerability
5. **Review** — post-mortem and prevention

---

## Pre-Launch Security Checklist

Before releasing v1.0:

- [ ] Firestore security rules audited
- [ ] Storage security rules audited
- [ ] All secrets in environment variables
- [ ] Privacy policy published
- [ ] Terms of service published
- [ ] Data deletion mechanism tested
- [ ] Rate limiting configured
- [ ] File upload validation tested
- [ ] Authentication flows tested
- [ ] Input validation on all forms
- [ ] HTTPS enforced
- [ ] No hardcoded secrets in code
- [ ] Dependencies updated
- [ ] Security testing completed

---

## Resources

- [Firebase Security Rules](https://firebase.google.com/docs/rules)
- [OWASP Mobile Security](https://owasp.org/www-project-mobile-security/)
- [Flutter Security Best Practices](https://docs.flutter.dev/security)
