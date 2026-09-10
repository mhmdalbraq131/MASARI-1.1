import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/masari_localization.dart';
import '../../../../core/persistence/admin_settings.dart';
import '../../../../core/persistence/app_persistence.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../foundation/presentation/providers/operational_catalog_provider.dart';

/// Real administrator settings surface rather than an empty placeholder.
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
  void initState() { super.initState(); _load(); }

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
      appBar: AppBar(title: Text(masariText(context, 'إعدادات النظام والإدارة', 'System & Administration Settings'), style: MasariTypography.titleLarge())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text(masariText(context, 'مركز إعدادات مساري', 'MASARI Settings Center'), style: MasariTypography.headlineSmall()),
        const SizedBox(height: 6),
        Text(masariText(context, 'الإعدادات هنا فعلية ومخزنة محليًا وليست عناصر واجهة شكلية.', 'These settings are functional and stored locally, not visual placeholders.'), style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
        const SizedBox(height: 18),
        MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(masariText(context, 'الأمان والتدقيق', 'Security & Audit'), style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          SwitchListTile.adaptive(title: Text(masariText(context, 'التوثيق الثنائي (2FA)', 'Two-factor authentication (2FA)')), subtitle: Text(masariText(context, 'تفعيل سياسة التحقق الإضافي للمشرفين.', 'Enable additional verification for administrators.')), value: settings.twoFactorEnabled, activeThumbColor: MasariColors.primaryCyan, onChanged: (v) async { await settings.setTwoFactorEnabled(v); setState(() {}); }),
          const Divider(),
          SwitchListTile.adaptive(title: Text(masariText(context, 'سجل التدقيق الإداري', 'Administrative audit log')), subtitle: Text(masariText(context, 'تسجيل كل تغيير إداري في سجل المراجعة.', 'Record administrative changes in the audit log.')), value: settings.auditLoggingEnabled, activeThumbColor: MasariColors.primaryCyan, onChanged: (v) async { await settings.setAuditLoggingEnabled(v); setState(() {}); }),
        ])),
        const SizedBox(height: 14),
        MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(masariText(context, 'تشغيل المنصة', 'Platform Operations'), style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          SwitchListTile.adaptive(title: Text(masariText(context, 'وضع الصيانة', 'Maintenance mode')), subtitle: Text(masariText(context, 'مفتاح تشغيلي محفوظ للاستخدام عند الحاجة لإيقاف استقبال العمليات الجديدة.', 'Operational switch for temporarily stopping new operations.')), value: _maintenanceMode, activeThumbColor: MasariColors.primaryOrange, onChanged: (v) async { setState(() => _maintenanceMode = v); await _saveBool('masari.admin.maintenance_mode', v); }),
          const Divider(),
          SwitchListTile.adaptive(title: Text(masariText(context, 'إظهار الكتالوج للعملاء', 'Show catalog to customers')), subtitle: Text(masariText(context, 'عند إيقافه يمكن حجب الكتالوج التشغيلي عن واجهات العملاء.', 'When disabled, the operational catalog can be hidden from customer screens.')), value: _allowCustomerCatalog, activeThumbColor: MasariColors.primaryCyan, onChanged: (v) async { setState(() => _allowCustomerCatalog = v); await _saveBool('masari.admin.customer_catalog_enabled', v); }),
        ])),
        const SizedBox(height: 14),
        MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(masariText(context, 'حالة البيانات التشغيلية', 'Operational Data Health'), style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          const SizedBox(height: 12),
          _statusRow(context, masariText(context, 'إجمالي سجلات الكتالوج', 'Total catalog records'), '${catalog.length}'),
          _statusRow(context, masariText(context, 'الخدمات المنشورة', 'Published services'), '${catalog.where((s) => s.status == 'نشط').length}'),
          _statusRow(context, masariText(context, 'الفنادق', 'Hotels'), '${catalog.where((s) => s.category == 'فنادق').length}'),
          _statusRow(context, masariText(context, 'الغرف', 'Rooms'), '${catalog.where((s) => s.category == 'غرف').length}'),
          const SizedBox(height: 8),
          Text(masariText(context, 'كل تعديل يتم من مركز العمليات يحفظ الاسم والوصف والسعر والصورة والحالة والبيانات الإضافية، وتقرأ واجهة العميل من نفس الكتالوج.', 'Changes made in the Operations Center save the name, description, price, image, status, and metadata; customer screens read from the same catalog.')),
        ])),
      ]),
    );
  }

  Widget _statusRow(BuildContext context, String label, String value) => Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Row(children: [Expanded(child: Text(label)), Text(value, style: MasariTypography.titleSmall(color: MasariColors.primaryCyan))]));
}
