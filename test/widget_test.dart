import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:feast/main.dart';

void main() {
  testWidgets('App smoke test — FeastApp boots inside ProviderScope',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FeastApp()));
    // SplashScreen renders while auth state loads — just confirm no crash.
    expect(find.text('FEAST'), findsOneWidget);
  });
}
