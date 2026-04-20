import 'package:flutter/material.dart';

/// ──────────────────────────────────────────────────────────────
/// AppColors — "The Neon Midnight" palette
/// ──────────────────────────────────────────────────────────────
/// Rooted in a night-game atmosphere, punctuated by the
/// high-intensity discharge of stadium lights.
///
/// Usage: `AppColors.primary`, `AppColors.surfaceDim`, etc.
/// ──────────────────────────────────────────────────────────────
class AppColors {
  AppColors._(); // prevent instantiation

  // ──────────────── Primary (Electric Blue) ────────────────
  static const Color primary          = Color(0xFF97A9FF);
  static const Color primaryDim       = Color(0xFF3E65FF);
  static const Color primaryFixed     = Color(0xFF2E5BFF); // high-vibrancy variant from design image
  static const Color onPrimary        = Color(0xFF0A0B10);

  // ──────────────── Secondary (Neon Purple) ────────────────
  static const Color secondary        = Color(0xFFBF81FF);
  static const Color secondaryDim     = Color(0xFF9C42F4);
  static const Color secondaryFixed   = Color(0xFF8A2BE2); // design image swatch
  static const Color onSecondary      = Color(0xFFFFFFFF);

  // ──────────────── Tertiary (Cyan / Green) ────────────────
  /// Reserved for "Go" signals, success states, heatmaps.
  static const Color tertiary         = Color(0xFFAAFFDC);
  static const Color tertiaryFixed    = Color(0xFF00FFC2); // design image swatch
  static const Color onTertiary       = Color(0xFF0A0B10);

  // ──────────────── Surface Hierarchy (Obsidian Layers) ────
  /// Treat UI as stacked sheets of obsidian & frosted glass.
  static const Color surfaceDim                = Color(0xFF070810); // Level 0 — The Void
  static const Color surface                   = Color(0xFF0A0B10); // Neutral base
  static const Color surfaceBright             = Color(0xFF1A1B2E);
  static const Color surfaceContainerLowest    = Color(0xFF0C0D14); // main background
  static const Color surfaceContainerLow       = Color(0xFF12131F); // Level 1 — general content
  static const Color surfaceContainer          = Color(0xFF181928);
  static const Color surfaceContainerHigh      = Color(0xFF1E1F32); // Level 2 — active cards
  static const Color surfaceContainerHighest   = Color(0xFF252640); // modals, inputs

  // ──────────────── On-Surface / Text ──────────────────────
  static const Color onBackground     = Color(0xFFF7F5FD); // NEVER use pure white
  static const Color onSurface        = Color(0xFFF7F5FD);
  static const Color onSurfaceVariant = Color(0xFFB0ACC0);

  // ──────────────── Outlines ───────────────────────────────
  /// "Ghost Border" — max 15% opacity. 1px solid is banned.
  static const Color outline          = Color(0xFF3A3B52);
  static const Color outlineVariant   = Color(0xFF2A2B40);

  // ──────────────── Semantic / State ───────────────────────
  static const Color error            = Color(0xFFFF6B6B);
  static const Color errorDim         = Color(0xFFE8457A); // crowd heatmap high-density
  static const Color errorContainer   = Color(0xFF3B1E1E); // deep red container
  static const Color onError          = Color(0xFF0A0B10);
  static const Color onErrorContainer = Color(0xFFFFDAD6); // light red text for container
  static const Color success          = tertiary;
  static const Color warning          = Color(0xFFFFB84D);

  // ──────────────── Gradients ──────────────────────────────
  /// Signature CTA gradient: primary → secondaryDim at 135°.
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondaryDim],
  );

  /// Subtle glow gradient for ambient backgrounds.
  static const LinearGradient ambientGlow = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x1497A9FF), // primary at ~8% opacity
      Color(0x00000000),
    ],
  );

  /// Reversed CTA gradient for variety.
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryDim, primary],
  );

  // ──────────────── Helpers ────────────────────────────────
  /// Ghost-border color at design-mandated 15% opacity.
  static Color ghostBorder      = outlineVariant.withValues(alpha: 0.15);

  /// Ambient glow shadow color (primary at 8%).
  static Color primaryGlow      = primary.withValues(alpha: 0.08);
  static Color secondaryGlow    = secondary.withValues(alpha: 0.08);

  /// Glassmorphism overlay (surfaceBright at 60%).
  static Color glassOverlay     = surfaceBright.withValues(alpha: 0.60);
}
