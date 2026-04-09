import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_fonts.dart';
import 'app_text_styles.dart';

/// ──────────────────────────────────────────────────────────────
/// AppTheme — "The Kinetic Atmosphere" ThemeData
/// ──────────────────────────────────────────────────────────────
/// Wires together colors, typography, components into a single
/// [ThemeData] that can be dropped into [MaterialApp].
/// ──────────────────────────────────────────────────────────────
class AppTheme {
  AppTheme._();

  // ──────────────── Dark Theme (Primary) ───────────────────
  static ThemeData get darkTheme {
    final base = ThemeData.dark();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // ── Color Scheme ──────────────────────────────────────
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryDim,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryDim,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        error: AppColors.error,
        onError: AppColors.onError,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        surfaceContainerLowest: AppColors.surfaceContainerLowest,
        surfaceContainerLow: AppColors.surfaceContainerLow,
        surfaceContainer: AppColors.surfaceContainer,
        surfaceContainerHigh: AppColors.surfaceContainerHigh,
        surfaceContainerHighest: AppColors.surfaceContainerHighest,
        surfaceDim: AppColors.surfaceDim,
        surfaceBright: AppColors.surfaceBright,
      ),

      // ── Scaffold ──────────────────────────────────────────
      scaffoldBackgroundColor: AppColors.surfaceContainerLowest,

      // ── Typography ────────────────────────────────────────
      textTheme: AppFonts.buildTextTheme(base.textTheme).copyWith(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // ── AppBar ────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDim,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.titleLarge,
        toolbarHeight: AppDimens.appBarHeight,
      ),

      // ── BottomNavigationBar ───────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDim,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTextStyles.labelSmall,
        unselectedLabelStyle: AppTextStyles.labelSmall,
      ),

      // ── NavigationBar (Material 3) ────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceDim,
        indicatorColor: AppColors.primaryDim.withValues(alpha: 0.20),
        height: AppDimens.bottomNavHeight,
        labelTextStyle: WidgetStatePropertyAll(AppTextStyles.labelSmall),
      ),

      // ── Cards — "Data Pods" ───────────────────────────────
      /// xl (24) radius, no dividers, tonal-depth separation.
      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        ),
        margin: const EdgeInsets.all(AppDimens.spacingSm),
      ),

      // ── ElevatedButton — Primary CTA ─────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDim,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spacingXl,
            vertical: AppDimens.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusXl),
          ),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),

      // ── OutlinedButton — "Ghost" Secondary Button ────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.onSurface,
          side: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.20),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spacingXl,
            vertical: AppDimens.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusXl),
          ),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),

      // ── TextButton — Tertiary ─────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondary,
          textStyle: AppTextStyles.labelMedium,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spacingBase,
            vertical: AppDimens.spacingSm,
          ),
        ),
      ),

      // ── FilledButton ──────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryDim,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spacingXl,
            vertical: AppDimens.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusXl),
          ),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),

      // ── InputDecoration — No border, tonal fill ──────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spacingBase,
          vertical: AppDimens.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: AppDimens.inputAccentWidth,
          ),
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.60),
        ),
        labelStyle: AppTextStyles.labelMedium,
      ),

      // ── Chip ──────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceContainerHigh,
        selectedColor: AppColors.primaryDim.withValues(alpha: 0.20),
        labelStyle: AppTextStyles.labelMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spacingMd,
          vertical: AppDimens.spacingXs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusFull),
        ),
        side: BorderSide.none,
      ),

      // ── Divider — technically banned, but provide as thin ─
      dividerTheme: DividerThemeData(
        color: AppColors.outlineVariant.withValues(alpha: 0.15),
        thickness: AppDimens.ghostBorderWidth,
        space: AppDimens.spacingBase,
      ),

      // ── Dialog / BottomSheet ──────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceContainerHigh,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        ),
        titleTextStyle: AppTextStyles.headlineSmall,
        contentTextStyle: AppTextStyles.bodyMedium,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceContainerHigh,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimens.radiusXl),
          ),
        ),
      ),

      // ── Snackbar ──────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceContainerHighest,
        contentTextStyle: AppTextStyles.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // ── Icon ──────────────────────────────────────────────
      iconTheme: const IconThemeData(
        color: AppColors.onSurfaceVariant,
        size: AppDimens.iconMd,
      ),

      // ── FloatingActionButton ──────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDim,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        ),
      ),

      // ── Switch ────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.onSurfaceVariant;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryDim.withValues(alpha: 0.40);
          }
          return AppColors.surfaceContainerHighest;
        }),
      ),

      // ── ProgressIndicator ─────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.surfaceContainerHigh,
      ),

      // ── TabBar ────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.onSurfaceVariant,
        indicatorColor: AppColors.primary,
        labelStyle: AppTextStyles.labelLarge,
        unselectedLabelStyle: AppTextStyles.labelMedium,
      ),
    );
  }
}
