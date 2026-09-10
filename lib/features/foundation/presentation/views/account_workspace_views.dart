import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/masari_localization.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../bookings/presentation/booking_provider.dart';
import '../providers/app_providers.dart';

class BookingsWorkspaceView extends ConsumerWidget {
  const BookingsWorkspaceView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingProvider);
    return _page(
      context,
      masariText(context, 'حجوزاتي وتذاكري', 'My Bookings & Tickets'),
      Icons.confirmation_number_outlined,
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(masariText(context, 'طلبات الحجز الخاصة بك', 'Your booking requests'), style: MasariTypography.headlineSmall()),
        const SizedBox(height: 12),
        if (bookings.isEmpty)
          MasariCard(child: Padding(padding: const EdgeInsets.all(24), child: Center(child: Text(masariText(context, 'لا توجد حجوزات بعد. اختر أي خدمة واضغط «احجز الآن» لبدء طلب جديد.', 'No bookings yet. Choose any service and tap “Book now” to start a new request.')))))
        else
          ...bookings.map((booking) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MasariCard(
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long, color: MasariColors.primaryCyan),
                    title: Text(booking.serviceName),
                    subtitle: Text('${booking.category} • ${booking.customerName} • ${booking.createdAt.toString().substring(0, 16)}'),
                    trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('${booking.price.toStringAsFixed(0)} ${booking.currency}'),
                      Text(booking.status, style: const TextStyle(color: MasariColors.primaryOrange)),
                    ]),
                  ),
                ),
              )),
      ]),
    );
  }
}

class TravelersWorkspaceView extends StatefulWidget {
  const TravelersWorkspaceView({super.key});
  @override
  State<TravelersWorkspaceView> createState() => _TravelersWorkspaceViewState();
}

class _TravelersWorkspaceViewState extends State<TravelersWorkspaceView> {
  final List<String> _travelers = ['المسافر الرئيسي'];
  final _name = TextEditingController();
  @override
  void dispose() { _name.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => _page(
        context,
        masariText(context, 'إدارة المسافرين', 'Traveler Management'),
        Icons.people_outline,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MasariCard(child: Row(children: [
            Expanded(child: TextField(controller: _name, decoration: InputDecoration(labelText: masariText(context, 'اسم مسافر جديد', 'New traveler name'), hintText: masariText(context, 'مثال: أحمد محمد', 'Example: Ahmed Mohamed')))),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: () { if (_name.text.trim().isEmpty) return; setState(() { _travelers.add(_name.text.trim()); _name.clear(); }); }, child: Text(masariText(context, 'إضافة', 'Add'))),
          ])),
          const SizedBox(height: 12),
          ..._travelers.map((name) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: MasariCard(child: ListTile(leading: const Icon(Icons.person, color: MasariColors.primaryCyan), title: Text(name), trailing: IconButton(onPressed: () { if (_travelers.length > 1) setState(() => _travelers.remove(name)); }, icon: const Icon(Icons.delete_outline)))),
              )),
        ]),
      );
}

class WalletWorkspaceView extends StatefulWidget {
  const WalletWorkspaceView({super.key});
  @override
  State<WalletWorkspaceView> createState() => _WalletWorkspaceViewState();
}
class _WalletWorkspaceViewState extends State<WalletWorkspaceView> {
  double _balance = 0;
  @override
  Widget build(BuildContext context) => _page(context, masariText(context, 'محفظة مساري', 'MASARI Wallet'), Icons.account_balance_wallet_outlined, Column(children: [
        MasariCard(child: Column(children: [Text(masariText(context, 'الرصيد الحالي', 'Current balance'), style: MasariTypography.bodyMedium()), const SizedBox(height: 8), Text('${_balance.toStringAsFixed(2)} SAR', style: MasariTypography.headlineSmall(color: MasariColors.primaryCyan)), const SizedBox(height: 16), ElevatedButton.icon(onPressed: () => setState(() => _balance += 500), icon: const Icon(Icons.add), label: Text(masariText(context, 'إضافة 500 SAR للتجربة', 'Add SAR 500 for testing')))])),
        const SizedBox(height: 12),
        MasariCard(child: ListTile(leading: const Icon(Icons.info_outline, color: MasariColors.primaryOrange), title: Text(masariText(context, 'المحفظة جاهزة لربط بوابة الدفع', 'Wallet ready for payment gateway integration')), subtitle: Text(masariText(context, 'حركات الرصيد الحقيقية تحتاج مزود دفع وخدمة مالية خلفية.', 'Real balance transactions require a payment provider and a backend financial service.')))),
      ]));
}

class PassportsWorkspaceView extends StatelessWidget {
  const PassportsWorkspaceView({super.key});
  @override
  Widget build(BuildContext context) => _page(context, masariText(context, 'مركز الجوازات والوثائق', 'Passports & Documents Center'), Icons.contact_page_outlined, Column(children: [
        MasariCard(child: ListTile(leading: const Icon(Icons.upload_file, color: MasariColors.primaryCyan), title: Text(masariText(context, 'وثائق السفر', 'Travel documents')), subtitle: Text(masariText(context, 'مساحة مخصصة لرفع صورة الجواز أو الوثيقة وإكمال ملف المسافر.', 'A dedicated area for uploading a passport or document and completing the traveler profile.')))),
        const SizedBox(height: 10),
        MasariCard(child: ListTile(leading: const Icon(Icons.verified_outlined, color: MasariColors.success), title: Text(masariText(context, 'حالة التحقق', 'Verification status')), subtitle: Text(masariText(context, 'لا توجد وثائق مرفوعة حاليًا.', 'No documents have been uploaded yet.')))),
      ]));
}

