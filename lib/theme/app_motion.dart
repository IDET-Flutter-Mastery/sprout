import 'package:flutter/animation.dart';

/// -----------------------------------------------------------------------
/// AppMotion — shared animation durations & curves, so every transition
/// in the app feels like it's paced by the same hand. "The right amount
/// of animation" means using these consistently, not adding effects
/// everywhere — most of these are 150–300ms, on purpose.
/// -----------------------------------------------------------------------
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);

  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
  static const Curve bouncy = Curves.easeOutBack;
}
