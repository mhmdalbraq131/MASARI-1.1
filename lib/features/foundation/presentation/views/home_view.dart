import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';
import '../../../../shared/components/masari_chips_badges.dart';
import '../../../../shared/components/masari_section_header.dart';
import '../../../../shared/components/masari_text_fields.dart';
import '../providers/app_providers.dart';

/// MASARI Primary Platform Home Dashboard Foundation
class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final isArabic = currentLocale.languageCode == 'ar';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Banner
          MasariLuxuryCard(
            badgeText: 'منصة مساري الموحدة',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'أهلاً بك في ${AppConstants.appNameArabic}',
                      style: MasariTypography.headlineMedium(color: MasariColors.primaryCyan),
                    ),
                    const Icon(Icons.flight_takeoff, color: MasariColors.primaryCyan, size: 28),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'الأساس الهندسي والجاهزية الفنية المتكاملة لكافة قطاعات السفر، السياحة، والحج والعمرة.',
                  style: MasariTypography.bodyMedium(color: MasariColors.pureWhite),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    MasariBadge(label: 'Riverpod', backgroundColor: MasariColors.primaryCyan, textColor: MasariColors.primaryBlueDark),
                    MasariBadge(label: 'GoRouter', backgroundColor: MasariColors.primaryBlueLight, textColor: MasariColors.pureWhite),
                    MasariBadge(label: 'Clean Architecture', backgroundColor: MasariColors.primaryCyanDark, textColor: MasariColors.pureWhite),
                    MasariBadge(label: 'Tri-Color Brand System', backgroundColor: MasariColors.primaryOrange, textColor: MasariColors.pureWhite),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Search Field
          const MasariSearchField(),

          const SizedBox(height: 28),

          // Primary Travel Services Grid
          MasariSectionHeader(
            title: isArabic ? 'قطاعات السفر والخدمات' : 'Travel Sectors & Services',
            subtitle: isArabic ? 'اختر الخدمة للتوجه إلى معمارية التوجيه الخاصة بها' : 'Select a service route to inspect architecture',
          ),

          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : (MediaQuery.of(context).size.width > 600 ? 3 : 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
            children: [
              _buildServiceCard(context, path: '/flights', title: 'رحلات الطيران', subtitle: 'Flights Route', icon: Icons.flight_takeoff, color: MasariColors.primaryCyan),
              _buildServiceCard(context, path: '/hotels', title: 'الفنادق والإقامة', subtitle: 'Hotels Route', icon: Icons.hotel, color: MasariColors.primaryBlueLight),
              _buildServiceCard(context, path: '/bus', title: 'حجوزات الحافلات', subtitle: 'Bus Route', icon: Icons.directions_bus, color: MasariColors.primaryOrange),
              _buildServiceCard(context, path: '/cars', title: 'تأجير السيارات', subtitle: 'Cars Route', icon: Icons.directions_car, color: MasariColors.primaryCyanDark),
              _buildServiceCard(context, path: '/transfers', title: 'النقل الخاص', subtitle: 'Transfers Route', icon: Icons.local_taxi, color: MasariColors.info),
              _buildServiceCard(context, path: '/tourism', title: 'الباقات السياحية', subtitle: 'Tourism Route', icon: Icons.explore, color: MasariColors.primaryOrangeDark),
              _buildServiceCard(context, path: '/hajj', title: 'باقات الحج', subtitle: 'Hajj Route', icon: Icons.mosque, color: MasariColors.primaryCyan),
              _buildServiceCard(context, path: '/umrah', title: 'خدمات العمرة', subtitle: 'Umrah Route', icon: Icons.night_shelter, color: MasariColors.primaryBlueLight),
            ],
          ),

          const SizedBox(height: 32),

          // Management & Account Routes
          MasariSectionHeader(
            title: isArabic ? 'إدارة الحساب والمسافرين' : 'Account & Traveler Center',
            subtitle: isArabic ? 'بنية المسارات المحمية والمحفظة الرقمية' : 'Protected routes architecture',
          ),

          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.2,
            children: [
              _buildQuickRouteCard(context, path: '/wallet', title: 'محفظة مساري', subtitle: 'Wallet Route', icon: Icons.account_balance_wallet),
              _buildQuickRouteCard(context, path: '/bookings', title: 'سجل الحجوزات', subtitle: 'Bookings Route', icon: Icons.confirmation_number),
              _buildQuickRouteCard(context, path: '/travelers', title: 'إدارة المسافرين', subtitle: 'Travelers Route', icon: Icons.people),
              _buildQuickRouteCard(context, path: '/passports', title: 'مركز الجوازات', subtitle: 'Passports Route', icon: Icons.contact_page),
              _buildQuickRouteCard(context, path: '/ai', title: 'مساعد AI الذكي', subtitle: 'AI Assistant Route', icon: Icons.auto_awesome),
              _buildQuickRouteCard(context, path: '/admin', title: 'بوابة الإدارة', subtitle: 'Admin Portal Route', icon: Icons.admin_panel_settings),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String path,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return MasariCard(
      onTap: () => context.go(path),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 10),
          Text(title, style: MasariTypography.titleSmall(), textAlign: TextAlign.center),
          Text(subtitle, style: MasariTypography.caption(color: MasariColors.titaniumGray, isArabic: false)),
        ],
      ),
    );
  }

  Widget _buildQuickRouteCard(
    BuildContext context, {
    required String path,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return MasariCard(
      onTap: () => context.go(path),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MasariColors.primaryCyan.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(icon, color: MasariColors.primaryCyanDark, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: MasariTypography.titleSmall()),
                Text(subtitle, style: MasariTypography.caption(color: MasariColors.titaniumGray, isArabic: false)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
