import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masari/app/app.dart';

void main() {
  testWidgets('MASARI App Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MasariApp(),
      ),
    );

    // Allow the splash screen's delayed navigation to complete before
    // Flutter verifies that no timers remain pending.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
