import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';

/// Splash Screen View Foundation
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MasariColors.primaryBlueDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: MasariColors.primaryCyan,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: MasariColors.primaryCyan.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: const Icon(
                Icons.flight_takeoff,
                size: 64,
                color: MasariColors.primaryBlueDark,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppConstants.appNameArabic,
              style: MasariTypography.headlineLarge(
                color: MasariColors.primaryCyan,
                isArabic: true,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppConstants.taglineAr,
              style: MasariTypography.bodyMedium(
                color: MasariColors.pureWhite,
                isArabic: true,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(MasariColors.primaryOrange),
            ),
          ],
        ),
      ),
    );
  }
}
