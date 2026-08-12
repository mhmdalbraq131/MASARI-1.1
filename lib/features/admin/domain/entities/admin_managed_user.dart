import 'package:flutter/foundation.dart';
import '../../../../core/security/protected_route_guard.dart';

/// Managed User Entity for Admin User Operations
@immutable
class AdminManagedUser {
  final String id;
  final String name;
  final String email;
  final UserRole role; // guest, user, admin
  final String roleTitle; // 'مستخدم عادي', 'مدير نظام', 'مدير عام'
  final DateTime createdAt;
  final bool isActive;

  const AdminManagedUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.roleTitle,
    required this.createdAt,
    this.isActive = true,
  });

  AdminManagedUser copyWith({
    String? name,
    String? email,
    UserRole? role,
    String? roleTitle,
    bool? isActive,
  }) {
    return AdminManagedUser(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      roleTitle: roleTitle ?? this.roleTitle,
      createdAt: createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
