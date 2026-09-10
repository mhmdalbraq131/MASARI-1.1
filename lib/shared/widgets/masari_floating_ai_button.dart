import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_typography.dart';

/// Persistent entry point to MASARI's AI assistant from the main app shell.
class MasariFloatingAiButton extends StatelessWidget {
  const MasariFloatingAiButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final label = isArabic ? 'مساعد مساري الذكي' : 'MASARI AI Assistant';

    return Tooltip(
      message: label,
      child: FloatingActionButton.extended(
        heroTag: 'masari-ai-fab',
        onPressed: () => context.go('/ai'),
        backgroundColor: MasariColors.brandBlue,
        foregroundColor: Colors.white,
        elevation: 8,
        icon: const Icon(Icons.auto_awesome, size: 21),
        label: Text(
          isArabic ? 'مساري AI' : 'MASARI AI',
          style: MasariTypography.labelLarge(
            color: Colors.white,
            isArabic: isArabic,
          ),
        ),
      ),
    );
  }
}
