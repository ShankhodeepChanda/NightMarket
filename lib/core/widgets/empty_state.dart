import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

/// A reusable widget for displaying empty states across the app.
///
/// Shows an icon, title, optional message, and optional action button
/// when a list or section has no content.
class EmptyState extends StatelessWidget {
  /// The icon to display
  final IconData icon;

  /// The title text
  final String title;

  /// Optional message below the title
  final String? message;

  /// Optional action button label
  final String? actionLabel;

  /// Optional callback for the action button
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  /// Empty state for marketplace with no listings
  factory EmptyState.noMarketplaceListings({
    VoidCallback? onCreateListing,
  }) {
    return EmptyState(
      icon: Icons.storefront_outlined,
      title: 'No listings yet',
      message: 'Start selling by creating your first marketplace listing.',
      actionLabel: 'Create Listing',
      onAction: onCreateListing,
    );
  }

  /// Empty state for no upcoming events
  factory EmptyState.noEvents({
    VoidCallback? onExploreClubs,
  }) {
    return EmptyState(
      icon: Icons.event_outlined,
      title: 'No upcoming events',
      message: 'Check back later for campus events and activities.',
      actionLabel: 'Explore Clubs',
      onAction: onExploreClubs,
    );
  }

  /// Empty state for no saved items
  factory EmptyState.noSavedItems() {
    return const EmptyState(
      icon: Icons.bookmark_border_outlined,
      title: 'No saved items',
      message: 'Items you save will appear here.',
    );
  }

  /// Empty state for no search results
  factory EmptyState.noSearchResults() {
    return const EmptyState(
      icon: Icons.search_off_outlined,
      title: 'No results found',
      message: 'Try adjusting your search or filters.',
    );
  }

  /// Empty state for no skills/services offered
  factory EmptyState.noSkills({
    VoidCallback? onCreateProfile,
  }) {
    return EmptyState(
      icon: Icons.work_outline,
      title: 'No services yet',
      message: 'Create your skills profile to start offering services.',
      actionLabel: 'Create Profile',
      onAction: onCreateProfile,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 80,
              color: colorScheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
