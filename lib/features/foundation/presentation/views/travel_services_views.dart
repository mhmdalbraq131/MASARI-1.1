import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/masari_localization.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_section_header.dart';
import '../../../bookings/presentation/booking_provider.dart';
import '../../domain/entities/platform_service.dart';
import '../providers/operational_catalog_provider.dart';

class _TravelServiceCatalogView extends ConsumerWidget {
  final String title, routePath, description, category;
  final IconData icon;
  final Color accentColor;
  const _TravelServiceCatalogView({required this.title, required this.routePath, required this.description, required this.icon, required this.accentColor, required this.category});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(operationalCatalogProvider).where((s) => s.category == category && s.status == 'نشط').toList();
    return SingleChildScrollView(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MasariLuxuryCard(badgeText: masariText(context, 'قطاع مساري التخصصي', 'MASARI Service Sector'), child: Row(children: [Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: accentColor.withValues(alpha: .2), shape: BoxShape.circle), child: Icon(icon, color: accentColor, size: 36)), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: MasariTypography.headlineSmall(color: Colors.white)), Text('${masariText(context, 'المسار المعتمد', 'Route')}: $routePath', style: MasariTypography.caption(color: MasariColors.primaryCyan)), const SizedBox(height: 6), Text(description, style: MasariTypography.bodySmall(color: MasariColors.marbleWhite))]))])),
      const SizedBox(height: 24),
      MasariSectionHeader(title: masariText(context, 'الخدمات المتاحة', 'Available services'), subtitle: masariText(context, 'بيانات هذه الصفحة من الكتالوج التشغيلي الموحد.', 'This page is powered by the unified operational catalog.')),
      const SizedBox(height: 16),
      if (services.isEmpty) MasariCard(child: Padding(padding: const EdgeInsets.all(22), child: Center(child: Text(masariText(context, 'لا توجد خدمات منشورة حاليًا.', 'No services are currently published.'))))) else ...services.map((service) => Padding(padding: const EdgeInsets.only(bottom: 14), child: _ServiceCard(service: service, accentColor: accentColor))),
    ]));
  }
}

class _ServiceCard extends ConsumerWidget {
  final PlatformService service;
  final Color accentColor;
  const _ServiceCard({required this.service, required this.accentColor});
  Future<void> _book(BuildContext context, WidgetRef ref) async {
    await ref.read(bookingProvider.notifier).createBooking(serviceId: service.id, serviceName: service.name, category: service.category, price: service.price, currency: service.currency);
    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(masariText(context, 'تم إنشاء طلب الحجز. يمكنك متابعة حالته من حجوزاتي.', 'Booking request created. You can track its status in My Bookings.'))));
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) => MasariCard(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    ClipRRect(borderRadius: BorderRadius.circular(10), child: service.imageUrl.isEmpty ? Container(width: 130, height: 95, color: MasariColors.primaryBlueContainer, child: Icon(Icons.image, color: accentColor)) : Image.network(service.imageUrl, width: 130, height: 95, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 130, height: 95, color: MasariColors.primaryBlueContainer, child: Icon(Icons.broken_image, color: accentColor)))),
    const SizedBox(width: 14),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(service.name, style: MasariTypography.titleMedium()), const SizedBox(height: 6), Text(service.description), const SizedBox(height: 7), Text('${service.price.toStringAsFixed(0)} ${service.currency}', style: MasariTypography.titleMedium(color: accentColor)), if (service.metadata.isNotEmpty) ...[const SizedBox(height: 7), Text(service.metadata.entries.map((e) => '${e.key}: ${e.value}').join(' • '), style: MasariTypography.caption(color: MasariColors.titaniumGray))], const SizedBox(height: 9), Align(alignment: AlignmentDirectional.centerStart, child: ElevatedButton.icon(onPressed: () => _book(context, ref), icon: const Icon(Icons.event_available, size: 17), label: Text(masariText(context, 'احجز الآن', 'Book now')), style: ElevatedButton.styleFrom(backgroundColor: accentColor, foregroundColor: MasariColors.primaryBlueDark))) ])),
  ]));
}

