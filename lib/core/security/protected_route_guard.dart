import 'package:flutter/foundation.dart';

/// User Role Classification for MASARI Role-Aware Architecture
enum UserRole {
  guest,
  user,
  admin,
}

/// Protected Route Guard Architecture.
/// Evaluates user session and role permissions before allowing route transitions.
class ProtectedRouteGuard {
  final UserRole currentRole;

  ProtectedRouteGuard({required this.currentRole});

  /// Evaluates whether a route can be accessed by the current user role.
  bool canAccessRoute(String routePath) {
    if (routePath.startsWith('/admin')) {
      final allowed = currentRole == UserRole.admin;
      debugPrint('[ProtectedRouteGuard] Route: $routePath | Role: $currentRole | Access Allowed: $allowed');
      return allowed;
    }

    if (routePath == '/wallet' || routePath == '/passports' || routePath == '/travelers') {
      final allowed = currentRole == UserRole.user || currentRole == UserRole.admin;
      debugPrint('[ProtectedRouteGuard] Route: $routePath | Role: $currentRole | Access Allowed: $allowed');
      return allowed;
    }

    // Public / Guest accessible routes
    return true;
  }
}
