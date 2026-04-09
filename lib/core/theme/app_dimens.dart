/// ──────────────────────────────────────────────────────────────
/// AppDimens — Spacing, Radii, Elevations & Sizing
/// ──────────────────────────────────────────────────────────────
/// Built on a consistent 4px grid system.
/// Space is used *instead of lines* to define boundaries.
/// ──────────────────────────────────────────────────────────────
class AppDimens {
  AppDimens._();

  // ──────────────── Spacing (4px grid) ─────────────────────
  static const double spacingXxs   = 2.0;
  static const double spacingXs    = 4.0;
  static const double spacingSm    = 8.0;
  static const double spacingMd    = 12.0;
  static const double spacingBase  = 16.0;  // 1rem
  static const double spacingLg    = 20.0;
  static const double spacingXl    = 24.0;  // 1.5rem — card header/body separation
  static const double spacingXxl   = 32.0;
  static const double spacing3xl   = 40.0;
  static const double spacing4xl   = 48.0;
  static const double spacing5xl   = 64.0;
  static const double spacing6xl   = 80.0;

  // ──────────────── Border Radius ──────────────────────────
  static const double radiusNone   = 0.0;
  static const double radiusXs     = 4.0;
  static const double radiusSm     = 8.0;
  static const double radiusMd     = 12.0;
  static const double radiusLg     = 16.0;
  static const double radiusXl     = 24.0;  // 1.5rem — cards & primary CTAs
  static const double radiusXxl    = 32.0;
  static const double radiusFull   = 999.0; // pill shape

  // ──────────────── Ambient Glow (replaces drop shadows) ───
  /// Design spec: large blur (24px+) with low opacity (8%).
  static const double glowBlurSmall  = 12.0;
  static const double glowBlurMedium = 24.0;
  static const double glowBlurLarge  = 40.0;
  static const double glowBlurXl     = 64.0;

  /// Glassmorphism backdrop blur
  static const double glassBlur      = 12.0;

  // ──────────────── Icon Sizes ─────────────────────────────
  static const double iconXs   = 16.0;
  static const double iconSm   = 20.0;
  static const double iconMd   = 24.0;
  static const double iconLg   = 28.0;
  static const double iconXl   = 32.0;
  static const double iconXxl  = 48.0;

  // ──────────────── Misc Sizing ────────────────────────────
  static const double buttonHeightSm  = 36.0;
  static const double buttonHeightMd  = 44.0;
  static const double buttonHeightLg  = 52.0;

  static const double inputHeight     = 48.0;

  static const double appBarHeight    = 56.0;
  static const double bottomNavHeight = 64.0;

  /// Ghost-border width (if accessibility requires it)
  static const double ghostBorderWidth = 1.0;

  /// Active-input accent bar width
  static const double inputAccentWidth = 2.0;
}
