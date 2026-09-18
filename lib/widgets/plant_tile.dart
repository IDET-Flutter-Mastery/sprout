import 'package:flutter/material.dart';

import '../models/plant.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// -----------------------------------------------------------------------
/// PlantTile — DONE, no edits needed.
/// -----------------------------------------------------------------------
/// A single row in the plant list: a soft card, a mood-tinted avatar, and
/// a "water it" action that gives a satisfied little bounce on tap. Pass
/// `onWater` to enable the quick-water button; omit it to hide it (used
/// on the Classic screen, which predates that feature).
/// -----------------------------------------------------------------------
class PlantTile extends StatefulWidget {
  const PlantTile({super.key, required this.plant, this.onWater});

  final Plant plant;
  final VoidCallback? onWater;

  @override
  State<PlantTile> createState() => _PlantTileState();
}

class _PlantTileState extends State<PlantTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;
    final thirsty = plant.isThirsty;
    final moodColor = thirsty ? AppColors.thirsty : AppColors.happy;
    final moodBg = thirsty ? AppColors.thirstyBg : AppColors.happyBg;

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
            onTap: () {},
            onTapUp: (_) => setState(() => _pressed = false),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: AppMotion.medium,
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: moodBg,
                      shape: BoxShape.circle,
                    ),
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
                  if (widget.onWater != null) _WaterButton(onTap: widget.onWater!, thirsty: thirsty),
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
