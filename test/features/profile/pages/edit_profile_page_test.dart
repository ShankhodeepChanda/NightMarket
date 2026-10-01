import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:night_market/core/services/auth_service.dart';
import 'package:night_market/features/profile/models/user_profile.dart';
import 'package:night_market/features/profile/pages/edit_profile_page.dart';
import 'package:night_market/features/profile/services/profile_service.dart';

import '../../../helpers/mock_auth_service_with_user.dart';
import '../../../helpers/mock_profile_service.dart';

void main() {
  late MockProfileService mockProfileService;
  late MockAuthServiceWithUser mockAuthService;

  setUp(() {
    mockProfileService = MockProfileService();
    mockAuthService = MockAuthServiceWithUser();

    ProfileService.setMockInstance(mockProfileService);
    AuthService.setMockInstance(mockAuthService);
  });

  tearDown(() {
    ProfileService.resetMockInstance();
    AuthService.resetMockInstance();
  });

  Widget buildTestApp({UserProfile? existingProfile}) {
    return MaterialApp(
      home: EditProfilePage(
        existingProfile: existingProfile,
        profileService: mockProfileService,
        authService: mockAuthService,
      ),
    );
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  // ---------------------------------------------------------------------------
  // Create mode (no existing profile)
  // ---------------------------------------------------------------------------

  group('create mode', () {
    testWidgets('shows Create Profile title and button', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Create Profile'), findsNWidgets(2)); // AppBar + button
    });

    testWidgets('renders all form fields', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(3)); // name, college, bio
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('College'), findsOneWidget);
      expect(find.text('Bio'), findsOneWidget);
    });

    testWidgets('renders skills chips', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(FilterChip), findsNWidgets(kSuggestedSkills.length));
      expect(find.text('Skills (up to $kMaxSkills)'), findsOneWidget);
      expect(find.text('0/$kMaxSkills selected'), findsOneWidget);
    });

    testWidgets('validates name is required', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      // Tap save without entering a name.
      await tapVisible(tester, find.widgetWithText(FilledButton, 'Create Profile'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your name'), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Edit mode (existing profile)
  // ---------------------------------------------------------------------------

  group('edit mode', () {
    final existingProfile = UserProfile(
      id: 'test-uid-123',
      name: 'Jane Doe',
      email: 'jane@example.com',
      bio: 'Hello world',
      college: 'MIT',
      skills: ['Photography', 'Music'],
    );

    testWidgets('shows Edit Profile title and Save Changes button',
        (tester) async {
      await tester.pumpWidget(buildTestApp(existingProfile: existingProfile));
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.text('Save Changes'), findsOneWidget);
    });

    testWidgets('pre-fills form fields from existing profile', (tester) async {
      await tester.pumpWidget(buildTestApp(existingProfile: existingProfile));
      await tester.pumpAndSettle();

      // TextFormField values
      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('MIT'), findsOneWidget);
      expect(find.text('Hello world'), findsOneWidget);
    });

    testWidgets('pre-selects existing skills', (tester) async {
      await tester.pumpWidget(buildTestApp(existingProfile: existingProfile));
      await tester.pumpAndSettle();

      expect(find.text('2/$kMaxSkills selected'), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Skills selection
  // ---------------------------------------------------------------------------

  group('skills', () {
    testWidgets('tapping a chip selects it', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      await tapVisible(tester, find.text('Photography'));
      await tester.pumpAndSettle();

      expect(find.text('1/$kMaxSkills selected'), findsOneWidget);
    });

    testWidgets('tapping a selected chip deselects it', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      // Select then deselect
      await tapVisible(tester, find.text('Photography'));
      await tester.pumpAndSettle();
      expect(find.text('1/$kMaxSkills selected'), findsOneWidget);

      await tapVisible(tester, find.text('Photography'));
      await tester.pumpAndSettle();
      expect(find.text('0/$kMaxSkills selected'), findsOneWidget);
    });

    testWidgets('cannot select more than $kMaxSkills skills', (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      // Select kMaxSkills skills
      for (var i = 0; i < kMaxSkills; i++) {
        await tapVisible(tester, find.text(kSuggestedSkills[i]));
        await tester.pumpAndSettle();
      }

      expect(find.text('$kMaxSkills/$kMaxSkills selected'), findsOneWidget);

      // Try selecting one more — count should stay at max
      await tapVisible(tester, find.text(kSuggestedSkills[kMaxSkills]));
      await tester.pumpAndSettle();

      expect(find.text('$kMaxSkills/$kMaxSkills selected'), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Save (create flow)
  // ---------------------------------------------------------------------------

  testWidgets('save creates profile when form is valid', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Fill in name (required)
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Name'),
      'Test User',
    );

    // Fill in college
    await tester.enterText(
      find.widgetWithText(TextFormField, 'College'),
      'Stanford',
    );

    // Select a skill
    await tapVisible(tester, find.text('Photography'));
    await tester.pumpAndSettle();

    // Tap save
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Create Profile'));
    await tester.pumpAndSettle();

    // Verify the mock service received the profile
    expect(mockProfileService.lastCreatedProfile, isNotNull);
    expect(mockProfileService.lastCreatedProfile!.name, 'Test User');
    expect(mockProfileService.lastCreatedProfile!.college, 'Stanford');
    expect(mockProfileService.lastCreatedProfile!.skills, ['Photography']);
  });

  // ---------------------------------------------------------------------------
  // Save (edit flow)
  // ---------------------------------------------------------------------------

  testWidgets('save updates profile in edit mode', (tester) async {
    final existingProfile = UserProfile(
      id: 'test-uid-123',
      name: 'Jane Doe',
      email: 'jane@example.com',
      bio: 'Old bio',
      college: 'MIT',
      skills: ['Photography'],
    );

    await tester.pumpWidget(buildTestApp(existingProfile: existingProfile));
    await tester.pumpAndSettle();

    // Change the name
    final nameField = find.widgetWithText(TextFormField, 'Name');
    await tester.enterText(nameField, 'Jane Smith');
    await tester.pumpAndSettle();

    // Tap Save Changes
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Save Changes'));
    await tester.pumpAndSettle();

    // Verify update was called (not create)
    expect(mockProfileService.lastUpdateData, isNotNull);
    expect(mockProfileService.lastUpdateData!['name'], 'Jane Smith');
    expect(mockProfileService.lastCreatedProfile, isNull);
  });

  // ---------------------------------------------------------------------------
  // Camera icon
  // ---------------------------------------------------------------------------

  testWidgets('renders camera icon for image picker', (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget); // default avatar
  });
}
