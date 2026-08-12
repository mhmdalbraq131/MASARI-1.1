import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/security/protected_route_guard.dart';
import '../../data/repositories/foundation_repository_impl.dart';
import '../../domain/entities/audit_record.dart';
import '../../domain/entities/managed_user.dart';
import '../../domain/entities/platform_service.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/repositories/foundation_repository.dart';

/// Repository Provider
final foundationRepositoryProvider = Provider<FoundationRepository>((ref) {
  return FoundationRepositoryImpl();
});

/// Locale / Language Provider ('ar' default for Arabic-first)
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('ar'));

  void setLocale(Locale newLocale) {
    state = newLocale;
  }

  void toggleLanguage() {
    if (state.languageCode == 'ar') {
      state = const Locale('en');
    } else {
      state = const Locale('ar');
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

/// Theme Mode Provider (Light / Dark - Defaulting to Elegant Dark)
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark);

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

/// Authenticated User Session Provider
class UserSessionNotifier extends StateNotifier<UserSession> {
  final Ref ref;

  UserSessionNotifier(this.ref) : super(UserSession.guest());

  void loginAsCustomer({String name = 'أحمد العتيبي', String email = 'traveler@masari.travel'}) {
    final session = UserSession.customer(name: name, email: email);
    state = session;
    ref.read(userRoleProvider.notifier).setRole(UserRole.user);
  }

  void loginAsUser({String name = 'أحمد العتيبي', required String email}) {
    loginAsCustomer(name: name, email: email);
  }

  void loginAsAdmin({String name = 'محمد البراق', String email = 'mhmd.albraq@masari.travel'}) {
    final session = UserSession.admin(name: name, email: email);
    state = session;
    ref.read(userRoleProvider.notifier).setRole(UserRole.admin);
  }

  void logout() {
    state = UserSession.guest();
    ref.read(userRoleProvider.notifier).setRole(UserRole.guest);
  }
}

final userSessionProvider = StateNotifierProvider<UserSessionNotifier, UserSession>((ref) {
  return UserSessionNotifier(ref);
});

/// User Role Provider (Reflects current session role)
class UserRoleNotifier extends StateNotifier<UserRole> {
  UserRoleNotifier() : super(UserRole.guest);

  void setRole(UserRole role) {
    state = role;
  }
}

final userRoleProvider = StateNotifierProvider<UserRoleNotifier, UserRole>((ref) {
  return UserRoleNotifier();
});

/// Immutable Audit Log State Notifier
class AuditLogNotifier extends StateNotifier<List<AuditRecord>> {
  AuditLogNotifier()
      : super([
          AuditRecord(
            id: 'audit_101',
            adminName: 'محمد البراق',
            adminEmail: 'mhmd.albraq@masari.travel',
            action: 'تعديل سعر',
            entity: 'خدمة العمرة الفاخرة',
            field: 'السعر',
            previousValue: '550 SAR',
            newValue: '500 SAR',
            timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
            summary: 'قام المستخدم محمد البراق بتعديل سعر العمرة من 550 إلى 500',
          ),
          AuditRecord(
            id: 'audit_102',
            adminName: 'محمد البراق',
            adminEmail: 'mhmd.albraq@masari.travel',
            action: 'إنشاء مستخدم',
            entity: 'إدارة المستخدمين',
            field: 'حساب جديد',
            previousValue: 'غير موجود',
            newValue: 'عبدالله الشمري (مشرف)',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            summary: 'قام المستخدم محمد البراق بإنشاء حساب مدير نظام جديد للعميل عبدالله الشمري',
          ),
          AuditRecord(
            id: 'audit_103',
            adminName: 'محمد البراق',
            adminEmail: 'mhmd.albraq@masari.travel',
            action: 'تعديل حالة',
            entity: 'رحلة الرياض - جدة',
            field: 'الحالة التشغيلية',
            previousValue: 'قيد الانتظار',
            newValue: 'نشط',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
            summary: 'قام المستخدم محمد البراق بتغيير حالة رحلة الرياض - جدة من قيد الانتظار إلى نشط',
          ),
        ]);

  void addAuditRecord({
    required String adminName,
    required String adminEmail,
    required String action,
    required String entity,
    required String field,
    required String previousValue,
    required String newValue,
    required String summary,
  }) {
    final record = AuditRecord(
      id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
      adminName: adminName,
      adminEmail: adminEmail,
      action: action,
      entity: entity,
      field: field,
      previousValue: previousValue,
      newValue: newValue,
      timestamp: DateTime.now(),
      summary: summary,
    );
    // Prepend to maintain reverse chronological order (newest first)
    state = [record, ...state];
  }
}

final auditLogProvider = StateNotifierProvider<AuditLogNotifier, List<AuditRecord>>((ref) {
  return AuditLogNotifier();
});

/// Platform Services Management State Notifier
class PlatformServicesNotifier extends StateNotifier<List<PlatformService>> {
  final Ref ref;

  PlatformServicesNotifier(this.ref)
      : super([
          const PlatformService(
            id: 'srv_umrah_01',
            category: 'عمرة',
            name: 'باقة العمرة الفاخرة VIP',
            description: 'إقامة فاخرة بجوار الحرم الشريف مع مواصلات خاصة وإرشاد ديني مخصص.',
            price: 500,
            currency: 'SAR',
            status: 'نشط',
            imageUrl: 'https://images.unsplash.com/photo-1591604466107-ec97de577aff?w=500',
            metadata: {'مدة الإقامة': '7 أيام', 'الفندق': 'برج الساعة مكة'},
          ),
          const PlatformService(
            id: 'srv_hajj_01',
            category: 'حج',
            name: 'باقة الحج الميسر الملكي',
            description: 'مخيمات مكيفة ومجهزة بالكامل في مشعر منى وعرفات مع رعاية صحية.',
            price: 12000,
            currency: 'SAR',
            status: 'نشط',
            imageUrl: 'https://images.unsplash.com/photo-1565552645632-d725f8bfc19a?w=500',
            metadata: {'التصنيف': 'سوبر ديلوكس', 'الخدمة': 'شاملة بالكامل'},
          ),
          const PlatformService(
            id: 'srv_flight_01',
            category: 'طيران',
            name: 'رحلة جدة - الرياض (الخطوط السعودية)',
            description: 'درجة رجال الأعمال مع ضيافة فاخرة ومرونة كاملة في التغيير.',
            price: 350,
            currency: 'SAR',
            status: 'نشط',
            imageUrl: 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=500',
            metadata: {'الناقل': 'Saudia', 'الدرجة': 'Business'},
          ),
          const PlatformService(
            id: 'srv_hotel_01',
            category: 'فنادق',
            name: 'فندق دار التوحيد إنتركونتيننتال مكة',
            description: 'إطلالة مباشرة على صحن المطاف مع مطاعم عالمية وخدمة خادم شخصي.',
            price: 850,
            currency: 'SAR',
            status: 'نشط',
            imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500',
            metadata: {'الإطلالة': 'مباشرة على الكعبة', 'التقييم': '5 نجوم'},
          ),
          const PlatformService(
            id: 'srv_bus_01',
            category: 'حافلات',
            name: 'حافلات سابتكو VIP (المدينة - مكة)',
            description: 'حافلات فاخرة مزودة بإنترنت عالي السرعة ومقاعد مريحة مساج.',
            price: 120,
            currency: 'SAR',
            status: 'نشط',
            imageUrl: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=500',
            metadata: {'الخدمة': 'سريعة مباشرة', 'الميزات': 'WiFi + مقاعد جلد'},
          ),
          const PlatformService(
            id: 'srv_car_01',
            category: 'سيارات',
            name: 'خدمة استقبال مطار الملك عبدالعزيز (لكزس VIP)',
            description: 'سيارات فارهة مع سائق خاص يتحدث عدة لغات بانتظارك بالمطار.',
            price: 450,
            currency: 'SAR',
            status: 'نشط',
            imageUrl: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=500',
            metadata: {'السيارة': 'Lexus ES 2025', 'السائق': 'محترف مخصص'},
          ),
        ]);

  void updateServicePrice({
    required String serviceId,
    required double newPrice,
    required UserSession adminSession,
  }) {
    state = state.map((service) {
      if (service.id == serviceId) {
        final previousPriceFormatted = '${service.price.toInt()} ${service.currency}';
        final newPriceFormatted = '${newPrice.toInt()} ${service.currency}';
        final updated = service.copyWith(price: newPrice);

        // Record immutable Audit Log
        ref.read(auditLogProvider.notifier).addAuditRecord(
              adminName: adminSession.name,
              adminEmail: adminSession.email,
              action: 'تعديل سعر',
              entity: service.name,
              field: 'السعر',
              previousValue: previousPriceFormatted,
              newValue: newPriceFormatted,
              summary: 'قام المستخدم ${adminSession.name} بتعديل سعر ${service.name} من ${service.price.toInt()} إلى ${newPrice.toInt()}',
            );

        return updated;
      }
      return service;
    }).toList();
  }

  void updateServiceStatus({
    required String serviceId,
    required String newStatus,
    required UserSession adminSession,
  }) {
    state = state.map((service) {
      if (service.id == serviceId) {
        final previousStatus = service.status;
        final updated = service.copyWith(status: newStatus);

        // Record immutable Audit Log
        ref.read(auditLogProvider.notifier).addAuditRecord(
              adminName: adminSession.name,
              adminEmail: adminSession.email,
              action: 'تعديل حالة',
              entity: service.name,
              field: 'الحالة',
              previousValue: previousStatus,
              newValue: newStatus,
              summary: 'قام المستخدم ${adminSession.name} بتعديل حالة ${service.name} من $previousStatus إلى $newStatus',
            );

        return updated;
      }
      return service;
    }).toList();
  }

  void updateServiceDetails({
    required String serviceId,
    required String newName,
    required String newDescription,
    required double newPrice,
    required UserSession adminSession,
  }) {
    state = state.map((service) {
      if (service.id == serviceId) {
        final oldName = service.name;
        final oldPrice = service.price;
        final updated = service.copyWith(
          name: newName,
          description: newDescription,
          price: newPrice,
        );

        ref.read(auditLogProvider.notifier).addAuditRecord(
              adminName: adminSession.name,
              adminEmail: adminSession.email,
              action: 'تعديل بيانات الخدمة',
              entity: oldName,
              field: 'الاسم والسعر والوصف',
              previousValue: '$oldName (${oldPrice.toInt()} SAR)',
              newValue: '$newName (${newPrice.toInt()} SAR)',
              summary: 'قام المستخدم ${adminSession.name} بتعديل تفاصيل الخدمة ($newName)',
            );

        return updated;
      }
      return service;
    }).toList();
  }
}

final platformServicesProvider = StateNotifierProvider<PlatformServicesNotifier, List<PlatformService>>((ref) {
  return PlatformServicesNotifier(ref);
});

/// Managed Users State Notifier for Admin User Management
class ManagedUsersNotifier extends StateNotifier<List<ManagedUser>> {
  final Ref ref;

  ManagedUsersNotifier(this.ref)
      : super([
          ManagedUser(
            id: 'usr_001',
            name: 'أحمد العتيبي',
            email: 'traveler@masari.travel',
            role: UserRole.user,
            status: 'نشط',
            createdAt: DateTime.now().subtract(const Duration(days: 30)),
          ),
          ManagedUser(
            id: 'usr_002',
            name: 'سارة الغامدي',
            email: 'sara@masari.travel',
            role: UserRole.user,
            status: 'نشط',
            createdAt: DateTime.now().subtract(const Duration(days: 14)),
          ),
          ManagedUser(
            id: 'adm_001',
            name: 'محمد البراق',
            email: 'mhmd.albraq@masari.travel',
            role: UserRole.admin,
            status: 'نشط',
            createdAt: DateTime.now().subtract(const Duration(days: 90)),
          ),
          ManagedUser(
            id: 'adm_002',
            name: 'عبدالله الشمري',
            email: 'abdullah@masari.travel',
            role: UserRole.admin,
            status: 'نشط',
            createdAt: DateTime.now().subtract(const Duration(days: 2)),
          ),
        ]);

  void createUser({
    required String name,
    required String email,
    required UserRole role,
    required UserSession adminSession,
  }) {
    final newUser = ManagedUser(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
      name: name,
      email: email,
      role: role,
      status: 'نشط',
      createdAt: DateTime.now(),
    );

    state = [...state, newUser];

    final roleLabel = role == UserRole.admin ? 'مدير نظام' : 'عميل مسافر';

    // Record immutable Audit Log
    ref.read(auditLogProvider.notifier).addAuditRecord(
          adminName: adminSession.name,
          adminEmail: adminSession.email,
          action: 'إنشاء مستخدم جديد',
          entity: 'إدارة المستخدمين',
          field: 'حساب جديد',
          previousValue: 'غير موجود',
          newValue: '$name ($email - $roleLabel)',
          summary: 'قام المستخدم ${adminSession.name} بإنشاء حساب $roleLabel جديد باسم ($name)',
        );
  }

  void updateUserStatus({
    required String userId,
    required String newStatus,
    required UserSession adminSession,
  }) {
    state = state.map((user) {
      if (user.id == userId) {
        final oldStatus = user.status;
        final updated = user.copyWith(status: newStatus);

        ref.read(auditLogProvider.notifier).addAuditRecord(
              adminName: adminSession.name,
              adminEmail: adminSession.email,
              action: 'تعديل حالة مستخدم',
              entity: user.name,
              field: 'حالة الحساب',
              previousValue: oldStatus,
              newValue: newStatus,
              summary: 'قام المستخدم ${adminSession.name} بتعديل حالة حساب ${user.name} إلى $newStatus',
            );

        return updated;
      }
      return user;
    }).toList();
  }
}

final managedUsersProvider = StateNotifierProvider<ManagedUsersNotifier, List<ManagedUser>>((ref) {
  return ManagedUsersNotifier(ref);
});
