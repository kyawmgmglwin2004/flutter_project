
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

import 'package:ntt/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Valid ID -> navigate to ConsumptionPage with argument', (tester) async {
    // App boot
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final input = find.byType(TextFormField);
    final searchBtn = find.widgetWithText(ElevatedButton, '検索');

    expect(input, findsOneWidget);
    expect(searchBtn, findsOneWidget);

    await tester.enterText(input, '123456');
    await tester.tap(searchBtn);
    await tester.pump();

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('consumption_screen')), findsOneWidget);
    expect(find.textContaining('123456'), findsWidgets);//
  });
}
