import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/core/plugins/local_storage/local_storage.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/external/datasources/weather_info_cache_datasource_impl.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late WeatherInfoCacheDatasourceImpl datasource;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    datasource = WeatherInfoCacheDatasourceImpl(localStorage: mockLocalStorage);
  });

  group('WeatherInfoCacheDatasourceImpl', () {
    const keyWeatherInfo = 'weather_info_cache_key';
    const keyLastUpdate = 'last_update_cache_key';

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
      final weatherList = [testWeatherModel];
      when(
        () => mockLocalStorage.saveString(keyWeatherInfo, any()),
      ).thenAnswer((_) async => true);

      await datasource.saveWeatherInfo(weatherList);

      verify(
        () => mockLocalStorage.saveString(keyWeatherInfo, any()),
      ).called(1);
    });

    test('| should retrieve weather info from cache', () async {
      final cachedData =
          '[{"city": {"name": "Test City", "state": "Test State", "lat": 0.0, "long": 0.0}, "currentTemp": 25.0, "humidity": 60, "pressure": 1013, "hourly": [], "daily": []}]';
      when(
        () => mockLocalStorage.getString(keyWeatherInfo),
      ).thenAnswer((_) async => cachedData);

      final result = await datasource.getWeatherInfo();

      expect(result, isNotEmpty);
      expect(result.first.city.name, 'Test City');
      verify(() => mockLocalStorage.getString(keyWeatherInfo)).called(1);
    });

    test('| should return empty list when no weather info is cached', () async {
      when(
        () => mockLocalStorage.getString(keyWeatherInfo),
      ).thenAnswer((_) async => null);

      final result = await datasource.getWeatherInfo();

      expect(result, isEmpty);
      verify(() => mockLocalStorage.getString(keyWeatherInfo)).called(1);
    });

    test('| should save last update to cache', () async {
      final now = DateTime.now();
      when(
        () => mockLocalStorage.saveString(keyLastUpdate, any()),
      ).thenAnswer((_) async => true);

      await datasource.saveLastUpdate(now);

      verify(
        () => mockLocalStorage.saveString(keyLastUpdate, now.toIso8601String()),
      ).called(1);
    });

    test('| should retrieve last update from cache', () async {
      final now = DateTime.now().toIso8601String();
      when(
        () => mockLocalStorage.getString(keyLastUpdate),
      ).thenAnswer((_) async => now);

      final result = await datasource.getLastUpdate();

      expect(result, isNotNull);
      expect(result!.toIso8601String(), now);
      verify(() => mockLocalStorage.getString(keyLastUpdate)).called(1);
    });

    test('| should return null when no last update is cached', () async {
      when(
        () => mockLocalStorage.getString(keyLastUpdate),
      ).thenAnswer((_) async => null);

      final result = await datasource.getLastUpdate();

      expect(result, isNull);
      verify(() => mockLocalStorage.getString(keyLastUpdate)).called(1);
    });
  });
}
