import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../domain/entities/platform_service.dart';
import '../providers/app_providers.dart';
import '../providers/platform_services_persistence_provider.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_section_header.dart';

/// Customer-facing catalog view backed by the same operational state used by
/// the admin portal, including persisted administrator changes.
class _TravelServiceCatalogView extends ConsumerWidget {
  final String title;
  final String routePath;
  final String description;
  final IconData icon;
  final Color accentColor;
  final String category;

  const _TravelServiceCatalogView({
    required this.title,
    required this.routePath,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(operationalPlatformServicesProvider)
        .where((service) => service.category == category && service.status == 'نشط')
        .toList();

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
          MasariSectionHeader(
            title: 'الخدمات المتاحة',
            subtitle: 'الأسعار والحالة معروضة من كتالوج مساري التشغيلي',
          ),
          const SizedBox(height: 16),
          if (services.isEmpty)
            const MasariCard(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: Text('لا توجد خدمات متاحة حاليًا ضمن هذا القطاع.')),
              ),
            )
          else
            ...services.map((service) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _ServiceCard(service: service, accentColor: accentColor),
            )),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final PlatformService service;
  final Color accentColor;

  const _ServiceCard({required this.service, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return MasariCard(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: accentColor.withValues(alpha: 0.15),
          child: Icon(Icons.workspace_premium, color: accentColor),
        ),
        title: Text(service.name, style: MasariTypography.titleMedium()),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(service.description),
        ),
        trailing: Text(
          '${service.price.toStringAsFixed(0)} ${service.currency}',
          style: MasariTypography.titleMedium(color: accentColor),
        ),
      ),
    );
  }
}

class FlightsView extends StatelessWidget {
  const FlightsView({super.key});
  @override
  Widget build(BuildContext context) => const _TravelServiceCatalogView(
    title: 'حجوزات الطيران (Flights)',
    routePath: '/flights',
    description: 'مقارنة خيارات الطيران ودرجات السفر ضمن منظومة مساري.',
    icon: Icons.flight_takeoff,
    accentColor: MasariColors.primaryCyan,
    category: 'طيران',
  );
}

class HotelsView extends StatelessWidget {
  const HotelsView({super.key});
  @override
  Widget build(BuildContext context) => const _TravelServiceCatalogView(
    title: 'حجوزات الفنادق والمنتجعات (Hotels)',
    routePath: '/hotels',
    description: 'خيارات إقامة فاخرة في مكة والمدينة والوجهات السياحية.',
    icon: Icons.hotel,
    accentColor: MasariColors.primaryBlueLight,
    category: 'فنادق',
  );
}

class BusView extends StatelessWidget {
  const BusView({super.key});
  @override
  Widget build(BuildContext context) => const _TravelServiceCatalogView(
    title: 'حافلات النقل الفاخر (Bus Booking)',
    routePath: '/bus',
    description: 'حجز النقل بين المدن والمشاعر المقدسة بأسطول فاخر.',
    icon: Icons.directions_bus,
    accentColor: MasariColors.primaryOrange,
    category: 'حافلات',
  );
}

class CarsView extends StatelessWidget {
  const CarsView({super.key});
  @override
  Widget build(BuildContext context) => const _TravelServiceCatalogView(
    title: 'تأجير السيارات الفارهة (Car Rental)',
    routePath: '/cars',
    description: 'سيارات فاخرة مع خيار السائق الخاص أو القيادة الشخصية.',
    icon: Icons.directions_car,
    accentColor: MasariColors.primaryCyanDark,
    category: 'سيارات',
  );
}

class TransfersView extends StatelessWidget {
  const TransfersView({super.key});
  @override
  Widget build(BuildContext context) => const _TravelServiceCatalogView(
    title: 'النقل الخاص والتوصيل (Private Transfers)',
    routePath: '/transfers',
    description: 'خدمات الاستقبال والتوصيل من وإلى المطارات والفنادق والمشاعر.',
    icon: Icons.local_taxi,
    accentColor: MasariColors.primaryBlue,
    category: 'سيارات',
  );
}

class TourismView extends StatelessWidget {
  const TourismView({super.key});
  @override
  Widget build(BuildContext context) => const _TravelServiceCatalogView(
    title: 'الباقات والبرامج السياحية (Tourism Packages)',
    routePath: '/tourism',
    description: 'برامج سياحية متكاملة ورحلات لاستكشاف الوجهات العالمية.',
    icon: Icons.explore,
    accentColor: MasariColors.primaryOrangeDark,
    category: 'سياحة',
  );
}
