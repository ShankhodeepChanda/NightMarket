import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:night_market/app/app.dart';
import 'package:night_market/core/services/auth_service.dart';
import 'package:night_market/features/splash/pages/splash_page.dart';
import 'package:night_market/features/profile/services/profile_service.dart';
import 'helpers/mock_auth_service.dart';
import 'helpers/mock_profile_service.dart';

void main() {
  setUp(() {
    AuthService.setMockInstance(MockAuthService());
    ProfileService.setMockInstance(MockProfileService());
  });

  tearDown(() {
    AuthService.resetMockInstance();
    ProfileService.resetMockInstance();
  });

  testWidgets('Night Market app shows SplashPage initially', (WidgetTester tester) async {
    // Mock shared preferences
    SharedPreferences.setMockInitialValues({});
    
    // Build the app and trigger a frame.
    await tester.pumpWidget(const NightMarketApp());

    // Verify SplashPage is displayed
    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // Advance time to finish the splash delay
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });

  testWidgets('MainScaffold shows bottom navigation', (WidgetTester tester) async {
    // Build just the MainScaffold
    await tester.pumpWidget(const MaterialApp(
      home: MainScaffold(),
    ));

    // Verify the app builds and shows bottom navigation.
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify all 5 navigation items exist in the bottom navigation bar.
    final bottomNav = find.byType(BottomNavigationBar);
    expect(find.descendant(of: bottomNav, matching: find.text('Home')), findsOneWidget);
    expect(find.descendant(of: bottomNav, matching: find.text('Market')), findsOneWidget);
    expect(find.descendant(of: bottomNav, matching: find.text('Community')), findsOneWidget);
    expect(find.descendant(of: bottomNav, matching: find.text('Skills')), findsOneWidget);
    expect(find.descendant(of: bottomNav, matching: find.text('Profile')), findsOneWidget);
  });
}
