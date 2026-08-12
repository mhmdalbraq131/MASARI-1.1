import 'package:flutter/material.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_shadows.dart';
import '../../core/theme/masari_spacing.dart';

/// Standard MASARI White Clean Card
class MasariCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const MasariCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MasariColors.pureWhite,
        borderRadius: MasariSpacing.borderMd,
        border: Border.all(color: MasariColors.titaniumDivider),
        boxShadow: MasariShadows.card,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: MasariSpacing.borderMd,
        child: InkWell(
          onTap: onTap,
          borderRadius: MasariSpacing.borderMd,
          child: Padding(
            padding: padding ?? MasariSpacing.cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// MASARI Luxury Card with Royal Gold Border & Deep Blue Accent
class MasariLuxuryCard extends StatelessWidget {
  final Widget child;
  final String? badgeText;
  final VoidCallback? onTap;

  const MasariLuxuryCard({
    super.key,
    required this.child,
    this.badgeText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: MasariColors.luxuryCardGradient,
        borderRadius: MasariSpacing.borderLg,
        border: Border.all(color: MasariColors.royalGold, width: 1.5),
        boxShadow: MasariShadows.luxuryGold,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: MasariSpacing.borderLg,
        child: InkWell(
          onTap: onTap,
          borderRadius: MasariSpacing.borderLg,
          child: Padding(
            padding: MasariSpacing.cardPaddingLarge,
            child: Stack(
              children: [
                child,
                if (badgeText != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: const BoxDecoration(
                        color: MasariColors.royalGold,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(MasariSpacing.radiusLg),
                          bottomRight: Radius.circular(MasariSpacing.radiusSm),
                        ),
                      ),
                      child: Text(
                        badgeText!,
                        style: const TextStyle(
                          color: MasariColors.deepBlue,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
