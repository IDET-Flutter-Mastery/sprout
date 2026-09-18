import 'package:flutter/material.dart';

/// -----------------------------------------------------------------------
/// IconBadge — a small reusable "icon in a colored rounded tile", used
/// all over the app (menu rows, list tiles, dialogs) instead of one-off
/// Container + Icon combos. Keeping this in one widget means every icon
/// tile in the app shares the same shape and proportions automatically.
/// -----------------------------------------------------------------------
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
    this.size = 44,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Icon(icon, color: color, size: size * 0.52),
    );
  }
}
