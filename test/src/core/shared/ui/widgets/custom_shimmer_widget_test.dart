import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_shimmer_widget.dart';

void main() {
  group('CustomShimmerWidget', () {
    testWidgets('| renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: CustomShimmerWidget(height: 50))),
      );

      expect(find.byType(CustomShimmerWidget), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });
  });
}
