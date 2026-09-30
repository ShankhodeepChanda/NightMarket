import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:night_market/app/auth_gate.dart';
import 'package:night_market/core/services/auth_service.dart';
import 'package:night_market/features/splash/pages/splash_page.dart';
import 'package:night_market/features/onboarding/pages/onboarding_page.dart';
import '../../../helpers/mock_auth_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    AuthService.setMockInstance(MockAuthService());
  });

  Widget buildTestApp() {
    return const MaterialApp(
      home: SplashPage(),
    );
  }

  testWidgets('SplashPage shows branding and indicator', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());

    expect(find.byIcon(Icons.nightlight_round), findsOneWidget);
    expect(find.text('Night Market'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // clear pending timer
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('Navigates to OnboardingPage when first launch', (WidgetTester tester) async {
    // SharedPreferences is empty (has_seen_onboarding == null)
    await tester.pumpWidget(buildTestApp());

    // Advance 2 seconds
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Should navigate to Onboarding
    expect(find.byType(OnboardingPage), findsOneWidget);
    expect(find.byType(AuthGate), findsNothing);
  });

  testWidgets('Navigates to AuthGate when onboarding already seen', (WidgetTester tester) async {
    // Set has_seen_onboarding = true
    SharedPreferences.setMockInitialValues({'has_seen_onboarding': true});

    await tester.pumpWidget(buildTestApp());

    // Advance 2 seconds
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Should navigate to AuthGate
    expect(find.byType(AuthGate), findsOneWidget);
    expect(find.byType(OnboardingPage), findsNothing);
  });
}
