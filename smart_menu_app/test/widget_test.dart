import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smart_menu_app/app/app.dart';

void main() {
  testWidgets('app starts with recipe list page', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: SmartMenuApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('我的配方'), findsOneWidget);
    expect(find.text('新建'), findsOneWidget);
  });
}
