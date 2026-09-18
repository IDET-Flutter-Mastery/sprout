// ignore_for_file: unused_import, unused_element
import 'package:flutter/material.dart';

import '../controllers/thirsty_filter_controller.dart';
import '../models/plant.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/plant_tile.dart';

/// -----------------------------------------------------------------------
/// "Classic" screen — Sections 1 & 2 (before Riverpod)
/// -----------------------------------------------------------------------
/// A static, offline list of plants used purely to illustrate the
/// setState problem and its ChangeNotifier fix. This screen intentionally
/// does NOT touch the repository or Riverpod — that comes later.
///
/// This is where CP1 lives: build ThirstyFilterController, then wire it
/// up below with a ListenableBuilder.
/// -----------------------------------------------------------------------
class LegacyPlantScreen extends StatefulWidget {
  const LegacyPlantScreen({super.key});

  @override
  State<LegacyPlantScreen> createState() => _LegacyPlantScreenState();
}

class _LegacyPlantScreenState extends State<LegacyPlantScreen> {
  // A fixed, offline snapshot — no repository involved on this screen.
  final List<Plant> _plants = [
    Plant(id: 'c1', name: 'Pothos', emoji: '\u{1F33F}',
        lastWatered: DateTime.now().subtract(const Duration(days: 2))),
    Plant(id: 'c2', name: 'Snake Plant', emoji: '\u{1FAB4}',
        lastWatered: DateTime.now().subtract(const Duration(days: 6)),
        wateringInterval: const Duration(days: 10)),
    Plant(id: 'c3', name: 'Basil', emoji: '\u{1F33A}',
        lastWatered: DateTime.now().subtract(const Duration(days: 5)),
        wateringInterval: const Duration(days: 3)),
  ];

  // TODO (CP1): once ThirstyFilterController is built, create one here:
  // final _thirstyController = ThirstyFilterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Classic · setState')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.sunSoft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: AppColors.sunDeep),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'This screen still uses plain setState. The switch below '
                    'has no effect yet — that’s CP1’s job to fix.',
                    style: AppTypography.body.copyWith(color: AppColors.sunDeep, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          // TODO (CP1): replace this placeholder SwitchListTile with a
          // ListenableBuilder that listens to _thirstyController and
          // drives a real Switch from controller.thirstyOnly, calling
          // controller.toggle() on change.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: SwitchListTile(
              title: Text('Thirsty only', style: AppTypography.body),
              value: false,
              onChanged: null, // TODO (CP1): wire this up.
            ),
          ),
          const Divider(height: 1, indent: AppSpacing.lg, endIndent: AppSpacing.lg),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView.builder(
              itemCount: _plants.length,
              itemBuilder: (context, i) => PlantTile(plant: _plants[i]),
            ),
          ),
        ],
      ),
    );
  }
}
