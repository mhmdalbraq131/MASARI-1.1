import 'package:flutter/material.dart';
import 'masari_colors.dart';

/// MASARI Centralized Design System Elevation & BoxShadow Tokens.
class MasariShadows {
  static final List<BoxShadow> subtle = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static final List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 12,
      offset: const Offset(0, 3),
    ),
  ];

  /// Brand Cyan Accent Glow
  static final List<BoxShadow> luxuryCyan = [
    BoxShadow(
      color: MasariColors.primaryCyan.withOpacity(0.2),
      blurRadius: 18,
      offset: const Offset(0, 4),
    ),
  ];

  /// Brand Orange Glow
  static final List<BoxShadow> luxuryOrange = [
    BoxShadow(
      color: MasariColors.primaryOrange.withOpacity(0.25),
      blurRadius: 18,
      offset: const Offset(0, 4),
    ),
  ];
}
