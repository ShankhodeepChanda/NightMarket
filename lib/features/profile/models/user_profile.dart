/// Data model representing a Night Market user profile.
///
/// Stored in the Firestore `users/{userId}` collection.
/// See `docs/DATABASE.md` for the full schema.
class UserProfile {
  /// Firebase Auth UID — also the Firestore document ID.
  final String id;

  /// Display name.
  final String name;

  /// Account email (from Firebase Auth).
  final String email;

  /// Firebase Storage download URL for the profile picture.
  final String? photoUrl;

  /// Short user-written bio.
  final String? bio;

  /// College or university name.
  final String? college;

  /// Skills the user offers (e.g. "Web Development", "Photography").
  final List<String> skills;

  /// Aggregate rating across marketplace + skills (0.0–5.0).
  final double rating;

  /// Total number of reviews received.
  final int reviewCount;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.bio,
    this.college,
    this.skills = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  /// Deserialize from a Firestore document snapshot map.
  factory UserProfile.fromMap(Map<String, dynamic> map, String documentId) {
    return UserProfile(
      id: documentId,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      photoUrl: map['photoUrl'] as String?,
      bio: map['bio'] as String?,
      college: map['college'] as String?,
      skills: List<String>.from(map['skills'] as List? ?? []),
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (map['reviewCount'] as num?)?.toInt() ?? 0,
    );
  }

  /// Serialize to a map suitable for Firestore `set()` / `update()`.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'college': college,
      'skills': skills,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }

  /// Returns a copy with the given fields replaced.
  UserProfile copyWith({
    String? name,
    String? email,
    String? photoUrl,
    String? bio,
    String? college,
    List<String>? skills,
    double? rating,
    int? reviewCount,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      college: college ?? this.college,
      skills: skills ?? this.skills,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  /// Initials derived from the display name (e.g. "Shankhodeep Chanda" → "SC").
  String get initials {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }
}
