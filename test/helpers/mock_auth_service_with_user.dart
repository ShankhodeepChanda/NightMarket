import 'package:firebase_auth/firebase_auth.dart';
import 'package:night_market/core/services/auth_service.dart';
import 'fake_firebase_user.dart';

/// An [AuthService] mock that reports a logged-in user by default.
///
/// ProfilePage and EditProfilePage need [currentUser] to return an
/// actual [User] so they can fetch / save the profile.  The base
/// [MockAuthService] returns `null`, which puts the page into its
/// "not signed in" state.
class MockAuthServiceWithUser implements AuthService {
  final User? userToReturn;

  MockAuthServiceWithUser({User? user})
      : userToReturn = user ?? FakeFirebaseUser();

  @override
  User? get currentUser => userToReturn;

  @override
  Stream<User?> get authStateChanges => Stream.value(userToReturn);

  @override
  Future<void> resetPassword(String email) async {}

  @override
  Future<UserCredential> signIn(String email, String password) async {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<UserCredential> signUp(String email, String password) async {
    throw UnimplementedError();
  }
}
