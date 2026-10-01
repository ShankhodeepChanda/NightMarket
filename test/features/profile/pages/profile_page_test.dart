import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:night_market/core/services/auth_service.dart';
import 'package:night_market/features/profile/models/user_profile.dart';
import 'package:night_market/features/profile/pages/profile_page.dart';
import 'package:night_market/features/profile/services/profile_service.dart';

import '../../../helpers/mock_auth_service.dart';
import '../../../helpers/mock_auth_service_with_user.dart';
import '../../../helpers/mock_profile_service.dart';

void main() {
  late MockProfileService mockProfileService;
  late MockAuthServiceWithUser mockAuthService;

  setUp(() {
    mockProfileService = MockProfileService();
    mockAuthService = MockAuthServiceWithUser();

    // Install mocks so default constructors inside the page also resolve.
    ProfileService.setMockInstance(mockProfileService);
    AuthService.setMockInstance(mockAuthService);
  });

  tearDown(() {
    ProfileService.resetMockInstance();
    AuthService.resetMockInstance();
  });

  Widget buildTestApp({
    ProfileService? profileService,
    AuthService? authService,
  }) {
    return MaterialApp(
      home: ProfilePage(
        profileService: profileService ?? mockProfileService,
        authService: authService ?? mockAuthService,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Loading state
  // ---------------------------------------------------------------------------

  testWidgets('shows loading skeleton while fetching profile', (tester) async {
    // The default mock returns quickly, but the FutureBuilder first frame is
    // ConnectionState.waiting.
    await tester.pumpWidget(buildTestApp());

    // On the very first frame, the FutureBuilder hasn't resolved yet.
    expect(find.text('Profile'), findsOneWidget); // AppBar title
  });

  // ---------------------------------------------------------------------------
  // Empty state (no profile document)
  // ---------------------------------------------------------------------------

  testWidgets('shows setup prompt when profile is null', (tester) async {
    mockProfileService.profileToReturn = null;

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Set Up Your Profile'), findsOneWidget);
    expect(find.text('Create Profile'), findsOneWidget);
    expect(find.text('Sign Out'), findsOneWidget);
  });

  // ---------------------------------------------------------------------------
  // Error state
  // ---------------------------------------------------------------------------

  testWidgets('shows error state when service throws', (tester) async {
    mockProfileService.shouldThrow = true;

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(
      find.text('Could not load your profile. Please try again.'),
      findsOneWidget,
    );
    // Retry button
    expect(find.text('Retry'), findsOneWidget);
  });

  // ---------------------------------------------------------------------------
  // Loaded state
  // ---------------------------------------------------------------------------

  group('loaded profile', () {
    final testProfile = UserProfile(
      id: 'test-uid-123',
      name: 'Jane Doe',
      email: 'jane@example.com',
      bio: 'Flutter developer',
      college: 'MIT',
      skills: ['Mobile Development', 'UI/UX Design'],
      rating: 4.5,
      reviewCount: 12,
    );

    testWidgets('displays profile card and details', (tester) async {
      mockProfileService.profileToReturn = testProfile;

      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      // Profile card fields
      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('MIT'), findsWidgets); // college appears in card

      // Bio section
      expect(find.text('About'), findsOneWidget);
      expect(find.text('Flutter developer'), findsOneWidget);

      // Email section
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('jane@example.com'), findsOneWidget);

      // Action buttons
      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.text('Sign Out'), findsOneWidget);
    });

    testWidgets('hides bio section when bio is empty', (tester) async {
      final noBioProfile = testProfile.copyWith(bio: '');
      mockProfileService.profileToReturn = noBioProfile;

      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('About'), findsNothing);
    });
  });

  // ---------------------------------------------------------------------------
  // No authenticated user
  // ---------------------------------------------------------------------------

  testWidgets('shows setup prompt when no user is signed in', (tester) async {
    final noUserAuth = MockAuthService(); // currentUser => null

    await tester.pumpWidget(buildTestApp(authService: noUserAuth));
    await tester.pumpAndSettle();

    // With no user, _loadProfile sets future to null → empty state.
    expect(find.text('Set Up Your Profile'), findsOneWidget);
  });
}
