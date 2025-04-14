import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/save_weather_info_cache_usecase.dart';

class MockWeatherInfoCacheRepository extends Mock
    implements WeatherInfoCacheRepository {}

void main() {
  late MockWeatherInfoCacheRepository mockWeatherInfoCacheRepository;
  late SaveWeatherInfoCacheUsecaseImpl saveWeatherInfoCacheUsecase;

  setUp(() {
    mockWeatherInfoCacheRepository = MockWeatherInfoCacheRepository();
    saveWeatherInfoCacheUsecase = SaveWeatherInfoCacheUsecaseImpl(
      repository: mockWeatherInfoCacheRepository,
    );

    registerFallbackValue(
      WeatherModel(
        city: CityModel(name: '', state: '', lat: 0.0, long: 0.0),
        currentTemp: 0.0,
        humidity: 0,
        pressure: 0,
        hourly: [],
        daily: [],
      ),
    );
  });

  group('SaveWeatherInfoCacheUsecaseImpl', () {
    test('| should save weather info to the cache', () async {
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

      when(
        () => mockWeatherInfoCacheRepository.saveWeatherInfo(weatherList),
      ).thenAnswer((_) async {});

      await saveWeatherInfoCacheUsecase.call(weatherList);

      verify(
        () => mockWeatherInfoCacheRepository.saveWeatherInfo(weatherList),
      ).called(1);
    });

    test('| should throw an exception if saving weather info fails', () async {
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
        () => mockWeatherInfoCacheRepository.saveWeatherInfo(weatherList),
      ).thenThrow(Exception('Failed to save weather info'));

      expect(
        () => saveWeatherInfoCacheUsecase.call(weatherList),
        throwsException,
      );
      verify(
        () => mockWeatherInfoCacheRepository.saveWeatherInfo(weatherList),
      ).called(1);
    });
  });
}
