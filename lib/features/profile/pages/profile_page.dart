import 'package:flutter/material.dart';
import 'package:night_market/core/services/auth_service.dart';
import 'package:night_market/core/widgets/loading_skeleton.dart';
import 'package:night_market/core/widgets/error_state.dart';
import 'package:night_market/core/widgets/profile_card.dart';
import 'package:night_market/core/constants/app_spacing.dart';
import 'package:night_market/features/profile/models/user_profile.dart';
import 'package:night_market/features/profile/pages/edit_profile_page.dart';
import 'package:night_market/features/profile/services/profile_service.dart';

/// Displays the current user's profile.
///
/// Shows a [LoadingSkeleton] while fetching, an [ErrorState] on failure,
/// a setup prompt when no profile document exists, and the full profile
/// via [ProfileCard] otherwise.
class ProfilePage extends StatefulWidget {
  /// Optional overrides for testing (avoids Firebase platform channels).
  final ProfileService? profileService;
  final AuthService? authService;

  const ProfilePage({
    super.key,
    this.profileService,
    this.authService,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileService _profileService;
  late final AuthService _authService;

  late Future<UserProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileService = widget.profileService ?? ProfileService();
    _authService = widget.authService ?? AuthService();
    _loadProfile();
  }

  void _loadProfile() {
    final uid = _authService.currentUser?.uid;
    if (uid != null) {
      _profileFuture = _profileService.getUserProfile(uid);
    } else {
      // No authenticated user — return null immediately.
      _profileFuture = Future.value(null);
    }
  }

  void _refresh() {
    setState(() {
      _loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder<UserProfile?>(
        future: _profileFuture,
        builder: (context, snapshot) {
          // --- Loading ---
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: LoadingSkeleton.profileCard(),
              ),
            );
          }

          // --- Error ---
          if (snapshot.hasError) {
            return ErrorState.general(
              message: 'Could not load your profile. Please try again.',
              onRetry: _refresh,
            );
          }

          final profile = snapshot.data;

          // --- No profile document yet (first login) ---
          if (profile == null) {
            return _buildEmptyProfile(theme);
          }

          // --- Loaded ---
          return _buildProfileView(context, profile);
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Sub-views
  // ---------------------------------------------------------------------------

  Widget _buildEmptyProfile(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_add_outlined,
              size: 80,
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Set Up Your Profile',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Add your details so other students can find you.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () => _navigateToEditProfile(null),
              child: const Text('Create Profile'),
            ),
            const SizedBox(height: AppSpacing.xl),
            OutlinedButton(
              onPressed: () async {
                await _authService.signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileView(BuildContext context, UserProfile profile) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // Profile card header
          ProfileCard(
            name: profile.name,
            college: profile.college ?? 'No college set',
            avatarInitials: profile.initials,
            skills: profile.skills,
            rating: profile.rating,
            reviewCount: profile.reviewCount,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Bio section
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                profile.bio!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Email info
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Email',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              profile.email,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Action buttons
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _navigateToEditProfile(profile),
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit Profile'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  Future<void> _navigateToEditProfile(UserProfile? existingProfile) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => EditProfilePage(
          existingProfile: existingProfile,
          profileService: widget.profileService,
          authService: widget.authService,
        ),
      ),
    );
    // If the edit page saved, refresh the profile.
    if (result == true) {
      _refresh();
    }
  }
}
