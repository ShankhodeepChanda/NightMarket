import 'dart:io';

import 'package:night_market/features/profile/models/user_profile.dart';
import 'package:night_market/features/profile/services/profile_service.dart';

/// A mock implementation of [ProfileService] for widget tests.
///
/// All methods return sensible defaults so tests can run without
/// Firebase platform channels.  Override individual fields to test
/// specific scenarios (e.g. [profileToReturn] for a loaded profile,
/// [shouldThrow] to simulate an error).
class MockProfileService implements ProfileService {
  /// The profile that [getUserProfile] will return.
  /// Set to `null` to simulate a missing / new user.
  UserProfile? profileToReturn;

  /// When `true`, every method throws a generic exception to simulate
  /// a Firebase error.
  bool shouldThrow = false;

  /// Tracks the last data map passed to [updateUserProfile].
  Map<String, dynamic>? lastUpdateData;

  /// Tracks the last profile passed to [createUserProfile].
  UserProfile? lastCreatedProfile;

  MockProfileService({this.profileToReturn, this.shouldThrow = false});

  @override
  Future<UserProfile?> getUserProfile(String userId) async {
    if (shouldThrow) throw Exception('MockProfileService: simulated error');
    return profileToReturn;
  }

  @override
  Future<void> createUserProfile(UserProfile profile) async {
    if (shouldThrow) throw Exception('MockProfileService: simulated error');
    lastCreatedProfile = profile;
  }

  @override
  Future<void> updateUserProfile(
    String userId,
    Map<String, dynamic> data,
  ) async {
    if (shouldThrow) throw Exception('MockProfileService: simulated error');
    lastUpdateData = data;
  }

  @override
  Future<String> uploadProfilePicture(String userId, File imageFile) async {
    if (shouldThrow) throw Exception('MockProfileService: simulated error');
    return 'https://mock-storage.example.com/profile_pictures/$userId.jpg';
  }

  // --- Properties from the real service that won't be used in tests --------
  // The mock implements the interface, so these are overridden as no-ops.

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
