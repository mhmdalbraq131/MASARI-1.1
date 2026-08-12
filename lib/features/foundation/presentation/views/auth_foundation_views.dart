import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/security/protected_route_guard.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_buttons.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_text_fields.dart';
import '../providers/app_providers.dart';

/// Foundation Login View Architecture
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _emailController = TextEditingController(text: 'traveler@masari.travel');
  final TextEditingController _passwordController = TextEditingController(text: '••••••••');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(userSessionProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            child: MasariCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: MasariColors.royalGold.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.lock_outline, color: MasariColors.royalGold, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('تسجيل الدخول إلى منصة مساري', style: MasariTypography.headlineSmall()),
                            const SizedBox(height: 2),
                            Text('مصادقة آمنة للمسافرين ومدراء النظام', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  if (session.isAuthenticated) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MasariColors.deepBlueLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: MasariColors.royalGold),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_circle, color: MasariColors.success, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'أنت مسجل الدخول حالياً بحساب:',
                                style: MasariTypography.titleSmall(color: MasariColors.pureWhite),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('الاسم: ${session.name}', style: MasariTypography.bodyMedium(color: MasariColors.royalGold)),
                          Text('البريد: ${session.email}', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
                          Text('نوع الحساب: ${session.role == UserRole.admin ? "مدير نظام (Admin)" : "عميل مسافر (User)"}',
                              style: MasariTypography.bodySmall(color: MasariColors.pureWhite)),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: MasariPrimaryButton(
                                  label: session.role == UserRole.admin ? 'الانتقال لبوابة الإدارة (/admin)' : 'الانتقال للرئيسية (/home)',
                                  onPressed: () {
                                    if (session.role == UserRole.admin) {
                                      context.go('/admin');
                                    } else {
                                      context.go('/home');
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              OutlinedButton(
                                onPressed: () {
                                  ref.read(userSessionProvider.notifier).logout();
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: MasariColors.coralOrange,
                                  side: const BorderSide(color: MasariColors.coralOrange),
                                ),
                                child: const Text('تسجيل الخروج'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    MasariTextField(
                      label: 'البريد الإلكتروني أو رقم الهاتف',
                      hintText: 'user@masari.travel',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),
                    const MasariPasswordField(),
                    const SizedBox(height: 24),

                    // Standard Login Action
                    MasariPrimaryButton(
                      label: 'تسجيل الدخول كعميل (Traveler)',
                      onPressed: () {
                        ref.read(userSessionProvider.notifier).loginAsUser(
                              name: 'أحمد العتيبي',
                              email: _emailController.text,
                            );
                        context.go('/home');
                      },
                    ),

                    const SizedBox(height: 12),

                    // Admin Quick Login Action
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ref.read(userSessionProvider.notifier).loginAsAdmin(
                                name: 'محمد البراق',
                                email: 'mhmd.albraq@masari.travel',
                              );
                          context.go('/admin');
                        },
                        icon: const Icon(Icons.admin_panel_settings, color: MasariColors.royalGold, size: 18),
                        label: const Text(
                          'تسجيل الدخول كمدير نظام (Admin Portal)',
                          style: TextStyle(color: MasariColors.royalGold, fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: MasariColors.royalGold, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () => context.go('/register'),
                        child: Text(
                          'ليس لديك حساب؟ إنشاء حساب جديد (/register)',
                          style: MasariTypography.titleSmall(color: MasariColors.royalGoldDark),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Foundation Register View Architecture
class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            child: MasariCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('إنشاء حساب جديد في مساري', style: MasariTypography.headlineSmall()),
                  const SizedBox(height: 4),
                  Text('انضم إلى منصة مساري الفاخرة لخدمات الحج والعمرة والسفر', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
                  const SizedBox(height: 20),
                  const MasariTextField(label: 'الاسم الكامل', hintText: 'سارة الغامدي'),
                  const SizedBox(height: 16),
                  const MasariTextField(label: 'البريد الإلكتروني', hintText: 'sara@masari.travel'),
                  const SizedBox(height: 16),
                  const MasariPasswordField(),
                  const SizedBox(height: 24),
                  MasariPrimaryButton(
                    label: 'إنشاء الحساب والمتابعة',
                    onPressed: () {
                      ref.read(userSessionProvider.notifier).loginAsUser(
                            name: 'سارة الغامدي',
                            email: 'sara@masari.travel',
                          );
                      context.go('/otp');
                    },
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () => context.go('/login'),
                      child: Text('لديك حساب بالفعل؟ تسجيل الدخول (/login)', style: MasariTypography.titleSmall(color: MasariColors.royalGoldDark)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Foundation OTP Verification View Architecture
class OtpView extends ConsumerWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.all(24),
          child: MasariCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.mark_email_read_outlined, size: 48, color: MasariColors.royalGold),
                const SizedBox(height: 16),
                Text('رمز التحقق (OTP)', style: MasariTypography.headlineSmall()),
                const SizedBox(height: 4),
                Text('تم إرسال رمز التوثيق إلى بريدك الإلكتروني', style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      width: 50,
                      height: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                MasariPrimaryButton(
                  label: 'تأكيد ودخول الرئيسية (/home)',
                  isGoldStyle: true,
                  onPressed: () => context.go('/home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
