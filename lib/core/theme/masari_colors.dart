import 'package:flutter/material.dart';

/// MASARI centralized design-system color tokens.
///
/// The three source brand colors are taken from the approved MASARI identity:
/// Blue #116EB4, Turquoise #53BDCA and Orange #EE8A3E.
/// All other colors are supporting tones derived for accessibility and UI use.
class MasariColors {
  // =========================================================================
  // APPROVED MASARI BRAND COLORS — DO NOT SUBSTITUTE GENERIC PALETTE VALUES
  // =========================================================================
  static const Color brandBlue = Color(0xFF116EB4);
  static const Color brandTurquoise = Color(0xFF53BDCA);
  static const Color brandOrange = Color(0xFFEE8A3E);

  // =========================================================================
  // BLUE — PRIMARY BRAND / NAVIGATION
  // =========================================================================
  static const Color primaryBlue = brandBlue;
  static const Color primaryBlueDark = Color(0xFF0A3556);
  static const Color primaryBlueLight = Color(0xFF3A86C1);
  static const Color primaryBlueContainer = Color(0xFF123E60);

  // =========================================================================
  // TURQUOISE — ACTIVE / DYNAMIC ACCENT
  // =========================================================================
  static const Color primaryCyan = brandTurquoise;
  static const Color primaryCyanDark = Color(0xFF2B97A8);
  static const Color primaryCyanLight = Color(0xFF8AD4DD);
  static const Color primaryCyanContainer = Color(0xFF174C56);

  // =========================================================================
  // ORANGE — ACTION / HIGHLIGHT
  // =========================================================================
  static const Color primaryOrange = brandOrange;
  static const Color primaryOrangeDark = Color(0xFFC9682F);
  static const Color primaryOrangeLight = Color(0xFFF3AE7A);
  static const Color primaryOrangeContainer = Color(0xFF5A2D18);

  // =========================================================================
  // NEUTRALS & BACKGROUNDS
  // =========================================================================
  static const Color darkGraphite = Color(0xFF071A2A);
  static const Color graphiteSurface = Color(0xFF0D263B);
  static const Color marbleWhite = Color(0xFFF8FAFC);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color titaniumGray = Color(0xFF64748B);
  static const Color titaniumLight = Color(0xFF94A3B8);
  static const Color titaniumDivider = Color(0xFFE2E8F0);
  static const Color titaniumDividerDark = Color(0xFF29465F);

  // =========================================================================
  // STATUS & FEEDBACK COLORS
  // =========================================================================
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFF064E3B);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFF78350F);
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFF7F1D1D);
  static const Color info = Color(0xFF0284C7);

  // =========================================================================
  // BRAND GRADIENTS
  // =========================================================================
  static const LinearGradient brandGradient = LinearGradient(
    colors: [brandBlue, brandTurquoise],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanOrangeGradient = LinearGradient(
    colors: [brandTurquoise, brandOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient luxuryCardGradient = LinearGradient(
    colors: [graphiteSurface, darkGraphite],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient deepBlueGradient = LinearGradient(
    colors: [darkGraphite, primaryBlueContainer],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // =========================================================================
  // LEGACY COMPATIBILITY ALIASES
  // =========================================================================
  static const Color deepBlue = primaryBlue;
  static const Color deepBlueDark = primaryBlueDark;
  static const Color deepBlueLight = primaryBlueLight;
  static const Color deepBlueContainer = primaryBlueContainer;
  static const Color skyCyan = primaryCyan;
  static const Color skyCyanLight = primaryCyanLight;
  static const Color coralOrange = primaryOrange;
  static const Color coralOrangeAccent = primaryOrangeDark;
}
