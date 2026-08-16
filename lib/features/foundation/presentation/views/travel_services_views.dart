import 'package:flutter/material.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_section_header.dart';

/// Base Travel Service Feature Foundation View Layout
class _BaseTravelServiceView extends StatelessWidget {
  final String title;
  final String routePath;
  final String description;
  final IconData icon;
  final Color accentColor;

  const _BaseTravelServiceView({
    required this.title,
    required this.routePath,
    required this.description,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MasariLuxuryCard(
            badgeText: 'قطاع مساري التخصصي',
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: accentColor, size: 36),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: MasariTypography.headlineSmall(color: MasariColors.pureWhite)),
                      const SizedBox(height: 4),
                      Text('المسار المعتمد: $routePath', style: MasariTypography.caption(color: MasariColors.primaryCyan, isArabic: false)),
                      const SizedBox(height: 6),
                      Text(description, style: MasariTypography.bodySmall(color: MasariColors.marbleWhite)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const MasariSectionHeader(
            title: 'الهيكل الهندسي وقواعد البيانات المجهزة',
            subtitle: 'جاهزية الربط البرمجي وواجهات المستخدم المستقلة',
          ),
          const SizedBox(height: 16),
          MasariCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.architecture, color: MasariColors.primaryCyan),
                  title: Text('Architecture Layer', style: MasariTypography.titleMedium()),
                  subtitle: const Text('data/ • domain/ • presentation/ (Clean Feature-First)'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.cloud_sync, color: MasariColors.primaryCyanLight),
                  title: Text('Repository & Data Sources', style: MasariTypography.titleMedium()),
                  subtitle: const Text('Firebase Firestore & REST API Ready Repository Contracts'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.view_agenda, color: MasariColors.primaryOrange),
                  title: Text('State Management', style: MasariTypography.titleMedium()),
                  subtitle: const Text('Riverpod Providers & AsyncNotifier Architecture'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlightsView extends StatelessWidget {
  const FlightsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const _BaseTravelServiceView(
      title: 'حجوزات الطيران (Flights)',
      routePath: '/flights',
      description: 'البنية المخصصة لمقارنة وحجز رحلات الطيران العالمية، الدرجة الأولى ودرجة الأعمال.',
      icon: Icons.flight_takeoff,
      accentColor: MasariColors.primaryCyan,
    );
  }
}

class HotelsView extends StatelessWidget {
  const HotelsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const _BaseTravelServiceView(
      title: 'حجوزات الفنادق والمنتجعات (Hotels)',
      routePath: '/hotels',
      description: 'البنية الهيكلية لفنادق الخمس نجوم، فنادق مكة والمدينة، والمنتجعات.',
      icon: Icons.hotel,
      accentColor: MasariColors.primaryBlueLight,
    );
  }
}

class BusView extends StatelessWidget {
  const BusView({super.key});
  @override
  Widget build(BuildContext context) {
    return const _BaseTravelServiceView(
      title: 'حافلات النقل الفاخر (Bus Booking)',
      routePath: '/bus',
      description: 'البنية التحتية لحجز الحافلات والتنقلات بين المدن والمشاعر المقدسة.',
      icon: Icons.directions_bus,
      accentColor: MasariColors.primaryOrange,
    );
  }
}

class CarsView extends StatelessWidget {
  const CarsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const _BaseTravelServiceView(
      title: 'تأجير السيارات الفارهة (Car Rental)',
      routePath: '/cars',
      description: 'منظومة تأجير السيارات مع سائقين خاصين أو قيادة شخصية.',
      icon: Icons.directions_car,
      accentColor: MasariColors.primaryCyanDark,
    );
  }
}

class TransfersView extends StatelessWidget {
  const TransfersView({super.key});
  @override
  Widget build(BuildContext context) {
    return const _BaseTravelServiceView(
      title: 'النقل الخاص والتوصيل (Private Transfers)',
      routePath: '/transfers',
      description: 'خدمات التوصيل من وإلى المطار، الفنادق، والمشاعر بأسطول حديث.',
      icon: Icons.local_taxi,
      accentColor: MasariColors.primaryBlue,
    );
  }
}

class TourismView extends StatelessWidget {
  const TourismView({super.key});
  @override
  Widget build(BuildContext context) {
    return const _BaseTravelServiceView(
      title: 'الباقات والبرامج السياحية (Tourism Packages)',
      routePath: '/tourism',
      description: 'جولات سياحية متكاملة، رحلات كروز، واستكشاف الوجهات العالمية.',
      icon: Icons.explore,
      accentColor: MasariColors.primaryOrangeDark,
    );
  }
}
