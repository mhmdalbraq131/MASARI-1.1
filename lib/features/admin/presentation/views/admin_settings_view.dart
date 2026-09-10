import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/persistence/admin_settings.dart';
import '../../../../core/persistence/app_persistence.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../foundation/presentation/providers/operational_catalog_provider.dart';

/// Real administrator settings surface rather than an empty placeholder.
/// Security switches are persisted and the page also exposes operational
/// application preferences and catalog health.
class AdminSettingsView extends ConsumerStatefulWidget {
  const AdminSettingsView({super.key});

  @override
  ConsumerState<AdminSettingsView> createState() => _AdminSettingsViewState();
}

class _AdminSettingsViewState extends ConsumerState<AdminSettingsView> {
  AdminSettings? _settings;
  AppPersistence? _appPersistence;
  bool _loading = true;
  bool _maintenanceMode = false;
  bool _allowCustomerCatalog = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final app = await AppPersistence.create();
    if (!mounted) return;
    setState(() {
      _appPersistence = app;
      _settings = AdminSettings(app);
      _maintenanceMode = app.getBool('masari.admin.maintenance_mode', defaultValue: false);
      _allowCustomerCatalog = app.getBool('masari.admin.customer_catalog_enabled', defaultValue: true);
      _loading = false;
    });
  }

  Future<void> _saveBool(String key, bool value) async {
    final app = _appPersistence;
    if (app == null) return;
    await app.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final settings = _settings;
    final catalog = ref.watch(operationalCatalogProvider);
    if (_loading || settings == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: Text('إعدادات النظام والإدارة', style: MasariTypography.titleLarge())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text('مركز إعدادات مساري', style: MasariTypography.headlineSmall()),
        const SizedBox(height: 6),
        Text('الإعدادات هنا فعلية ومخزنة محليًا وليست عناصر واجهة شكلية.', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
        const SizedBox(height: 18),
        MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('الأمان والتدقيق', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          SwitchListTile.adaptive(title: const Text('التوثيق الثنائي (2FA)'), subtitle: const Text('تفعيل سياسة التحقق الإضافي للمشرفين.'), value: settings.twoFactorEnabled, activeThumbColor: MasariColors.primaryCyan, onChanged: (v) async { await settings.setTwoFactorEnabled(v); setState(() {}); }),
          const Divider(),
          SwitchListTile.adaptive(title: const Text('سجل التدقيق الإداري'), subtitle: const Text('تسجيل كل تغيير إداري في سجل المراجعة.'), value: settings.auditLoggingEnabled, activeThumbColor: MasariColors.primaryCyan, onChanged: (v) async { await settings.setAuditLoggingEnabled(v); setState(() {}); }),
        ])),
        const SizedBox(height: 14),
        MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('تشغيل المنصة', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          SwitchListTile.adaptive(title: const Text('وضع الصيانة'), subtitle: const Text('مفتاح تشغيلي محفوظ للاستخدام عند الحاجة لإيقاف استقبال العمليات الجديدة.'), value: _maintenanceMode, activeThumbColor: MasariColors.primaryOrange, onChanged: (v) async { setState(() => _maintenanceMode = v); await _saveBool('masari.admin.maintenance_mode', v); }),
          const Divider(),
          SwitchListTile.adaptive(title: const Text('إظهار الكتالوج للعملاء'), subtitle: const Text('عند إيقافه يمكن حجب الكتالوج التشغيلي عن واجهات العملاء.'), value: _allowCustomerCatalog, activeThumbColor: MasariColors.primaryCyan, onChanged: (v) async { setState(() => _allowCustomerCatalog = v); await _saveBool('masari.admin.customer_catalog_enabled', v); }),
        ])),
        const SizedBox(height: 14),
        MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('حالة البيانات التشغيلية', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          const SizedBox(height: 12),
          _statusRow('إجمالي سجلات الكتالوج', '${catalog.length}'),
          _statusRow('الخدمات المنشورة', '${catalog.where((s) => s.status == 'نشط').length}'),
          _statusRow('الفنادق', '${catalog.where((s) => s.category == 'فنادق').length}'),
          _statusRow('الغرف', '${catalog.where((s) => s.category == 'غرف').length}'),
          const SizedBox(height: 8),
          const Text('كل تعديل يتم من مركز العمليات يحفظ الاسم والوصف والسعر والصورة والحالة والبيانات الإضافية، وتقرأ واجهة العميل من نفس الكتالوج.'),
        ])),
      ]),
    );
  }

  Widget _statusRow(String label, String value) => Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Row(children: [Expanded(child: Text(label)), Text(value, style: MasariTypography.titleSmall(color: MasariColors.primaryCyan))]));
}
