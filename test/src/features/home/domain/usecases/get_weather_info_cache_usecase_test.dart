import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/get_weather_info_cache_usecase.dart';

class MockWeatherInfoCacheRepository extends Mock
    implements WeatherInfoCacheRepository {}

void main() {
  late MockWeatherInfoCacheRepository mockWeatherInfoCacheRepository;
  late GetWeatherInfoCacheUsecaseImpl getWeatherInfoCacheUsecase;

  setUp(() {
    mockWeatherInfoCacheRepository = MockWeatherInfoCacheRepository();
    getWeatherInfoCacheUsecase = GetWeatherInfoCacheUsecaseImpl(
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

  group('GetWeatherInfoCacheUsecaseImpl', () {
    test('| should return a list of weather info from the cache', () async {
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
        () => mockWeatherInfoCacheRepository.getWeatherInfo(),
      ).thenAnswer((_) async => weatherList);

      final result = await getWeatherInfoCacheUsecase.call();

      expect(result, weatherList);
      verify(() => mockWeatherInfoCacheRepository.getWeatherInfo()).called(1);
    });

    test(
      '| should return an empty list if no weather info is cached',
      () async {
        when(
          () => mockWeatherInfoCacheRepository.getWeatherInfo(),
        ).thenAnswer((_) async => []);

        final result = await getWeatherInfoCacheUsecase.call();

        expect(result, isEmpty);
        verify(() => mockWeatherInfoCacheRepository.getWeatherInfo()).called(1);
      },
    );

    test(
      '| should throw an exception if fetching weather info fails',
      () async {
        when(
          () => mockWeatherInfoCacheRepository.getWeatherInfo(),
        ).thenThrow(Exception('Failed to fetch weather info'));

        expect(() => getWeatherInfoCacheUsecase.call(), throwsException);
        verify(() => mockWeatherInfoCacheRepository.getWeatherInfo()).called(1);
      },
    );
  });
}
