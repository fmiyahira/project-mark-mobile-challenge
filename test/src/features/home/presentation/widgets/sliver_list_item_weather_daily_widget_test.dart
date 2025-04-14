import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';
import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/item_tile_weather_daily_widget.dart';

void main() {
  group('SliverListItemWeatherDailyWidget', () {
    testWidgets('| should display a list of daily weather items', (
      tester,
    ) async {
      final dailyWeatherList = [
        DailyWeatherModel(
          date: DateTime(2023, 10, 10),
          minTemp: 15.0,
          maxTemp: 25.0,
          weatherConditionEnum: WeatherConditionEnum.sunny,
        ),
        DailyWeatherModel(
          date: DateTime(2023, 10, 11),
          minTemp: 18.0,
          maxTemp: 28.0,
          weatherConditionEnum: WeatherConditionEnum.cloudy,
        ),
        DailyWeatherModel(
          date: DateTime(2023, 10, 12),
          minTemp: 10.0,
          maxTemp: 20.0,
          weatherConditionEnum: WeatherConditionEnum.rainy,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ItemTileWeatherDailyWidget(
                      dailyWeatherModel: dailyWeatherList[index],
                    );
                  }, childCount: dailyWeatherList.length),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ItemTileWeatherDailyWidget), findsNWidgets(3));
      expect(find.text('Tuesday'), findsOneWidget);
      expect(find.text('Wednesday'), findsOneWidget);
      expect(find.text('Thursday'), findsOneWidget);
    });

    testWidgets('| should display correct weather data for each item', (
      tester,
    ) async {
      final dailyWeather = DailyWeatherModel(
        date: DateTime(2023, 10, 10),
        minTemp: 15.0,
        maxTemp: 25.0,
        weatherConditionEnum: WeatherConditionEnum.sunny,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemTileWeatherDailyWidget(dailyWeatherModel: dailyWeather),
          ),
        ),
      );

      expect(find.text('Tuesday'), findsOneWidget);
      expect(find.text('15° '), findsOneWidget);
      expect(find.text('/ 25°'), findsOneWidget);
      expect(find.byType(ItemTileWeatherDailyWidget), findsOneWidget);
    });
  });
}
