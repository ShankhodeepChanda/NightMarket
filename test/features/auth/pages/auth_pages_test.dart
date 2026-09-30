import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:night_market/core/services/auth_service.dart';
import 'package:night_market/features/auth/pages/login_page.dart';
import 'package:night_market/features/auth/pages/register_page.dart';
import 'package:night_market/features/auth/pages/forgot_password_page.dart';
import '../../../helpers/mock_auth_service.dart';

void main() {
  setUp(() {
    AuthService.setMockInstance(MockAuthService());
  });

  Widget buildTestApp(Widget home) {
    return MaterialApp(home: home);
  }

  testWidgets('LoginPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp(const LoginPage()));

    expect(find.text('Login'), findsWidgets); // Title and Button
    expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Create an Account'), findsOneWidget);
  });

  testWidgets('RegisterPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp(const RegisterPage()));

    expect(find.text('Sign Up'), findsWidgets); // Title and Button
    expect(find.byType(TextFormField), findsNWidgets(3)); // Email, Pass, Confirm Pass
  });

  testWidgets('ForgotPasswordPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp(const ForgotPasswordPage()));

    expect(find.text('Reset Password'), findsOneWidget); // Title
    expect(find.byType(TextField), findsOneWidget); // Email
    expect(find.text('Send Reset Link'), findsOneWidget); // Button
  });
}
