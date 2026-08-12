import 'package:flutter/material.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_section_header.dart';

/// Hajj Platform Foundation View
class HajjView extends StatelessWidget {
  const HajjView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MasariLuxuryCard(
            badgeText: 'خدمات الحج المعتمدة',
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: MasariColors.royalGold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mosque, color: MasariColors.deepBlue, size: 36),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('باقات ومجموعات الحج (Hajj)', style: MasariTypography.headlineSmall(color: MasariColors.pureWhite)),
                      const SizedBox(height: 4),
                      Text('المسار: /hajj', style: MasariTypography.caption(color: MasariColors.royalGold, isArabic: false)),
                      const SizedBox(height: 6),
                      Text('بنية تنظيم وتنفيذ رحلات الحج VIP، المخيمات، والتنقلات المقدسة.', style: MasariTypography.bodySmall(color: MasariColors.marbleWhite)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          MasariSectionHeader(title: 'جاهزية الربط بوزارة الحج والمؤسسات'),
          const SizedBox(height: 16),
          const MasariCard(
            child: Text('هيكل الموديول جاهز لتطبيق بروتوكولات الحج وإدارة المجموعات.'),
          ),
        ],
      ),
    );
  }
}

/// Umrah Platform Foundation View
class UmrahView extends StatelessWidget {
  const UmrahView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MasariLuxuryCard(
            badgeText: 'خدمات العمرة الملكية',
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: MasariColors.deepBlueContainer,
                    shape: BoxShape.circle,
                    border: Border.all(color: MasariColors.royalGold),
                  ),
                  child: const Icon(Icons.night_shelter, color: MasariColors.royalGold, size: 36),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('برامج العمرة المخصصة (Umrah)', style: MasariTypography.headlineSmall(color: MasariColors.pureWhite)),
                      const SizedBox(height: 4),
                      Text('المسار: /umrah', style: MasariTypography.caption(color: MasariColors.royalGold, isArabic: false)),
                      const SizedBox(height: 6),
                      Text('باقات العمرة الشاملة للتصاريح، الطيران، الفنادق المطلة، والإرشاد.', style: MasariTypography.bodySmall(color: MasariColors.marbleWhite)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Visa Services Foundation View
class VisaView extends StatelessWidget {
  const VisaView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MasariLuxuryCard(
            badgeText: 'مركز التأشيرات',
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: MasariColors.skyCyan,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.badge, color: MasariColors.deepBlue, size: 36),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('تأشيرات السفر والسياحة والعمرة (Visa)', style: MasariTypography.headlineSmall(color: MasariColors.pureWhite)),
                      const SizedBox(height: 4),
                      Text('المسار: /visa', style: MasariTypography.caption(color: MasariColors.royalGold, isArabic: false)),
                      const SizedBox(height: 6),
                      Text('معالجة طلبات التأشيرات الإلكترونية، التأشيرات السياحية، والدعم القنصلي.', style: MasariTypography.bodySmall(color: MasariColors.marbleWhite)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
