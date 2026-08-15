import 'package:flutter/material.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_spacing.dart';
import '../../core/theme/masari_typography.dart';

/// Modal Bottom Sheet for Mobile Responsive Layouts
class MasariBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: isDark ? MasariColors.graphiteSurface : MasariColors.pureWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(MasariSpacing.radiusXl)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? MasariColors.titaniumDividerDark : MasariColors.titaniumDivider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(title, style: MasariTypography.titleLarge()),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }
}

/// MASARI Custom Dialog
class MasariDialog extends StatelessWidget {
  final String title;
  final String message;
  final String primaryButtonLabel;
  final VoidCallback onPrimaryPressed;

  const MasariDialog({
    super.key,
    required this.title,
    required this.message,
    required this.primaryButtonLabel,
    required this.onPrimaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: MasariSpacing.borderLg),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? MasariColors.graphiteSurface : MasariColors.pureWhite,
          borderRadius: MasariSpacing.borderLg,
          border: Border.all(color: MasariColors.primaryCyan, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: MasariColors.primaryCyan, size: 40),
            const SizedBox(height: 12),
            Text(title, style: MasariTypography.titleLarge()),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center, style: MasariTypography.bodyMedium(color: MasariColors.titaniumGray)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MasariColors.primaryBlue,
                foregroundColor: MasariColors.pureWhite,
              ),
              onPressed: onPrimaryPressed,
              child: Text(primaryButtonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
