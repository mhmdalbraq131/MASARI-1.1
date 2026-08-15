import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_buttons.dart';
import '../../../../shared/components/masari_cards.dart';

/// Onboarding Foundation View
class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MasariColors.marbleWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.explore, color: MasariColors.primaryCyan, size: 48),
              const SizedBox(height: 16),
              Text(
                'مرحباً بك في منصة ${AppConstants.appNameArabic}',
                style: MasariTypography.headlineMedium(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'البوابة الموحدة للسفر الفاخر، رحلات الطيران، الفنادق، وباقات الحج والعمرة.',
                style: MasariTypography.bodyLarge(color: MasariColors.titaniumGray),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              MasariLuxuryCard(
                badgeText: 'الأساس التقني',
                child: Column(
                  children: [
                    const Icon(Icons.verified, color: MasariColors.primaryCyan, size: 36),
                    const SizedBox(height: 12),
                    Text(
                      'هيكل المنصة الموحد جاهز للعمل على كافة المنصات',
                      style: MasariTypography.titleMedium(color: MasariColors.pureWhite),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Android • iOS • Windows • Web',
                      style: MasariTypography.caption(color: MasariColors.primaryCyanLight, isArabic: false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              MasariPrimaryButton(
                label: 'الدخول إلى المنصة (Home)',
                isOrangeCta: true,
                onPressed: () => context.go('/home'),
              ),
              const SizedBox(height: 12),
              MasariSecondaryButton(
                label: 'تسجيل الدخول (Login)',
                onPressed: () => context.go('/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
