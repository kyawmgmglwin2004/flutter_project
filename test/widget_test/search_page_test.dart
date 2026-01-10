import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ntt/feature/Facility/facility_index.dart';

void main() {
  testWidgets('Searchpage UI and Validation test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Searchpage(),
      )
    );

    expect(find.text('施設ID'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('検索'), findsOneWidget);

    await tester.tap(find.text('検索'));
    await tester.pump();
  });
}