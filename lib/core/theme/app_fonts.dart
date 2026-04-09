import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ──────────────────────────────────────────────────────────────
/// AppFonts — Typeface definitions
/// ──────────────────────────────────────────────────────────────
/// Space Grotesk  →  Display & Headline (large, aggressive, tech)
/// Inter          →  Body & Label (precision data, high legibility)
/// ──────────────────────────────────────────────────────────────
class AppFonts {
  AppFonts._();

  // ──────────────── Font Family Names ──────────────────────
  static const String spaceGroteskFamily = 'Space Grotesk';
  static const String interFamily        = 'Inter';

  // ──────────────── Base TextStyles ────────────────────────
  /// Returns a base [TextStyle] for **Space Grotesk**.
  /// Override size / weight / color at the call-site.
  static TextStyle spaceGrotesk({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  /// Returns a base [TextStyle] for **Inter**.
  /// Override size / weight / color at the call-site.
  static TextStyle inter({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // ──────────────── TextTheme Builders ─────────────────────
  /// Complete [TextTheme] using Space Grotesk for display / headline
  /// and Inter for everything else.
  static TextTheme buildTextTheme(TextTheme base) {
    return GoogleFonts.interTextTheme(base).copyWith(
      // Display — Space Grotesk
      displayLarge:  GoogleFonts.spaceGrotesk(textStyle: base.displayLarge),
      displayMedium: GoogleFonts.spaceGrotesk(textStyle: base.displayMedium),
      displaySmall:  GoogleFonts.spaceGrotesk(textStyle: base.displaySmall),
      // Headline — Space Grotesk
      headlineLarge:  GoogleFonts.spaceGrotesk(textStyle: base.headlineLarge),
      headlineMedium: GoogleFonts.spaceGrotesk(textStyle: base.headlineMedium),
      headlineSmall:  GoogleFonts.spaceGrotesk(textStyle: base.headlineSmall),
    );
  }
}
