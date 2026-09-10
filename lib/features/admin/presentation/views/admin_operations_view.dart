import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../foundation/presentation/providers/app_providers.dart';
import '../../../foundation/presentation/providers/operational_catalog_provider.dart';
import 'admin_catalog_management_view.dart';
import 'admin_settings_view.dart';

/// Operational admin workspace. This replaces the incomplete service-only
/// administration surface with one place for catalog, security and metrics.
class AdminOperationsView extends ConsumerStatefulWidget {
  const AdminOperationsView({super.key});

  @override
  ConsumerState<AdminOperationsView> createState() => _AdminOperationsViewState();
}

class _AdminOperationsViewState extends ConsumerState<AdminOperationsView> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(operationalCatalogProvider);
    final users = ref.watch(managedUsersProvider);
    final audits = ref.watch(auditLogProvider);
    final admin = ref.watch(userSessionProvider);

    return Scaffold(
      backgroundColor: MasariColors.darkGraphite,
      body: SafeArea(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 14),
            decoration: const BoxDecoration(
              color: MasariColors.primaryBlue,
              border: Border(bottom: BorderSide(color: MasariColors.primaryCyan, width: 1.5)),
            ),
            child: Row(children: [
              const Icon(Icons.admin_panel_settings, color: MasariColors.primaryCyan, size: 30),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('مركز عمليات مساري', style: MasariTypography.titleLarge(color: Colors.white)),
                Text('المشرف: ${admin.name} • الكتالوج الموحد متصل بواجهة العميل', style: MasariTypography.caption(color: MasariColors.titaniumLight)),
              ])),
            ]),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _tabButton(0, 'لوحة العمليات', Icons.dashboard_outlined),
              _tabButton(1, 'الخدمات والفنادق والغرف', Icons.inventory_2_outlined),
              _tabButton(2, 'المستخدمون والتدقيق', Icons.security_outlined),
              _tabButton(3, 'إعدادات النظام', Icons.settings_outlined),
            ]),
          ),
          Expanded(child: Padding(padding: const EdgeInsets.all(20), child: IndexedStack(index: _tab, children: [
            _dashboard(catalog.length, users.length, audits.length),
            const AdminCatalogManagementView(),
            _security(users.length, audits),
            const AdminSettingsView(),
          ]))),
        ]),
      ),
    );
  }

  Widget _tabButton(int index, String label, IconData icon) => InkWell(
    onTap: () => setState(() => _tab = index),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _tab == index ? MasariColors.primaryCyan : Colors.transparent, width: 3))),
      child: Row(children: [Icon(icon, size: 18, color: _tab == index ? MasariColors.primaryCyan : MasariColors.titaniumLight), const SizedBox(width: 7), Text(label, style: TextStyle(color: _tab == index ? Colors.white : MasariColors.titaniumLight))]),
    ),
  );

  Widget _dashboard(int services, int users, int audits) => SingleChildScrollView(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('لوحة العمليات', style: MasariTypography.headlineSmall(color: Colors.white)),
      const SizedBox(height: 6),
      Text('مؤشرات حية من نفس الكتالوج الذي يراه العميل.', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
      const SizedBox(height: 20),
      LayoutBuilder(builder: (context, c) {
        final count = c.maxWidth > 850 ? 4 : 2;
        return GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: count, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 2.3, children: [
          _metric('الخدمات والمنتجات', '$services', Icons.inventory_2_outlined, MasariColors.primaryCyan),
          _metric('المستخدمون', '$users', Icons.people_outline, MasariColors.success),
          _metric('سجل التدقيق', '$audits', Icons.verified_user_outlined, MasariColors.primaryOrange),
          _metric('الكتالوج', 'متزامن', Icons.sync, MasariColors.primaryBlueLight),
        ]);
      }),
      const SizedBox(height: 22),
      MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('ما الذي أصبح قابلًا للإدارة؟', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
        const SizedBox(height: 12),
        const Text('• الخدمات والرحلات والباقات: الاسم، الوصف، السعر، العملة، الحالة، الصورة والبيانات الإضافية.'),
        const Text('• الفنادق: بيانات الفندق نفسها + إنشاء وإدارة غرف مستقلة مرتبطة بالفندق.'),
        const Text('• الغرف: الاسم، الوصف، السعر، الصورة، السعة، الإطلالة والبيانات الإضافية.'),
        const Text('• الحذف والإضافة والتعديل محفوظة في الكتالوج المحلي وتنعكس على واجهة العميل.'),
      ])),
    ]),
  );

  Widget _metric(String title, String value, IconData icon, Color color) => MasariCard(child: Row(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withValues(alpha: .15), shape: BoxShape.circle), child: Icon(icon, color: color)), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, maxLines: 1, overflow: TextOverflow.ellipsis), const SizedBox(height: 4), Text(value, style: MasariTypography.titleMedium(color: color))]))]));

  Widget _security(int users, List<dynamic> audits) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('المستخدمون والتدقيق', style: MasariTypography.headlineSmall(color: Colors.white)),
    const SizedBox(height: 12),
    MasariCard(child: ListTile(leading: const Icon(Icons.people, color: MasariColors.primaryCyan), title: Text('$users حسابات مسجلة'), subtitle: const Text('إدارة المستخدمين الأساسية ما زالت متاحة من بوابة الإدارة السابقة.'))),
    const SizedBox(height: 12),
    Expanded(child: ListView.builder(itemCount: audits.length, itemBuilder: (_, i) => Padding(padding: const EdgeInsets.only(bottom: 8), child: MasariCard(child: ListTile(leading: const Icon(Icons.history, color: MasariColors.primaryOrange), title: Text(audits[i].summary), subtitle: Text(audits[i].timestamp.toString()))))))),
  ]);
}
