import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/security/protected_route_guard.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_typography.dart';
import '../../features/foundation/presentation/providers/app_providers.dart';
import '../components/masari_chips_badges.dart';

/// Top App Bar for Desktop / Windows / Web Responsive Shell
class MasariTopBar extends ConsumerWidget implements PreferredSizeWidget {
  const MasariTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final userSession = ref.watch(userSessionProvider);
    final currentRole = userSession.role;
    final isArabic = currentLocale.languageCode == 'ar';

    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: MasariColors.deepBlue,
        border: Border(bottom: BorderSide(color: MasariColors.royalGold, width: 1.5)),
      ),
      child: Row(
        children: [
          // Brand Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MasariColors.royalGold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.flight_takeoff, color: MasariColors.deepBlue, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.appNameArabic,
                    style: MasariTypography.titleLarge(color: MasariColors.royalGold, isArabic: true),
                  ),
                  Text(
                    AppConstants.appName,
                    style: MasariTypography.caption(color: MasariColors.pureWhite, isArabic: false),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(width: 40),

          // Search Bar
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: isArabic ? 'ابحث في وجهات مساري الفاخرة، الرحلات، الفنادق...' : 'Search luxury destinations, flights, hotels...',
                  hintStyle: MasariTypography.bodySmall(color: MasariColors.titaniumLight, isArabic: isArabic),
                  prefixIcon: const Icon(Icons.search, color: MasariColors.royalGold, size: 20),
                  fillColor: MasariColors.deepBlueLight,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: MasariColors.royalGold),
                  ),
                ),
                style: const TextStyle(color: MasariColors.pureWhite, fontSize: 13),
              ),
            ),
          ),

          const SizedBox(width: 24),

          // User Session State Indicator / Auth Controls
          if (!userSession.isAuthenticated) ...[
            OutlinedButton.icon(
              onPressed: () => context.go('/login'),
              icon: const Icon(Icons.login, size: 16, color: MasariColors.royalGold),
              label: Text(
                isArabic ? 'تسجيل الدخول' : 'Sign In',
                style: const TextStyle(color: MasariColors.royalGold, fontSize: 13, fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: MasariColors.royalGold, width: 1.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ] else ...[
            if (currentRole == UserRole.admin) ...[
              InkWell(
                onTap: () => context.go('/admin'),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: MasariColors.royalGold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: MasariColors.royalGold, width: 1.2),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.admin_panel_settings, color: MasariColors.royalGold, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        isArabic ? 'لوحة الإدارة' : 'Admin Portal',
                        style: MasariTypography.caption(color: MasariColors.royalGold, isArabic: isArabic),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: MasariColors.deepBlueLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: MasariColors.royalGold.withOpacity(0.5), width: 1),
              ),
              child: Row(
                children: [
                  Icon(
                    currentRole == UserRole.admin ? Icons.shield : Icons.verified_user,
                    color: MasariColors.royalGold,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${userSession.name} (${currentRole == UserRole.admin ? 'مسؤول' : 'مسافر'})',
                    style: MasariTypography.caption(color: MasariColors.pureWhite, isArabic: isArabic),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Logout Button
            IconButton(
              tooltip: isArabic ? 'تسجيل الخروج' : 'Logout',
              icon: const Icon(Icons.logout, color: MasariColors.coralOrange, size: 20),
              onPressed: () {
                ref.read(userSessionProvider.notifier).logout();
                context.go('/home');
              },
            ),
          ],

          const SizedBox(width: 16),

          // Language Switcher (RTL Arabic / LTR English)
          IconButton(
            tooltip: isArabic ? 'English' : 'العربية',
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: MasariColors.royalGold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: MasariColors.royalGold, width: 1),
              ),
              child: Text(
                isArabic ? 'EN' : 'عربي',
                style: const TextStyle(color: MasariColors.royalGold, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            onPressed: () {
              ref.read(localeProvider.notifier).toggleLanguage();
            },
          ),

          const SizedBox(width: 8),

          // Theme Toggle Button
          IconButton(
            tooltip: 'تغيير المظهر',
            icon: const Icon(Icons.brightness_6, color: MasariColors.royalGold),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
          ),

          const SizedBox(width: 8),

          // Notifications Button
          IconButton(
            tooltip: 'الإشعارات',
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none, color: MasariColors.pureWhite),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: MasariColors.coralOrange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () => context.go('/notifications'),
          ),

          const SizedBox(width: 16),

          // User Avatar & Profile Quick Access
          GestureDetector(
            onTap: () => context.go('/profile'),
            child: const MasariAvatar(initials: 'م', radius: 18),
          ),
        ],
      ),
    );
  }
}
