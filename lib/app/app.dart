import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/masari_theme.dart';
import '../features/foundation/presentation/providers/app_providers.dart';
import 'app_router.dart';

/// MASARI Platform Master Root App Widget
class MasariApp extends ConsumerWidget {
  const MasariApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final currentThemeMode = ref.watch(themeModeProvider);
    final currentRole = ref.watch(userRoleProvider);
    final isArabic = currentLocale.languageCode == 'ar';

    final router = AppRouter.createRouter(userRole: currentRole);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: currentLocale,
      supportedLocales: const [
        Locale('ar', ''),
        Locale('en', ''),
      ],
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
          child: child!,
        );
      },
    );
  }
}
