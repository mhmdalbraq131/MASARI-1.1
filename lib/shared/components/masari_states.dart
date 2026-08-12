import 'package:flutter/material.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_typography.dart';

/// Loading State Spinner with Gold Accent
class MasariLoadingState extends StatelessWidget {
  final String? message;

  const MasariLoadingState({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(MasariColors.royalGold),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(message!, style: MasariTypography.bodyMedium(color: MasariColors.titaniumGray)),
          ],
        ],
      ),
    );
  }
}

/// Skeleton Loader for Data Placeholder
class MasariSkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const MasariSkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: MasariColors.titaniumDivider,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Empty State Component
class MasariEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const MasariEmptyState({
    super.key,
    this.title = 'لا توجد بيانات متاحة حالياً',
    this.description = 'قم بالبحث أو اختيار قسم آخر لعرض محتوى منصة مساري.',
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MasariColors.marbleWhite,
                shape: BoxShape.circle,
                border: Border.all(color: MasariColors.royalGold, width: 1.5),
              ),
              child: Icon(icon, size: 48, color: MasariColors.royalGold),
            ),
            const SizedBox(height: 20),
            Text(title, style: MasariTypography.titleLarge(), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(description, style: MasariTypography.bodyMedium(color: MasariColors.titaniumGray), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

/// Error State Component with Retry Action
class MasariErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const MasariErrorState({
    super.key,
    this.errorMessage = 'حدث خطأ أثناء تحميل البيانات',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 56, color: MasariColors.error),
            const SizedBox(height: 16),
            Text(errorMessage, style: MasariTypography.titleMedium(color: MasariColors.error), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, color: MasariColors.deepBlue),
                label: Text('إعادة المحاولة', style: MasariTypography.buttonText(color: MasariColors.deepBlue)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
