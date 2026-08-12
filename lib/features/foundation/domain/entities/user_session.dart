import '../../../../core/security/protected_route_guard.dart';

/// User Session Domain Entity
class UserSession {
  final String userId;
  final String name;
  final String email;
  final UserRole role;
  final bool isAuthenticated;

  const UserSession({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.isAuthenticated,
  });

  factory UserSession.guest() {
    return const UserSession(
      userId: 'guest_001',
      name: 'زائر مساري',
      email: 'guest@masari.travel',
      role: UserRole.guest,
      isAuthenticated: false,
    );
  }

  factory UserSession.customer({required String name, required String email}) {
    return UserSession(
      userId: 'usr_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      name: name.isNotEmpty ? name : 'أحمد العتيبي',
      email: email.isNotEmpty ? email : 'traveler@masari.travel',
      role: UserRole.user,
      isAuthenticated: true,
    );
  }

  factory UserSession.admin({required String name, required String email}) {
    return UserSession(
      userId: 'adm_001',
      name: name.isNotEmpty ? name : 'محمد البراق',
      email: email.isNotEmpty ? email : 'mhmd.albraq@masari.travel',
      role: UserRole.admin,
      isAuthenticated: true,
    );
  }
}
