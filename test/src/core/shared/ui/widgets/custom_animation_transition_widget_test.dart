import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_animation_transition_widget.dart';

void main() {
  group('CustomAnimationTransitionWidget', () {
    testWidgets('| CustomAnimationTransitionWidget animates correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomAnimationTransitionWidget(
              child: const Text('Animated Text'),
            ),
          ),
        ),
      );

      expect(find.text('Animated Text'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Animated Text'), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('Animated Text'), findsOneWidget);
    });
  });
}
