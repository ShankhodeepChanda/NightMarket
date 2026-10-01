import 'package:firebase_auth/firebase_auth.dart';

/// A minimal fake [User] for widget tests.
///
/// Only implements the properties used by ProfilePage / EditProfilePage:
/// [uid] and [email].  Everything else throws on access via [noSuchMethod].
class FakeFirebaseUser implements User {
  @override
  final String uid;

  @override
  final String? email;

  FakeFirebaseUser({this.uid = 'test-uid-123', this.email = 'test@example.com'});

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
