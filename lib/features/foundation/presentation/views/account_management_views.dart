import 'package:flutter/material.dart';
import '../../../admin/presentation/views/admin_portal_view.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_chips_badges.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAccountSection('محفظة مساري الرقمية (Wallet)', '/wallet', Icons.account_balance_wallet, 'إدارة الرصيد والبطاقات واستبدال نقاط المكافآت.');
  }
}

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAccountSection('حجوزاتي وتذاكري (Bookings)', '/bookings', Icons.confirmation_number, 'سجل كافة الحجوزات النشطة والسابقة والتذاكر الإلكترونية.');
  }
}

class TravelersView extends StatelessWidget {
  const TravelersView({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAccountSection('إدارة بيانات المسافرين (Travelers)', '/travelers', Icons.people, 'حفظ واسترجاع بيانات أفراد العائلة والمسافرين المعتمدين.');
  }
}

class PassportsView extends StatelessWidget {
  const PassportsView({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAccountSection('مركز الجوازات والتثبت (Passport Center)', '/passports', Icons.contact_page, 'تشفير وحفظ صور وثائق السفر وتنبيهات انتهاء الجوازات.');
  }
}

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAccountSection('مركز الإشعارات والتنبيهات (Notifications)', '/notifications', Icons.notifications, 'تنبيهات الرحلات المباشرة، تغيير المواعيد، والتحديثات.');
  }
}

class AiAssistantView extends StatelessWidget {
  const AiAssistantView({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAccountSection('مساعد مساري الذكي (AI Travel Assistant)', '/ai', Icons.auto_awesome, 'المساعد الشخصي الذكي لتخطيط الرحلات والإنفاق والتوصيات.');
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAccountSection('الملف الشخصي (Profile)', '/profile', Icons.person, 'إدارة البيانات الشخصية، العضوية، وتفضيلات السفر.');
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildAccountSection('إعدادات المنصة (Settings)', '/settings', Icons.settings, 'اللغة، المظهر، الخصوصية، إشعارات التطبيق، والأمان.');
  }
}

class AdminView extends StatelessWidget {
  const AdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return const AdminPortalView();
  }
}

Widget _buildAccountSection(String title, String path, IconData icon, String description) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MasariCard(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MasariColors.primaryCyan.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: MasariColors.primaryCyanDark, size: 36),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: MasariTypography.titleLarge()),
                    const SizedBox(height: 4),
                    const MasariBadge(label: 'Active Route', backgroundColor: MasariColors.primaryBlueLight, textColor: MasariColors.pureWhite),
                    const SizedBox(height: 8),
                    Text(description, style: MasariTypography.bodyMedium(color: MasariColors.titaniumGray)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
