import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'masari_colors.dart';

/// MASARI Typography System.
/// Arabic First: Cairo Font
/// English: Inter Font
class MasariTypography {
  static const String arabicFontFamily = 'Cairo';
  static const String englishFontFamily = 'Inter';

  static TextStyle _getTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required bool isArabic,
    double height = 1.3,
    double? letterSpacing,
  }) {
    if (isArabic) {
      return GoogleFonts.cairo(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
    } else {
      return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );
    }
  }

  // --- Display / Headlines ---
  static TextStyle headlineLarge({Color color = MasariColors.darkGraphite, bool isArabic = true}) =>
      _getTextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color, isArabic: isArabic, height: 1.2);

  static TextStyle headlineMedium({Color color = MasariColors.darkGraphite, bool isArabic = true}) =>
      _getTextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color, isArabic: isArabic, height: 1.25);

  static TextStyle headlineSmall({Color color = MasariColors.darkGraphite, bool isArabic = true}) =>
      _getTextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color, isArabic: isArabic);

  // --- Titles ---
  static TextStyle titleLarge({Color color = MasariColors.darkGraphite, bool isArabic = true}) =>
      _getTextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color, isArabic: isArabic);

  static TextStyle titleMedium({Color color = MasariColors.darkGraphite, bool isArabic = true}) =>
      _getTextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color, isArabic: isArabic);

  static TextStyle titleSmall({Color color = MasariColors.darkGraphite, bool isArabic = true}) =>
      _getTextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color, isArabic: isArabic);

  // --- Body Text ---
  static TextStyle bodyLarge({Color color = MasariColors.darkGraphite, bool isArabic = true}) =>
      _getTextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color, isArabic: isArabic, height: 1.5);

  static TextStyle bodyMedium({Color color = MasariColors.darkGraphite, bool isArabic = true}) =>
      _getTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color, isArabic: isArabic, height: 1.5);

  static TextStyle bodySmall({Color color = MasariColors.titaniumGray, bool isArabic = true}) =>
      _getTextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: color, isArabic: isArabic, height: 1.4);

  // --- Captions & Controls ---
  static TextStyle caption({Color color = MasariColors.titaniumGray, bool isArabic = true}) =>
      _getTextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: color, isArabic: isArabic);

  static TextStyle buttonText({Color color = MasariColors.pureWhite, bool isArabic = true}) =>
      _getTextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: color, isArabic: isArabic);

  static TextStyle navLabel({Color color = MasariColors.titaniumGray, bool isArabic = true}) =>
      _getTextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color, isArabic: isArabic);
}
