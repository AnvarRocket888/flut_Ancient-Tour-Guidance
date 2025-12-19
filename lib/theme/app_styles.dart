import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

class AppStyles {
  // Text styles with glow
  static TextStyle get titleLarge => const TextStyle(
        color: AppColors.goldPrimary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: AppColors.glowGold,
            blurRadius: 20,
          ),
          Shadow(
            color: AppColors.glowGold,
            blurRadius: 10,
          ),
        ],
      );

  static TextStyle get titleMedium => const TextStyle(
        color: AppColors.goldPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: AppColors.glowGold,
            blurRadius: 15,
          ),
        ],
      );

  static TextStyle get titleSmall => const TextStyle(
        color: AppColors.textGold,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(
            color: AppColors.glowGold,
            blurRadius: 10,
          ),
        ],
      );

  static TextStyle get bodyLarge => const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyMedium => const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodySmall => const TextStyle(
        color: AppColors.textTertiary,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );

  // Button style
  static BoxDecoration get buttonDecoration => BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.buttonStart, AppColors.buttonEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.goldPrimary, width: 2),
        boxShadow: const [
          BoxShadow(
            color: AppColors.glowGold,
            blurRadius: 15,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      );

  // Card decoration
  static BoxDecoration get cardDecoration => BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.secondaryBg, AppColors.tertiaryBg],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goldSecondary.withOpacity(0.3), width: 1),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      );

  // Background gradient
  static BoxDecoration get backgroundGradient => const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBg, AppColors.secondaryBg, AppColors.tertiaryBg],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.5, 1.0],
        ),
      );
}
