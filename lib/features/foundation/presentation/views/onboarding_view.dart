import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/masari_localization.dart';
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
                masariText(context, 'مرحباً بك في منصة ${AppConstants.appNameArabic}', 'Welcome to ${AppConstants.appName}'),
                style: MasariTypography.headlineMedium(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                masariText(context, 'البوابة الموحدة للسفر الفاخر، رحلات الطيران، الفنادق، وباقات الحج والعمرة.', 'The unified gateway for luxury travel, flights, hotels, Hajj, and Umrah packages.'),
                style: MasariTypography.bodyLarge(color: MasariColors.titaniumGray),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              MasariLuxuryCard(
                badgeText: masariText(context, 'الأساس التقني', 'Platform Foundation'),
                child: Column(
                  children: [
                    const Icon(Icons.verified, color: MasariColors.primaryCyan, size: 36),
                    const SizedBox(height: 12),
                    Text(
                      masariText(context, 'هيكل المنصة الموحد جاهز للعمل على كافة المنصات', 'The unified platform foundation is ready across all supported platforms.'),
                      style: MasariTypography.titleMedium(color: MasariColors.pureWhite),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Android • iOS • Windows • Web',
                      style: TextStyle(color: MasariColors.primaryCyanLight),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              MasariPrimaryButton(
                label: masariText(context, 'الدخول إلى المنصة', 'Enter platform'),
                isOrangeCta: true,
                onPressed: () => context.go('/home'),
              ),
              const SizedBox(height: 12),
              MasariSecondaryButton(
                label: masariText(context, 'تسجيل الدخول', 'Sign in'),
                onPressed: () => context.go('/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