class NotificationsWorkspaceView extends StatelessWidget {
  const NotificationsWorkspaceView({super.key});
  @override
  Widget build(BuildContext context) => _page(context, masariText(context, 'مركز الإشعارات', 'Notifications Center'), Icons.notifications_none_outlined, Column(children: [
        MasariCard(child: ListTile(leading: const Icon(Icons.notifications_active, color: MasariColors.primaryCyan), title: Text(masariText(context, 'لا توجد إشعارات جديدة', 'No new notifications')), subtitle: Text(masariText(context, 'ستظهر هنا تحديثات الحجوزات وتغييرات الرحلات وحالات الطلبات.', 'Booking updates, flight changes, and request statuses will appear here.')))),
        const SizedBox(height: 10),
        MasariCard(child: SwitchListTile(title: Text(masariText(context, 'إشعارات الحجوزات', 'Booking notifications')), subtitle: Text(masariText(context, 'السماح بالتنبيهات المتعلقة بالحجوزات.', 'Allow booking-related notifications.')), value: true, onChanged: (_) {})),
      ]));
}

class AiWorkspaceView extends StatelessWidget {
  const AiWorkspaceView({super.key});
  @override
  Widget build(BuildContext context) => _page(context, masariText(context, 'مساعد مساري الذكي', 'MASARI AI Assistant'), Icons.auto_awesome, Column(children: [
        MasariCard(child: Text(masariText(context, 'أهلاً بك في مساعد مساري. اسأل عن الرحلات أو الفنادق أو برامج الحج والعمرة.', 'Welcome to the MASARI assistant. Ask about flights, hotels, Hajj, or Umrah programs.'))),
        const SizedBox(height: 10),
        MasariCard(child: TextField(maxLines: 3, decoration: InputDecoration(hintText: masariText(context, 'اكتب طلبك هنا...', 'Type your request here...'), suffixIcon: const Icon(Icons.send)))),
      ]));
}

class ProfileWorkspaceView extends ConsumerWidget {
  const ProfileWorkspaceView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(userSessionProvider);
    return _page(context, masariText(context, 'الملف الشخصي', 'Profile'), Icons.person_outline, Column(children: [
      MasariCard(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: Text(session.name), subtitle: Text(session.email))),
      const SizedBox(height: 10),
      MasariCard(child: ListTile(leading: const Icon(Icons.security, color: MasariColors.primaryCyan), title: Text(masariText(context, 'حالة الحساب', 'Account status')), subtitle: Text(masariText(context, 'الحساب يعمل ضمن صلاحيات الجلسة الحالية.', 'The account is operating under the permissions of the current session.')))),
    ]));
  }
}

class SettingsWorkspaceView extends ConsumerWidget {
  const SettingsWorkspaceView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final theme = ref.watch(themeModeProvider);
    return _page(context, masariText(context, 'إعدادات التطبيق', 'App Settings'), Icons.settings_outlined, Column(children: [
      MasariCard(child: Column(children: [
        ListTile(title: Text(masariText(context, 'اللغة', 'Language')), subtitle: Text(locale.languageCode == 'ar' ? 'العربية' : 'English'), trailing: ElevatedButton(onPressed: () => ref.read(localeProvider.notifier).toggleLanguage(), child: Text(masariText(context, 'تبديل', 'Switch')))),
        const Divider(),
        ListTile(title: Text(masariText(context, 'المظهر', 'Appearance')), subtitle: Text(theme == ThemeMode.dark ? masariText(context, 'داكن', 'Dark') : masariText(context, 'فاتح', 'Light')), trailing: ElevatedButton(onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(), child: Text(masariText(context, 'تبديل', 'Switch'))),
      ])),
      const SizedBox(height: 10),
      MasariCard(child: ListTile(leading: const Icon(Icons.privacy_tip_outlined), title: Text(masariText(context, 'الخصوصية والأمان', 'Privacy & Security')), subtitle: Text(masariText(context, 'إدارة الجلسة والوثائق والتنبيهات من الأقسام المخصصة.', 'Manage the session, documents, and notifications from their dedicated sections.')))),
    ]));
  }
}

Widget _page(BuildContext context, String title, IconData icon, Widget child) => SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MasariLuxuryCard(badgeText: 'MASARI', child: Row(children: [
          Container(padding: const EdgeInsets.all(14), decoration: const BoxDecoration(color: MasariColors.primaryCyan, shape: BoxShape.circle), child: Icon(icon, color: MasariColors.primaryBlueDark)),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: MasariTypography.headlineSmall(color: Colors.white))),
        ])),
        const SizedBox(height: 20),
        child,
      ]),
    );
