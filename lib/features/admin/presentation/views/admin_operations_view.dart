import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/security/protected_route_guard.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../foundation/domain/entities/managed_user.dart';
import '../../../foundation/presentation/providers/app_providers.dart';
import '../../../foundation/presentation/providers/operational_catalog_provider.dart';
import 'admin_catalog_management_view.dart';
import 'admin_settings_view.dart';

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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 14),
              decoration: const BoxDecoration(color: MasariColors.primaryBlue, border: Border(bottom: BorderSide(color: MasariColors.primaryCyan, width: 1.5))),
              child: Row(
                children: [
                  const Icon(Icons.admin_panel_settings, color: MasariColors.primaryCyan, size: 30),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('مركز عمليات مساري', style: MasariTypography.titleLarge(color: Colors.white)), Text('المشرف: ${admin.name} • الكتالوج الموحد متصل بواجهة العميل', style: MasariTypography.caption(color: MasariColors.titaniumLight))])),
                ],
              ),
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
            Expanded(child: Padding(padding: const EdgeInsets.all(20), child: IndexedStack(index: _tab, children: [_dashboard(catalog.length, users.length, audits.length), const AdminCatalogManagementView(), _security(users, audits, admin), const AdminSettingsView()]))),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(int index, String label, IconData icon) {
    final selected = _tab == index;
    return InkWell(
      onTap: () => setState(() => _tab = index),
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: selected ? MasariColors.primaryCyan : Colors.transparent, width: 3))), child: Row(children: [Icon(icon, size: 18, color: selected ? MasariColors.primaryCyan : MasariColors.titaniumLight), const SizedBox(width: 7), Text(label, style: TextStyle(color: selected ? Colors.white : MasariColors.titaniumLight))])),
    );
  }

  Widget _dashboard(int services, int users, int audits) {
    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('لوحة العمليات', style: MasariTypography.headlineSmall(color: Colors.white)),
      const SizedBox(height: 6),
      Text('مؤشرات حية من نفس الكتالوج الذي يراه العميل.', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
      const SizedBox(height: 20),
      LayoutBuilder(builder: (context, constraints) {
        final count = constraints.maxWidth > 850 ? 4 : 2;
        return GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: count, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 2.3, children: [
          _metric('الخدمات والمنتجات', '$services', Icons.inventory_2_outlined, MasariColors.primaryCyan),
          _metric('المستخدمون', '$users', Icons.people_outline, MasariColors.success),
          _metric('سجل التدقيق', '$audits', Icons.verified_user_outlined, MasariColors.primaryOrange),
          _metric('الكتالوج', 'متزامن', Icons.sync, MasariColors.primaryBlueLight),
        ]);
      }),
      const SizedBox(height: 22),
      MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('مركز التحكم الموحد', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
        const SizedBox(height: 12),
        const Text('• الخدمات والرحلات والباقات: الاسم، الوصف، السعر، العملة، الحالة، الصورة والبيانات الإضافية.'),
        const Text('• الفنادق: بيانات الفندق + إنشاء وإدارة غرف مرتبطة بالفندق.'),
        const Text('• المستخدمون: إنشاء حسابات وتغيير حالتها مع سجل تدقيق.'),
        const Text('• كل تعديل على الكتالوج محفوظ ويظهر في صفحات العميل التشغيلية.'),
      ])),
    ]));
  }

  Widget _metric(String title, String value, IconData icon, Color color) => MasariCard(child: Row(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withValues(alpha: .15), shape: BoxShape.circle), child: Icon(icon, color: color)), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, maxLines: 1, overflow: TextOverflow.ellipsis), const SizedBox(height: 4), Text(value, style: MasariTypography.titleMedium(color: color))]))]));

  Widget _security(List<ManagedUser> users, List<dynamic> audits, dynamic admin) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('المستخدمون والتدقيق', style: MasariTypography.headlineSmall(color: Colors.white)), const SizedBox(height: 4), Text('إدارة الحسابات والحالات من نفس مركز الإدارة.', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray))])), ElevatedButton.icon(onPressed: () => _createUser(admin), icon: const Icon(Icons.person_add), label: const Text('إضافة مستخدم'))]),
      const SizedBox(height: 14),
      Expanded(child: ListView(children: [
        ...users.map((user) => Padding(padding: const EdgeInsets.only(bottom: 8), child: _userCard(user, admin))),
        const SizedBox(height: 8),
        Text('سجل التدقيق', style: MasariTypography.titleMedium(color: MasariColors.primaryOrange)),
        const SizedBox(height: 8),
        ...audits.map((audit) => Padding(padding: const EdgeInsets.only(bottom: 8), child: MasariCard(child: ListTile(leading: const Icon(Icons.history, color: MasariColors.primaryOrange), title: Text(audit.summary), subtitle: Text(audit.timestamp.toString()))))),
      ])),
    ]);
  }

  Widget _userCard(ManagedUser user, dynamic admin) {
    final isAdmin = user.role == UserRole.admin;
    return MasariCard(child: ListTile(
      leading: CircleAvatar(backgroundColor: isAdmin ? MasariColors.primaryOrange.withValues(alpha: .18) : MasariColors.primaryCyan.withValues(alpha: .18), child: Icon(isAdmin ? Icons.admin_panel_settings : Icons.person, color: isAdmin ? MasariColors.primaryOrange : MasariColors.primaryCyan)),
      title: Text(user.name),
      subtitle: Text('${user.email}\n${isAdmin ? 'مدير نظام' : 'عميل مسافر'} • ${user.status}'),
      isThreeLine: true,
      trailing: DropdownButton<String>(value: user.status, items: const [DropdownMenuItem(value: 'نشط', child: Text('نشط')), DropdownMenuItem(value: 'موقوف', child: Text('موقوف'))], onChanged: (value) { if (value != null) ref.read(managedUsersProvider.notifier).updateUserStatus(userId: user.id, newStatus: value, adminSession: admin); }),
    ));
  }

  Future<void> _createUser(dynamic admin) async {
    final name = TextEditingController();
    final email = TextEditingController();
    UserRole role = UserRole.user;
    await showDialog<void>(context: context, builder: (dialogContext) => StatefulBuilder(builder: (context, setDialogState) => AlertDialog(title: const Text('إنشاء حساب'), content: SizedBox(width: 480, child: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: name, decoration: const InputDecoration(labelText: 'الاسم')), TextField(controller: email, decoration: const InputDecoration(labelText: 'البريد الإلكتروني')), DropdownButtonFormField<UserRole>(value: role, decoration: const InputDecoration(labelText: 'نوع الحساب'), items: const [DropdownMenuItem(value: UserRole.user, child: Text('عميل مسافر')), DropdownMenuItem(value: UserRole.admin, child: Text('مدير نظام'))], onChanged: (v) => setDialogState(() => role = v ?? role))])), actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')), ElevatedButton(onPressed: () { if (name.text.trim().isEmpty || email.text.trim().isEmpty) return; ref.read(managedUsersProvider.notifier).createUser(name: name.text.trim(), email: email.text.trim(), role: role, adminSession: admin); Navigator.pop(dialogContext); }, child: const Text('إنشاء'))]));
    name.dispose();
    email.dispose();
  }
}
