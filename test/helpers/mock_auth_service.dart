import 'package:firebase_auth/firebase_auth.dart';
import 'package:night_market/core/services/auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Stream<User?> get authStateChanges => Stream.value(null);

  @override
  User? get currentUser => null;

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
