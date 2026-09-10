import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/masari_localization.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final isTablet = screenWidth > 600 && screenWidth <= 900;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MasariLuxuryCard(
          badgeText: masariText(context, 'منصة مساري الموحدة', 'Unified MASARI Platform'),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(child: Text(masariText(context, 'أهلاً بك في ${AppConstants.appNameArabic}', 'Welcome to ${AppConstants.appName}'), style: isMobile ? MasariTypography.headlineSmall(color: MasariColors.primaryCyan) : MasariTypography.headlineMedium(color: MasariColors.primaryCyan), maxLines: 1, overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 8),
              const Icon(Icons.flight_takeoff, color: MasariColors.primaryCyan, size: 28),
            ]),
            const SizedBox(height: 8),
            Text(masariText(context, 'الأساس الهندسي والجاهزية الفنية المتكاملة لكافة قطاعات السفر، السياحة، والحج والعمرة.', 'A unified technical foundation for travel, tourism, Hajj, and Umrah services.'), style: MasariTypography.bodyMedium(color: MasariColors.pureWhite)),
            const SizedBox(height: 16),
            Wrap(spacing: 8, runSpacing: 8, children: const [
              MasariBadge(label: 'Riverpod', backgroundColor: MasariColors.primaryCyan, textColor: MasariColors.primaryBlueDark),
              MasariBadge(label: 'GoRouter', backgroundColor: MasariColors.primaryBlueLight, textColor: MasariColors.pureWhite),
              MasariBadge(label: 'Clean Architecture', backgroundColor: MasariColors.primaryCyanDark, textColor: MasariColors.pureWhite),
              MasariBadge(label: 'Tri-Color Brand System', backgroundColor: MasariColors.primaryOrange, textColor: MasariColors.pureWhite),
            ]),
          ]),
        ),
        const SizedBox(height: 24),
        const MasariSearchField(),
        const SizedBox(height: 24),
        MasariSectionHeader(title: masariText(context, 'قطاعات السفر والخدمات', 'Travel Sectors & Services'), subtitle: masariText(context, 'اختر الخدمة للتوجه إلى مسارها', 'Select a service to open its route')),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: screenWidth > 900 ? 4 : (isTablet ? 3 : 2),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: isMobile ? 12 : 16,
          mainAxisSpacing: isMobile ? 12 : 16,
          childAspectRatio: isMobile ? 1.02 : (isTablet ? 1.25 : 1.35),
          children: [
            _buildServiceCard(context, path: '/flights', title: masariText(context, 'رحلات الطيران', 'Flights'), subtitle: 'Flights Route', icon: Icons.flight_takeoff, color: MasariColors.primaryCyan),
            _buildServiceCard(context, path: '/hotels', title: masariText(context, 'الفنادق والإقامة', 'Hotels & Stays'), subtitle: 'Hotels Route', icon: Icons.hotel, color: MasariColors.primaryBlueLight),
            _buildServiceCard(context, path: '/bus', title: masariText(context, 'حجوزات الحافلات', 'Bus Bookings'), subtitle: 'Bus Route', icon: Icons.directions_bus, color: MasariColors.primaryOrange),
            _buildServiceCard(context, path: '/cars', title: masariText(context, 'تأجير السيارات', 'Car Rental'), subtitle: 'Cars Route', icon: Icons.directions_car, color: MasariColors.primaryCyanDark),
            _buildServiceCard(context, path: '/transfers', title: masariText(context, 'النقل الخاص', 'Private Transfers'), subtitle: 'Transfers Route', icon: Icons.local_taxi, color: MasariColors.info),
            _buildServiceCard(context, path: '/tourism', title: masariText(context, 'الباقات السياحية', 'Tour Packages'), subtitle: 'Tourism Route', icon: Icons.explore, color: MasariColors.primaryOrangeDark),
            _buildServiceCard(context, path: '/hajj', title: masariText(context, 'باقات الحج', 'Hajj Packages'), subtitle: 'Hajj Route', icon: Icons.mosque, color: MasariColors.primaryCyan),
            _buildServiceCard(context, path: '/umrah', title: masariText(context, 'خدمات العمرة', 'Umrah Services'), subtitle: 'Umrah Route', icon: Icons.night_shelter, color: MasariColors.primaryBlueLight),
          ],
        ),
        const SizedBox(height: 28),
        MasariSectionHeader(title: masariText(context, 'إدارة الحساب والمسافرين', 'Account & Traveler Center'), subtitle: masariText(context, 'المسارات المحمية والمحفظة الرقمية', 'Protected account routes and digital wallet')),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: screenWidth > 900 ? 3 : (isTablet ? 2 : 1),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: isMobile ? 12 : 16,
          mainAxisSpacing: isMobile ? 12 : 16,
          childAspectRatio: isMobile ? 3.6 : (isTablet ? 2.4 : 2.7),
          children: [
            _buildQuickRouteCard(context, path: '/wallet', title: masariText(context, 'محفظة مساري', 'MASARI Wallet'), subtitle: 'Wallet Route', icon: Icons.account_balance_wallet),
            _buildQuickRouteCard(context, path: '/bookings', title: masariText(context, 'سجل الحجوزات', 'Booking History'), subtitle: 'Bookings Route', icon: Icons.confirmation_number),
            _buildQuickRouteCard(context, path: '/travelers', title: masariText(context, 'إدارة المسافرين', 'Traveler Management'), subtitle: 'Travelers Route', icon: Icons.people),
            _buildQuickRouteCard(context, path: '/passports', title: masariText(context, 'مركز الجوازات', 'Passports Center'), subtitle: 'Passports Route', icon: Icons.contact_page),
            _buildQuickRouteCard(context, path: '/ai', title: masariText(context, 'مساعد مساري الذكي', 'MASARI AI Assistant'), subtitle: 'AI Assistant Route', icon: Icons.auto_awesome),
            _buildQuickRouteCard(context, path: '/admin', title: masariText(context, 'بوابة الإدارة', 'Admin Portal'), subtitle: 'Admin Portal Route', icon: Icons.admin_panel_settings),
          ],
        ),
      ]),
    );
  }

  Widget _buildServiceCard(BuildContext context, {required String path, required String title, required String subtitle, required IconData icon, required Color color}) => MasariCard(
        onTap: () => context.go(path),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle), child: Icon(icon, color: color, size: 24)),
          const SizedBox(height: 8),
          Flexible(child: Text(title, style: MasariTypography.titleSmall(), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis)),
          const SizedBox(height: 2),
          Flexible(child: Text(subtitle, style: MasariTypography.caption(color: MasariColors.titaniumGray, isArabic: false), maxLines: 1, overflow: TextOverflow.ellipsis)),
        ]),
      );

  Widget _buildQuickRouteCard(BuildContext context, {required String path, required String title, required String subtitle, required IconData icon}) => MasariCard(
        onTap: () => context.go(path),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: MasariColors.primaryCyan.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: MasariColors.primaryCyanDark, size: 20)),
          const SizedBox(width: 12),
          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(title, style: MasariTypography.titleSmall(), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(subtitle, style: MasariTypography.caption(color: MasariColors.titaniumGray, isArabic: false), maxLines: 1, overflow: TextOverflow.ellipsis),
          ])),
          const Icon(Icons.arrow_forward_ios, size: 14, color: MasariColors.titaniumGray),
        ]),
      );
}
