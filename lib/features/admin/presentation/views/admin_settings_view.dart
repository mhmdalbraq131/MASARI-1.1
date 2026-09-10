import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../providers/admin_settings_provider.dart';

class AdminSettingsView extends ConsumerWidget {
  const AdminSettingsView({super.key});

  void _setTwoFactor(WidgetRef ref, bool value) {
    ref.read(adminSettingsProvider.notifier).setTwoFactorEnabled(value);
  }

  void _setAuditLogging(WidgetRef ref, bool value) {
    ref.read(adminSettingsProvider.notifier).setAuditLoggingEnabled(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(adminSettingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('إعدادات النظام')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'إعدادات الإدارة والأمان',
            style: MasariTypography.headlineSmall(color: MasariColors.primaryBlue),
          ),
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
                  onChanged: (value) => _setTwoFactor(ref, value),
                ),
                const Divider(),
                SwitchListTile.adaptive(
                  title: const Text('سجل التدقيق الإداري'),
                  subtitle: const Text('تسجيل الإجراءات الإدارية تلقائيًا للمراجعة والمساءلة.'),
                  value: settings.auditLoggingEnabled,
                  activeThumbColor: MasariColors.primaryCyan,
                  onChanged: (value) => _setAuditLogging(ref, value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
