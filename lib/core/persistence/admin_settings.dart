import 'app_persistence.dart';

/// Persistent operational settings controlled by MASARI administrators.
class AdminSettings {
  AdminSettings(this._persistence);

  final AppPersistence _persistence;

  static const _twoFactorKey = 'masari.admin.2fa';
  static const _auditLoggingKey = 'masari.admin.audit_logging';

  bool get twoFactorEnabled => _persistence.getBool(_twoFactorKey, defaultValue: true);
  bool get auditLoggingEnabled => _persistence.getBool(_auditLoggingKey, defaultValue: true);

  Future<bool> setTwoFactorEnabled(bool value) =>
      _persistence.setBool(_twoFactorKey, value);

  Future<bool> setAuditLoggingEnabled(bool value) =>
      _persistence.setBool(_auditLoggingKey, value);
}
