import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/security/protected_route_guard.dart';
import '../../core/theme/masari_colors.dart';
import '../../features/foundation/presentation/providers/app_providers.dart';
import 'masari_brand.dart';

/// Top Bar for MASARI Desktop / Web / Mobile Platforms
class MasariTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;

  const MasariTopBar({super.key, this.onMenuPressed});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRole = ref.watch(userRoleProvider);
    final userSession = ref.watch(userSessionProvider);
    final currentLocale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final isArabic = currentLocale.languageCode == 'ar';
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: MasariColors.primaryBlueDark,
        border: Border(bottom: BorderSide(color: MasariColors.brandTurquoise, width: 1.5)),
      ),
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: MasariColors.brandTurquoise),
              onPressed: onMenuPressed,
            ),
          MasariBrand(compact: isMobile, onTap: () => context.go('/home')),
          const SizedBox(width: 24),
          if (!isMobile)
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                height: 38,
                child: TextField(
                  style: const TextStyle(color: MasariColors.pureWhite, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: isArabic ? 'البحث عن رحلات، فنادق، برامج عمرة...' : 'Search flights, hotels, Umrah packages...',
                    hintStyle: const TextStyle(color: MasariColors.titaniumLight, fontSize: 12),
                    prefixIcon: const Icon(Icons.search, color: MasariColors.brandTurquoise, size: 18),
                    filled: true,
                    fillColor: MasariColors.primaryBlueContainer,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: MasariColors.brandTurquoise, width: 0.5)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: MasariColors.brandTurquoise.withValues(alpha: 0.3), width: 0.5)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: MasariColors.brandTurquoise, width: 1.5)),
                  ),
                ),
              ),
            ),
          if (isMobile) const Spacer(),
          const SizedBox(width: 16),
          if (currentRole == UserRole.admin && !isMobile)
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: OutlinedButton.icon(
                onPressed: () => context.go('/admin'),
                icon: const Icon(Icons.admin_panel_settings_outlined, color: MasariColors.brandOrange, size: 16),
                label: Text(isArabic ? 'بوابة الإدارة' : 'Admin Portal', style: const TextStyle(color: MasariColors.brandOrange, fontSize: 12, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: MasariColors.brandOrange), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), backgroundColor: MasariColors.brandOrange.withValues(alpha: 0.1)),
              ),
            ),
          IconButton(
            icon: Icon(themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode, color: MasariColors.brandTurquoise, size: 20),
            tooltip: isArabic ? 'تغيير المظهر' : 'Toggle Theme',
            onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.language, color: MasariColors.brandTurquoise, size: 20),
            tooltip: isArabic ? 'Change Language' : 'تغيير اللغة',
            onPressed: () => ref.read(localeProvider.notifier).toggleLocale(),
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none, color: MasariColors.pureWhite, size: 22),
                Positioned(right: 0, top: 0, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: MasariColors.brandOrange, shape: BoxShape.circle), constraints: const BoxConstraints(minWidth: 8, minHeight: 8))),
              ],
            ),
            onPressed: () => context.go('/notifications'),
          ),
          const SizedBox(width: 8),
          if (userSession.isAuthenticated)
            PopupMenuButton<String>(
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: MasariColors.brandTurquoise)),
              color: MasariColors.primaryBlueDark,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: MasariColors.brandTurquoise,
                    child: Text(userSession.name.isNotEmpty ? userSession.name[0] : 'U', style: const TextStyle(color: MasariColors.primaryBlueDark, fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                  if (!isMobile) ...[
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userSession.name, style: const TextStyle(color: MasariColors.pureWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(userSession.role == UserRole.admin ? 'مدير نظام' : 'مسافر معتمد', style: const TextStyle(color: MasariColors.brandTurquoise, fontSize: 10)),
                      ],
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: MasariColors.brandTurquoise, size: 16),
                  ],
                ],
              ),
              onSelected: (value) {
                switch (value) {
                  case 'profile': context.go('/profile');
                    break;
                  case 'admin': context.go('/admin');
                    break;
                  case 'logout':
                    ref.read(userSessionProvider.notifier).logout();
                    context.go('/login');
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'profile', child: Row(children: [const Icon(Icons.person_outline, color: MasariColors.brandTurquoise, size: 18), const SizedBox(width: 8), Text(isArabic ? 'الملف الشخصي' : 'Profile', style: const TextStyle(color: MasariColors.pureWhite))])),
                if (userSession.role == UserRole.admin)
                  PopupMenuItem(value: 'admin', child: Row(children: [const Icon(Icons.admin_panel_settings_outlined, color: MasariColors.brandOrange, size: 18), const SizedBox(width: 8), Text(isArabic ? 'بوابة الإدارة' : 'Admin Portal', style: const TextStyle(color: MasariColors.brandOrange))])),
                const PopupMenuDivider(height: 1),
                PopupMenuItem(value: 'logout', child: Row(children: [const Icon(Icons.logout, color: MasariColors.brandOrange, size: 18), const SizedBox(width: 8), Text(isArabic ? 'تسجيل الخروج' : 'Logout', style: const TextStyle(color: MasariColors.brandOrange))])),
              ],
            )
          else
            OutlinedButton(
              onPressed: () => context.go('/login'),
              style: OutlinedButton.styleFrom(foregroundColor: MasariColors.brandTurquoise, side: const BorderSide(color: MasariColors.brandTurquoise), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8)),
              child: Text(isArabic ? 'تسجيل الدخول' : 'Login'),
            ),
        ],
      ),
    );
  }
}
