import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/masari_localization.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_buttons.dart';

/// MASARI's first-touch welcome screen.
///
/// The visual language intentionally feels like a calm travel/worship gateway:
/// a centered card, soft Islamic geometry, mosque silhouettes, lanterns and a
/// short remembrance of Allah. The background is painted locally so the screen
/// does not require an additional image package or a remote asset.
class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EC),
      body: Stack(
        children: [
          const Positioned.fill(child: _OnboardingBackdrop()),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: _WelcomeCard(isArabic: isArabic),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.isArabic});

  final bool isArabic;

  String text(String ar, String en) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 28, 30, 22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: MasariColors.brandTurquoise.withValues(alpha: 0.16)),
        boxShadow: [
          BoxShadow(
            color: MasariColors.primaryBlueDark.withValues(alpha: 0.12),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              gradient: MasariColors.brandGradient,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: MasariColors.brandTurquoise.withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.explore_rounded, color: Colors.white, size: 42),
          ),
          const SizedBox(height: 12),
          Text(
            AppConstants.appNameArabic,
            style: MasariTypography.headlineSmall(color: MasariColors.primaryBlueDark),
          ),
          Text(
            text('لإدارة الرحلات والمهام', 'Travel & Journey Management'),
            style: MasariTypography.bodySmall(color: MasariColors.titaniumGray),
          ),
          const SizedBox(height: 24),
          Text(
            text('مرحبًا بك في منصة مساري', 'Welcome to MASARI'),
            style: MasariTypography.headlineMedium(color: MasariColors.primaryBlueDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            text(
              'البوابة الموحدة للسفر الفاخر، رحلات الطيران، الفنادق، وباقات الحج والعمرة.',
              'Your unified gateway for luxury travel, flights, hotels, Hajj and Umrah packages.',
            ),
            style: MasariTypography.bodyLarge(color: MasariColors.titaniumGray),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              gradient: MasariColors.luxuryCardGradient,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: MasariColors.brandTurquoise.withValues(alpha: 0.9)),
            ),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: MasariColors.brandTurquoise,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        text('بوابة السفر والعبادة', 'Travel & Worship Gateway'),
                        style: MasariTypography.labelMedium(color: MasariColors.darkGraphite),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Icon(Icons.auto_awesome_rounded, color: MasariColors.primaryCyan, size: 34),
                const SizedBox(height: 10),
                Text(
                  text(
                    'نسير معك في رحلتك بخدمات متكاملة وتجربة تليق بمسارك.',
                    'A complete journey experience designed to move with you, wherever your path leads.',
                  ),
                  style: MasariTypography.titleMedium(color: MasariColors.pureWhite),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Android • iOS • Windows • Web',
                  style: MasariTypography.bodyMedium(color: MasariColors.primaryCyanLight),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: MasariPrimaryButton(
              label: text('الدخول إلى المنصة', 'Enter MASARI'),
              isOrangeCta: true,
              onPressed: () => context.go('/home'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: MasariSecondaryButton(
              label: text('تسجيل الدخول', 'Sign in'),
              onPressed: () => context.go('/login'),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Expanded(child: Divider(color: Color(0xFFDCCBAA))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.star_rounded, color: MasariColors.primaryOrange, size: 18),
              ),
              const Expanded(child: Divider(color: Color(0xFFDCCBAA))),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            text('وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ', 'My success is only through Allah'),
            style: MasariTypography.titleSmall(color: MasariColors.primaryBlueDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            text('استعن بالله دائمًا .. فكل طريق يبدأ بذكره', 'Always seek Allah\'s help — every journey begins with remembrance.'),
            style: MasariTypography.bodySmall(color: MasariColors.titaniumGray),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _OnboardingBackdrop extends StatelessWidget {
  const _OnboardingBackdrop();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _OnboardingBackdropPainter());
  }
}

class _OnboardingBackdropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE8F2F0), Color(0xFFFFFBF0), Color(0xFFF5EFE1)],
      ).createShader(rect);
    canvas.drawRect(rect, background);

    final center = size.center(Offset.zero);
    final glow = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white.withValues(alpha: 0.92), Colors.white.withValues(alpha: 0)],
      ).createShader(Rect.fromCircle(center: center, radius: size.shortestSide * 0.52));
    canvas.drawCircle(center, size.shortestSide * 0.52, glow);

    _drawGeometry(canvas, size);
    _drawMosques(canvas, size);
    _drawLantern(canvas, Offset(50, 115), 1.0);
    _drawLantern(canvas, Offset(size.width - 50, 115), -1.0);
    _drawPalms(canvas, size);
  }

  void _drawGeometry(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = MasariColors.primaryBlue.withValues(alpha: 0.06);
    const step = 46.0;
    for (double x = -step; x < size.width + step; x += step) {
      for (double y = -step; y < size.height + step; y += step) {
        final path = Path();
        for (int i = 0; i < 8; i++) {
          final a = i * math.pi / 4;
          final point = Offset(x + 15 + math.cos(a) * 15, y + 15 + math.sin(a) * 15);
          if (i == 0) {
            path.moveTo(point.dx, point.dy);
          } else {
            path.lineTo(point.dx, point.dy);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  void _drawMosques(Canvas canvas, Size size) {
    final paint = Paint()..color = MasariColors.primaryBlueDark.withValues(alpha: 0.09);
    final baseY = size.height * 0.70;
    final centerX = size.width / 2;

    canvas.drawRect(Rect.fromLTWH(0, baseY, size.width, size.height - baseY), paint);
    _drawDome(canvas, Offset(centerX, baseY + 5), 105, paint);

    for (final dx in <double>[-170, -115, 115, 170]) {
      _drawMinaret(canvas, Offset(centerX + dx, baseY), dx.abs() > 140 ? 78 : 62, paint);
    }
    for (final dx in <double>[-65, 65]) {
      _drawMinaret(canvas, Offset(centerX + dx, baseY + 5), 48, paint);
    }
  }

  void _drawDome(Canvas canvas, Offset base, double width, Paint paint) {
    final path = Path()
      ..moveTo(base.dx - width, base.dy)
      ..quadraticBezierTo(base.dx - width * 0.72, base.dy - width * 0.66, base.dx, base.dy - width * 0.72)
      ..quadraticBezierTo(base.dx + width * 0.72, base.dy - width * 0.66, base.dx + width, base.dy)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawRect(Rect.fromLTWH(base.dx - width * 0.74, base.dy, width * 1.48, 120), paint);
  }

  void _drawMinaret(Canvas canvas, Offset base, double height, Paint paint) {
    final width = height * 0.16;
    canvas.drawRect(Rect.fromLTWH(base.dx - width / 2, base.dy - height, width, height), paint);
    canvas.drawCircle(Offset(base.dx, base.dy - height - 4), width * 0.7, paint);
    final spire = Path()
      ..moveTo(base.dx, base.dy - height - 24)
      ..lineTo(base.dx - width * 0.65, base.dy - height - 7)
      ..lineTo(base.dx + width * 0.65, base.dy - height - 7)
      ..close();
    canvas.drawPath(spire, paint);
  }

  void _drawLantern(Canvas canvas, Offset origin, double direction) {
    final line = Paint()
      ..color = MasariColors.primaryOrange.withValues(alpha: 0.28)
      ..strokeWidth = 1.4;
    canvas.drawLine(origin, Offset(origin.dx, origin.dy + 28), line);
    final body = Paint()..color = MasariColors.primaryOrange.withValues(alpha: 0.20);
    final center = Offset(origin.dx, origin.dy + 48);
    final path = Path()
      ..moveTo(center.dx - 12, center.dy - 17)
      ..lineTo(center.dx + 12, center.dy - 17)
      ..lineTo(center.dx + 9, center.dy + 14)
      ..lineTo(center.dx, center.dy + 20)
      ..lineTo(center.dx - 9, center.dy + 14)
      ..close();
    canvas.drawPath(path, body);
    canvas.drawCircle(Offset(center.dx + direction * 1, center.dy), 5, Paint()..color = const Color(0xFFFFD98A).withValues(alpha: 0.7));
  }

  void _drawPalms(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MasariColors.primaryBlueDark.withValues(alpha: 0.10)
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round;
    final left = Path()
      ..moveTo(-15, size.height + 20)
      ..quadraticBezierTo(25, size.height * 0.83, 105, size.height * 0.72);
    final right = Path()
      ..moveTo(size.width + 15, size.height + 20)
      ..quadraticBezierTo(size.width - 25, size.height * 0.83, size.width - 105, size.height * 0.72);
    canvas.drawPath(left, paint);
    canvas.drawPath(right, paint);

    final leafPaint = Paint()
      ..color = MasariColors.primaryBlueDark.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    for (final side in <double>[1, -1]) {
      final x = side > 0 ? 100.0 : size.width - 100;
      final y = size.height * 0.72;
      for (int i = 0; i < 7; i++) {
        final a = -math.pi * 0.95 + i * math.pi * 0.3;
        final path = Path()
          ..moveTo(x, y)
          ..quadraticBezierTo(x + math.cos(a) * 42, y + math.sin(a) * 38, x + math.cos(a) * 78, y + math.sin(a) * 65);
        canvas.drawPath(path, leafPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
