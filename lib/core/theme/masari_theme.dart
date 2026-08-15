import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'masari_colors.dart';
import 'masari_spacing.dart';

/// MASARI High-End Theme Configuration.
/// Standardized on the Tri-Color Palette: Blue, Cyan, and Orange.
class MasariTheme {
  // Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: MasariColors.primaryBlue,
      scaffoldBackgroundColor: MasariColors.marbleWhite,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: MasariColors.primaryBlue,
        onPrimary: MasariColors.pureWhite,
        primaryContainer: MasariColors.primaryBlueContainer,
        onPrimaryContainer: MasariColors.pureWhite,
        secondary: MasariColors.primaryCyan,
        onSecondary: MasariColors.primaryBlueDark,
        secondaryContainer: MasariColors.primaryCyanContainer,
        onSecondaryContainer: MasariColors.primaryCyan,
        tertiary: MasariColors.primaryOrange,
        onTertiary: MasariColors.pureWhite,
        tertiaryContainer: MasariColors.primaryOrangeContainer,
        onTertiaryContainer: MasariColors.primaryOrange,
        error: MasariColors.error,
        onError: MasariColors.pureWhite,
        surface: MasariColors.pureWhite,
        onSurface: MasariColors.primaryBlueDark,
        surfaceContainerHighest: MasariColors.titaniumDivider,
        outline: MasariColors.titaniumDivider,
        outlineVariant: MasariColors.primaryCyanDark,
      ),
      fontFamily: GoogleFonts.cairo().fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: MasariColors.primaryBlue,
        foregroundColor: MasariColors.pureWhite,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: MasariColors.primaryCyan),
      ),
      cardTheme: CardTheme(
        color: MasariColors.pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: MasariSpacing.borderLg,
          side: const BorderSide(color: MasariColors.titaniumDivider, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MasariColors.primaryBlue,
          foregroundColor: MasariColors.pureWhite,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: MasariSpacing.borderMd),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MasariColors.primaryBlue,
          side: const BorderSide(color: MasariColors.primaryBlue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: MasariSpacing.borderMd),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MasariColors.primaryCyanDark,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MasariColors.pureWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          borderSide: const BorderSide(color: MasariColors.primaryCyan, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: MasariColors.error),
        ),
        hintStyle: const TextStyle(color: MasariColors.titaniumLight, fontSize: 14),
      ),
      dividerTheme: const DividerThemeData(
        color: MasariColors.titaniumDivider,
        thickness: 1,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: MasariColors.primaryCyan,
        unselectedLabelColor: MasariColors.titaniumGray,
        indicatorColor: MasariColors.primaryCyan,
      ),
    );
  }

  // Dark Theme Configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: MasariColors.primaryCyan,
      scaffoldBackgroundColor: MasariColors.primaryBlueDark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: MasariColors.primaryCyan,
        onPrimary: MasariColors.primaryBlueDark,
        primaryContainer: MasariColors.primaryBlueContainer,
        onPrimaryContainer: MasariColors.primaryCyan,
        secondary: MasariColors.primaryOrange,
        onSecondary: MasariColors.pureWhite,
        secondaryContainer: MasariColors.primaryOrangeContainer,
        onSecondaryContainer: MasariColors.primaryOrangeLight,
        tertiary: MasariColors.primaryBlueLight,
        onTertiary: MasariColors.pureWhite,
        tertiaryContainer: MasariColors.primaryBlueContainer,
        onTertiaryContainer: MasariColors.primaryCyanLight,
        error: MasariColors.error,
        onError: MasariColors.pureWhite,
        surface: MasariColors.graphiteSurface,
        onSurface: MasariColors.pureWhite,
        surfaceContainerHighest: MasariColors.primaryBlueContainer,
        outline: MasariColors.titaniumDividerDark,
        outlineVariant: MasariColors.primaryCyanDark,
      ),
      fontFamily: GoogleFonts.cairo().fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: MasariColors.primaryBlueDark,
        foregroundColor: MasariColors.pureWhite,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: MasariColors.primaryCyan),
      ),
      cardTheme: CardTheme(
        color: MasariColors.graphiteSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: MasariSpacing.borderLg,
          side: BorderSide(color: MasariColors.primaryCyan.withOpacity(0.2), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MasariColors.primaryCyan,
          foregroundColor: MasariColors.primaryBlueDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: MasariSpacing.borderMd),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MasariColors.primaryCyan,
          side: const BorderSide(color: MasariColors.primaryCyan, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: MasariSpacing.borderMd),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MasariColors.primaryCyanLight,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MasariColors.graphiteSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: MasariColors.titaniumDividerDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: MasariColors.titaniumDividerDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: MasariColors.primaryCyan, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: MasariSpacing.borderMd,
          borderSide: const BorderSide(color: MasariColors.error),
        ),
        hintStyle: const TextStyle(color: MasariColors.titaniumLight, fontSize: 14),
      ),
      dividerTheme: const DividerThemeData(
        color: MasariColors.titaniumDividerDark,
        thickness: 1,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: MasariColors.primaryCyan,
        unselectedLabelColor: MasariColors.titaniumLight,
        indicatorColor: MasariColors.primaryCyan,
      ),
    );
  }
}
