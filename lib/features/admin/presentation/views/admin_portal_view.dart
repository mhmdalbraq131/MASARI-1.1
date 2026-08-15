import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/security/protected_route_guard.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_buttons.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_chips_badges.dart';
import '../../../../shared/components/masari_section_header.dart';
import '../../../../shared/components/masari_text_fields.dart';
import '../../../foundation/domain/entities/audit_record.dart';
import '../../../foundation/domain/entities/managed_user.dart';
import '../../../foundation/domain/entities/platform_service.dart';
import '../../../foundation/presentation/providers/app_providers.dart';

/// Dedicated Operational Admin Portal View
class AdminPortalView extends ConsumerStatefulWidget {
  const AdminPortalView({super.key});

  @override
  ConsumerState<AdminPortalView> createState() => _AdminPortalViewState();
}

class _AdminPortalViewState extends ConsumerState<AdminPortalView> {
  int _selectedTabIndex = 0;

  // Filter states for Audit Log
  String _auditAdminFilter = 'الكل';
  String _auditActionFilter = 'الكل';
  String _auditSearchQuery = '';

  // Filter state for Services
  String _serviceCategoryFilter = 'الكل';

  @override
  Widget build(BuildContext context) {
    final userSession = ref.watch(userSessionProvider);
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';

    // Verify Admin Authorization
    if (userSession.role != UserRole.admin) {
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(24),
            child: MasariCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.block, color: MasariColors.primaryOrange, size: 56),
                  const SizedBox(height: 16),
                  Text('غير مصرح بالدخول', style: MasariTypography.headlineSmall(color: MasariColors.primaryOrange)),
                  const SizedBox(height: 8),
                  Text(
                    'عذراً، هذه المنطقة مخصصة لمدراء النظام المعتمدين فقط.',
                    textAlign: TextAlign.center,
                    style: MasariTypography.bodyMedium(color: MasariColors.titaniumGray),
                  ),
                  const SizedBox(height: 24),
                  MasariPrimaryButton(
                    label: 'العودة للصفحة الرئيسية (/home)',
                    onPressed: () => context.go('/home'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: MasariColors.primaryBlueDark,
      body: SafeArea(
        child: Column(
          children: [
            // Admin Portal Header Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: MasariColors.primaryBlue,
                border: Border(bottom: BorderSide(color: MasariColors.primaryCyan, width: 1.5)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: MasariColors.primaryCyan,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.admin_panel_settings, color: MasariColors.primaryBlueDark, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('بوابة الإدارة المركزية (MASARI Admin Portal)',
                                style: MasariTypography.titleLarge(color: MasariColors.pureWhite, isArabic: isArabic)),
                            const SizedBox(width: 12),
                            const MasariBadge(
                              label: 'OPERATIONAL CONTROL',
                              backgroundColor: MasariColors.primaryCyan,
                              textColor: MasariColors.primaryBlueDark,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'المسار المحمي: /admin | المشرف الحالي: ${userSession.name} (${userSession.email})',
                          style: MasariTypography.caption(color: MasariColors.titaniumLight, isArabic: false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Admin Operational Navigation Tabs
            Container(
              color: MasariColors.primaryBlueLight.withOpacity(0.4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildAdminTab(0, 'لوحة التحكم والعمليات', Icons.dashboard_outlined),
                    _buildAdminTab(1, 'إدارة الخدمات والأسعار', Icons.inventory_2_outlined),
                    _buildAdminTab(2, 'إدارة المستخدمين', Icons.people_alt_outlined),
                    _buildAdminTab(3, 'سجل التدقيق الأمني (Audit Log)', Icons.security_outlined, isCyan: true),
                    _buildAdminTab(4, 'التقارير والمالية', Icons.assessment_outlined),
                    _buildAdminTab(5, 'إعدادات النظام', Icons.settings_applications_outlined),
                  ],
                ),
              ),
            ),

            // Active Admin Tab View Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: IndexedStack(
                  index: _selectedTabIndex,
                  children: [
                    _buildDashboardSection(),
                    _buildServicesManagementSection(),
                    _buildUserManagementSection(),
                    _buildAuditLogSection(),
                    _buildReportsSection(),
                    _buildSettingsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminTab(int index, String label, IconData icon, {bool isCyan = false}) {
    final isSelected = _selectedTabIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? MasariColors.primaryCyan : Colors.transparent,
              width: 3,
            ),
          ),
          color: isSelected ? MasariColors.primaryBlue.withOpacity(0.5) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? MasariColors.primaryCyan
                  : isCyan
                      ? MasariColors.primaryCyanLight
                      : MasariColors.titaniumLight,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? MasariColors.pureWhite : MasariColors.titaniumLight,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1. Dashboard Overview Tab
  Widget _buildDashboardSection() {
    final services = ref.watch(platformServicesProvider);
    final users = ref.watch(managedUsersProvider);
    final auditLogs = ref.watch(auditLogProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MasariSectionHeader(title: 'ملخص المؤشرات التشغيلية والمالية'),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossCount = constraints.maxWidth > 900 ? 4 : (constraints.maxWidth > 600 ? 2 : 1);
              return GridView.count(
                crossAxisCount: crossCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.2,
                children: [
                  _buildStatCard('إجمالي الإيرادات', '1,450,200 SAR', Icons.monetization_on_outlined, MasariColors.primaryCyan),
                  _buildStatCard('الخدمات النشطة', '${services.length} خدمات', Icons.inventory_2_outlined, MasariColors.primaryBlueLight),
                  _buildStatCard('المستخدمين والمدراء', '${users.length} حسابات', Icons.group_outlined, MasariColors.success),
                  _buildStatCard('سجلات التدقيق الأمني', '${auditLogs.length} سجلات', Icons.verified_user_outlined, MasariColors.primaryOrange),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Actions Panel
              Expanded(
                flex: 1,
                child: MasariCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('إجراءات تشغيلية سريعة', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => setState(() => _selectedTabIndex = 1),
                          icon: const Icon(Icons.edit_note, color: MasariColors.primaryCyan),
                          label: const Text('تعديل أسعار العمرة والخدمات'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: MasariColors.primaryCyan),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => setState(() => _selectedTabIndex = 2),
                          icon: const Icon(Icons.person_add_outlined, color: MasariColors.primaryCyanLight),
                          label: const Text('إضافة مدير نظام أو عميل جديد'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: MasariColors.primaryCyanLight),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => setState(() => _selectedTabIndex = 3),
                          icon: const Icon(Icons.history_outlined, color: MasariColors.primaryOrange),
                          label: const Text('مراجعة سجل التدقيق الأمني'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: MasariColors.primaryOrange),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Recent Activity Feed
              Expanded(
                flex: 2,
                child: MasariCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('آخر عمليات التدقيق والتغييرات المسجلة', style: MasariTypography.titleMedium(color: MasariColors.pureWhite)),
                      const SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: auditLogs.length > 3 ? 3 : auditLogs.length,
                        separatorBuilder: (_, __) => const Divider(color: MasariColors.primaryBlueLight),
                        itemBuilder: (context, index) {
                          final log = auditLogs[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: MasariColors.primaryCyan.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit_attributes, color: MasariColors.primaryCyan, size: 20),
                            ),
                            title: Text(log.summary, style: MasariTypography.bodySmall(color: MasariColors.pureWhite)),
                            subtitle: Text(
                              'بواسطة: ${log.adminName} | ${log.timestamp.toString().substring(0, 16)}',
                              style: MasariTypography.caption(color: MasariColors.titaniumGray, isArabic: false),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. Services & Products Management Tab
  Widget _buildServicesManagementSection() {
    final services = ref.watch(platformServicesProvider);
    final userSession = ref.watch(userSessionProvider);

    final filteredServices = _serviceCategoryFilter == 'الكل'
        ? services
        : services.where((s) => s.category == _serviceCategoryFilter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('إدارة الخدمات والأسعار', style: MasariTypography.titleLarge()),
                Text('إدارة قائمة خدمات مساري وتعديل أسعارها وحالاتها مع التتبع الأمني التلقائي',
                    style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
              ],
            ),
            // Category Filter Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: MasariColors.primaryBlueContainer,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: MasariColors.primaryCyan),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _serviceCategoryFilter,
                  dropdownColor: MasariColors.primaryBlueDark,
                  style: const TextStyle(color: MasariColors.pureWhite, fontSize: 13),
                  items: ['الكل', 'عمرة', 'حج', 'طيران', 'فنادق', 'حافلات', 'سيارات']
                      .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _serviceCategoryFilter = val);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Expanded(
          child: ListView.builder(
            itemCount: filteredServices.length,
            itemBuilder: (context, index) {
              final service = filteredServices[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MasariCard(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          service.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 80,
                            height: 80,
                            color: MasariColors.primaryBlueLight.withOpacity(0.3),
                            child: const Icon(Icons.image, color: MasariColors.primaryCyan),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(service.name, style: MasariTypography.titleMedium()),
                                const SizedBox(width: 8),
                                MasariBadge(
                                  label: service.category,
                                  backgroundColor: MasariColors.primaryCyan.withOpacity(0.2),
                                  textColor: MasariColors.primaryCyan,
                                ),
                                const SizedBox(width: 8),
                                MasariBadge(
                                  label: service.status,
                                  backgroundColor: service.status == 'نشط'
                                      ? MasariColors.success.withOpacity(0.2)
                                      : MasariColors.primaryOrange.withOpacity(0.2),
                                  textColor: service.status == 'نشط' ? MasariColors.success : MasariColors.primaryOrange,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(service.description,
                                style: MasariTypography.bodySmall(color: MasariColors.titaniumGray),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 6),
                            Text(
                              'السعر الحالي: ${service.price.toInt()} ${service.currency}',
                              style: MasariTypography.titleSmall(color: MasariColors.primaryCyan),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Actions: Edit Price / Details
                      Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _showEditPriceDialog(context, service, userSession),
                            icon: const Icon(Icons.price_change, size: 16),
                            label: const Text('تعديل السعر'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MasariColors.primaryCyan,
                              foregroundColor: MasariColors.primaryBlueDark,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          ),
                          const SizedBox(height: 6),
                          OutlinedButton(
                            onPressed: () {
                              final newStatus = service.status == 'نشط' ? 'معطل' : 'نشط';
                              ref.read(platformServicesProvider.notifier).updateServiceStatus(
                                    serviceId: service.id,
                                    newStatus: newStatus,
                                    adminSession: userSession,
                                  );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: service.status == 'نشط' ? MasariColors.primaryOrange : MasariColors.success,
                              side: BorderSide(
                                color: service.status == 'نشط' ? MasariColors.primaryOrange : MasariColors.success,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            child: Text(service.status == 'نشط' ? 'تعطيل الخدمة' : 'تفعيل الخدمة'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Edit Price Dialog Component
  void _showEditPriceDialog(BuildContext context, PlatformService service, dynamic adminSession) {
    final controller = TextEditingController(text: service.price.toInt().toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: MasariColors.primaryBlueDark,
        title: Text('تعديل سعر (${service.name})', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('السعر الحالي: ${service.price.toInt()} SAR', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
            const SizedBox(height: 16),
            MasariTextField(
              label: 'السعر الجديد (SAR)',
              hintText: 'أدخل السعر الجديد',
              controller: controller,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MasariColors.primaryBlueContainer,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: MasariColors.primaryCyan.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.security, color: MasariColors.primaryCyan, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'سيتم تسجيل هذا التعديل في سجل التدقيق الأمني باسم المشرف الحالي (${adminSession.name}).',
                      style: MasariTypography.caption(color: MasariColors.pureWhite),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final newPrice = double.tryParse(controller.text) ?? service.price;
              ref.read(platformServicesProvider.notifier).updateServicePrice(
                    serviceId: service.id,
                    newPrice: newPrice,
                    adminSession: adminSession,
                  );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم تحديث سعر ${service.name} إلى $newPrice SAR وتسجيل العملية بنجاح.'),
                  backgroundColor: MasariColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MasariColors.primaryCyan,
              foregroundColor: MasariColors.primaryBlueDark,
            ),
            child: const Text('تأكيد وحفظ السعر'),
          ),
        ],
      ),
    );
  }

  // 3. User Management Tab
  Widget _buildUserManagementSection() {
    final users = ref.watch(managedUsersProvider);
    final userSession = ref.watch(userSessionProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('إدارة المستخدمين ومدراء النظام', style: MasariTypography.titleLarge()),
                Text('عرض وإضافة الحسابات والتحكم في الصلاحيات والحالات التشغيلية',
                    style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () => _showAddUserDialog(context, userSession),
              icon: const Icon(Icons.person_add, size: 18),
              label: const Text('إضافة مستخدم / مدير جديد'),
              style: ElevatedButton.styleFrom(
                backgroundColor: MasariColors.primaryOrange,
                foregroundColor: MasariColors.pureWhite,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MasariCard(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: user.role == UserRole.admin ? MasariColors.primaryCyan : MasariColors.primaryBlueLight,
                        foregroundColor: user.role == UserRole.admin ? MasariColors.primaryBlueDark : MasariColors.pureWhite,
                        child: Text(user.name.isNotEmpty ? user.name[0] : 'U'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(user.name, style: MasariTypography.titleMedium()),
                                const SizedBox(width: 8),
                                MasariBadge(
                                  label: user.role == UserRole.admin ? 'مدير نظام (Admin)' : 'عميل مسافر (User)',
                                  backgroundColor: user.role == UserRole.admin
                                      ? MasariColors.primaryCyan.withOpacity(0.2)
                                      : MasariColors.primaryBlueLight.withOpacity(0.2),
                                  textColor: user.role == UserRole.admin ? MasariColors.primaryCyan : MasariColors.primaryCyanLight,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(user.email, style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
                          ],
                        ),
                      ),
                      MasariBadge(
                        label: user.status,
                        backgroundColor: user.status == 'نشط'
                            ? MasariColors.success.withOpacity(0.2)
                            : MasariColors.primaryOrange.withOpacity(0.2),
                        textColor: user.status == 'نشط' ? MasariColors.success : MasariColors.primaryOrange,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Create User Dialog Component
  void _showAddUserDialog(BuildContext context, dynamic adminSession) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    UserRole selectedRole = UserRole.user;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: MasariColors.primaryBlueDark,
          title: Text('إضافة مستخدم / مدير نظام جديد', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MasariTextField(label: 'الاسم الكامل', hintText: 'مثال: عبدالله الشمري', controller: nameCtrl),
              const SizedBox(height: 12),
              MasariTextField(label: 'البريد الإلكتروني', hintText: 'user@masari.travel', controller: emailCtrl),
              const SizedBox(height: 16),
              Text('نوع الحساب والصلاحية:', style: MasariTypography.bodySmall(color: MasariColors.pureWhite)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Radio<UserRole>(
                    value: UserRole.user,
                    groupValue: selectedRole,
                    activeColor: MasariColors.primaryCyan,
                    onChanged: (val) => setDialogState(() => selectedRole = val!),
                  ),
                  const Text('عميل مسافر (User)'),
                  const SizedBox(width: 16),
                  Radio<UserRole>(
                    value: UserRole.admin,
                    groupValue: selectedRole,
                    activeColor: MasariColors.primaryCyan,
                    onChanged: (val) => setDialogState(() => selectedRole = val!),
                  ),
                  const Text('مدير نظام (Admin)'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.isNotEmpty && emailCtrl.text.isNotEmpty) {
                  ref.read(managedUsersProvider.notifier).createUser(
                        name: nameCtrl.text,
                        email: emailCtrl.text,
                        role: selectedRole,
                        adminSession: adminSession,
                      );
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم إنشاء الحساب بنجاح وتسجيل الإجراء في سجل التدقيق الأمني.'),
                      backgroundColor: MasariColors.success,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: MasariColors.primaryCyan, foregroundColor: MasariColors.primaryBlueDark),
              child: const Text('حفظ وإضافة الحساب'),
            ),
          ],
        ),
      ),
    );
  }

  // 4. Audit Log Vault Tab
  Widget _buildAuditLogSection() {
    final auditLogs = ref.watch(auditLogProvider);

    // Filter Logic
    final filteredLogs = auditLogs.where((log) {
      final matchesAdmin = _auditAdminFilter == 'الكل' || log.adminName == _auditAdminFilter;
      final matchesAction = _auditActionFilter == 'الكل' || log.action == _auditActionFilter;
      final matchesSearch = _auditSearchQuery.isEmpty ||
          log.summary.contains(_auditSearchQuery) ||
          log.entity.contains(_auditSearchQuery);
      return matchesAdmin && matchesAction && matchesSearch;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.shield, color: MasariColors.primaryCyan, size: 24),
                    const SizedBox(width: 8),
                    Text('سجل التدقيق والنشاط الأمني (Immutable Audit Vault)', style: MasariTypography.titleLarge()),
                  ],
                ),
                Text('تتبع شامل لكافة العمليات الإدارية وتعديلات الأسعار والصلاحيات بشكل مشفر وغير قابل للتعديل',
                    style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
              ],
            ),
            const MasariBadge(
              label: 'IMMUTABLE RECORD',
              backgroundColor: MasariColors.primaryBlueContainer,
              textColor: MasariColors.primaryCyan,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Filter Bar Controls
        MasariCard(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'البحث في سجل التدقيق...',
                    prefixIcon: const Icon(Icons.search, color: MasariColors.primaryCyan),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onChanged: (val) => setState(() => _auditSearchQuery = val),
                ),
              ),
              const SizedBox(width: 16),
              // Action Filter Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: MasariColors.primaryBlueContainer,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: MasariColors.primaryCyan),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _auditActionFilter,
                    dropdownColor: MasariColors.primaryBlueDark,
                    style: const TextStyle(color: MasariColors.pureWhite, fontSize: 13),
                    items: ['الكل', 'تعديل سعر', 'إنشاء مستخدم', 'تعديل حالة']
                        .map((act) => DropdownMenuItem(value: act, child: Text('الإجراء: $act')))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _auditActionFilter = val);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Audit Logs Stream List
        Expanded(
          child: filteredLogs.isEmpty
              ? Center(
                  child: Text('لا توجد سجلات تدقيق تطابق معايير البحث.',
                      style: MasariTypography.bodyMedium(color: MasariColors.titaniumGray)),
                )
              : ListView.builder(
                  itemCount: filteredLogs.length,
                  itemBuilder: (context, index) {
                    final log = filteredLogs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MasariColors.primaryBlue,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: log.action == 'تعديل سعر' ? MasariColors.primaryCyan : MasariColors.primaryBlueLight,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MasariBadge(
                                  label: log.action,
                                  backgroundColor: log.action == 'تعديل سعر'
                                      ? MasariColors.primaryCyan.withOpacity(0.2)
                                      : MasariColors.primaryBlueLight.withOpacity(0.2),
                                  textColor: log.action == 'تعديل سعر' ? MasariColors.primaryCyan : MasariColors.primaryCyanLight,
                                ),
                                const SizedBox(width: 12),
                                Text('الكيان: ${log.entity}', style: MasariTypography.titleSmall(color: MasariColors.pureWhite)),
                                const Spacer(),
                                Icon(Icons.access_time, size: 14, color: MasariColors.titaniumLight),
                                const SizedBox(width: 4),
                                Text(
                                  log.timestamp.toString().substring(0, 16),
                                  style: MasariTypography.caption(color: MasariColors.titaniumLight, isArabic: false),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Structured Human-Readable Log Message
                            Text(
                              log.summary,
                              style: MasariTypography.bodyMedium(color: MasariColors.pureWhite),
                            ),
                            const SizedBox(height: 8),

                            // Detailed Audit Breakdown Bar
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: MasariColors.primaryBlueDark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Text('المشرف المسؤول: ', style: MasariTypography.caption(color: MasariColors.titaniumGray)),
                                  Text(log.adminName, style: MasariTypography.caption(color: MasariColors.primaryCyan)),
                                  const Spacer(),
                                  Text('القيمة السابقة: ', style: MasariTypography.caption(color: MasariColors.primaryOrange)),
                                  Text(log.previousValue, style: MasariTypography.caption(color: MasariColors.primaryOrange)),
                                  const SizedBox(width: 16),
                                  Text('القيمة الجديدة: ', style: MasariTypography.caption(color: MasariColors.success)),
                                  Text(log.newValue, style: MasariTypography.caption(color: MasariColors.success)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // 5. Reports Section
  Widget _buildReportsSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('التقارير المالية التشغيلية والتحليلات', style: MasariTypography.titleLarge()),
          const SizedBox(height: 16),
          MasariCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('توزيع المبيعات والإيرادات حسب نوع الخدمة', style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
                const SizedBox(height: 16),
                _buildReportRow('باقات العمرة والحج الفاخرة', '650,000 SAR', '45%', MasariColors.primaryCyan),
                const SizedBox(height: 8),
                _buildReportRow('رحلات الطيران الدولي والداخلي', '380,000 SAR', '26%', MasariColors.primaryBlueLight),
                const SizedBox(height: 8),
                _buildReportRow('الحجوزات الفندقية البرجية', '270,000 SAR', '19%', MasariColors.success),
                const SizedBox(height: 8),
                _buildReportRow('النقل الخاص والسيارات الفارهة', '150,200 SAR', '10%', MasariColors.primaryOrange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportRow(String name, String amount, String percentage, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Expanded(child: Text(name, style: MasariTypography.bodySmall(color: MasariColors.pureWhite))),
        Text(amount, style: MasariTypography.titleSmall(color: MasariColors.primaryCyan)),
        const SizedBox(width: 16),
        Text(percentage, style: MasariTypography.caption(color: MasariColors.titaniumGray)),
      ],
    );
  }

  // 6. Settings Section
  Widget _buildSettingsSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('إعدادات النظام وسياسات الأمان', style: MasariTypography.titleLarge()),
          const SizedBox(height: 16),
          MasariCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: const Text('تفعيل التوثيق الثنائي (2FA) للمدراء'),
                  subtitle: const Text('إلزام جميع المشرفين بإدخال رمز OTP عند تسجيل الدخول للنظام.'),
                  value: true,
                  activeColor: MasariColors.primaryCyan,
                  onChanged: (val) {},
                ),
                const Divider(color: MasariColors.primaryBlueLight),
                SwitchListTile(
                  title: const Text('التسجيل التلقائي لسجلات التدقيق (Immutable Logging)'),
                  subtitle: const Text('تشفير وحفظ كل إجراء إداري بشكل مباشر يمنع تعديله أو مسحه.'),
                  value: true,
                  activeColor: MasariColors.primaryCyan,
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return MasariCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
                const SizedBox(height: 2),
                Text(title, style: MasariTypography.caption(color: MasariColors.titaniumGray)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
