import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// -----------------------------------------------------------------------
/// AppTypography — every text style Sprout uses, named by role rather
/// than by size. Reach for `AppTypography.title` (what it's for), not
/// `TextStyle(fontSize: 20)` (what it looks like) — that's what keeps
/// text consistent when the design changes later.
/// -----------------------------------------------------------------------
/// Display & headings use "Baloo 2" — a rounded, friendly display face
/// that matches Sprout's cute-but-capable personality. Body text uses
/// "Nunito Sans" for calm, highly-legible long-form reading.
/// -----------------------------------------------------------------------
abstract final class AppTypography {
  static TextStyle get _headingBase => GoogleFonts.baloo2(color: AppColors.ink);
  static TextStyle get _bodyBase => GoogleFonts.nunitoSans(color: AppColors.ink);

  static TextStyle get display => _headingBase.copyWith(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        height: 1.15,
      );

  static TextStyle get headline => _headingBase.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
      );

  static TextStyle get title => _headingBase.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.25,
      );

  static TextStyle get body => _bodyBase.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get bodyMuted => body.copyWith(color: AppColors.muted);

  static TextStyle get label => _bodyBase.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: 0.2,
      );

  static TextStyle get caption => _bodyBase.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.muted,
        height: 1.3,
      );

  static TextStyle get button => _bodyBase.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      );
}
