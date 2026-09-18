// The imports below (and a couple of small private widgets further down)
// are used by the finished code shown in the TODO comments, not yet by
// the placeholder body — that's expected until CP3/CP4 are done, so this
// file silences the "unused" warnings that would otherwise be noisy.
// ignore_for_file: unused_import, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/plant_repository_provider.dart';
import '../providers/plants_provider.dart';
import '../providers/thirsty_only_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart' show AppSpacing, AppRadius;
import '../theme/app_typography.dart';
import '../widgets/empty_state.dart';
import '../widgets/plant_tile.dart';
import '../widgets/staggered_fade_in.dart';

/// -----------------------------------------------------------------------
/// CP3 — Wire the Screen to Live Data (Section 3)
/// CP4 — Add a Plant, Live (Section 3)
/// -----------------------------------------------------------------------
/// This is Sprout's real, Riverpod-powered screen. It combines two
/// watched providers (plantsProvider + thirstyOnlyProvider) into one UI,
/// and lets you add a plant that appears without a hot restart.
///
/// CP3 do this:
///   1. Watch plantsProvider -> an AsyncValue<List<Plant>>.
///   2. Watch thirstyOnlyProvider -> a bool.
///   3. Use plantsAsync.when(loading:, error:, data:) to render the list,
///      filtering by thirstyOnly when the data arrives.
///
/// CP4 do this (inside _onAddPlantPressed below):
///   1. Read the repository with ref.read(plantRepositoryProvider).
///   2. Call repo.addPlant(name).
///   3. Call ref.invalidate(plantsProvider) to force a refetch.
///
/// Everything else on this screen — the AppBar, the filter pill, the
/// empty states, the dialog styling — is already done for you.
/// -----------------------------------------------------------------------
class PlantListScreen extends ConsumerWidget {
  const PlantListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO (CP3): watch plantsProvider and thirstyOnlyProvider here.
    //   final plantsAsync = ref.watch(plantsProvider);
    //   final thirstyOnly = ref.watch(thirstyOnlyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sprout'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            child: _ThirstyFilterPill(
              // TODO (CP3): pass the real watched value in place of `false`.
              value: false,
              onChanged: () {
                // TODO (CP3): ref.read(thirstyOnlyProvider.notifier).toggle()
              },
            ),
          ),
        ],
      ),
      // TODO (CP3): replace this placeholder body with:
      //
      //   plantsAsync.when(
      //     loading: () => const SproutSpinner(message: 'Fetching your plants…'),
      //     error: (e, _) => _ErrorPanel(message: '$e'),
      //     data: (plants) {
      //       final visible = thirstyOnly
      //           ? plants.where((p) => p.isThirsty).toList()
      //           : plants;
      //       return visible.isEmpty
      //           ? EmptyState(
      //               image: thirstyOnly
      //                   ? 'assets/images/all_watered.png'
      //                   : 'assets/images/empty_garden.png',
      //               title: thirstyOnly ? 'Nothing thirsty!' : 'No plants yet',
      //               message: thirstyOnly
      //                   ? 'Every plant has had a drink recently.'
      //                   : 'Tap the + button to add your first plant.',
      //             )
      //           : ListView.builder(
      //               padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      //               itemCount: visible.length,
      //               itemBuilder: (context, i) => StaggeredFadeIn(
      //                 index: i,
      //                 child: PlantTile(
      //                   plant: visible[i],
      //                   onWater: () => ref
      //                       .read(plantRepositoryProvider)
      //                       .waterPlant(visible[i].id),
      //                 ),
      //               ),
      //             );
      //     },
      //   )
      body: const Center(
        child: Text('TODO (CP3): render the plant list here.'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onAddPlantPressed(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add plant'),
      ),
    );
  }

  Future<void> _onAddPlantPressed(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.leafSoft,
          child: Text('\u{1F331}', style: TextStyle(fontSize: 22)),
        ),
        title: const Text('Add a plant'),
        content: TextField(
          controller: nameController,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(hintText: 'e.g. Fiddle Leaf Fig'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, nameController.text.trim()),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (name == null || name.isEmpty) return;

    // TODO (CP4):
    //   1. await ref.read(plantRepositoryProvider).addPlant(name)
    //   2. ref.invalidate(plantsProvider)
  }
}

/// A pill-shaped filter toggle for the AppBar — DONE, no edits needed.
class _ThirstyFilterPill extends StatelessWidget {
  const _ThirstyFilterPill({required this.value, required this.onChanged});

  final bool value;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: AnimatedContainer(
        duration: AppMotion.medium,
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: value ? AppColors.thirstyBg : AppColors.lineSoft,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: AppMotion.fast,
              child: Icon(
                value ? Icons.water_drop : Icons.water_drop_outlined,
                key: ValueKey(value),
                size: 16,
                color: value ? AppColors.thirsty : AppColors.muted,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Thirsty only',
              style: AppTypography.label.copyWith(
                color: value ? AppColors.thirsty : AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A friendly error panel — DONE, no edits needed.
class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.eco_outlined, size: 48, color: AppColors.faint),
            const SizedBox(height: AppSpacing.md),
            Text('Couldn’t load your plants', style: AppTypography.title),
            const SizedBox(height: AppSpacing.xs),
            Text(message, style: AppTypography.bodyMuted, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
