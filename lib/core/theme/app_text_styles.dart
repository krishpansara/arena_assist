import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

/// ──────────────────────────────────────────────────────────────
/// AppTextStyles — "Editorial Authority" typography scale
/// ──────────────────────────────────────────────────────────────
/// Uses extreme scale contrast:
///   Display (Space Grotesk) — large, aggressive, tech-driven
///   Body / Label (Inter)    — high x-height for legibility
/// ──────────────────────────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  // ──────────────── Display — Space Grotesk ────────────────
  /// 3.5rem (56px) — scores, seat numbers, major headliners
  static TextStyle displayLarge = AppFonts.spaceGrotesk(
    fontSize: 56,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    height: 1.1,
    letterSpacing: -1.5,
  );

  /// 2.5rem (40px)
  static TextStyle displayMedium = AppFonts.spaceGrotesk(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    height: 1.15,
    letterSpacing: -1.0,
  );

  /// 2rem (32px)
  static TextStyle displaySmall = AppFonts.spaceGrotesk(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.2,
    letterSpacing: -0.5,
  );

  // ──────────────── Headline — Space Grotesk ───────────────
  /// 1.75rem (28px) — editorial section headers
  static TextStyle headlineLarge = AppFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.25,
  );

  /// 1.5rem (24px)
  static TextStyle headlineMedium = AppFonts.spaceGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.3,
  );

  /// 1.25rem (20px)
  static TextStyle headlineSmall = AppFonts.spaceGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
    height: 1.35,
  );

  // ──────────────── Title — Inter ──────────────────────────
  /// 1.125rem (18px)
  static TextStyle titleLarge = AppFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.4,
  );

  /// 1rem (16px)
  static TextStyle titleMedium = AppFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.4,
    letterSpacing: 0.15,
  );

  /// 0.875rem (14px)
  static TextStyle titleSmall = AppFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.4,
    letterSpacing: 0.1,
  );

  // ──────────────── Body — Inter ───────────────────────────
  /// 1rem (16px)
  static TextStyle bodyLarge = AppFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.5,
  );

  /// 0.875rem (14px) — primary body text
  static TextStyle bodyMedium = AppFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.5,
    letterSpacing: 0.25,
  );

  /// 0.75rem (12px)
  static TextStyle bodySmall = AppFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
    height: 1.5,
    letterSpacing: 0.4,
  );

  // ──────────────── Label — Inter ──────────────────────────
  /// 0.875rem (14px)
  static TextStyle labelLarge = AppFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurface,
    height: 1.4,
    letterSpacing: 0.1,
  );

  /// 0.75rem (12px)
  static TextStyle labelMedium = AppFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceVariant,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// 0.6875rem (11px) — smallest readable size
  static TextStyle labelSmall = AppFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceVariant,
    height: 1.4,
    letterSpacing: 0.5,
  );
}
