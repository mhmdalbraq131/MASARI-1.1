import 'package:flutter/foundation.dart';

/// Immutable Audit Log Record for MASARI Administrative Activity
@immutable
class AuditRecord {
  final String id;
  final String adminName;
  final String adminEmail;
  final String action; // e.g., 'تعديل سعر', 'إنشاء مستخدم', 'تغيير حالة'
  final String entity; // e.g., 'خدمة العمرة', 'إدارة المستخدمين'
  final String field; // e.g., 'السعر', 'الصلاحية', 'الحالة'
  final String previousValue;
  final String newValue;
  final DateTime timestamp;
  final String summary;

  const AuditRecord({
    required this.id,
    required this.adminName,
    required this.adminEmail,
    required this.action,
    required this.entity,
    required this.field,
    required this.previousValue,
    required this.newValue,
    required this.timestamp,
    required this.summary,
  });
}
