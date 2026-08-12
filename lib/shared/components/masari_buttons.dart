import 'package:flutter/material.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_spacing.dart';
import '../../core/theme/masari_typography.dart';

/// Primary MASARI Luxury Button with Deep Blue fill & optional Gold accent
class MasariPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isGoldStyle;
  final double? width;

  const MasariPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isGoldStyle = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isGoldStyle ? MasariColors.royalGold : MasariColors.deepBlue;
    final fg = isGoldStyle ? MasariColors.deepBlue : MasariColors.pureWhite;

    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: MasariSpacing.borderMd,
          ),
          padding: MasariSpacing.buttonPaddingHorizontal,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: fg,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: fg),
                    const SizedBox(width: MasariSpacing.sm),
                  ],
                  Text(
                    label,
                    style: MasariTypography.buttonText(color: fg),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Secondary Outlined MASARI Button
class MasariSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color borderColor;
  final Color? textColor;

  const MasariSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.borderColor = MasariColors.royalGold,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = textColor ?? (isDark ? MasariColors.royalGold : MasariColors.deepBlue);

    return SizedBox(
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveColor,
          side: BorderSide(color: borderColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: MasariSpacing.borderMd,
          ),
          padding: MasariSpacing.buttonPaddingHorizontal,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: effectiveColor),
              const SizedBox(width: MasariSpacing.sm),
            ],
            Text(
              label,
              style: MasariTypography.buttonText(color: effectiveColor),
            ),
          ],
        ),
      ),
    );
  }
}
