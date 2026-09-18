/// -----------------------------------------------------------------------
/// AppSpacing — a small, consistent scale for every gap, padding, and
/// margin in the app. Picking from this scale (instead of inventing a
/// new number each time) is what makes a layout feel calm and intentional
/// rather than accidental.
/// -----------------------------------------------------------------------
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

/// A matching scale for corner radii — pairs with AppSpacing so cards,
/// chips, and buttons all feel like part of one family of shapes.
abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 14;
  static const double lg = 20;
  static const double xl = 28;
  static const double pill = 999;
}
