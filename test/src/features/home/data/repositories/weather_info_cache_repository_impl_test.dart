import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/data/datasources/weather_info_cache_datasource.dart';
import 'package:weather_forecast/src/features/home/data/repositories/weather_info_cache_repository_impl.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

class MockWeatherInfoCacheDatasource extends Mock
    implements WeatherInfoCacheDatasource {}

void main() {
  late WeatherInfoCacheRepositoryImpl repository;
  late MockWeatherInfoCacheDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockWeatherInfoCacheDatasource();
    repository = WeatherInfoCacheRepositoryImpl(datasource: mockDatasource);
  });

  group('WeatherInfoCacheRepositoryImpl', () {
    final testWeatherModel = WeatherModel(
      city: CityModel(
        name: 'Test City',
        state: 'Test State',
        lat: 0.0,
        long: 0.0,
      ),
      currentTemp: 25.0,
      humidity: 60,
      pressure: 1013,
      hourly: [],
      daily: [],
    );

    test('| should save weather info to cache', () async {
      when(
        () => mockDatasource.saveWeatherInfo(any()),
      ).thenAnswer((_) async => true);

      await repository.saveWeatherInfo([testWeatherModel]);

      verify(
        () => mockDatasource.saveWeatherInfo([testWeatherModel]),
      ).called(1);
    });

    test('| should retrieve weather info from cache', () async {
      when(
        () => mockDatasource.getWeatherInfo(),
      ).thenAnswer((_) async => [testWeatherModel]);

      final result = await repository.getWeatherInfo();

      expect(result, isNotEmpty);
      expect(result.first.city.name, 'Test City');
      verify(() => mockDatasource.getWeatherInfo()).called(1);
    });

    test('| should save last update to cache', () async {
      final now = DateTime.now();
      when(
        () => mockDatasource.saveLastUpdate(any()),
      ).thenAnswer((_) async => true);

      await repository.saveLastUpdate(now);

      verify(() => mockDatasource.saveLastUpdate(now)).called(1);
    });

    test('| should retrieve last update from cache', () async {
      final now = DateTime.now();
      when(() => mockDatasource.getLastUpdate()).thenAnswer((_) async => now);

      final result = await repository.getLastUpdate();

      expect(result, isNotNull);
      expect(result, now);
      verify(() => mockDatasource.getLastUpdate()).called(1);
    });
  });
}
