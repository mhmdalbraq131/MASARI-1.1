import 'package:flutter/material.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_shadows.dart';
import '../../core/theme/masari_spacing.dart';

/// Standard MASARI Clean Card
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? MasariColors.graphiteSurface : MasariColors.pureWhite;
    final borderColor = isDark ? MasariColors.primaryCyan.withValues(alpha: 0.2) : MasariColors.titaniumDivider;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: MasariSpacing.borderMd,
        border: Border.all(color: borderColor),
        boxShadow: isDark ? const [] : MasariShadows.card,
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

/// MASARI High-End Brand Card with Cyan Border & Deep Blue Gradient
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
        border: Border.all(color: MasariColors.primaryCyan, width: 1.5),
        boxShadow: MasariShadows.luxuryCyan,
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
                        color: MasariColors.primaryCyan,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(MasariSpacing.radiusLg),
                          bottomRight: Radius.circular(MasariSpacing.radiusSm),
                        ),
                      ),
                      child: Text(
                        badgeText!,
                        style: const TextStyle(
                          color: MasariColors.primaryBlueDark,
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
