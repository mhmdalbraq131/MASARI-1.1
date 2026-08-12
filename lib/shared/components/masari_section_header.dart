import 'package:flutter/material.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_typography.dart';

/// Section Header Component with Title, Subtitle & Optional Action
class MasariSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  const MasariSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? MasariColors.pureWhite : MasariColors.darkGraphite;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: MasariColors.royalGold,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: MasariTypography.titleLarge(color: titleColor),
                ),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: MasariTypography.bodySmall(color: MasariColors.titaniumGray),
              ),
            ],
          ],
        ),
        if (actionLabel != null && onActionPressed != null)
          TextButton(
            onPressed: onActionPressed,
            child: Row(
              children: [
                Text(
                  actionLabel!,
                  style: MasariTypography.titleSmall(color: MasariColors.royalGoldDark),
                ),
                const Icon(Icons.arrow_forward_ios, size: 12, color: MasariColors.royalGoldDark),
              ],
            ),
          ),
      ],
    );
  }
}
