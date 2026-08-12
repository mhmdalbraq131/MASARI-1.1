import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masari/app/app.dart';

void main() {
  testWidgets('MASARI App Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MasariApp(),
      ),
    );
  });
}
