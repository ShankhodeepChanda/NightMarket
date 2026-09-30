import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

/// A reusable card component for displaying campus events.
class EventCard extends StatelessWidget {
  /// The title of the event
  final String title;

  /// The formatted date and time string
  final String dateTime;

  /// A single emoji or icon representing the event image (placeholder)
  final String imagePlaceholder;

  /// The location of the event
  final String location;

  /// The club or organization hosting the event
  final String organizer;

  /// The number of students attending
  final int attendeeCount;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  const EventCard({
    super.key,
    required this.title,
    required this.dateTime,
    required this.imagePlaceholder,
    required this.location,
    required this.organizer,
    required this.attendeeCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder area (16:9 aspect ratio)
            AspectRatio(
              aspectRatio: 16.0 / 9.0, // AppImageConstants.eventAspectRatio
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.tertiary.withValues(alpha: 0.8),
                      colorScheme.primary.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                     imagePlaceholder,
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ),

            // Content area
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateTime,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          location,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Footer section
                  Container(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            organizer,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '$attendeeCount attending',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
