import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_error_widget.dart';

void main() {
  group('CustomErrorWidget', () {
    testWidgets('| displays the error message', (WidgetTester tester) async {
      const errorMessage = 'Something went wrong';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomErrorWidget(message: errorMessage, onRetry: () {}),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('| calls onRetry when the button is pressed', (
      WidgetTester tester,
    ) async {
      bool retryCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomErrorWidget(
              message: 'Something went wrong',
              onRetry: () {
                retryCalled = true;
              },
            ),
          ),
        ),
      );

      final retryButton = find.byType(ElevatedButton);
      expect(retryButton, findsOneWidget);

      await tester.tap(retryButton);
      await tester.pumpAndSettle();

      expect(retryCalled, isTrue);
    });
  });
}
