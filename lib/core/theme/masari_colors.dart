import 'package:flutter/material.dart';

/// MASARI Centralized Design System Color Tokens.
/// The Single Source of Truth for the MASARI Brand Visual Identity.
/// Core Tri-Color Palette:
/// 1. Blue (Primary Brand Foundation & Navigation)
/// 2. Cyan / Turquoise (Dynamic High-End Accent & Active States)
/// 3. Orange (Warm High-Energy Accent & Call-To-Action)
class MasariColors {
  // =========================================================================
  // 1. PRIMARY BLUE & DERIVED VARIANTS
  // =========================================================================
  /// MASARI Deep Blue - Main brand color for app bars, headers, primary buttons
  static const Color primaryBlue = Color(0xFF0A2540);

  /// Ultra-deep blue dark canvas for dark mode scaffold and dark shells
  static const Color primaryBlueDark = Color(0xFF061528);

  /// Vibrant/interactive blue for links, selection states, secondary badges
  static const Color primaryBlueLight = Color(0xFF1E5B94);

  /// Container & surface fill for dark-mode cards and embedded panels
  static const Color primaryBlueContainer = Color(0xFF0D2545);

  // =========================================================================
  // 2. PRIMARY CYAN / TURQUOISE & DERIVED VARIANTS
  // =========================================================================
  /// Vibrant MASARI Cyan / Turquoise - Key accent, badges, active icons, tabs
  static const Color primaryCyan = Color(0xFF00C5E0);

  /// Deep turquoise for borders, high-contrast text, and dark-theme outlines
  static const Color primaryCyanDark = Color(0xFF0891B2);

  /// Soft cyan for glowing accents, light badges, and subtle highlights
  static const Color primaryCyanLight = Color(0xFF38BDF8);

  /// Background container for cyan badges and interactive chip fills
  static const Color primaryCyanContainer = Color(0xFF083344);

  // =========================================================================
  // 3. PRIMARY ORANGE & DERIVED VARIANTS
  // =========================================================================
  /// Warm MASARI Coral Orange - Highlights, primary CTAs, alerts, and promo badges
  static const Color primaryOrange = Color(0xFFFF6B35);

  /// Deep burnt orange for borders, pressed states, and high-contrast warnings
  static const Color primaryOrangeDark = Color(0xFFEA580C);

  /// Soft coral orange for highlights and subtle badge backgrounds
  static const Color primaryOrangeLight = Color(0xFFFB923C);

  /// Background container for orange badges and warning containers
  static const Color primaryOrangeContainer = Color(0xFF431407);

  // =========================================================================
  // 4. NEUTRALS & BACKGROUNDS (TECHNICAL READABILITY)
  // =========================================================================
  /// Dark canvas background
  static const Color darkGraphite = Color(0xFF061528);

  /// Dark surface card background
  static const Color graphiteSurface = Color(0xFF0B213B);

  /// Light theme background & pristine surfaces
  static const Color marbleWhite = Color(0xFFF8FAFC);

  /// Pure crisp white
  static const Color pureWhite = Color(0xFFFFFFFF);

  /// Slate / Titanium Gray for subtitles, captions & muted elements
  static const Color titaniumGray = Color(0xFF64748B);

  /// Light titanium for secondary captions & placeholder text
  static const Color titaniumLight = Color(0xFF94A3B8);

  /// Divider in light mode
  static const Color titaniumDivider = Color(0xFFE2E8F0);

  /// Divider in dark mode
  static const Color titaniumDividerDark = Color(0xFF1E3A5F);

  // =========================================================================
  // 5. STATUS & FEEDBACK COLORS
  // =========================================================================
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFF064E3B);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFF78350F);
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFF7F1D1D);
  static const Color info = Color(0xFF0284C7);

  // =========================================================================
  // 6. BRAND GRADIENTS
  // =========================================================================
  /// Signature Blue to Cyan gradient
  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFF0A2540), Color(0xFF00C5E0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// High-energy Cyan to Orange gradient
  static const LinearGradient cyanOrangeGradient = LinearGradient(
    colors: [Color(0xFF00C5E0), Color(0xFFFF6B35)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Deep Blue Luxury Card Gradient
  static const LinearGradient luxuryCardGradient = LinearGradient(
    colors: [Color(0xFF0B213B), Color(0xFF061528)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient deepBlueGradient = LinearGradient(
    colors: [Color(0xFF061528), Color(0xFF0D2545)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // =========================================================================
  // 7. COMPATIBILITY ALIASES (Transitioned to the 3-Color Brand System)
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
