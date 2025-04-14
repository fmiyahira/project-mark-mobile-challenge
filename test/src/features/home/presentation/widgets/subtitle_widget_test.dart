import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/subtitle_widget.dart';

void main() {
  group('SubtitleWidget', () {
    testWidgets('| should display the correct subtitle text', (tester) async {
      const subtitleText = 'Current Weather';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SubtitleWidget(subtile: subtitleText)),
        ),
      );

      expect(find.text(subtitleText), findsOneWidget);
    });

    testWidgets('| should apply the correct text style', (tester) async {
      const subtitleText = 'Current Weather';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SubtitleWidget(subtile: subtitleText)),
        ),
      );

      final textWidget = tester.widget<Text>(find.text(subtitleText));
      expect(
        textWidget.style,
        AppTextStyles.subtitle1.copyWith(color: AppColors.primary),
      );
    });
  });
}
