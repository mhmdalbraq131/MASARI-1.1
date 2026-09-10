import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/platform_service_persistence.dart';
import '../../domain/entities/platform_service.dart';
import '../../domain/entities/user_session.dart';
import 'app_providers.dart';

/// Single editable catalog used by administration and customer-facing views.
///
/// Unlike the original service provider, this controller can create and delete
/// records and persists every field so both sides render the same catalog.
class OperationalCatalogNotifier extends StateNotifier<List<PlatformService>> {
  final Ref ref;

  OperationalCatalogNotifier(this.ref)
      : super(PlatformServicePersistence.loadCatalog(
          List<PlatformService>.from(ref.read(platformServicesProvider)),
        ));

  Future<void> _persist() async {
    await PlatformServicePersistence.saveCatalog(state);
  }

  void createService({
    required String category,
    required String name,
    required String description,
    required double price,
    required String currency,
    required String status,
    required String imageUrl,
    required Map<String, String> metadata,
    required UserSession adminSession,
  }) {
    final service = PlatformService(
      id: 'srv_${DateTime.now().millisecondsSinceEpoch}',
      category: category,
      name: name,
      description: description,
      price: price,
      currency: currency,
      status: status,
      imageUrl: imageUrl,
      metadata: Map<String, String>.from(metadata),
    );
    state = [...state, service];
    unawaited(_persist());
    _audit(
      adminSession,
      'إنشاء خدمة',
      name,
      'السجل بالكامل',
      'غير موجود',
      '$name (${price.toStringAsFixed(0)} $currency)',
      'قام المستخدم ${adminSession.name} بإنشاء خدمة جديدة: $name',
    );
  }

  void updateService({
    required String serviceId,
    required String category,
    required String name,
    required String description,
    required double price,
    required String currency,
    required String status,
    required String imageUrl,
    required Map<String, String> metadata,
    required UserSession adminSession,
  }) {
    final old = state.where((item) => item.id == serviceId).firstOrNull;
    if (old == null) return;

    final updated = old.copyWith(
      category: category,
      name: name,
      description: description,
      price: price,
      currency: currency,
      status: status,
      imageUrl: imageUrl,
      metadata: Map<String, String>.from(metadata),
    );
    state = [for (final item in state) item.id == serviceId ? updated : item];
    unawaited(_persist());
    _audit(
      adminSession,
      'تعديل خدمة',
      old.name,
      'الاسم والوصف والسعر والصورة والحالة والبيانات الإضافية',
      '${old.name} | ${old.price.toStringAsFixed(0)} ${old.currency}',
      '$name | ${price.toStringAsFixed(0)} $currency',
      'قام المستخدم ${adminSession.name} بتعديل جميع بيانات الخدمة: $name',
    );
  }

  void deleteService({
    required String serviceId,
    required UserSession adminSession,
  }) {
    final old = state.where((item) => item.id == serviceId).firstOrNull;
    if (old == null) return;
    state = state.where((item) => item.id != serviceId).toList();
    unawaited(_persist());
    _audit(
      adminSession,
      'حذف خدمة',
      old.name,
      'السجل بالكامل',
      old.name,
      'محذوف',
      'قام المستخدم ${adminSession.name} بحذف الخدمة: ${old.name}',
    );
  }

  void _audit(
    UserSession session,
    String action,
    String entity,
    String field,
    String previousValue,
    String newValue,
    String summary,
  ) {
    ref.read(auditLogProvider.notifier).addAuditRecord(
          adminName: session.name,
          adminEmail: session.email,
          action: action,
          entity: entity,
          field: field,
          previousValue: previousValue,
          newValue: newValue,
          summary: summary,
        );
  }
}

final operationalCatalogProvider =
    StateNotifierProvider<OperationalCatalogNotifier, List<PlatformService>>((ref) {
  return OperationalCatalogNotifier(ref);
});
