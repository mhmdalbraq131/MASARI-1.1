import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../core/security/protected_route_guard.dart';
import '../features/admin/presentation/views/admin_operations_view.dart';
import '../features/admin/presentation/views/admin_settings_view.dart';
import '../features/foundation/presentation/views/account_workspace_views.dart';
import '../features/foundation/presentation/views/auth_foundation_views.dart';
import '../features/foundation/presentation/views/home_view.dart';
import '../features/foundation/presentation/views/onboarding_view.dart';
import '../features/foundation/presentation/views/spiritual_services_views.dart';
import '../features/foundation/presentation/views/splash_view.dart';
import '../features/foundation/presentation/views/travel_services_views.dart';
import '../features/payments/presentation/realistic_payment_view.dart';
import '../shared/widgets/masari_app_shell.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter({
    ValueListenable<UserRole>? roleListenable,
    UserRole userRole = UserRole.guest,
  }) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/splash',
      refreshListenable: roleListenable,
      redirect: (context, state) {
        final role = roleListenable?.value ?? userRole;
        final guard = ProtectedRouteGuard(currentRole: role);
        return guard.canAccessRoute(state.matchedLocation) ? null : '/home';
      },
      routes: [
        GoRoute(path: '/splash', builder: (context, state) => const SplashView()),
        GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingView()),
        GoRoute(path: '/login', builder: (context, state) => const LoginView()),
        GoRoute(path: '/register', builder: (context, state) => const RegisterView()),
        GoRoute(path: '/otp', builder: (context, state) => const OtpView()),
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) => MasariAppShell(currentPath: state.matchedLocation, child: child),
          routes: [
            GoRoute(path: '/home', builder: (context, state) => const HomeView()),
            GoRoute(path: '/flights', builder: (context, state) => const FlightsView()),
            GoRoute(path: '/hotels', builder: (context, state) => const HotelsView()),
            GoRoute(path: '/bus', builder: (context, state) => const BusView()),
            GoRoute(path: '/cars', builder: (context, state) => const CarsView()),
            GoRoute(path: '/transfers', builder: (context, state) => const TransfersView()),
            GoRoute(path: '/tourism', builder: (context, state) => const TourismView()),
            GoRoute(path: '/visa', builder: (context, state) => const VisaView()),
            GoRoute(path: '/hajj', builder: (context, state) => const HajjView()),
            GoRoute(path: '/umrah', builder: (context, state) => const UmrahView()),
            GoRoute(path: '/wallet', builder: (context, state) => const RealisticPaymentView()),
            GoRoute(path: '/bookings', builder: (context, state) => const BookingsWorkspaceView()),
            GoRoute(path: '/travelers', builder: (context, state) => const TravelersWorkspaceView()),
            GoRoute(path: '/passports', builder: (context, state) => const PassportsWorkspaceView()),
            GoRoute(path: '/notifications', builder: (context, state) => const NotificationsWorkspaceView()),
            GoRoute(path: '/ai', builder: (context, state) => const AiWorkspaceView()),
            GoRoute(path: '/profile', builder: (context, state) => const ProfileWorkspaceView()),
            GoRoute(path: '/settings', builder: (context, state) => const SettingsWorkspaceView()),
            GoRoute(path: '/admin', builder: (context, state) => const AdminOperationsView()),
            GoRoute(path: '/admin/settings', builder: (context, state) => const AdminSettingsView()),
          ],
        ),
      ],
    );
  }
}
