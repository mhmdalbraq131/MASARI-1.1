import 'package:flutter/material.dart';

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

  static final List<BoxShadow> luxuryGold = [
    BoxShadow(
      color: const Color(0xFFD4AF37).withOpacity(0.25),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];
}
