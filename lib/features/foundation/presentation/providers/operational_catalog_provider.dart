import 'dart:async';
import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/platform_service_persistence.dart';
import '../../domain/entities/platform_service.dart';
import '../../domain/entities/user_session.dart';
import 'app_providers.dart';

List<PlatformService> _completeOperationalDefaults(List<PlatformService> base) {
  return [
    ...base,
    const PlatformService(
      id: 'srv_transfer_01',
      category: 'نقل خاص',
      name: 'استقبال وتوصيل VIP من المطار',
      description: 'سيارة فاخرة مع سائق خاص للاستقبال والتوصيل بين المطار والفندق.',
      price: 300,
      currency: 'SAR',
      status: 'نشط',
      imageUrl: 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=500',
      metadata: {'الخدمة': 'استقبال وتوصيل', 'السيارة': 'VIP'},
    ),
    const PlatformService(
      id: 'srv_tourism_01',
      category: 'سياحة',
      name: 'باقة جدة الفاخرة',
      description: 'برنامج سياحي خاص لاكتشاف جدة التاريخية والواجهة البحرية مع مرشد.',
      price: 950,
      currency: 'SAR',
      status: 'نشط',
      imageUrl: 'https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e?w=500',
      metadata: {'المدة': '3 أيام', 'النوع': 'خاص'},
    ),
    const PlatformService(
      id: 'srv_visa_01',
      category: 'فيزا',
      name: 'خدمة إصدار التأشيرة السياحية',
      description: 'مساعدة متكاملة في تجهيز طلب التأشيرة السياحية ومتابعة الطلب.',
      price: 450,
      currency: 'SAR',
      status: 'نشط',
      imageUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=500',
      metadata: {'المعالجة': 'متابعة الطلب', 'النوع': 'سياحية'},
    ),
  ];
}

class OperationalCatalogNotifier extends StateNotifier<List<PlatformService>> {
  final Ref ref;

  OperationalCatalogNotifier(this.ref)
      : super(
          PlatformServicePersistence.loadCatalog(
            _completeOperationalDefaults(List<PlatformService>.from(ref.read(platformServicesProvider))),
          ),
        );

  Future<void> _persist() async => PlatformServicePersistence.saveCatalog(state);

  void createService({required String category, required String name, required String description, required double price, required String currency, required String status, required String imageUrl, required Map<String, String> metadata, required UserSession adminSession}) {
    final service = PlatformService(id: 'srv_${DateTime.now().millisecondsSinceEpoch}', category: category, name: name, description: description, price: price, currency: currency, status: status, imageUrl: imageUrl, metadata: Map<String, String>.from(metadata));
    state = [...state, service];
    unawaited(_persist());
    _audit(adminSession, 'إنشاء خدمة', name, 'السجل بالكامل', 'غير موجود', '$name (${price.toStringAsFixed(0)} $currency)', 'قام المستخدم ${adminSession.name} بإنشاء خدمة جديدة: $name');
  }

  void updateService({required String serviceId, required String category, required String name, required String description, required double price, required String currency, required String status, required String imageUrl, required Map<String, String> metadata, required UserSession adminSession}) {
    final old = state.where((item) => item.id == serviceId).firstOrNull;
    if (old == null) return;
    final updated = old.copyWith(category: category, name: name, description: description, price: price, currency: currency, status: status, imageUrl: imageUrl, metadata: Map<String, String>.from(metadata));
    state = [for (final item in state) item.id == serviceId ? updated : item];
    unawaited(_persist());
    _audit(adminSession, 'تعديل خدمة', old.name, 'الاسم والوصف والسعر والصورة والحالة والبيانات الإضافية', '${old.name} | ${old.price.toStringAsFixed(0)} ${old.currency}', '$name | ${price.toStringAsFixed(0)} $currency', 'قام المستخدم ${adminSession.name} بتعديل جميع بيانات الخدمة: $name');
  }

  void deleteService({required String serviceId, required UserSession adminSession}) {
    final old = state.where((item) => item.id == serviceId).firstOrNull;
    if (old == null) return;
    state = state.where((item) => item.id != serviceId).toList();
    unawaited(_persist());
    _audit(adminSession, 'حذف خدمة', old.name, 'السجل بالكامل', old.name, 'محذوف', 'قام المستخدم ${adminSession.name} بحذف الخدمة: ${old.name}');
  }

  void _audit(UserSession session, String action, String entity, String field, String previousValue, String newValue, String summary) {
    ref.read(auditLogProvider.notifier).addAuditRecord(adminName: session.name, adminEmail: session.email, action: action, entity: entity, field: field, previousValue: previousValue, newValue: newValue, summary: summary);
  }
}

final operationalCatalogProvider = StateNotifierProvider<OperationalCatalogNotifier, List<PlatformService>>((ref) => OperationalCatalogNotifier(ref));
