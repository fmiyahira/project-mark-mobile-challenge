import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';
import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/item_tile_weather_daily_widget.dart';

void main() {
  group('ItemTileWeatherDailyWidget', () {
    testWidgets('displays the correct day of the week', (tester) async {
      final dailyWeatherModel = DailyWeatherModel(
        date: DateTime(2023, 10, 10),
        minTemp: 15.0,
        maxTemp: 25.0,
        weatherConditionEnum: WeatherConditionEnum.sunny,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTileWeatherDailyWidget(
              dailyWeatherModel: dailyWeatherModel,
            ),
          ),
        ),
      );

      expect(find.text('Tuesday'), findsOneWidget);
    });

    testWidgets('displays the correct min and max temperatures', (
      tester,
    ) async {
      final dailyWeatherModel = DailyWeatherModel(
        date: DateTime(2023, 10, 10),
        minTemp: 15.0,
        maxTemp: 25.0,
        weatherConditionEnum: WeatherConditionEnum.sunny,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTileWeatherDailyWidget(
              dailyWeatherModel: dailyWeatherModel,
            ),
          ),
        ),
      );

      expect(find.text('15° '), findsOneWidget);
      expect(find.text('/ 25°'), findsOneWidget);
    });

    testWidgets('displays the correct weather icon', (tester) async {
      final dailyWeatherModel = DailyWeatherModel(
        date: DateTime(2023, 10, 10),
        minTemp: 15.0,
        maxTemp: 25.0,
        weatherConditionEnum: WeatherConditionEnum.sunny,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTileWeatherDailyWidget(
              dailyWeatherModel: dailyWeatherModel,
            ),
          ),
        ),
      );

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('renders with correct styles', (tester) async {
      final dailyWeatherModel = DailyWeatherModel(
        date: DateTime(2023, 10, 10),
        minTemp: 15.0,
        maxTemp: 25.0,
        weatherConditionEnum: WeatherConditionEnum.sunny,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTileWeatherDailyWidget(
              dailyWeatherModel: dailyWeatherModel,
            ),
          ),
        ),
      );

      final dayText = tester.widget<Text>(find.text('Tuesday'));
      expect(
        dayText.style,
        AppTextStyles.bodyText1.copyWith(color: AppColors.primaryLight),
      );

      final minTempText = tester.widget<Text>(find.text('15° '));
      expect(
        minTempText.style,
        AppTextStyles.bodyText1.copyWith(color: AppColors.primaryLight),
      );

      final maxTempText = tester.widget<Text>(find.text('/ 25°'));
      expect(
        maxTempText.style,
        AppTextStyles.bodyText1.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.primaryLight,
        ),
      );
    });
  });
}
