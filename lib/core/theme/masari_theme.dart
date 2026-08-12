import 'package:flutter/material.dart';
import 'masari_colors.dart';
import 'masari_spacing.dart';

/// Centralized MASARI ThemeData Configuration for Light & Dark luxury theme modes.
class MasariTheme {
  static ThemeData lightTheme({bool isArabic = true}) {
    final colorScheme = const ColorScheme.light(
      primary: MasariColors.deepBlue,
      onPrimary: MasariColors.pureWhite,
      primaryContainer: MasariColors.deepBlueContainer,
      secondary: MasariColors.royalGold,
      onSecondary: MasariColors.deepBlue,
      secondaryContainer: MasariColors.royalGoldLight,
      tertiary: MasariColors.skyCyan,
      surface: MasariColors.pureWhite,
      onSurface: MasariColors.darkGraphite,
      error: MasariColors.error,
      onError: MasariColors.pureWhite,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: MasariColors.marbleWhite,
      fontFamily: isArabic ? 'Cairo' : 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: MasariColors.deepBlue,
        foregroundColor: MasariColors.pureWhite,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: MasariColors.pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: MasariSpacing.borderMd,
          side: const BorderSide(color: MasariColors.titaniumDivider, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MasariColors.pureWhite,
        border: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: MasariColors.titaniumDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: MasariColors.titaniumDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: MasariColors.royalGold, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MasariColors.deepBlue,
          foregroundColor: MasariColors.pureWhite,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: MasariSpacing.borderMd),
          elevation: 2,
        ),
      ),
    );
  }

  static ThemeData darkTheme({bool isArabic = true}) {
    final colorScheme = const ColorScheme.dark(
      primary: MasariColors.royalGold,
      onPrimary: MasariColors.deepBlue,
      primaryContainer: MasariColors.deepBlueLight,
      secondary: MasariColors.skyCyan,
      onSecondary: MasariColors.deepBlue,
      surface: MasariColors.graphiteSurface,
      onSurface: MasariColors.pureWhite,
      error: MasariColors.error,
      onError: MasariColors.pureWhite,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: MasariColors.darkGraphite,
      fontFamily: isArabic ? 'Cairo' : 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: MasariColors.darkGraphite,
        foregroundColor: MasariColors.pureWhite,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: MasariColors.graphiteSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: MasariSpacing.borderMd,
          side: const BorderSide(color: Color(0x26D4AF37), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MasariColors.deepBlueLight,
        border: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: Color(0x1AFFFFFF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: Color(0x1AFFFFFF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: MasariColors.royalGold, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MasariColors.royalGold,
          foregroundColor: MasariColors.deepBlue,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: MasariSpacing.borderMd),
          elevation: 2,
        ),
      ),
    );
  }
}
