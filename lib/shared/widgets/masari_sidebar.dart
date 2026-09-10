import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/security/protected_route_guard.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_typography.dart';
import '../../features/foundation/presentation/providers/app_providers.dart';
import 'masari_brand.dart';

/// MASARI navigation sidebar for desktop, Windows, Web and tablet layouts.
///
/// The navigation is intentionally compact and task-oriented. The list is
/// explicitly scrollable with a visible scrollbar so users can discover all
/// sections without relying on trial-and-error dragging.
class MasariSidebar extends ConsumerWidget {
  final String currentPath;
  final bool isCollapsed;

  const MasariSidebar({super.key, required this.currentPath, this.isCollapsed = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRole = ref.watch(userRoleProvider);
    final currentLocale = ref.watch(localeProvider);
    final isArabic = currentLocale.languageCode == 'ar';

    return Container(
      width: isCollapsed ? 76 : 276,
      decoration: BoxDecoration(
        color: MasariColors.primaryBlueDark,
        border: Border(right: BorderSide(color: MasariColors.brandTurquoise.withValues(alpha: 0.16))),
      ),
      child: Column(
        children: [
          _buildBrandHeader(context),
          Expanded(
            child: Scrollbar(
              thumbVisibility: !isCollapsed,
              trackVisibility: !isCollapsed,
              interactive: true,
              child: ListView(
                padding: EdgeInsets.fromLTRB(isCollapsed ? 8 : 12, 8, isCollapsed ? 8 : 12, 8),
                children: [
                  _buildSectionTitle(isArabic ? 'الرئيسية' : 'Main', isArabic),
                  _buildNavItem(context, path: '/home', label: isArabic ? 'الرئيسية' : 'Home', icon: Icons.home_outlined),
                  _buildNavItem(context, path: '/ai', label: isArabic ? 'مساعد مساري الذكي' : 'AI Travel Assistant', icon: Icons.auto_awesome_outlined, badge: 'AI'),

                  _buildSectionTitle(isArabic ? 'خدمات السفر' : 'Travel Services', isArabic),
                  _buildNavItem(context, path: '/flights', label: isArabic ? 'الطيران' : 'Flights', icon: Icons.flight_outlined),
                  _buildNavItem(context, path: '/hotels', label: isArabic ? 'الفنادق والإقامة' : 'Hotels & Stays', icon: Icons.hotel_outlined),
                  _buildNavItem(context, path: '/bus', label: isArabic ? 'الحافلات' : 'Bus Booking', icon: Icons.directions_bus_outlined),
                  _buildNavItem(context, path: '/cars', label: isArabic ? 'تأجير السيارات' : 'Car Rental', icon: Icons.directions_car_outlined),
                  _buildNavItem(context, path: '/transfers', label: isArabic ? 'النقل الخاص' : 'Private Transfers', icon: Icons.local_taxi_outlined),
                  _buildNavItem(context, path: '/tourism', label: isArabic ? 'الباقات السياحية' : 'Tourism Packages', icon: Icons.explore_outlined),

                  _buildSectionTitle(isArabic ? 'الحج والعمرة والتأشيرات' : 'Hajj, Umrah & Visas', isArabic),
                  _buildNavItem(context, path: '/hajj', label: isArabic ? 'الحج' : 'Hajj', icon: Icons.mosque_outlined, isSpecial: true),
                  _buildNavItem(context, path: '/umrah', label: isArabic ? 'العمرة' : 'Umrah', icon: Icons.night_shelter_outlined, isSpecial: true),
                  _buildNavItem(context, path: '/visa', label: isArabic ? 'التأشيرات' : 'Visa Services', icon: Icons.badge_outlined),

                  _buildSectionTitle(isArabic ? 'المسافر والحساب' : 'Traveler & Account', isArabic),
                  _buildNavItem(context, path: '/bookings', label: isArabic ? 'حجوزاتي' : 'My Bookings', icon: Icons.confirmation_number_outlined),
                  _buildNavItem(context, path: '/travelers', label: isArabic ? 'المسافرون' : 'Travelers', icon: Icons.people_outline),
                  _buildNavItem(context, path: '/passports', label: isArabic ? 'مركز الجوازات' : 'Passport Center', icon: Icons.contact_page_outlined),
                  _buildNavItem(context, path: '/wallet', label: isArabic ? 'محفظة مساري' : 'MASARI Wallet', icon: Icons.account_balance_wallet_outlined),

                  _buildSectionTitle(isArabic ? 'النظام' : 'System', isArabic),
                  _buildNavItem(context, path: '/notifications', label: isArabic ? 'الإشعارات' : 'Notifications', icon: Icons.notifications_none_outlined),
                  _buildNavItem(context, path: '/profile', label: isArabic ? 'الملف الشخصي' : 'Profile', icon: Icons.person_outline),
                  _buildNavItem(context, path: '/settings', label: isArabic ? 'الإعدادات' : 'Settings', icon: Icons.settings_outlined),

                  if (currentRole == UserRole.admin) ...[
                    _buildSectionTitle(isArabic ? 'الإدارة' : 'Administration', isArabic),
                    // One entry only: all service, hotel, room, user, audit and
                    // system controls live inside the admin workspace.
                    _buildNavItem(context, path: '/admin', label: isArabic ? 'مركز عمليات الإدارة' : 'Admin Operations Center', icon: Icons.admin_panel_settings_outlined, isAdmin: true),
                  ],
                ],
              ),
            ),
          ),
          if (!isCollapsed)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.unfold_more, color: MasariColors.titaniumLight, size: 15),
                  const SizedBox(width: 5),
                  Text(isArabic ? 'اسحب للتصفح' : 'Scroll to explore', style: MasariTypography.caption(color: MasariColors.titaniumLight, isArabic: isArabic)),
                ],
              ),
            ),
          _buildFooter(isArabic),
        ],
      ),
    );
  }

  Widget _buildBrandHeader(BuildContext context) {
    return Container(
      height: isCollapsed ? 74 : 96,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 8 : 16, vertical: 12),
      decoration: BoxDecoration(
        color: MasariColors.primaryBlueContainer,
        border: Border(bottom: BorderSide(color: MasariColors.brandTurquoise.withValues(alpha: 0.24))),
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: MasariBrand(compact: isCollapsed, onTap: () => context.go('/home')),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isArabic) {
    if (isCollapsed) {
      return Padding(
        padding: const EdgeInsets.only(top: 9, bottom: 3),
        child: Divider(color: MasariColors.brandTurquoise.withValues(alpha: 0.18), height: 1),
      );
    }
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10, end: 10, top: 12, bottom: 4),
      child: Row(
        children: [
          Container(width: 3, height: 13, decoration: BoxDecoration(color: MasariColors.brandOrange, borderRadius: BorderRadius.circular(4))),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: TextStyle(color: MasariColors.brandTurquoise.withValues(alpha: 0.88), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: isArabic ? 0 : 0.4))),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required String path, required String label, required IconData icon, bool isSpecial = false, bool isAdmin = false, String? badge}) {
    final isSelected = currentPath == path;
    final accent = isAdmin ? MasariColors.brandOrange : isSpecial ? MasariColors.brandTurquoise : MasariColors.brandBlue;
    final item = Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          onTap: () => context.go(path),
          borderRadius: BorderRadius.circular(9),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 10 : 11, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? accent.withValues(alpha: 0.16) : Colors.transparent,
              borderRadius: BorderRadius.circular(9),
              border: isSelected ? Border.all(color: accent.withValues(alpha: 0.32)) : null,
            ),
            child: Row(
              children: [
                if (isSelected && !isCollapsed)
                  Container(width: 3, height: 22, margin: const EdgeInsetsDirectional.only(end: 8), decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(3))),
                Expanded(
                  child: isCollapsed
                      ? Center(child: Icon(icon, size: 21, color: isSelected ? accent : MasariColors.titaniumLight))
                      : Row(
                          children: [
                            Icon(icon, size: 19, color: isSelected ? accent : isSpecial || isAdmin ? accent.withValues(alpha: 0.88) : MasariColors.titaniumLight),
                            const SizedBox(width: 10),
                            Expanded(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: isSelected ? MasariColors.pureWhite : isSpecial || isAdmin ? accent : MasariColors.titaniumLight, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, fontSize: 13))),
                            if (badge != null) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: MasariColors.brandOrange, borderRadius: BorderRadius.circular(8)), child: Text(badge, style: const TextStyle(color: MasariColors.pureWhite, fontSize: 9, fontWeight: FontWeight.w800))),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return isCollapsed ? Tooltip(message: label, child: item) : item;
  }

  Widget _buildFooter(bool isArabic) {
    return Container(
      padding: EdgeInsets.fromLTRB(isCollapsed ? 8 : 16, 8, isCollapsed ? 8 : 16, 10),
      decoration: BoxDecoration(color: MasariColors.primaryBlueContainer.withValues(alpha: 0.72), border: Border(top: BorderSide(color: MasariColors.brandTurquoise.withValues(alpha: 0.14)))),
      child: isCollapsed
          ? const Tooltip(message: 'منصة مساري الموثوقة', child: Center(child: Icon(Icons.verified_user_outlined, color: MasariColors.brandTurquoise, size: 20)))
          : Row(
              children: [
                Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: MasariColors.brandTurquoise.withValues(alpha: 0.12), shape: BoxShape.circle), child: const Icon(Icons.verified_user_outlined, color: MasariColors.brandTurquoise, size: 16)),
                const SizedBox(width: 9),
                Expanded(child: Text(isArabic ? 'منصة مساري الموثوقة' : 'MASARI Trusted Platform', maxLines: 1, overflow: TextOverflow.ellipsis, style: MasariTypography.caption(color: MasariColors.pureWhite, isArabic: isArabic))),
              ],
            ),
    );
  }
}
