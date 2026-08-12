import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/security/protected_route_guard.dart';
import '../features/foundation/presentation/views/account_management_views.dart';
import '../features/foundation/presentation/views/auth_foundation_views.dart';
import '../features/foundation/presentation/views/home_view.dart';
import '../features/foundation/presentation/views/onboarding_view.dart';
import '../features/foundation/presentation/views/spiritual_services_views.dart';
import '../features/foundation/presentation/views/splash_view.dart';
import '../features/foundation/presentation/views/travel_services_views.dart';
import '../shared/widgets/masari_app_shell.dart';

/// Centralized GoRouter Navigation Architecture for MASARI Platform
class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter({UserRole userRole = UserRole.guest}) {
    final guard = ProtectedRouteGuard(currentRole: userRole);

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/splash',
      redirect: (context, state) {
        final path = state.matchedLocation;
        if (!guard.canAccessRoute(path)) {
          // If access denied to protected route, redirect to /home
          return '/home';
        }
        return null;
      },
      routes: [
        // Standalone Auth & Entry Routes
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingView(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterView(),
        ),
        GoRoute(
          path: '/otp',
          builder: (context, state) => const OtpView(),
        ),

        // Shell-Wrapped Main Application Routes
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return MasariAppShell(
              currentPath: state.matchedLocation,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeView(),
            ),
            GoRoute(
              path: '/flights',
              builder: (context, state) => const FlightsView(),
            ),
            GoRoute(
              path: '/hotels',
              builder: (context, state) => const HotelsView(),
            ),
            GoRoute(
              path: '/bus',
              builder: (context, state) => const BusView(),
            ),
            GoRoute(
              path: '/cars',
              builder: (context, state) => const CarsView(),
            ),
            GoRoute(
              path: '/transfers',
              builder: (context, state) => const TransfersView(),
            ),
            GoRoute(
              path: '/tourism',
              builder: (context, state) => const TourismView(),
            ),
            GoRoute(
              path: '/visa',
              builder: (context, state) => const VisaView(),
            ),
            GoRoute(
              path: '/hajj',
              builder: (context, state) => const HajjView(),
            ),
            GoRoute(
              path: '/umrah',
              builder: (context, state) => const UmrahView(),
            ),
            GoRoute(
              path: '/wallet',
              builder: (context, state) => const WalletView(),
            ),
            GoRoute(
              path: '/bookings',
              builder: (context, state) => const BookingsView(),
            ),
            GoRoute(
              path: '/travelers',
              builder: (context, state) => const TravelersView(),
            ),
            GoRoute(
              path: '/passports',
              builder: (context, state) => const PassportsView(),
            ),
            GoRoute(
              path: '/notifications',
              builder: (context, state) => const NotificationsView(),
            ),
            GoRoute(
              path: '/ai',
              builder: (context, state) => const AiAssistantView(),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileView(),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsView(),
            ),
            GoRoute(
              path: '/admin',
              builder: (context, state) => const AdminView(),
            ),
          ],
        ),
      ],
    );
  }
}
