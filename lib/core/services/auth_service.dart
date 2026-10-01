import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Initialize Firebase services.
/// Called before runApp() in main.dart.
class FirebaseService {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      // Catch initialization errors (e.g., missing google-services.json)
      // so the app won't crash during development before Firebase is fully linked.
      debugPrint('Firebase initialization warning: $e');
    }
  }
}

/// Auth service wrapping FirebaseAuth.
/// Keeps auth logic centralized in core/services per architecture.
class AuthService {
  static AuthService? _mockInstance;

  @visibleForTesting
  static void setMockInstance(AuthService mock) {
    _mockInstance = mock;
  }

  @visibleForTesting
  static void resetMockInstance() {
    _mockInstance = null;
  }

  factory AuthService() {
    if (_mockInstance != null) return _mockInstance!;
    return AuthService._internal();
  }

  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signUp(String email, String password) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() => _auth.signOut();

  Future<void> resetPassword(String email) => _auth.sendPasswordResetEmail(email: email);
}
