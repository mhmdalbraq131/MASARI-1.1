import 'package:flutter/material.dart';

/// MASARI Design Tokens for Spacing, Padding, Margins, Border Radius & Responsive Breakpoints
class MasariSpacing {
  // --- Spacing Steps ---
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 48.0;

  // --- Padding Tokens ---
  static const EdgeInsets pagePaddingMobile = EdgeInsets.all(16.0);
  static const EdgeInsets pagePaddingTablet = EdgeInsets.all(24.0);
  static const EdgeInsets pagePaddingDesktop = EdgeInsets.all(32.0);

  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(24.0);

  static const EdgeInsets buttonPaddingHorizontal = EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0);
  static const EdgeInsets chipPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0);

  // --- Border Radius Tokens ---
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusPill = 999.0;

  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius borderXl = BorderRadius.all(Radius.circular(radiusXl));

  // --- Responsive Breakpoints ---
  static const double mobileMaxBreakpoint = 600.0;
  static const double tabletMaxBreakpoint = 1100.0;
  static const double desktopMinBreakpoint = 1101.0;
}
