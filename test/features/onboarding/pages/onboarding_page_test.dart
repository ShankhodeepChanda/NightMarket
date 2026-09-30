import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:night_market/app/app.dart';
import 'package:night_market/features/onboarding/pages/onboarding_page.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget buildTestApp() {
    return const MaterialApp(
      home: OnboardingPage(),
    );
  }

  testWidgets('OnboardingPage renders 3 pages and Skip button', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());

    // Initially at page 0
    expect(find.text('Welcome to Night Market'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Get Started'), findsNothing);
  });

  testWidgets('Pressing Next advances to the next page', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());

    // Page 0
    expect(find.text('Welcome to Night Market'), findsOneWidget);

    // Press Next
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Page 1
    expect(find.text('College Community'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Press Next
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Page 2
    expect(find.text('Skills Marketplace'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget); // Changed to Get Started on last page
  });

  testWidgets('Pressing Skip completes onboarding and navigates to Main', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    // Should navigate to MainScaffold
    expect(find.byType(MainScaffold), findsOneWidget);

    // has_seen_onboarding should be true
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('has_seen_onboarding'), isTrue);
  });

  testWidgets('Pressing Get Started on last page completes onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());

    // Go to page 1
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Go to page 2 (last)
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Tap Get Started
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Should navigate to MainScaffold
    expect(find.byType(MainScaffold), findsOneWidget);

    // has_seen_onboarding should be true
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('has_seen_onboarding'), isTrue);
  });
}
