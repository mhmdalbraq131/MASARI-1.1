import 'package:flutter/foundation.dart';

/// Immutable Audit Record Domain Entity for MASARI Governance & Audit System
@immutable
class AuditRecord {
  final String id;
  final String actorId;
  final String actorName;
  final String action; // e.g. "تعديل سعر", "إنشاء مستخدم", "تغيير صلاحية", "تحديث حالة الخدمة"
  final String entity; // e.g. "خدمة العمرة الملكية", "مستخدم جديد", "فندق برج الساعة"
  final String? field; // e.g. "السعر", "الدور", "الحالة"
  final String? previousValue; // e.g. "550 SAR", "User"
  final String? newValue; // e.g. "500 SAR", "Admin"
  final DateTime timestamp;

  const AuditRecord({
    required this.id,
    required this.actorId,
    required this.actorName,
    required this.action,
    required this.entity,
    this.field,
    this.previousValue,
    this.newValue,
    required this.timestamp,
  });

  /// Generates the human-readable Audit Log sentence according to MASARI compliance specs
  String get formattedMessage {
    if (field != null && previousValue != null && newValue != null) {
      return 'قام المستخدم $actorName بـ $action $entity ($field) من $previousValue إلى $newValue';
    } else if (field != null && newValue != null) {
      return 'قام المستخدم $actorName بـ $action $entity ($field: $newValue)';
    } else {
      return 'قام المستخدم $actorName بـ $action $entity';
    }
  }

  String get formattedDate {
    return '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}';
  }

  String get formattedTime {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
  }
}
