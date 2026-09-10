import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/masari_localization.dart';
import '../../../../core/security/protected_route_guard.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_buttons.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_text_fields.dart';
import '../providers/app_providers.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _emailController = TextEditingController(text: 'traveler@masari.travel');
  final TextEditingController _passwordController = TextEditingController(text: '••••••••');
  @override
  void dispose() { _emailController.dispose(); _passwordController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(userSessionProvider);
    final isAdmin = session.role == UserRole.admin;
    return Scaffold(
      body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        child: MasariCard(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: MasariColors.primaryCyan.withValues(alpha: 0.15), shape: BoxShape.circle), child: const Icon(Icons.lock_outline, color: MasariColors.primaryCyan, size: 28)),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(masariText(context, 'تسجيل الدخول إلى منصة مساري', 'Sign in to MASARI'), style: MasariTypography.headlineSmall()),
              const SizedBox(height: 2),
              Text(masariText(context, 'مصادقة آمنة للمسافرين ومدراء النظام', 'Secure authentication for travelers and administrators'), style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
            ])),
          ]),
          const SizedBox(height: 24),
          if (session.isAuthenticated) Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: MasariColors.primaryBlueContainer, borderRadius: BorderRadius.circular(12), border: Border.all(color: MasariColors.primaryCyan)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [const Icon(Icons.check_circle, color: MasariColors.success, size: 20), const SizedBox(width: 8), Text(masariText(context, 'أنت مسجل الدخول حاليًا بحساب:', 'You are currently signed in as:'), style: MasariTypography.titleSmall(color: MasariColors.pureWhite))]),
              const SizedBox(height: 8),
              Text('${masariText(context, 'الاسم', 'Name')}: ${session.name}', style: MasariTypography.bodyMedium(color: MasariColors.primaryCyan)),
              Text('${masariText(context, 'البريد', 'Email')}: ${session.email}', style: MasariTypography.bodySmall(color: MasariColors.titaniumLight)),
              Text('${masariText(context, 'نوع الحساب', 'Account type')}: ${isAdmin ? masariText(context, 'مدير نظام', 'Administrator') : masariText(context, 'عميل مسافر', 'Traveler')}', style: MasariTypography.bodySmall(color: MasariColors.pureWhite)),
              const SizedBox(height: 16),
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                MasariPrimaryButton(label: isAdmin ? masariText(context, 'الانتقال إلى بوابة الإدارة', 'Go to Admin Portal') : masariText(context, 'الانتقال إلى الرئيسية', 'Go to Home'), onPressed: () => context.go(isAdmin ? '/admin' : '/home')),
                const SizedBox(height: 8),
                OutlinedButton(onPressed: () => ref.read(userSessionProvider.notifier).logout(), style: OutlinedButton.styleFrom(foregroundColor: MasariColors.primaryOrange, side: const BorderSide(color: MasariColors.primaryOrange), padding: const EdgeInsets.symmetric(vertical: 12)), child: Text(masariText(context, 'تسجيل الخروج', 'Sign out'))),
              ]),
            ]),
          ) else Column(children: [
            MasariTextField(label: masariText(context, 'البريد الإلكتروني أو رقم الهاتف', 'Email or phone number'), hintText: 'user@masari.travel', controller: _emailController),
            const SizedBox(height: 16),
            MasariPasswordField(controller: _passwordController),
            const SizedBox(height: 24),
            MasariPrimaryButton(label: masariText(context, 'تسجيل الدخول كعميل', 'Sign in as Traveler'), onPressed: () { ref.read(userSessionProvider.notifier).loginAsUser(name: 'أحمد العتيبي', email: _emailController.text); context.go('/home'); }),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: OutlinedButton.icon(
              onPressed: () { ref.read(userSessionProvider.notifier).loginAsAdmin(name: 'محمد البراق', email: 'mhmd.albraq@masari.travel'); context.go('/admin'); },
              icon: const Icon(Icons.admin_panel_settings, color: MasariColors.primaryCyan, size: 18),
              label: Text(masariText(context, 'تسجيل الدخول كمدير نظام', 'Sign in as Administrator'), style: const TextStyle(color: MasariColors.primaryCyan, fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: MasariColors.primaryCyan, width: 1.5), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            )),
            const SizedBox(height: 16),
            Center(child: TextButton(onPressed: () => context.go('/register'), child: Text(masariText(context, 'ليس لديك حساب؟ إنشاء حساب جديد', 'Do not have an account? Create one'), style: MasariTypography.titleSmall(color: MasariColors.primaryCyanDark)))),
          ]),
        ])),
      )),
    );
  }
}

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Container(
      constraints: const BoxConstraints(maxWidth: 480),
      child: MasariCard(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(masariText(context, 'إنشاء حساب جديد في مساري', 'Create a new MASARI account'), style: MasariTypography.headlineSmall()),
        const SizedBox(height: 4),
        Text(masariText(context, 'انضم إلى منصة مساري لخدمات الحج والعمرة والسفر الفاخر', 'Join MASARI for Hajj, Umrah, and luxury travel services'), style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
        const SizedBox(height: 20),
        MasariTextField(label: masariText(context, 'الاسم الكامل', 'Full name'), hintText: masariText(context, 'سارة الغامدي', 'Sara Alghamdi')),
        const SizedBox(height: 16),
        MasariTextField(label: masariText(context, 'البريد الإلكتروني', 'Email'), hintText: 'sara@masari.travel'),
        const SizedBox(height: 16),
        const MasariPasswordField(),
        const SizedBox(height: 24),
        MasariPrimaryButton(label: masariText(context, 'إنشاء الحساب والمتابعة', 'Create account & continue'), isOrangeCta: true, onPressed: () { ref.read(userSessionProvider.notifier).loginAsUser(name: 'سارة الغامدي', email: 'sara@masari.travel'); context.go('/otp'); }),
        const SizedBox(height: 12),
        Center(child: TextButton(onPressed: () => context.go('/login'), child: Text(masariText(context, 'لديك حساب بالفعل؟ تسجيل الدخول', 'Already have an account? Sign in'), style: MasariTypography.titleSmall(color: MasariColors.primaryCyanDark)))),
      ])),
    ))));
  }
}

class OtpView extends ConsumerWidget {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: Center(child: Container(
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(24),
      child: MasariCard(child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.mark_email_read_outlined, size: 48, color: MasariColors.primaryCyan),
        const SizedBox(height: 16),
        Text(masariText(context, 'رمز التحقق (OTP)', 'Verification code (OTP)'), style: MasariTypography.headlineSmall()),
        const SizedBox(height: 4),
        Text(masariText(context, 'تم إرسال رمز التوثيق إلى بريدك الإلكتروني', 'A verification code has been sent to your email'), style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: List.generate(4, (index) {
          return SizedBox(width: 50, height: 50, child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: MasariColors.primaryCyan, width: 2)),
            ),
          ));
        })),
        const SizedBox(height: 24),
        MasariPrimaryButton(label: masariText(context, 'تأكيد والدخول إلى الرئيسية', 'Verify & go to Home'), isOrangeCta: true, onPressed: () => context.go('/home')),
      ])),
    )));
  }
}
