import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

/// A reusable widget for displaying error states across the app.
///
/// Shows an error icon, title, message, and an optional retry/action button
/// when content fails to load or an operation fails.
class ErrorState extends StatelessWidget {
  /// The icon to display
  final IconData icon;

  /// The title text
  final String title;

  /// The error message explanation
  final String message;

  /// Optional action button label (e.g., 'Retry')
  final String? actionLabel;

  /// Optional callback for the action button
  final VoidCallback? onAction;

  const ErrorState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  /// Error state for network or connection issues
  factory ErrorState.networkError({VoidCallback? onRetry}) {
    return ErrorState(
      icon: Icons.wifi_off_rounded,
      title: 'Connection Error',
      message: 'Unable to load content. Please check your internet connection and try again.',
      actionLabel: 'Retry',
      onAction: onRetry,
    );
  }

  /// Error state for missing or deleted content
  factory ErrorState.notFound({VoidCallback? onGoBack}) {
    return ErrorState(
      icon: Icons.search_off_rounded,
      title: 'Not Found',
      message: 'The item you are looking for does not exist or has been removed.',
      actionLabel: 'Go Back',
      onAction: onGoBack,
    );
  }

  /// Error state for general/unknown errors
  factory ErrorState.general({
    String? message,
    VoidCallback? onRetry,
  }) {
    return ErrorState(
      icon: Icons.error_outline_rounded,
      title: 'Something went wrong',
      message: message ?? 'An unexpected error occurred. Please try again later.',
      actionLabel: 'Retry',
      onAction: onRetry,
    );
  }

  /// Error state for unauthorized access
  factory ErrorState.accessDenied({VoidCallback? onGoBack}) {
    return ErrorState(
      icon: Icons.lock_outline_rounded,
      title: 'Access Denied',
      message: 'You do not have permission to view this content.',
      actionLabel: 'Go Back',
      onAction: onGoBack,
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
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.xl),
              OutlinedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(actionLabel!),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.primary, // Or use error color if preferred
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
