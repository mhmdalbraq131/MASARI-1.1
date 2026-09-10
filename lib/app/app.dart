import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_constants.dart';
import '../core/security/protected_route_guard.dart';
import '../core/theme/masari_theme.dart';
import '../features/foundation/presentation/providers/app_providers.dart';
import '../features/foundation/presentation/providers/platform_services_persistence_provider.dart';
import '../shared/widgets/app_lock.dart';
import 'app_router.dart';

/// MASARI Platform Master Root App Widget.
///
/// The router is intentionally created once. Recreating GoRouter every time
/// the role/theme/locale changes can reset the navigation tree and cause
/// transient or misplaced routed pages.
class MasariApp extends ConsumerStatefulWidget {
  const MasariApp({super.key});

  @override
  ConsumerState<MasariApp> createState() => _MasariAppState();
}

class _MasariAppState extends ConsumerState<MasariApp> {
  late final ValueNotifier<UserRole> _roleListenable;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _roleListenable = ValueNotifier<UserRole>(UserRole.guest);
    _router = AppRouter.createRouter(roleListenable: _roleListenable);
    ref.listenManual<UserRole>(userRoleProvider, (previous, next) {
      if (_roleListenable.value != next) _roleListenable.value = next;
    });
  }

  @override
  void dispose() {
    _router.dispose();
    _roleListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(platformServicesPersistenceSyncProvider);

    final currentLocale = ref.watch(localeProvider);
    final currentThemeMode = ref.watch(themeModeProvider);
    final currentRole = ref.watch(userRoleProvider);
    final isArabic = currentLocale.languageCode == 'ar';

    if (_roleListenable.value != currentRole) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _roleListenable.value != currentRole) {
          _roleListenable.value = currentRole;
        }
      });
    }

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      locale: currentLocale,
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: MasariTheme.lightTheme(isArabic: isArabic),
      darkTheme: MasariTheme.darkTheme(isArabic: isArabic),
      themeMode: currentThemeMode,
      builder: (context, child) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: AppLockGate(child: child ?? const SizedBox.shrink()),
        );
      },
    );
  }
}
