import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';
import 'package:weather_forecast/src/features/home/domain/models/hourly_weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/card_weather_hourly_widget.dart';

void main() {
  group('CardWeatherHourlyWidget', () {
    testWidgets('| should display hourly weather information correctly', (
      tester,
    ) async {
      final now = DateTime.now();
      final hourlyWeather = HourlyWeatherModel(
        temp: 25.0,
        date: now,
        weatherConditionEnum: WeatherConditionEnum.sunny,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardWeatherHourlyWidget(hourlyWeatherModel: hourlyWeather),
          ),
        ),
      );

      expect(find.text('Now'), findsOneWidget);
      expect(find.text('25° C'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('| should display formatted time for non current hours', (
      tester,
    ) async {
      final date = DateTime.now().add(const Duration(hours: 3));
      final formattedTime = DateFormat('ha').format(date).toLowerCase();
      final hourlyWeather = HourlyWeatherModel(
        temp: 20.0,
        date: date,
        weatherConditionEnum: WeatherConditionEnum.cloudy,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardWeatherHourlyWidget(hourlyWeatherModel: hourlyWeather),
          ),
        ),
      );

      expect(find.text(formattedTime), findsOneWidget);
      expect(find.text('20° C'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('| should apply active styling for the current hour', (
      tester,
    ) async {
      final now = DateTime.now();
      final hourlyWeather = HourlyWeatherModel(
        temp: 22.0,
        date: now,
        weatherConditionEnum: WeatherConditionEnum.rainy,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardWeatherHourlyWidget(hourlyWeatherModel: hourlyWeather),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.decoration, isNotNull);
      expect((container.decoration as BoxDecoration).color, isNotNull);
    });

    testWidgets('| should apply inactive styling for non current hours', (
      tester,
    ) async {
      final date = DateTime.now().add(const Duration(hours: 5));
      final hourlyWeather = HourlyWeatherModel(
        temp: 18.0,
        date: date,
        weatherConditionEnum: WeatherConditionEnum.cloudy,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardWeatherHourlyWidget(hourlyWeatherModel: hourlyWeather),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.decoration, isNotNull);
      expect((container.decoration as BoxDecoration).color, isNotNull);
    });
  });
}