class HotelsView extends ConsumerWidget {
  const HotelsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(operationalCatalogProvider);
    final hotels = catalog.where((s) => s.category == 'فنادق' && s.status == 'نشط').toList();
    return SingleChildScrollView(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MasariLuxuryCard(badgeText: 'HOTELS', child: Row(children: [const Icon(Icons.hotel, color: MasariColors.primaryCyan, size: 42), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(masariText(context, 'الفنادق والمنتجعات', 'Hotels & Resorts'), style: MasariTypography.headlineSmall(color: Colors.white)), const SizedBox(height: 5), Text(masariText(context, 'الفندق والغرف والأسعار والصور المعروضة من الكتالوج الإداري الموحد.', 'Hotels, rooms, prices, and images shown here come from the unified admin catalog.'))]))])),
      const SizedBox(height: 22),
      if (hotels.isEmpty) MasariCard(child: Padding(padding: const EdgeInsets.all(22), child: Text(masariText(context, 'لا توجد فنادق متاحة حاليًا.', 'No hotels are currently available.'))))
      else ...hotels.map((hotel) {
        final rooms = catalog.where((r) => r.category == 'غرف' && r.status == 'نشط' && r.metadata['hotelId'] == hotel.id).toList();
        return Padding(padding: const EdgeInsets.only(bottom: 18), child: MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _ServiceCard(service: hotel, accentColor: MasariColors.primaryCyan), const SizedBox(height: 16),
          MasariSectionHeader(title: '${masariText(context, 'الغرف المتاحة', 'Available rooms')} (${rooms.length})', subtitle: masariText(context, 'الغرف التي يديرها مدير الفندق تظهر هنا تلقائيًا.', 'Rooms managed by the hotel manager appear here automatically.')), const SizedBox(height: 10),
          if (rooms.isEmpty) Text(masariText(context, 'لا توجد غرف منشورة لهذا الفندق بعد.', 'No rooms have been published for this hotel yet.')) else ...rooms.map((room) => Padding(padding: const EdgeInsets.only(bottom: 8), child: _ServiceCard(service: room, accentColor: MasariColors.primaryOrange))),
        ])));
      }),
    ]));
  }
}

class FlightsView extends StatelessWidget { const FlightsView({super.key}); @override Widget build(BuildContext context) => _TravelServiceCatalogView(title: masariText(context, 'حجوزات الطيران', 'Flight Bookings'), routePath: '/flights', description: masariText(context, 'خيارات الطيران ودرجات السفر ضمن منظومة مساري.', 'Flight options and travel classes within the MASARI platform.'), icon: Icons.flight_takeoff, accentColor: MasariColors.primaryCyan, category: 'طيران'); }
class BusView extends StatelessWidget { const BusView({super.key}); @override Widget build(BuildContext context) => _TravelServiceCatalogView(title: masariText(context, 'حافلات النقل الفاخر', 'Luxury Bus Transport'), routePath: '/bus', description: masariText(context, 'حجز النقل بين المدن والمشاعر المقدسة.', 'Transport bookings between cities and the holy sites.'), icon: Icons.directions_bus, accentColor: MasariColors.primaryOrange, category: 'حافلات'); }
class CarsView extends StatelessWidget { const CarsView({super.key}); @override Widget build(BuildContext context) => _TravelServiceCatalogView(title: masariText(context, 'تأجير السيارات الفارهة', 'Luxury Car Rental'), routePath: '/cars', description: masariText(context, 'سيارات فاخرة مع السائق أو القيادة الشخصية.', 'Luxury cars with a private driver or self-drive.'), icon: Icons.directions_car, accentColor: MasariColors.primaryCyanDark, category: 'سيارات'); }
class TransfersView extends StatelessWidget { const TransfersView({super.key}); @override Widget build(BuildContext context) => _TravelServiceCatalogView(title: masariText(context, 'النقل الخاص والتوصيل', 'Private Transfers'), routePath: '/transfers', description: masariText(context, 'الاستقبال والتوصيل من وإلى المطارات والفنادق.', 'Airport and hotel pickup and drop-off services.'), icon: Icons.local_taxi, accentColor: MasariColors.primaryBlue, category: 'نقل خاص'); }
class TourismView extends StatelessWidget { const TourismView({super.key}); @override Widget build(BuildContext context) => _TravelServiceCatalogView(title: masariText(context, 'الباقات والبرامج السياحية', 'Tour Packages & Programs'), routePath: '/tourism', description: masariText(context, 'برامج سياحية متكاملة ورحلات لاستكشاف الوجهات.', 'Complete tourism programs and destination experiences.'), icon: Icons.explore, accentColor: MasariColors.primaryOrangeDark, category: 'سياحة'); }
