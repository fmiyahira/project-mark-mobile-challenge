import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/domain/facades/weather_info_facade.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';

class MockWeatherInfoFacade extends Mock implements WeatherInfoFacade {}

void main() {
  late MockWeatherInfoFacade mockWeatherInfoFacade;
  late HomePresenter homePresenter;

  setUp(() {
    mockWeatherInfoFacade = MockWeatherInfoFacade();
    homePresenter = HomePresenter(weatherInfoFacade: mockWeatherInfoFacade);
  });

  group('HomePresenter', () {
    test('| should fetch weather info and update the listWeather', () async {
      final weatherList = [
        WeatherModel(
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
        ),
      ];

      when(
        () => mockWeatherInfoFacade.getWeatherInfoFromCities(),
      ).thenAnswer((_) async => weatherList);

      await homePresenter.fetchWeather();

      expect(homePresenter.listWeather.value, weatherList);
      expect(homePresenter.hasError.value, isFalse);
      verify(() => mockWeatherInfoFacade.getWeatherInfoFromCities()).called(1);
    });

    test('| should handle errors and set hasError to true', () async {
      when(
        () => mockWeatherInfoFacade.getWeatherInfoFromCities(),
      ).thenThrow(Exception('Failed to fetch weather info'));

      await homePresenter.fetchWeather();

      expect(homePresenter.listWeather.value, isNull);
      expect(homePresenter.hasError.value, isTrue);
      verify(() => mockWeatherInfoFacade.getWeatherInfoFromCities()).called(1);
    });

    test(
      '| should update currentCityWeather when setCurrentCityWeather is called',
      () {
        final weatherList = [
          WeatherModel(
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
          ),
          WeatherModel(
            city: CityModel(
              name: 'San Francisco',
              state: 'CA',
              lat: 37.7749,
              long: -122.4194,
            ),
            currentTemp: 18.0,
            humidity: 70,
            pressure: 1015,
            hourly: [],
            daily: [],
          ),
        ];

        homePresenter.listWeather.value = weatherList;

        homePresenter.setCurrentCityWeather(1);

        expect(homePresenter.currentCityWeather.value, weatherList[1]);
      },
    );

    test('| should not update currentCityWeather if index not exists', () {
      final weatherList = [
        WeatherModel(
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
        ),
      ];

      homePresenter.listWeather.value = weatherList;

      homePresenter.setCurrentCityWeather(5);

      expect(homePresenter.currentCityWeather.value, isNull);
    });

    test('| should set loading state while fetching weather info', () async {
      final completer = Completer<List<WeatherModel>>();
      when(
        () => mockWeatherInfoFacade.getWeatherInfoFromCities(),
      ).thenAnswer((_) => completer.future);

      final future = homePresenter.fetchWeather();

      expect(homePresenter.hasError.value, isFalse);

      completer.complete([]);
      await future;

      expect(homePresenter.listWeather.value, isEmpty);
    });
  });
}
