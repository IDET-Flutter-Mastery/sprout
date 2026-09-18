import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/counter_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// -----------------------------------------------------------------------
/// QUICK CHALLENGE — Build a Riverpod Counter
/// -----------------------------------------------------------------------
/// This screen is already wired up correctly — it's counter_provider.dart
/// that needs finishing. Once CounterNotifier works, tapping the button
/// below should increment the number on screen (with a little bounce).
/// -----------------------------------------------------------------------
class CounterChallengeScreen extends ConsumerWidget {
  const CounterChallengeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Quick Challenge · Counter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                color: AppColors.sunSoft,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: TweenAnimationBuilder<double>(
                key: ValueKey(count),
                tween: Tween(begin: 0.7, end: 1),
                duration: AppMotion.medium,
                curve: AppMotion.bouncy,
                builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
                child: Text('$count', style: AppTypography.display.copyWith(fontSize: 48)),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton.icon(
              onPressed: () => ref.read(counterProvider.notifier).increment(),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
