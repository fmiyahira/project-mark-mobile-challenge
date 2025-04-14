import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/card_weather_current_widget.dart';

void main() {
  group('CardWeatherCurrentWidget', () {
    testWidgets('| should display weather information correctly', (
      tester,
    ) async {
      final weather = WeatherModel(
        city: CityModel(
          name: 'Joinville',
          state: 'SC',
          lat: -26.3044,
          long: -48.8456,
        ),
        currentTemp: 25.0,
        humidity: 60,
        pressure: 1013,
        hourly: [],
        daily: [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CardWeatherCurrentWidget(weather: weather)),
        ),
      );

      expect(find.text('Joinville / SC'), findsOneWidget);
      expect(find.text('25° C'), findsOneWidget);
      expect(find.text('Humidity: 60%'), findsOneWidget);
      expect(find.text('Pressure: 1013 hPa'), findsOneWidget);
    });

    testWidgets(
      '| should display the correct background asset for normal temperature',
      (tester) async {
        final weather = WeatherModel(
          city: CityModel(
            name: 'Joinville',
            state: 'SC',
            lat: -26.3044,
            long: -48.8456,
          ),
          currentTemp: 20.0,
          humidity: 50,
          pressure: 1010,
          hourly: [],
          daily: [],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: CardWeatherCurrentWidget(weather: weather)),
          ),
        );

        expect(find.byType(SvgPicture), findsOneWidget);
      },
    );

    testWidgets('| should not display a background asset for hot temperature', (
      tester,
    ) async {
      final weather = WeatherModel(
        city: CityModel(
          name: 'Death Valley',
          state: 'CA',
          lat: 36.5054,
          long: -116.8460,
        ),
        currentTemp: 40.0,
        humidity: 10,
        pressure: 1005,
        hourly: [],
        daily: [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CardWeatherCurrentWidget(weather: weather)),
        ),
      );

      expect(find.byType(SvgPicture), findsNothing);
    });
  });
}
