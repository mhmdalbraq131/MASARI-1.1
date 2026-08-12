import 'package:flutter/material.dart';
import '../theme/masari_spacing.dart';

/// Device Screen Type Categories
enum DeviceType { mobile, tablet, desktop }

/// Responsive Layout Utilities for MASARI Multiplatform Engine.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static DeviceType getDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < MasariSpacing.mobileMaxBreakpoint) {
      return DeviceType.mobile;
    } else if (width <= MasariSpacing.tabletMaxBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  static bool isMobile(BuildContext context) => getDeviceType(context) == DeviceType.mobile;
  static bool isTablet(BuildContext context) => getDeviceType(context) == DeviceType.tablet;
  static bool isDesktop(BuildContext context) => getDeviceType(context) == DeviceType.desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= MasariSpacing.desktopMinBreakpoint) {
          return desktop;
        } else if (constraints.maxWidth >= MasariSpacing.mobileMaxBreakpoint && tablet != null) {
          return tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}
