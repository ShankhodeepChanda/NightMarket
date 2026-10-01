import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/user_profile.dart';

/// Service for managing user profiles in Firestore and Firebase Storage.
///
/// Follows the same singleton + mock-injection pattern as [AuthService]
/// so widget tests can substitute a [MockProfileService] without
/// hitting real Firebase SDKs.
class ProfileService {
  static ProfileService? _mockInstance;

  @visibleForTesting
  static void setMockInstance(ProfileService mock) {
    _mockInstance = mock;
  }

  @visibleForTesting
  static void resetMockInstance() {
    _mockInstance = null;
  }

  factory ProfileService() {
    if (_mockInstance != null) return _mockInstance!;
    return ProfileService._internal();
  }

  ProfileService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Firestore collection reference for users.
  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  // ---------------------------------------------------------------------------
  // Read
  // ---------------------------------------------------------------------------

  /// Fetch a user profile by [userId].
  ///
  /// Returns `null` when no document exists for the given ID.
  Future<UserProfile?> getUserProfile(String userId) async {
    final doc = await _usersCollection.doc(userId).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserProfile.fromMap(doc.data()!, doc.id);
  }

  // ---------------------------------------------------------------------------
  // Write
  // ---------------------------------------------------------------------------

  /// Create a new profile document (typically on first login).
  Future<void> createUserProfile(UserProfile profile) {
    return _usersCollection.doc(profile.id).set(profile.toMap());
  }

  /// Merge-update specific fields on an existing profile.
  Future<void> updateUserProfile(
    String userId,
    Map<String, dynamic> data,
  ) {
    return _usersCollection.doc(userId).update(data);
  }

  // ---------------------------------------------------------------------------
  // Storage
  // ---------------------------------------------------------------------------

  /// Upload a profile picture and return its download URL.
  ///
  /// Images are stored at `profile_pictures/{userId}.jpg`.
  Future<String> uploadProfilePicture(String userId, File imageFile) async {
    final ref = _storage.ref().child('profile_pictures/$userId.jpg');
    await ref.putFile(imageFile);
    return ref.getDownloadURL();
  }
}
