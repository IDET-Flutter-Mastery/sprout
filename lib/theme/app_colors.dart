import 'package:flutter/material.dart';

/// -----------------------------------------------------------------------
/// AppColors — the single source of truth for every color in Sprout.
/// -----------------------------------------------------------------------
/// Mirrors the palette from the lecture deck (clay / leaf / sun) so the
/// app and the slides feel like they belong to the same little world.
/// Never hardcode a hex value in a widget — reach for a token here
/// instead, so a palette change is a one-file edit.
/// -----------------------------------------------------------------------
abstract final class AppColors {
  // Neutrals
  static const Color ink = Color(0xFF332B22);
  static const Color muted = Color(0xFF8C8272);
  static const Color faint = Color(0xFFC2BAA8);
  static const Color line = Color(0xFFEDE8DD);
  static const Color lineSoft = Color(0xFFF8F5EE);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);

  // Clay (warm terracotta) — accents, primary actions
  static const Color clay = Color(0xFFF3C7A2);
  static const Color clayDeep = Color(0xFFC2703D);
  static const Color claySoft = Color(0xFFFDF0E5);

  // Leaf (green) — success, growth, "happy"
  static const Color leaf = Color(0xFFB7E4C7);
  static const Color leafDeep = Color(0xFF2F9E5C);
  static const Color leafSoft = Color(0xFFEAF8EF);

  // Sun (amber) — warnings, "thirsty", highlights
  static const Color sun = Color(0xFFFFE9A0);
  static const Color sunDeep = Color(0xFFC08A1A);
  static const Color sunSoft = Color(0xFFFFF8E5);

  // Semantic aliases — use these in feature code so intent stays legible.
  static const Color happy = leafDeep;
  static const Color happyBg = leafSoft;
  static const Color thirsty = clayDeep;
  static const Color thirstyBg = claySoft;
  static const Color highlight = sunDeep;
  static const Color highlightBg = sunSoft;

  /// Soft, brand-tinted shadow — used instead of pure black for a
  /// friendlier, less "corporate" elevation.
  static Color shadow = ink.withOpacity(0.08);

  static const List<Color> heroGradient = [sunSoft, background];
}
