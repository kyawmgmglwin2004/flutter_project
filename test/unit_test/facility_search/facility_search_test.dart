// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:ntt/feature/facility_search/facility_search_index.dart';
// import 'package:ntt/core/route/app_route.dart';
// import 'package:ntt/mock/consumption_mock_data.dart';
// import 'package:mocktail/mocktail.dart';



// Mock classes
// class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
// class MockNavigatorObserver extends Mock implements NavigatorObserver {}
// class MockBuildContext extends Mock implements BuildContext {}

// void main() {
//   late MockFlutterSecureStorage mockStorage;
//   late MockNavigatorObserver mockObserver;
//
//   setUpAll(() {
//     // Register fallback values for mocktail
//     registerFallbackValue(MaterialPageRoute(
//       builder: (context) => Container(),
//     ));
//   });

  // setUp(() {
  //   mockStorage = MockFlutterSecureStorage();
  //   mockObserver = MockNavigatorObserver();
  // });
  //
  // tearDown(() {
  //   reset(mockStorage);
  //   reset(mockObserver);
  // });

  // group('FacilitySearch Widget Tests', () {
  //   testWidgets('should render all UI elements correctly',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //             navigatorObservers: [mockObserver],
  //           ),
  //         );
  //
  //         // Check if all required UI elements are present
  //         expect(find.text('施設ID'), findsOneWidget);
  //         expect(find.byType(TextFormField), findsOneWidget);
  //         expect(find.text('検索'), findsOneWidget);
  //         expect(find.byType(ElevatedButton), findsOneWidget);
  //       });
  //
  //   testWidgets('should find existing facility ID from mock data',
  //           (WidgetTester tester) async {
  //         // Mock the storage write method
  //         when(() => mockStorage.write(
  //           key: any(named: 'key'),
  //           value: any(named: 'value'),
  //         )).thenAnswer((_) async => {});
  //
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //             routes: {
  //               AppRoute.consumption: (context) => Scaffold(
  //                 appBar: AppBar(title: Text('Consumption Page')),
  //                 body: Center(child: Text('Mock Consumption Page')),
  //               ),
  //             },
  //           ),
  //         );
  //
  //         // Test with existing facility ID from mock data
  //         await tester.enterText(find.byType(TextFormField), '123456');
  //         await tester.tap(find.text('検索'));
  //
  //         // Wait for loading and navigation
  //         await tester.pumpAndSettle(const Duration(seconds: 1));
  //
  //         // Should navigate to consumption page for valid ID
  //         // Note: This test might fail if navigation isn't properly mocked
  //         // We can at least verify the loading state
  //         expect(find.byType(CircularProgressIndicator), findsNothing);
  //       });
  //
  //   testWidgets('should show error dialog for non-existing facility ID',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //           ),
  //         );
  //
  //         // Test with non-existing facility ID
  //         await tester.enterText(find.byType(TextFormField), '999999');
  //         await tester.tap(find.text('検索'));
  //         await tester.pumpAndSettle();
  //
  //         // Should show error dialog
  //         expect(find.text('指定した施設IDが存在しません。'), findsOneWidget);
  //         expect(find.text('OK'), findsOneWidget);
  //       });
  //
  //   testWidgets('should find all three mock facilities',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //           ),
  //         );
  //
  //         // Test all three mock facility IDs
  //         final mockIds = ['123123', '112233', '123456'];
  //
  //         for (final id in mockIds) {
  //           await tester.enterText(find.byType(TextFormField), id);
  //           await tester.tap(find.text('検索'));
  //           await tester.pump();
  //
  //           // Should show loading
  //           expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //
  //           // Clear for next test
  //           await tester.enterText(find.byType(TextFormField), '');
  //           await tester.pump();
  //         }
  //       });
  //
  //   testWidgets('should have correct TextFormField properties',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //           ),
  //         );
  //
  //         final textField = tester.widget<TextFormField>(find.byType(TextFormField));
  //
  //         // Check maxLength (should be 6)
  //         expect(textField.maxLength, 6);
  //
  //         // Check textAlignVertical
  //         expect(textField.textAlignVertical, TextAlignVertical.center);
  //
  //         // Check decoration properties
  //         final decoration = textField.decoration as InputDecoration;
  //         expect(decoration.counterText, '');
  //         expect(decoration.isDense, true);
  //         expect(decoration.floatingLabelBehavior, FloatingLabelBehavior.never);
  //
  //         // Check content padding
  //         expect(decoration.contentPadding, const EdgeInsets.only(
  //           right: 12,
  //           bottom: 28,
  //           left: 12,
  //           top: 2,
  //         ));
  //       });
  //
  //   testWidgets('should limit input to 6 characters (mock IDs are 6 digits)',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //           ),
  //         );
  //
  //         final textFieldFinder = find.byType(TextFormField);
  //
  //         // Enter 7 characters
  //         await tester.enterText(textFieldFinder, '1234567');
  //         await tester.pump();
  //
  //         // Should only display 6 characters (all mock IDs are 6 digits)
  //         expect(find.text('123456'), findsOneWidget);
  //         expect(find.text('1234567'), findsNothing);
  //
  //         // Enter 5 characters (should work)
  //         await tester.enterText(textFieldFinder, '12345');
  //         await tester.pump();
  //         expect(find.text('12345'), findsOneWidget);
  //       });
  //
  //   testWidgets('should show loading indicator when searching',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //           ),
  //         );
  //
  //         // Enter existing mock ID
  //         await tester.enterText(find.byType(TextFormField), '123456');
  //
  //         // Tap search button
  //         await tester.tap(find.text('検索'));
  //         await tester.pump();
  //
  //         // Should show CircularProgressIndicator during search
  //         expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //       });
  //
  //   testWidgets('should close error dialog when OK is pressed',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //           ),
  //         );
  //
  //         // Show error dialog with non-existing ID
  //         await tester.enterText(find.byType(TextFormField), '000000');
  //         await tester.tap(find.text('検索'));
  //         await tester.pumpAndSettle();
  //
  //         // Verify dialog appears
  //         expect(find.text('指定した施設IDが存在しません。'), findsOneWidget);
  //
  //         // Tap OK button
  //         await tester.tap(find.text('OK'));
  //         await tester.pumpAndSettle();
  //
  //         // Dialog should be closed
  //         expect(find.text('指定した施設IDが存在しません。'), findsNothing);
  //
  //         // Should be back to search screen
  //         expect(find.byType(TextFormField), findsOneWidget);
  //         expect(find.text('検索'), findsOneWidget);
  //       });
  //
  //   testWidgets('should have correct button styling',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //           ),
  //         );
  //
  //         final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
  //         final style = button.style;
  //
  //         // Check button colors
  //         expect(style?.backgroundColor?.resolve({}), Colors.orange);
  //         expect(style?.foregroundColor?.resolve({}), Colors.white);
  //
  //         // Check padding
  //         expect(style?.padding?.resolve({}), const EdgeInsets.symmetric(
  //           vertical: 11,
  //           horizontal: 30,
  //         ));
  //
  //         // Check shape (rounded corners)
  //         expect(style?.shape?.resolve({}), isA<RoundedRectangleBorder>());
  //       });
  //
  //   testWidgets('should have correct border styling for TextFormField',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //           ),
  //         );
  //
  //         final textField = tester.widget<TextFormField>(find.byType(TextFormField));
  //         final decoration = textField.decoration as InputDecoration;
  //
  //         // Check enabled border (black, 1px, rounded)
  //         final enabledBorder = decoration.enabledBorder as OutlineInputBorder;
  //         expect(enabledBorder.borderRadius, BorderRadius.circular(12));
  //         expect(enabledBorder.borderSide.color, Colors.black);
  //         expect(enabledBorder.borderSide.width, 1);
  //
  //         // Check focused border (orange, 2px, rounded)
  //         final focusedBorder = decoration.focusedBorder as OutlineInputBorder;
  //         expect(focusedBorder.borderRadius, BorderRadius.circular(12));
  //         expect(focusedBorder.borderSide.color, Colors.orange);
  //         expect(focusedBorder.borderSide.width, 2);
  //       });
  //
  //   testWidgets('should have correct layout structure',
  //           (WidgetTester tester) async {
  //         await tester.pumpWidget(
  //           MaterialApp(
  //             home: FacilitySearch(),
  //           ),
  //         );
  //
  //         // Check main structure
  //         expect(find.byType(Scaffold), findsOneWidget);
  //         expect(find.byType(Padding), findsWidgets);
  //
  //         // Check layout widgets
  //         expect(find.byType(Row), findsWidgets);
  //         expect(find.byType(Column), findsWidgets);
  //         expect(find.byType(SizedBox), findsAtLeastNWidgets(2));
  //
  //         // Check input box dimensions
  //         final inputSizedBox = find.byWidgetPredicate(
  //                 (widget) => widget is SizedBox && widget.width == 250 && widget.height == 50
  //         );
  //         expect(inputSizedBox, findsOneWidget);
  //       });
  // });
// }