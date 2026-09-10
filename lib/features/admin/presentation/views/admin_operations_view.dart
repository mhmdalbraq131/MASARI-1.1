import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/masari_localization.dart';
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
      body: SafeArea(child: Column(children: [
        Container(padding: const EdgeInsets.fromLTRB(22, 18, 22, 14), decoration: const BoxDecoration(color: MasariColors.primaryBlue, border: Border(bottom: BorderSide(color: MasariColors.primaryCyan, width: 1.5))), child: Row(children: [
          const Icon(Icons.admin_panel_settings, color: MasariColors.primaryCyan, size: 30),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(masariText(context, 'مركز عمليات مساري', 'MASARI Operations Center'), style: MasariTypography.titleLarge(color: Colors.white)),
            Text('${masariText(context, 'المشرف', 'Administrator')}: ${admin.name} • ${masariText(context, 'الكتالوج الموحد متصل بواجهة العميل', 'Unified catalog connected to customer screens')}', style: MasariTypography.caption(color: MasariColors.titaniumLight)),
          ])),
        ])),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          _tabButton(context, 0, masariText(context, 'لوحة العمليات', 'Operations Dashboard'), Icons.dashboard_outlined),
          _tabButton(context, 1, masariText(context, 'الخدمات والفنادق والغرف', 'Services, Hotels & Rooms'), Icons.inventory_2_outlined),
          _tabButton(context, 2, masariText(context, 'المستخدمون والتدقيق', 'Users & Audit'), Icons.security_outlined),
          _tabButton(context, 3, masariText(context, 'إعدادات النظام', 'System Settings'), Icons.settings_outlined),
        ])),
        Expanded(child: Padding(padding: const EdgeInsets.all(20), child: IndexedStack(index: _tab, children: [_dashboard(context, catalog.length, users.length, audits.length), const AdminCatalogManagementView(), _security(context, users, audits, admin), const AdminSettingsView()]))),
      ])),
    );
  }

  Widget _tabButton(BuildContext context, int index, String label, IconData icon) {
    final selected = _tab == index;
    return InkWell(
      onTap: () => setState(() => _tab = index),
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: selected ? MasariColors.primaryCyan : Colors.transparent, width: 3))), child: Row(children: [Icon(icon, size: 18, color: selected ? MasariColors.primaryCyan : MasariColors.titaniumLight), const SizedBox(width: 7), Text(label, style: TextStyle(color: selected ? Colors.white : MasariColors.titaniumLight))])),
    );
  }

  Widget _dashboard(BuildContext context, int services, int users, int audits) {
    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(masariText(context, 'لوحة العمليات', 'Operations Dashboard'), style: MasariTypography.headlineSmall(color: Colors.white)),
      const SizedBox(height: 6),
      Text(masariText(context, 'مؤشرات حية من نفس الكتالوج الذي يراه العميل.', 'Live indicators from the same catalog used by customer screens.'), style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
      const SizedBox(height: 20),
      LayoutBuilder(builder: (context, constraints) {
        final count = constraints.maxWidth > 850 ? 4 : 2;
        return GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: count, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 2.3, children: [
          _metric(masariText(context, 'الخدمات والمنتجات', 'Services & Products'), '$services', Icons.inventory_2_outlined, MasariColors.primaryCyan),
          _metric(masariText(context, 'المستخدمون', 'Users'), '$users', Icons.people_outline, MasariColors.success),
          _metric(masariText(context, 'سجل التدقيق', 'Audit Log'), '$audits', Icons.verified_user_outlined, MasariColors.primaryOrange),
          _metric(masariText(context, 'الكتالوج', 'Catalog'), masariText(context, 'متزامن', 'Synced'), Icons.sync, MasariColors.primaryBlueLight),
        ]);
      }),
      const SizedBox(height: 22),
      MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(masariText(context, 'مركز التحكم الموحد', 'Unified Control Center'), style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
        const SizedBox(height: 12),
        Text(masariText(context, '• الخدمات والرحلات والباقات: الاسم، الوصف، السعر، العملة، الحالة، الصورة والبيانات الإضافية.', '• Services, journeys, and packages: name, description, price, currency, status, image, and metadata.')),
        Text(masariText(context, '• الفنادق: بيانات الفندق + إنشاء وإدارة غرف مرتبطة بالفندق.', '• Hotels: hotel data plus creation and management of linked rooms.')),
        Text(masariText(context, '• المستخدمون: إنشاء حسابات وتغيير حالتها مع سجل تدقيق.', '• Users: create accounts and change their status with audit tracking.')),
        Text(masariText(context, '• كل تعديل على الكتالوج محفوظ ويظهر في صفحات العميل التشغيلية.', '• Every catalog change is saved and reflected in customer-facing operational pages.')),
      ])),
    ]));
  }

  Widget _metric(String title, String value, IconData icon, Color color) {
    return MasariCard(child: Row(children: [
      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withValues(alpha: .15), shape: BoxShape.circle), child: Icon(icon, color: color)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Text(value, style: MasariTypography.titleMedium(color: color)),
      ])),
    ]));
  }

  Widget _security(BuildContext context, List<ManagedUser> users, List<dynamic> audits, dynamic admin) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(masariText(context, 'المستخدمون والتدقيق', 'Users & Audit'), style: MasariTypography.headlineSmall(color: Colors.white)),
          const SizedBox(height: 4),
          Text(masariText(context, 'إدارة الحسابات والحالات من نفس مركز الإدارة.', 'Manage accounts and statuses from the same admin center.'), style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
        ])),
        ElevatedButton.icon(onPressed: () => _createUser(context, admin), icon: const Icon(Icons.person_add), label: Text(masariText(context, 'إضافة مستخدم', 'Add user'))),
      ]),
      const SizedBox(height: 14),
      Expanded(child: ListView(children: [
        ...users.map((user) => Padding(padding: const EdgeInsets.only(bottom: 8), child: _userCard(context, user, admin))),
        const SizedBox(height: 8),
        Text(masariText(context, 'سجل التدقيق', 'Audit Log'), style: MasariTypography.titleMedium(color: MasariColors.primaryOrange)),
        const SizedBox(height: 8),
        ...audits.map((audit) => Padding(padding: const EdgeInsets.only(bottom: 8), child: MasariCard(child: ListTile(
          leading: const Icon(Icons.history, color: MasariColors.primaryOrange),
          title: Text(audit.summary),
          subtitle: Text(audit.timestamp.toString()),
        )))),
      ])),
    ]);
  }

  Widget _userCard(BuildContext context, ManagedUser user, dynamic admin) {
    final isAdmin = user.role == UserRole.admin;
    return MasariCard(child: ListTile(
      leading: CircleAvatar(backgroundColor: isAdmin ? MasariColors.primaryOrange.withValues(alpha: .18) : MasariColors.primaryCyan.withValues(alpha: .18), child: Icon(isAdmin ? Icons.admin_panel_settings : Icons.person, color: isAdmin ? MasariColors.primaryOrange : MasariColors.primaryCyan)),
      title: Text(user.name),
      subtitle: Text('${user.email}\n${isAdmin ? masariText(context, 'مدير نظام', 'Administrator') : masariText(context, 'عميل مسافر', 'Traveler')} • ${user.status}'),
      isThreeLine: true,
      trailing: DropdownButton<String>(
        value: user.status,
        items: [
          DropdownMenuItem(value: 'نشط', child: Text(masariText(context, 'نشط', 'Active'))),
          DropdownMenuItem(value: 'موقوف', child: Text(masariText(context, 'موقوف', 'Suspended'))),
        ],
        onChanged: (value) {
          if (value != null) {
            ref.read(managedUsersProvider.notifier).updateUserStatus(userId: user.id, newStatus: value, adminSession: admin);
          }
        },
      ),
    ));
  }

  Future<void> _createUser(BuildContext context, dynamic admin) async {
    final name = TextEditingController();
    final email = TextEditingController();
    UserRole role = UserRole.user;
    await showDialog<void>(context: context, builder: (dialogContext) => StatefulBuilder(builder: (context, setDialogState) => AlertDialog(
      title: Text(masariText(context, 'إنشاء حساب', 'Create account')),
      content: SizedBox(width: 480, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: name, decoration: InputDecoration(labelText: masariText(context, 'الاسم', 'Name'))),
        TextField(controller: email, decoration: InputDecoration(labelText: masariText(context, 'البريد الإلكتروني', 'Email'))),
        DropdownButtonFormField<UserRole>(
          initialValue: role,
          decoration: InputDecoration(labelText: masariText(context, 'نوع الحساب', 'Account type')),
          items: [
            DropdownMenuItem(value: UserRole.user, child: Text(masariText(context, 'عميل مسافر', 'Traveler'))),
            DropdownMenuItem(value: UserRole.admin, child: Text(masariText(context, 'مدير نظام', 'Administrator'))),
          ],
          onChanged: (value) => setDialogState(() => role = value ?? role),
        ),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: Text(masariText(context, 'إلغاء', 'Cancel'))),
        ElevatedButton(onPressed: () { if (name.text.trim().isEmpty || email.text.trim().isEmpty) return; ref.read(managedUsersProvider.notifier).createUser(name: name.text.trim(), email: email.text.trim(), role: role, adminSession: admin); Navigator.pop(dialogContext); }, child: Text(masariText(context, 'إنشاء', 'Create'))),
      ],
    )));
    name.dispose();
    email.dispose();
  }
}
