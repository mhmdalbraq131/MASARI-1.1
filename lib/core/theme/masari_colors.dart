import 'package:flutter/material.dart';

/// MASARI Centralized Design System Color Tokens.
/// Elegant Dark Palette crafted for High-End Travel, Hajj & Umrah Platform.
class MasariColors {
  // --- Primary Brand Colors ---
  /// MASARI Deep Midnight - Ultra-deep obsidian dark canvas
  static const Color deepBlue = Color(0xFF050914);
  static const Color deepBlueDark = Color(0xFF03060D);
  static const Color deepBlueLight = Color(0xFF0A1631);
  static const Color deepBlueContainer = Color(0xFF080E1E);

  /// Royal Gold - Signature luxury accent color
  static const Color royalGold = Color(0xFFD4AF37);
  static const Color royalGoldLight = Color(0xFFE5C358);
  static const Color royalGoldDark = Color(0xFFB8860B);
  static const Color royalGoldMuted = Color(0xFFC5A059);

  /// Sky Cyan - Modern travel, aviation & dynamic accents
  static const Color skyCyan = Color(0xFF00D4FF);
  static const Color skyCyanLight = Color(0xFF38BDF8);

  /// Coral Orange - Warm highlights & promo callouts
  static const Color coralOrange = Color(0xFFFF7F50);
  static const Color coralOrangeAccent = Color(0xFFF97316);

  // --- Neutrals & Backgrounds ---
  /// Dark Graphite / Midnight Obsidian - Dark theme background & primary text
  static const Color darkGraphite = Color(0xFF050914);
  static const Color graphiteSurface = Color(0xFF0A1631);

  /// Marble White - Light theme background & pristine surfaces
  static const Color marbleWhite = Color(0xFFF8FAFC);
  static const Color pureWhite = Color(0xFFFFFFFF);

  /// Titanium Gray - Subtitles, borders, dividers & captions
  static const Color titaniumGray = Color(0xFF64748B);
  static const Color titaniumLight = Color(0xFF94A3B8);
  static const Color titaniumDivider = Color(0xFF1E293B);

  // --- Status & Feedback Colors ---
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFF064E3B);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFF78350F);
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFF7F1D1D);
  static const Color info = Color(0xFF3B82F6);

  // --- Luxury Gradients ---
  static const LinearGradient royalGoldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF3E5AB), Color(0xFFB8860B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient deepBlueGradient = LinearGradient(
    colors: [Color(0xFF050914), Color(0xFF0A1631)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient luxuryCardGradient = LinearGradient(
    colors: [Color(0xFF0A1631), Color(0xFF050914)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
