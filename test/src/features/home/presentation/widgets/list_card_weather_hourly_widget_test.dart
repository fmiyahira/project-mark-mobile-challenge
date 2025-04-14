import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_shimmer_widget.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/hourly_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/card_weather_hourly_widget.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/list_card_weather_hourly_widget.dart';

class MockHomePresenter extends Mock implements IHomePresenter {}

void main() {
  late MockHomePresenter mockHomePresenter;

  setUp(() {
    mockHomePresenter = MockHomePresenter();
    Get.put<IHomePresenter>(mockHomePresenter);
  });

  tearDown(() {
    Get.reset();
  });

  group('ListCardWeatherHourlyWidget', () {
    testWidgets('| should display shimmer when currentCityWeather is null', (
      tester,
    ) async {
      when(
        () => mockHomePresenter.currentCityWeather,
      ).thenReturn(Rxn<WeatherModel>());

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: const ListCardWeatherHourlyWidget())),
      );

      expect(find.byType(CustomShimmerWidget), findsOneWidget);
      expect(find.byType(CardWeatherHourlyWidget), findsNothing);
    });

    testWidgets(
      '| should display hourly weather cards when currentCityWeather is available',
      (tester) async {
        final hourlyWeather = [
          HourlyWeatherModel(
            temp: 25.0,
            date: DateTime.now(),
            weatherConditionEnum: WeatherConditionEnum.sunny,
          ),
          HourlyWeatherModel(
            temp: 20.0,
            date: DateTime.now().add(const Duration(hours: 1)),
            weatherConditionEnum: WeatherConditionEnum.cloudy,
          ),
        ];

        final weatherModel = WeatherModel(
          city: CityModel(
            name: 'Joinville',
            state: 'SC',
            lat: -26.3044,
            long: -48.8456,
          ),
          currentTemp: 25.0,
          humidity: 60,
          pressure: 1013,
          hourly: hourlyWeather,
          daily: [],
        );

        when(
          () => mockHomePresenter.currentCityWeather,
        ).thenReturn(Rxn<WeatherModel>(weatherModel));

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: const ListCardWeatherHourlyWidget()),
          ),
        );

        expect(find.byType(CardWeatherHourlyWidget), findsNWidgets(2));
      },
    );

    testWidgets('| should display the correct number of hourly weather cards', (
      tester,
    ) async {
      final hourlyWeather = List.generate(
        5,
        (index) => HourlyWeatherModel(
          temp: 20.0 + index,
          date: DateTime.now().add(Duration(hours: index)),
          weatherConditionEnum: WeatherConditionEnum.cloudy,
        ),
      );

      final weatherModel = WeatherModel(
        city: CityModel(
          name: 'Joinville',
          state: 'SC',
          lat: -26.3044,
          long: -48.8456,
        ),
        currentTemp: 25.0,
        humidity: 60,
        pressure: 1013,
        hourly: hourlyWeather,
        daily: [],
      );

      when(
        () => mockHomePresenter.currentCityWeather,
      ).thenReturn(Rxn<WeatherModel>(weatherModel));

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: const ListCardWeatherHourlyWidget())),
      );

      expect(find.byType(CardWeatherHourlyWidget), findsNWidgets(5));
    });
  });
}
