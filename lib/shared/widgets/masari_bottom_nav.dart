import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/masari_colors.dart';
import '../../features/foundation/presentation/providers/app_providers.dart';

/// Mobile Bottom Navigation Bar for MASARI Application Shell
class MasariBottomNav extends ConsumerWidget {
  final String currentPath;

  const MasariBottomNav({
    super.key,
    required this.currentPath,
  });

  int _getSelectedIndex() {
    if (currentPath == '/home') return 0;
    if (currentPath == '/flights' || currentPath == '/hotels' || currentPath == '/tourism') return 1;
    if (currentPath == '/hajj' || currentPath == '/umrah') return 2;
    if (currentPath == '/ai') return 3;
    if (currentPath == '/profile') return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final isArabic = currentLocale.languageCode == 'ar';

    return Container(
      decoration: const BoxDecoration(
        color: MasariColors.deepBlue,
        border: Border(top: BorderSide(color: MasariColors.royalGold, width: 1.5)),
      ),
      child: BottomNavigationBar(
        currentIndex: _getSelectedIndex(),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/tourism');
              break;
            case 2:
              context.go('/hajj');
              break;
            case 3:
              context.go('/ai');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: MasariColors.deepBlue,
        selectedItemColor: MasariColors.royalGold,
        unselectedItemColor: MasariColors.titaniumLight,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home, color: MasariColors.royalGold),
            label: isArabic ? 'الرئيسية' : 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined),
            activeIcon: const Icon(Icons.explore, color: MasariColors.royalGold),
            label: isArabic ? 'الخدمات' : 'Services',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.mosque_outlined),
            activeIcon: const Icon(Icons.mosque, color: MasariColors.royalGold),
            label: isArabic ? 'الحج والعمرة' : 'Hajj/Umrah',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.auto_awesome_outlined),
            activeIcon: const Icon(Icons.auto_awesome, color: MasariColors.royalGold),
            label: isArabic ? 'مساعد AI' : 'AI Assistant',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person, color: MasariColors.royalGold),
            label: isArabic ? 'حسابي' : 'Profile',
          ),
        ],
      ),
    );
  }
}
