import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test/main.dart';
import 'package:test/fibonacci.dart';
import 'package:test/result.dart';

// Import your app's main.dart file and the widgets

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('e2e test', () {
    testWidgets('Fibonacci Calculator and Result Widget Integration Test',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Finder for the TextField in the calculator widget
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);

      // Finder for the ElevatedButton in the calculator widget
      final buttonFinder = find.byType(ElevatedButton);
      expect(buttonFinder, findsOneWidget);

      // Finder for the Text widget that displays the result in the result widget
      final resultTextFinder = find.text('El resultado es: ');
      expect(resultTextFinder, findsOneWidget);

      // Enter a number in the TextField
      await tester.enterText(textFieldFinder, '10');

      // Tap the Calculate Fibonacci button
      await tester.tap(buttonFinder);

      // Trigger a frame to allow the HTTP request to complete
      await tester.pump();

      // Ensure that the Text widget in the result widget displays the correct result
      expect(find.text('El resultado es: 54'), findsOneWidget);
    });
  });
}
