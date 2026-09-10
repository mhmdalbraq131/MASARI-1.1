import 'package:flutter/material.dart';
import 'masari_bottom_nav.dart';
import 'masari_floating_ai_button.dart';
import 'masari_sidebar.dart';
import 'masari_top_bar.dart';

/// Primary Master Shell Component for Multi-Platform Responsive Layout.
///
/// Builds only the layout branch that is currently needed. This is important
/// because the routed [child] is a live widget subtree and must never be
/// pre-mounted in multiple responsive branches at the same time.
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
    const aiButton = MasariFloatingAiButton();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Mobile: bottom navigation + main content.
        if (width < 600) {
          return Scaffold(
            body: SafeArea(child: child),
            bottomNavigationBar: MasariBottomNav(currentPath: currentPath),
            floatingActionButton: aiButton,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }

        // Tablet: compact sidebar + main content.
        if (width <= 1100) {
          return Scaffold(
            body: Row(
              children: [
                MasariSidebar(currentPath: currentPath, isCollapsed: true),
                Expanded(child: child),
              ],
            ),
            floatingActionButton: aiButton,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }

        // Desktop/Web: top bar + full sidebar + main content.
        return Scaffold(
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
          floatingActionButton: aiButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
