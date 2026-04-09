import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimens.dart';

/// ──────────────────────────────────────────────────────────────
/// AppShadows — "Ambient Glows" (no standard drop shadows)
/// ──────────────────────────────────────────────────────────────
/// Mimics the light spill of a stadium Jumbotron.
/// Use large blur + low opacity of primary/secondary colors.
/// ──────────────────────────────────────────────────────────────
class AppShadows {
  AppShadows._();

  // ──────────────── Primary Glows ──────────────────────────
  static List<BoxShadow> primaryGlowSmall = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.08),
      blurRadius: AppDimens.glowBlurSmall,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> primaryGlowMedium = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.08),
      blurRadius: AppDimens.glowBlurMedium,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> primaryGlowLarge = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.10),
      blurRadius: AppDimens.glowBlurLarge,
      spreadRadius: 0,
    ),
  ];

  // ──────────────── Secondary Glows ────────────────────────
  static List<BoxShadow> secondaryGlowSmall = [
    BoxShadow(
      color: AppColors.secondary.withValues(alpha: 0.08),
      blurRadius: AppDimens.glowBlurSmall,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> secondaryGlowMedium = [
    BoxShadow(
      color: AppColors.secondary.withValues(alpha: 0.08),
      blurRadius: AppDimens.glowBlurMedium,
      spreadRadius: 0,
    ),
  ];

  // ──────────────── Tertiary / Success Glow ────────────────
  static List<BoxShadow> tertiaryGlow = [
    BoxShadow(
      color: AppColors.tertiary.withValues(alpha: 0.08),
      blurRadius: AppDimens.glowBlurMedium,
      spreadRadius: 0,
    ),
  ];

  // ──────────────── Error Glow ─────────────────────────────
  static List<BoxShadow> errorGlow = [
    BoxShadow(
      color: AppColors.error.withValues(alpha: 0.10),
      blurRadius: AppDimens.glowBlurMedium,
      spreadRadius: 0,
    ),
  ];

  // ──────────────── Hover Glow (for CTA buttons) ──────────
  static List<BoxShadow> primaryHoverGlow = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.20),
      blurRadius: AppDimens.glowBlurLarge,
      spreadRadius: 4,
    ),
  ];
}
