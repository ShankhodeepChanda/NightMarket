import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

/// A skeleton loader widget that displays a shimmering placeholder while content is loading.
///
/// Use the static factory methods to create card-specific skeletons:
/// - `[LoadingSkeleton.productCard()]` — for marketplace listings
/// - `[LoadingSkeleton.eventCard()]` — for event listings
/// - `[LoadingSkeleton.profileCard()]` — for student profiles
class LoadingSkeleton extends StatefulWidget {
  /// The height of the skeleton
  final double? height;

  /// The width of the skeleton (defaults to double.infinity)
  final double? width;

  /// The border radius of the skeleton (default: 8.0)
  final double borderRadius;

  /// Whether this is a circular skeleton (overrides borderRadius)
  final bool isCircular;

  /// If true, renders a full product-card skeleton layout instead of a plain bar
  final bool isProductCard;

  /// If true, renders a full event-card skeleton layout instead of a plain bar
  final bool isEventCard;

  /// If true, renders a full profile-card skeleton layout instead of a plain bar
  final bool isProfileCard;

  /// Creates a skeleton for a product card (full layout)
  const LoadingSkeleton.productCard({super.key})
      : height = null,
        width = null,
        borderRadius = 8.0,
        isCircular = false,
        isProductCard = true,
        isEventCard = false,
        isProfileCard = false;

  /// Creates a skeleton for an event card (full layout)
  const LoadingSkeleton.eventCard({super.key})
      : height = null,
        width = null,
        borderRadius = 8.0,
        isCircular = false,
        isProductCard = false,
        isEventCard = true,
        isProfileCard = false;

  /// Creates a skeleton for a profile card (full layout)
  const LoadingSkeleton.profileCard({super.key})
      : height = null,
        width = null,
        borderRadius = 8.0,
        isCircular = false,
        isProductCard = false,
        isEventCard = false,
        isProfileCard = true;

  const LoadingSkeleton({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 8.0,
    this.isCircular = false,
    this.isProductCard = false,
    this.isEventCard = false,
    this.isProfileCard = false,
  });

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isProductCard) return const _ProductCardSkeleton();
    if (widget.isEventCard) return const _EventCardSkeleton();
    if (widget.isProfileCard) return const _ProfileCardSkeleton();

    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: widget.isCircular
                ? null
                : BorderRadius.circular(widget.borderRadius),
            shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment(-1.0 - _controller.value * 2, 0.0),
              end: Alignment(1.0 - _controller.value * 2, 0.0),
              colors: [
                colorScheme.surfaceContainerHighest,
                colorScheme.surfaceContainerHigh,
                colorScheme.surfaceContainerHighest,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// Skeleton loader for product cards
class _ProductCardSkeleton extends StatelessWidget {
  const _ProductCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AspectRatio(
            aspectRatio: 1.0,
            child: LoadingSkeleton(),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoadingSkeleton(height: 16, width: double.infinity),
                const SizedBox(height: AppSpacing.xs),
                LoadingSkeleton(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                const SizedBox(height: AppSpacing.sm),
                LoadingSkeleton(
                  height: 12,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton loader for event cards
class _EventCardSkeleton extends StatelessWidget {
  const _EventCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: LoadingSkeleton(),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingSkeleton(
                  height: 12,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                const SizedBox(height: AppSpacing.xs),
                const LoadingSkeleton(height: 16, width: double.infinity),
                const SizedBox(height: AppSpacing.sm),
                LoadingSkeleton(
                  height: 12,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingSkeleton(
                      height: 12,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    LoadingSkeleton(
                      height: 12,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton loader for profile cards
class _ProfileCardSkeleton extends StatelessWidget {
  const _ProfileCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LoadingSkeleton(
              height: 80,
              width: 80,
              isCircular: true,
            ),
            const SizedBox(height: AppSpacing.md),
            LoadingSkeleton(
              height: 16,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            const SizedBox(height: AppSpacing.xs),
            LoadingSkeleton(
              height: 12,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingSkeleton(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.15,
                  borderRadius: 16,
                ),
                const SizedBox(width: AppSpacing.xs),
                LoadingSkeleton(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.15,
                  borderRadius: 16,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            LoadingSkeleton(
              height: 12,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ],
        ),
      ),
    );
  }
}