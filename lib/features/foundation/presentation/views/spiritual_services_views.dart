import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/masari_localization.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../bookings/presentation/booking_provider.dart';
import '../../domain/entities/platform_service.dart';
import '../providers/operational_catalog_provider.dart';

class _SpiritualCatalogView extends ConsumerWidget {
  final String title;
  final String description;
  final String category;
  final IconData icon;
  const _SpiritualCatalogView({required this.title, required this.description, required this.category, required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(operationalCatalogProvider).where((s) => s.category == category && s.status == 'نشط').toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MasariLuxuryCard(
          badgeText: category,
          child: Row(children: [
            Container(padding: const EdgeInsets.all(16), decoration: const BoxDecoration(color: MasariColors.primaryCyan, shape: BoxShape.circle), child: Icon(icon, color: MasariColors.primaryBlueDark, size: 36)),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: MasariTypography.headlineSmall(color: Colors.white)),
              const SizedBox(height: 6),
              Text(description, style: MasariTypography.bodySmall(color: MasariColors.marbleWhite)),
            ])),
          ]),
        ),
        const SizedBox(height: 22),
        Text(masariText(context, 'الباقات والخدمات المتاحة', 'Available packages & services'), style: MasariTypography.titleLarge()),
        const SizedBox(height: 12),
        if (items.isEmpty)
          MasariCard(child: Padding(padding: const EdgeInsets.all(22), child: Text(masariText(context, 'لا توجد باقات أو خدمات منشورة حاليًا. يمكن للمدير إضافتها من مركز العمليات.', 'No packages or services are currently published. An administrator can add them from the Operations Center.'))))
        else
          ...items.map((service) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _ItemCard(service: service))),
      ]),
    );
  }
}

class _ItemCard extends ConsumerWidget {
  final PlatformService service;
  const _ItemCard({required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MasariCard(child: ListTile(
      leading: CircleAvatar(backgroundColor: MasariColors.primaryCyan.withValues(alpha: .15), child: const Icon(Icons.workspace_premium, color: MasariColors.primaryCyan)),
      title: Text(service.name, style: MasariTypography.titleMedium()),
      subtitle: Text(service.description),
      trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('${service.price.toStringAsFixed(0)} ${service.currency}', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
        TextButton(
          onPressed: () async {
            await ref.read(bookingProvider.notifier).createBooking(serviceId: service.id, serviceName: service.name, category: service.category, price: service.price, currency: service.currency);
            if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(masariText(context, 'تم إنشاء طلب الحجز.', 'Booking request created.'))));
          },
          child: Text(masariText(context, 'احجز', 'Book')),
        ),
      ]),
    ));
  }
}

class HajjView extends StatelessWidget {
  const HajjView({super.key});
  @override
  Widget build(BuildContext context) => _SpiritualCatalogView(title: masariText(context, 'باقات ومجموعات الحج', 'Hajj Packages & Groups'), description: masariText(context, 'باقات الحج والمخيمات والتنقلات التي يديرها فريق مساري.', 'Hajj packages, camps, and transport managed by the MASARI team.'), category: 'حج', icon: Icons.mosque);
}

class UmrahView extends StatelessWidget {
  const UmrahView({super.key});
  @override
  Widget build(BuildContext context) => _SpiritualCatalogView(title: masariText(context, 'برامج العمرة المخصصة', 'Personalized Umrah Programs'), description: masariText(context, 'باقات العمرة الشاملة للتصاريح والطيران والفنادق والإرشاد.', 'Complete Umrah packages covering permits, flights, hotels, and guidance.'), category: 'عمرة', icon: Icons.night_shelter);
}

class VisaView extends StatelessWidget {
  const VisaView({super.key});
  @override
  Widget build(BuildContext context) => _SpiritualCatalogView(title: masariText(context, 'تأشيرات السفر والسياحة والعمرة', 'Travel, Tourism & Umrah Visas'), description: masariText(context, 'خدمات التأشيرات التي ينشرها مديرو العمليات ويحدثون بياناتها.', 'Visa services published and maintained by operations managers.'), category: 'فيزا', icon: Icons.badge);
}
