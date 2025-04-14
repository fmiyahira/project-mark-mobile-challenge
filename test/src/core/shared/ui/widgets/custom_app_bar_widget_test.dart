import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_app_bar_widget.dart';

void main() {
  group('CustomAppBarWidget', () {
    testWidgets('| displays title and svg', (WidgetTester tester) async {
      const title = 'Weather Forecast';

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(appBar: CustomAppBarWidget(title: title))),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
