import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/security/protected_route_guard.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_typography.dart';
import '../../features/foundation/presentation/providers/app_providers.dart';

/// Navigation Sidebar for Desktop / Windows / Web Application Shell
class MasariSidebar extends ConsumerWidget {
  final String currentPath;
  final bool isCollapsed;

  const MasariSidebar({
    super.key,
    required this.currentPath,
    this.isCollapsed = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRole = ref.watch(userRoleProvider);
    final currentLocale = ref.watch(localeProvider);
    final isArabic = currentLocale.languageCode == 'ar';

    return Container(
      width: isCollapsed ? 70 : 260,
      color: MasariColors.primaryBlueDark,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: isCollapsed ? 6 : 12),
              children: [
                _buildSectionTitle(isArabic ? 'الرئيسية والمساعد' : 'Main & AI', isArabic),
                _buildNavItem(context, path: '/home', label: isArabic ? 'الرئيسية' : 'Home', icon: Icons.home_outlined),
                _buildNavItem(context, path: '/ai', label: isArabic ? 'مساعد مساري الذكي' : 'AI Travel Assistant', icon: Icons.auto_awesome, badge: 'AI'),

                const Divider(color: MasariColors.primaryBlueContainer, height: 24),
                _buildSectionTitle(isArabic ? 'خدمات السفر' : 'Travel Services', isArabic),
                _buildNavItem(context, path: '/flights', label: isArabic ? 'الطيران' : 'Flights', icon: Icons.flight_outlined),
                _buildNavItem(context, path: '/hotels', label: isArabic ? 'الفنادق' : 'Hotels', icon: Icons.hotel_outlined),
                _buildNavItem(context, path: '/bus', label: isArabic ? 'الحافلات' : 'Bus Booking', icon: Icons.directions_bus_outlined),
                _buildNavItem(context, path: '/cars', label: isArabic ? 'تأجير السيارات' : 'Car Rental', icon: Icons.directions_car_outlined),
                _buildNavItem(context, path: '/transfers', label: isArabic ? 'النقل الخاص' : 'Private Transfers', icon: Icons.local_taxi_outlined),
                _buildNavItem(context, path: '/tourism', label: isArabic ? 'الباقات السياحية' : 'Tourism Packages', icon: Icons.explore_outlined),

                const Divider(color: MasariColors.primaryBlueContainer, height: 24),
                _buildSectionTitle(isArabic ? 'الحج والعمرة والـتأشيرات' : 'Hajj, Umrah & Visas', isArabic),
                _buildNavItem(context, path: '/hajj', label: isArabic ? 'الحج' : 'Hajj', icon: Icons.mosque, isSpecial: true),
                _buildNavItem(context, path: '/umrah', label: isArabic ? 'العمرة' : 'Umrah', icon: Icons.night_shelter, isSpecial: true),
                _buildNavItem(context, path: '/visa', label: isArabic ? 'تأشيرات السفر' : 'Visa Services', icon: Icons.badge_outlined),

                const Divider(color: MasariColors.primaryBlueContainer, height: 24),
                _buildSectionTitle(isArabic ? 'إدارة المسافر والحساب' : 'Account & Travel Center', isArabic),
                _buildNavItem(context, path: '/wallet', label: isArabic ? 'محفظة مساري' : 'Wallet', icon: Icons.account_balance_wallet_outlined),
                _buildNavItem(context, path: '/bookings', label: isArabic ? 'حجوزاتي' : 'My Bookings', icon: Icons.confirmation_number_outlined),
                _buildNavItem(context, path: '/travelers', label: isArabic ? 'إدارة المسافرين' : 'Travelers', icon: Icons.people_outline),
                _buildNavItem(context, path: '/passports', label: isArabic ? 'مركز الجوازات' : 'Passport Center', icon: Icons.contact_page_outlined),

                const Divider(color: MasariColors.primaryBlueContainer, height: 24),
                _buildSectionTitle(isArabic ? 'النظام والإعدادات' : 'System & Settings', isArabic),
                _buildNavItem(context, path: '/notifications', label: isArabic ? 'الإشعارات' : 'Notifications', icon: Icons.notifications_none),
                _buildNavItem(context, path: '/profile', label: isArabic ? 'الملف الشخصي' : 'Profile', icon: Icons.person_outline),
                _buildNavItem(context, path: '/settings', label: isArabic ? 'الإعدادات' : 'Settings', icon: Icons.settings_outlined),

                if (currentRole == UserRole.admin) ...[
                  const Divider(color: MasariColors.primaryBlueContainer, height: 24),
                  _buildSectionTitle(isArabic ? 'لوحة التحكم' : 'Admin Panel', isArabic),
                  _buildNavItem(context, path: '/admin', label: isArabic ? 'بوابة الإدارة' : 'Admin Portal', icon: Icons.admin_panel_settings, isSpecial: true),
                ],
              ],
            ),
          ),

          // Sidebar Footer Status
          Container(
            padding: const EdgeInsets.all(16),
            color: MasariColors.primaryBlueContainer.withValues(alpha: 0.5),
            child: isCollapsed
                ? const Center(
                    child: Icon(Icons.shield_outlined, color: MasariColors.primaryCyan, size: 20),
                  )
                : Row(
                    children: [
                      const Icon(Icons.shield_outlined, color: MasariColors.primaryCyan, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isArabic ? 'منصة مساري الموثوقة' : 'MASARI Verified Shell',
                          style: MasariTypography.caption(color: MasariColors.pureWhite, isArabic: isArabic),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isArabic) {
    if (isCollapsed) return const SizedBox(height: 8);
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          color: MasariColors.primaryCyan.withValues(alpha: 0.85),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String path,
    required String label,
    required IconData icon,
    bool isSpecial = false,
    String? badge,
  }) {
    final isSelected = currentPath == path;

    final navWidget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: isSelected ? MasariColors.primaryBlueLight.withValues(alpha: 0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => context.go(path),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 8 : 12, vertical: 10),
            child: isCollapsed
                ? Center(
                    child: Icon(
                      icon,
                      size: 22,
                      color: isSelected
                          ? MasariColors.primaryCyan
                          : isSpecial
                              ? MasariColors.primaryCyan
                              : MasariColors.titaniumLight,
                    ),
                  )
                : Row(
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: isSelected
                            ? MasariColors.primaryCyan
                            : isSpecial
                                ? MasariColors.primaryCyan
                                : MasariColors.titaniumLight,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            color: isSelected
                                ? MasariColors.pureWhite
                                : isSpecial
                                    ? MasariColors.primaryCyan
                                    : MasariColors.titaniumLight,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      if (badge != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: MasariColors.primaryOrange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            badge,
                            style: const TextStyle(color: MasariColors.pureWhite, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );

    if (isCollapsed) {
      return Tooltip(
        message: label,
        child: navWidget,
      );
    }
    return navWidget;
  }
}
