import 'package:flutter/material.dart';

import '../models/plant.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// -----------------------------------------------------------------------
/// PlantTile — DONE, no edits needed.
/// -----------------------------------------------------------------------
/// A single row in the plant list: a soft card, a mood-tinted avatar, a
/// freshness bar, and a "water it" action that gives a satisfied little
/// bounce on tap. Swipe left to remove a plant; tap the row (not the
/// water button) to open a bigger detail view.
///
/// `onWater` and `onDelete` are optional — omit either to hide that
/// feature (the Classic screen only passes neither, since it predates
/// both).
/// -----------------------------------------------------------------------
class PlantTile extends StatefulWidget {
  const PlantTile({super.key, required this.plant, this.onWater, this.onDelete});

  final Plant plant;
  final VoidCallback? onWater;
  final VoidCallback? onDelete;

  @override
  State<PlantTile> createState() => _PlantTileState();
}

class _PlantTileState extends State<PlantTile> {
  bool _pressed = false;

  void _openDetail() {
    showPlantDetailSheet(
      context,
      plant: widget.plant,
      onWater: widget.onWater,
      onDelete: widget.onDelete,
    );
  }

  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;
    final tile = _buildCard(context, plant);

    if (widget.onDelete == null) return tile;

    return Dismissible(
      key: ValueKey(plant.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: AppColors.clayDeep,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      onDismissed: (_) {
        final name = plant.name;
        widget.onDelete!.call();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Removed $name \u{1F44B}')),
        );
      },
      child: tile,
    );
  }

  Widget _buildCard(BuildContext context, Plant plant) {
    final thirsty = plant.isThirsty;
    final moodColor = thirsty ? AppColors.thirsty : AppColors.happy;
    final moodBg = thirsty ? AppColors.thirstyBg : AppColors.happyBg;
    final freshness = (1 - (plant.daysSinceWatered / plant.wateringInterval.inDays))
        .clamp(0.0, 1.0);

    return AnimatedScale(
      scale: _pressed ? 0.985 : 1,
      duration: AppMotion.fast,
      curve: AppMotion.enter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.lineSoft,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTapDown: (_) => setState(() => _pressed = true),
            onTapCancel: () => setState(() => _pressed = false),
            onTap: _openDetail,
            onTapUp: (_) => setState(() => _pressed = false),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: AppMotion.medium,
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(color: moodBg, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Text(plant.emoji, style: const TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(plant.name, style: AppTypography.title),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                AnimatedSwitcher(
                                  duration: AppMotion.fast,
                                  child: Icon(
                                    thirsty ? Icons.water_drop : Icons.wb_sunny_rounded,
                                    key: ValueKey(thirsty),
                                    size: 14,
                                    color: moodColor,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    thirsty
                                        ? 'Thirsty · watered ${plant.daysSinceWatered}d ago'
                                        : 'Happy · watered ${plant.daysSinceWatered}d ago',
                                    style: AppTypography.caption.copyWith(color: moodColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (widget.onWater != null)
                        _WaterButton(onTap: widget.onWater!, thirsty: thirsty),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: freshness),
                      duration: AppMotion.slow,
                      curve: AppMotion.enter,
                      builder: (context, value, _) => LinearProgressIndicator(
                        value: value,
                        minHeight: 5,
                        backgroundColor: AppColors.line,
                        valueColor: AlwaysStoppedAnimation(moodColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WaterButton extends StatefulWidget {
  const _WaterButton({required this.onTap, required this.thirsty});

  final VoidCallback onTap;
  final bool thirsty;

  @override
  State<_WaterButton> createState() => _WaterButtonState();
}

class _WaterButtonState extends State<_WaterButton> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _tapped = true);
        widget.onTap();
        Future.delayed(AppMotion.medium, () {
          if (mounted) setState(() => _tapped = false);
        });
      },
      child: AnimatedScale(
        scale: _tapped ? 1.3 : 1,
        duration: AppMotion.fast,
        curve: AppMotion.bouncy,
        child: IconBadgeButton(active: widget.thirsty),
      ),
    );
  }
}

class IconBadgeButton extends StatelessWidget {
  const IconBadgeButton({super.key, required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.medium,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: active ? AppColors.leafDeep : AppColors.line,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.water_drop_outlined,
        color: active ? Colors.white : AppColors.faint,
        size: 20,
      ),
    );
  }
}

/// A bigger, bottom-sheet view of a single plant — DONE, no edits needed.
void showPlantDetailSheet(
  BuildContext context, {
  required Plant plant,
  VoidCallback? onWater,
  VoidCallback? onDelete,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final thirsty = plant.isThirsty;
      final moodColor = thirsty ? AppColors.thirsty : AppColors.happy;
      final moodBg = thirsty ? AppColors.thirstyBg : AppColors.happyBg;

      return Container(
        padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.xxl),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: AppColors.line, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(color: moodBg, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(plant.emoji, style: const TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(plant.name, style: AppTypography.headline),
            const SizedBox(height: AppSpacing.xs),
            Text(
              thirsty
                  ? 'Thirsty — watered ${plant.daysSinceWatered} days ago'
                  : 'Happy — watered ${plant.daysSinceWatered} days ago',
              style: AppTypography.bodyMuted.copyWith(color: moodColor, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (onWater != null)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    onWater();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.water_drop_rounded),
                  label: const Text('Water it'),
                ),
              ),
            if (onDelete != null) ...[
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    onDelete();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete_outline_rounded, color: AppColors.clayDeep),
                  label: const Text('Remove plant', style: TextStyle(color: AppColors.clayDeep)),
                ),
              ),
            ],
          ],
        ),
      );
    },
  );
}
