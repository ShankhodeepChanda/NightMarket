import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:night_market/core/services/auth_service.dart';
import 'package:night_market/features/auth/pages/login_page.dart';
import 'app.dart';

/// Routes between LoginPage and MainScaffold based on auth state.
class AuthGate extends StatelessWidget {
  final AuthService? authService;

  const AuthGate({super.key, this.authService});

  @override
  Widget build(BuildContext context) {
    final auth = authService ?? AuthService();

    return StreamBuilder<User?>(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        // Show loading indicator while waiting for auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If user is logged in, show main app
        if (snapshot.hasData && snapshot.data != null) {
          return const MainScaffold();
        }

        // Otherwise show login page
        return const LoginPage();
      },
    );
  }
}
