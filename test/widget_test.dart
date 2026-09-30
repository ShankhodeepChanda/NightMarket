// Basic widget test for Night Market app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:night_market/app/app.dart';

void main() {
  testWidgets('Night Market app smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const NightMarketApp());

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
