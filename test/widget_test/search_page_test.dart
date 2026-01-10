import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ntt/feature/Facility/facility_index.dart';

void main() {

  testWidgets('Searchpage UI test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Searchpage(),
      ),
    );

    expect(find.text('施設ID'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('検索'), findsOneWidget);
  });

  testWidgets('Validation test - input not 6 characters',
          (WidgetTester tester) async {

        await tester.pumpWidget(
          const MaterialApp(
            home: Searchpage(),
          ),
        );

        final textField = find.byType(TextFormField);

        await tester.enterText(textField, '1234');
        await tester.tap(find.text('検索'));
        await tester.pump();

        final textFormField = tester.widget<TextFormField>(textField);
        expect(textFormField.controller!.text.length, isNot(6));
      });

  testWidgets('Validation test - input exactly 6 characters',
          (WidgetTester tester) async {

        await tester.pumpWidget(
          const MaterialApp(
            home: Searchpage(),
          ),
        );

        final textField = find.byType(TextFormField);

        await tester.enterText(textField, '123456');
        await tester.tap(find.text('検索'));
        await tester.pump();

        expect(find.byType(TextFormField), findsOneWidget);
      });
}
