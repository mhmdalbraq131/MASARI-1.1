import 'package:flutter/material.dart';
import '../../core/utils/responsive_layout.dart';
import 'masari_bottom_nav.dart';
import 'masari_sidebar.dart';
import 'masari_top_bar.dart';

/// Primary Master Shell Component for Multi-Platform Responsive Layout
class MasariAppShell extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const MasariAppShell({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      // Mobile Layout: Bottom Navigation + Main Content Area
      mobile: Scaffold(
        body: SafeArea(child: child),
        bottomNavigationBar: MasariBottomNav(currentPath: currentPath),
      ),
      // Tablet Layout: Compact Sidebar Navigation + Main Content
      tablet: Scaffold(
        body: Row(
          children: [
            MasariSidebar(currentPath: currentPath, isCollapsed: true),
            Expanded(child: child),
          ],
        ),
      ),
      // Desktop / Web Layout: Top Bar + Full Expanded Sidebar + Main View Area
      desktop: Scaffold(
        appBar: const MasariTopBar(),
        body: Row(
          children: [
            MasariSidebar(currentPath: currentPath, isCollapsed: false),
            Expanded(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
