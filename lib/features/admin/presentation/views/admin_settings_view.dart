import 'package:flutter/material.dart';

import '../../../../core/persistence/admin_settings.dart';
import '../../../../core/persistence/app_persistence.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';

/// Persistent administrator security settings.
class AdminSettingsView extends StatefulWidget {
  const AdminSettingsView({super.key});

  @override
  State<AdminSettingsView> createState() => _AdminSettingsViewState();
}

class _AdminSettingsViewState extends State<AdminSettingsView> {
  AdminSettings? _settings;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final persistence = await AppPersistence.create();
    if (!mounted) return;
    setState(() {
      _settings = AdminSettings(persistence);
      _loading = false;
    });
  }

  Future<void> _setTwoFactor(bool value) async {
    final settings = _settings;
    if (settings == null) return;
    await settings.setTwoFactorEnabled(value);
    if (mounted) setState(() {});
  }

  Future<void> _setAuditLogging(bool value) async {
    final settings = _settings;
    if (settings == null) return;
    await settings.setAuditLoggingEnabled(value);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final settings = _settings;

    return Scaffold(
      appBar: AppBar(
        title: Text('إعدادات النظام والأمان', style: MasariTypography.titleLarge()),
      ),
      body: _loading || settings == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text('سياسات أمان المشرفين', style: MasariTypography.headlineSmall()),
                const SizedBox(height: 8),
                Text(
                  'تُحفظ هذه الإعدادات محليًا وتبقى فعالة بعد إعادة تشغيل التطبيق.',
                  style: MasariTypography.bodySmall(color: MasariColors.titaniumGray),
                ),
                const SizedBox(height: 20),
                MasariCard(
                  child: Column(
                    children: [
                      SwitchListTile.adaptive(
                        title: const Text('التوثيق الثنائي (2FA)'),
                        subtitle: const Text('إلزام المشرفين بخطوة تحقق إضافية عند تسجيل الدخول.'),
                        value: settings.twoFactorEnabled,
                        activeThumbColor: MasariColors.primaryCyan,
                        onChanged: _setTwoFactor,
                      ),
                      const Divider(),
                      SwitchListTile.adaptive(
                        title: const Text('سجل التدقيق الإداري'),
                        subtitle: const Text('تسجيل الإجراءات الإدارية تلقائيًا للمراجعة والمساءلة.'),
                        value: settings.auditLoggingEnabled,
                        activeThumbColor: MasariColors.primaryCyan,
                        onChanged: _setAuditLogging,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
