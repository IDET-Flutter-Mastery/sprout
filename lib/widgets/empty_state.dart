import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// -----------------------------------------------------------------------
/// EmptyState — a reusable "nothing to show" panel: an illustration, a
/// title, and a short supporting line. Used both for "no plants yet" and
/// "everything's happy" — same shape, different asset and copy.
/// -----------------------------------------------------------------------
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.image,
    required this.title,
    required this.message,
  });

  final String image;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.9, end: 1),
              duration: AppMotion.slow,
              curve: AppMotion.bouncy,
              builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
              child: Image.asset(image, width: 220, height: 176, fit: BoxFit.contain),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(title, style: AppTypography.title, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              style: AppTypography.bodyMuted,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// A small inline spinner that matches the brand palette, used in place
/// of the default (theme-colored but visually flat) CircularProgressIndicator
/// wherever a loading state needs a bit more personality.
class SproutSpinner extends StatelessWidget {
  const SproutSpinner({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 34,
            height: 34,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(AppColors.leafDeep),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(message!, style: AppTypography.bodyMuted),
          ],
        ],
      ),
    );
  }
}
