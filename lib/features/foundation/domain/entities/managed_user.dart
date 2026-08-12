import 'package:flutter/foundation.dart';
import '../../../../core/security/protected_route_guard.dart';

/// Managed User Entity for Admin User Management
@immutable
class ManagedUser {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String status; // 'نشط', 'موقوف'
  final DateTime createdAt;

  const ManagedUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.createdAt,
  });

  ManagedUser copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    String? status,
    DateTime? createdAt,
  }) {
    return ManagedUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
