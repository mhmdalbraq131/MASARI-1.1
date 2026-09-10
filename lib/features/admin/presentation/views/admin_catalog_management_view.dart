import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../foundation/domain/entities/platform_service.dart';
import '../../../foundation/presentation/providers/operational_catalog_provider.dart';
import '../../../foundation/presentation/providers/app_providers.dart';

/// Full operational catalog manager shared with customer-facing catalog pages.
/// Supports create/edit/delete and all editable fields, not price-only edits.
class AdminCatalogManagementView extends ConsumerStatefulWidget {
  const AdminCatalogManagementView({super.key});

  @override
  ConsumerState<AdminCatalogManagementView> createState() => _AdminCatalogManagementViewState();
}

class _AdminCatalogManagementViewState extends ConsumerState<AdminCatalogManagementView> {
  String _category = 'الكل';
  final _categories = const ['الكل', 'طيران', 'فنادق', 'غرف', 'حافلات', 'سيارات', 'سياحة', 'فيزا', 'حج', 'عمرة'];

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(operationalCatalogProvider);
    final filtered = _category == 'الكل' ? services : services.where((s) => s.category == _category).toList();
    final admin = ref.watch(userSessionProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('كتالوج الخدمات والمنتجات', style: MasariTypography.titleLarge()),
                const SizedBox(height: 4),
                Text('إضافة وتعديل وحذف الخدمات. أي تغيير محفوظ ويظهر مباشرة في واجهة المستخدم.', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
              ]),
            ),
            ElevatedButton.icon(
              onPressed: () => _openEditor(context, admin),
              icon: const Icon(Icons.add),
              label: const Text('إضافة خدمة / منتج'),
              style: ElevatedButton.styleFrom(backgroundColor: MasariColors.primaryOrange, foregroundColor: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories.map((category) => ChoiceChip(
            label: Text(category),
            selected: _category == category,
            onSelected: (_) => setState(() => _category = category),
            selectedColor: MasariColors.primaryCyan,
          )).toList(),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('لا توجد سجلات في هذا القطاع.'))
              : ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) => _buildCard(filtered[index], admin),
                ),
        ),
      ],
    );
  }

  Widget _buildCard(PlatformService service, dynamic admin) {
    final isHotel = service.category == 'فنادق';
    return MasariCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: service.imageUrl.isEmpty
                ? Container(width: 110, height: 90, color: MasariColors.primaryBlueContainer, child: const Icon(Icons.image, color: MasariColors.primaryCyan))
                : Image.network(service.imageUrl, width: 110, height: 90, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 110, height: 90, color: MasariColors.primaryBlueContainer, child: const Icon(Icons.broken_image))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(spacing: 8, runSpacing: 5, children: [
                Text(service.name, style: MasariTypography.titleMedium()),
                Chip(label: Text(service.category), visualDensity: VisualDensity.compact),
                Chip(label: Text(service.status), visualDensity: VisualDensity.compact),
              ]),
              const SizedBox(height: 4),
              Text(service.description, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 6),
              Text('${service.price.toStringAsFixed(0)} ${service.currency}', style: MasariTypography.titleSmall(color: MasariColors.primaryCyan)),
              if (service.metadata.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(service.metadata.entries.map((e) => '${e.key}: ${e.value}').join(' • '), maxLines: 2, overflow: TextOverflow.ellipsis, style: MasariTypography.caption(color: MasariColors.titaniumGray)),
              ],
            ]),
          ),
          const SizedBox(width: 12),
          Column(children: [
            OutlinedButton.icon(onPressed: () => _openEditor(context, admin, service: service), icon: const Icon(Icons.edit, size: 16), label: const Text('تعديل')),
            if (isHotel) ...[
              const SizedBox(height: 6),
              OutlinedButton.icon(onPressed: () => _openRooms(context, admin, service), icon: const Icon(Icons.bed, size: 16), label: const Text('الغرف')),
            ],
            const SizedBox(height: 6),
            TextButton.icon(
              onPressed: () => _confirmDelete(service, admin),
              icon: const Icon(Icons.delete_outline, size: 16, color: MasariColors.error),
              label: const Text('حذف', style: TextStyle(color: MasariColors.error)),
            ),
          ]),
        ],
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, dynamic admin, {PlatformService? service}) async {
    final name = TextEditingController(text: service?.name ?? '');
    final description = TextEditingController(text: service?.description ?? '');
    final price = TextEditingController(text: service?.price.toStringAsFixed(0) ?? '');
    final image = TextEditingController(text: service?.imageUrl ?? '');
    final currency = TextEditingController(text: service?.currency ?? 'SAR');
    String category = service?.category ?? 'طيران';
    String status = service?.status ?? 'نشط';
    final metadata = <String, TextEditingController>{
      for (final entry in (service?.metadata ?? {}).entries) entry.key: TextEditingController(text: entry.value),
    };
    if (metadata.isEmpty) metadata['معلومة'] = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: MasariColors.primaryBlueDark,
          title: Text(service == null ? 'إضافة خدمة أو منتج' : 'تعديل جميع بيانات الخدمة'),
          content: SizedBox(
            width: 650,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                DropdownButtonFormField<String>(value: category, decoration: const InputDecoration(labelText: 'القسم'), items: _categories.where((x) => x != 'الكل' && x != 'غرف').map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(), onChanged: (v) => setDialogState(() => category = v ?? category)),
                TextField(controller: name, decoration: const InputDecoration(labelText: 'اسم الخدمة / الفندق')),
                TextField(controller: description, maxLines: 3, decoration: const InputDecoration(labelText: 'الوصف')),
                Row(children: [Expanded(child: TextField(controller: price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'السعر'))), const SizedBox(width: 10), Expanded(child: TextField(controller: currency, decoration: const InputDecoration(labelText: 'العملة')))]),
                TextField(controller: image, decoration: const InputDecoration(labelText: 'رابط الصورة')),
                DropdownButtonFormField<String>(value: status, decoration: const InputDecoration(labelText: 'الحالة'), items: const [DropdownMenuItem(value: 'نشط', child: Text('نشط')), DropdownMenuItem(value: 'معطل', child: Text('معطل'))], onChanged: (v) => setDialogState(() => status = v ?? status)),
                const SizedBox(height: 12),
                Row(children: [Text('بيانات إضافية', style: MasariTypography.titleSmall(color: MasariColors.primaryCyan)), const Spacer(), IconButton(onPressed: () => setDialogState(() => metadata['معلومة_${metadata.length + 1}'] = TextEditingController()), icon: const Icon(Icons.add))]),
                ...metadata.entries.map((entry) => Row(children: [Expanded(child: TextField(controller: TextEditingController(text: entry.key), decoration: const InputDecoration(labelText: 'الحقل'), onChanged: (v) { final value = metadata.remove(entry.key); if (value != null) metadata[v] = value; })), const SizedBox(width: 8), Expanded(child: TextField(controller: entry.value, decoration: const InputDecoration(labelText: 'القيمة'))), IconButton(onPressed: () => setDialogState(() => metadata.remove(entry.key)), icon: const Icon(Icons.remove_circle_outline))])),
              ]),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')),
            ElevatedButton(
              onPressed: () {
                final parsedPrice = double.tryParse(price.text.trim());
                if (name.text.trim().isEmpty || parsedPrice == null || parsedPrice < 0) return;
                final data = <String, String>{for (final e in metadata.entries) if (e.key.trim().isNotEmpty) e.key.trim(): e.value.text.trim()};
                final notifier = ref.read(operationalCatalogProvider.notifier);
                if (service == null) {
                  notifier.createService(category: category, name: name.text.trim(), description: description.text.trim(), price: parsedPrice, currency: currency.text.trim().isEmpty ? 'SAR' : currency.text.trim(), status: status, imageUrl: image.text.trim(), metadata: data, adminSession: admin);
                } else {
                  notifier.updateService(serviceId: service.id, category: category, name: name.text.trim(), description: description.text.trim(), price: parsedPrice, currency: currency.text.trim().isEmpty ? 'SAR' : currency.text.trim(), status: status, imageUrl: image.text.trim(), metadata: data, adminSession: admin);
                }
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(backgroundColor: MasariColors.primaryCyan, foregroundColor: MasariColors.primaryBlueDark),
              child: const Text('حفظ كل التعديلات'),
            ),
          ],
        ),
      ),
    );
    for (final controller in [name, description, price, image, currency, ...metadata.values]) controller.dispose();
  }

  Future<void> _openRooms(BuildContext context, dynamic admin, PlatformService hotel) async {
    final rooms = ref.read(operationalCatalogProvider).where((s) => s.category == 'غرف' && s.metadata['hotelId'] == hotel.id).toList();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: MasariColors.primaryBlueDark,
        title: Text('غرف ${hotel.name}'),
        content: SizedBox(
          width: 700,
          height: 430,
          child: Column(children: [
            Align(alignment: Alignment.centerLeft, child: ElevatedButton.icon(onPressed: () async { Navigator.pop(dialogContext); await _openRoomEditor(context, admin, hotel); }, icon: const Icon(Icons.add), label: const Text('إضافة غرفة'))),
            const SizedBox(height: 10),
            Expanded(child: rooms.isEmpty ? const Center(child: Text('لم تتم إضافة غرف لهذا الفندق بعد.')) : ListView.builder(itemCount: rooms.length, itemBuilder: (_, index) { final room = rooms[index]; return ListTile(leading: const Icon(Icons.bed), title: Text(room.name), subtitle: Text('${room.price.toStringAsFixed(0)} ${room.currency}'), trailing: Wrap(children: [IconButton(onPressed: () async { Navigator.pop(dialogContext); await _openRoomEditor(context, admin, hotel, room: room); }, icon: const Icon(Icons.edit)), IconButton(onPressed: () { ref.read(operationalCatalogProvider.notifier).deleteService(serviceId: room.id, adminSession: admin); Navigator.pop(dialogContext); }, icon: const Icon(Icons.delete_outline, color: MasariColors.error))])); })),
          ]),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إغلاق'))],
      ),
    );
  }

  Future<void> _openRoomEditor(BuildContext context, dynamic admin, PlatformService hotel, {PlatformService? room}) async {
    final name = TextEditingController(text: room?.name ?? '');
    final description = TextEditingController(text: room?.description ?? '');
    final price = TextEditingController(text: room?.price.toStringAsFixed(0) ?? '');
    final image = TextEditingController(text: room?.imageUrl ?? '');
    final data = <String, String>{...(room?.metadata ?? {}), 'hotelId': hotel.id};
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: MasariColors.primaryBlueDark,
        title: Text(room == null ? 'إضافة غرفة' : 'تعديل بيانات الغرفة'),
        content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: name, decoration: const InputDecoration(labelText: 'اسم / نوع الغرفة')), TextField(controller: description, maxLines: 3, decoration: const InputDecoration(labelText: 'الوصف')), TextField(controller: price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'السعر')), TextField(controller: image, decoration: const InputDecoration(labelText: 'رابط صورة الغرفة')), TextField(decoration: const InputDecoration(labelText: 'السعة'), onChanged: (v) => data['السعة'] = v), TextField(decoration: const InputDecoration(labelText: 'الإطلالة'), onChanged: (v) => data['الإطلالة'] = v)])),
        actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')), ElevatedButton(onPressed: () { final p = double.tryParse(price.text.trim()); if (name.text.trim().isEmpty || p == null || p < 0) return; final notifier = ref.read(operationalCatalogProvider.notifier); if (room == null) { notifier.createService(category: 'غرف', name: name.text.trim(), description: description.text.trim(), price: p, currency: 'SAR', status: 'نشط', imageUrl: image.text.trim(), metadata: data, adminSession: admin); } else { notifier.updateService(serviceId: room.id, category: 'غرف', name: name.text.trim(), description: description.text.trim(), price: p, currency: room.currency, status: room.status, imageUrl: image.text.trim(), metadata: data, adminSession: admin); } Navigator.pop(dialogContext); }, style: ElevatedButton.styleFrom(backgroundColor: MasariColors.primaryCyan, foregroundColor: MasariColors.primaryBlueDark), child: const Text('حفظ الغرفة'))],
      ),
    );
    name.dispose(); description.dispose(); price.dispose(); image.dispose();
  }

  Future<void> _confirmDelete(PlatformService service, dynamic admin) async {
    final yes = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(title: const Text('تأكيد الحذف'), content: Text('سيتم حذف «${service.name}» من الكتالوج. هل أنت متأكد؟'), actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')), ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('حذف'))])) ?? false;
    if (yes) ref.read(operationalCatalogProvider.notifier).deleteService(serviceId: service.id, adminSession: admin);
  }
}
