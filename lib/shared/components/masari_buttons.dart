import 'package:flutter/material.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_spacing.dart';
import '../../core/theme/masari_typography.dart';

/// Primary MASARI Button with Primary Blue or Orange CTA styling
class MasariPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isOrangeCta;
  final double? width;

  const MasariPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isOrangeCta = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isOrangeCta ? MasariColors.primaryOrange : MasariColors.primaryBlue;
    const fg = MasariColors.pureWhite;

    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: MasariSpacing.borderMd,
          ),
          padding: MasariSpacing.buttonPaddingHorizontal,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
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
                  Flexible(
                    child: Text(
                      label,
                      style: MasariTypography.buttonText(color: fg),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Secondary Outlined MASARI Button with Cyan or Blue border
class MasariSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;

  const MasariSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBorderColor = borderColor ?? (isDark ? MasariColors.primaryCyan : MasariColors.primaryBlueLight);
    final effectiveTextColor = textColor ?? (isDark ? MasariColors.primaryCyan : MasariColors.primaryBlue);

    return SizedBox(
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveTextColor,
          side: BorderSide(color: effectiveBorderColor, width: 1.5),
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
              Icon(icon, size: 18, color: effectiveTextColor),
              const SizedBox(width: MasariSpacing.sm),
            ],
            Flexible(
              child: Text(
                label,
                style: MasariTypography.buttonText(color: effectiveTextColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
