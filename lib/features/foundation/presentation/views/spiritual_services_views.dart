import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../bookings/presentation/booking_provider.dart';
import '../../domain/entities/platform_service.dart';
import '../providers/operational_catalog_provider.dart';

class _SpiritualCatalogView extends ConsumerWidget {
  final String title, description, category;
  final IconData icon;
  const _SpiritualCatalogView({required this.title, required this.description, required this.category, required this.icon});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(operationalCatalogProvider).where((s) => s.category == category && s.status == 'نشط').toList();
    return SingleChildScrollView(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MasariLuxuryCard(badgeText: category, child: Row(children: [Container(padding: const EdgeInsets.all(16), decoration: const BoxDecoration(color: MasariColors.primaryCyan, shape: BoxShape.circle), child: Icon(icon, color: MasariColors.primaryBlueDark, size: 36)), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: MasariTypography.headlineSmall(color: Colors.white)), const SizedBox(height: 6), Text(description, style: MasariTypography.bodySmall(color: MasariColors.marbleWhite))]))])),
      const SizedBox(height: 22),
      Text('الباقات والخدمات المتاحة', style: MasariTypography.titleLarge()), const SizedBox(height: 12),
      if (items.isEmpty) const MasariCard(child: Padding(padding: EdgeInsets.all(22), child: Text('لا توجد باقات أو خدمات منشورة حاليًا. يمكن للمدير إضافتها من مركز العمليات.')))
      else ...items.map((service) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _ItemCard(service: service))),
    ]));
  }
}

class _ItemCard extends ConsumerWidget {
  final PlatformService service;
  const _ItemCard({required this.service});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MasariCard(child: ListTile(
    leading: CircleAvatar(backgroundColor: MasariColors.primaryCyan.withValues(alpha: .15), child: const Icon(Icons.workspace_premium, color: MasariColors.primaryCyan)),
    title: Text(service.name, style: MasariTypography.titleMedium()), subtitle: Text(service.description),
    trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('${service.price.toStringAsFixed(0)} ${service.currency}', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)), TextButton(onPressed: () async { await ref.read(bookingProvider.notifier).createBooking(serviceId: service.id, serviceName: service.name, category: service.category, price: service.price, currency: service.currency); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنشاء طلب الحجز.'))); }, child: const Text('احجز'))]),
  ));
}

class HajjView extends StatelessWidget { const HajjView({super.key}); @override Widget build(BuildContext context) => const _SpiritualCatalogView(title: 'باقات ومجموعات الحج', description: 'باقات الحج والمخيمات والتنقلات التي يديرها فريق مساري.', category: 'حج', icon: Icons.mosque); }
class UmrahView extends StatelessWidget { const UmrahView({super.key}); @override Widget build(BuildContext context) => const _SpiritualCatalogView(title: 'برامج العمرة المخصصة', description: 'باقات العمرة الشاملة للتصاريح والطيران والفنادق والإرشاد.', category: 'عمرة', icon: Icons.night_shelter); }
class VisaView extends StatelessWidget { const VisaView({super.key}); @override Widget build(BuildContext context) => const _SpiritualCatalogView(title: 'تأشيرات السفر والسياحة والعمرة', description: 'خدمات التأشيرات التي ينشرها مديرو العمليات ويحدثون بياناتها.', category: 'فيزا', icon: Icons.badge); }
