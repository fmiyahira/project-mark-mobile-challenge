import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/domain/facades/weather_info_facade.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_updated_weather_info_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/get_last_update_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/get_weather_info_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/save_last_update_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/save_weather_info_cache_usecase.dart';

class MockFetchUpdatedWeatherInfoUsecase extends Mock
    implements FetchUpdatedWeatherInfoUsecase {}

class MockSaveLastUpdateCacheUsecase extends Mock
    implements SaveLastUpdateCacheUsecase {}

class MockSaveWeatherInfoCacheUsecase extends Mock
    implements SaveWeatherInfoCacheUsecase {}

class MockGetLastUpdateCacheUseCase extends Mock
    implements GetLastUpdateCacheUseCase {}

class MockGetWeatherInfoCacheUsecase extends Mock
    implements GetWeatherInfoCacheUsecase {}

void main() {
  late MockFetchUpdatedWeatherInfoUsecase mockFetchUpdatedWeatherInfoUsecase;
  late MockSaveLastUpdateCacheUsecase mockSaveLastUpdateCacheUsecase;
  late MockSaveWeatherInfoCacheUsecase mockSaveWeatherInfoCacheUsecase;
  late MockGetLastUpdateCacheUseCase mockGetLastUpdateCacheUseCase;
  late MockGetWeatherInfoCacheUsecase mockGetWeatherInfoCacheUsecase;
  late WeatherInfoFacadeImpl weatherInfoFacade;

  setUp(() {
    mockFetchUpdatedWeatherInfoUsecase = MockFetchUpdatedWeatherInfoUsecase();
    mockSaveLastUpdateCacheUsecase = MockSaveLastUpdateCacheUsecase();
    mockSaveWeatherInfoCacheUsecase = MockSaveWeatherInfoCacheUsecase();
    mockGetLastUpdateCacheUseCase = MockGetLastUpdateCacheUseCase();
    mockGetWeatherInfoCacheUsecase = MockGetWeatherInfoCacheUsecase();

    weatherInfoFacade = WeatherInfoFacadeImpl(
      fetchUpdatedWeatherInfoUsecase: mockFetchUpdatedWeatherInfoUsecase,
      saveLastUpdateCacheUsecase: mockSaveLastUpdateCacheUsecase,
      saveWeatherInfoCacheUsecase: mockSaveWeatherInfoCacheUsecase,
      getLastUpdateCacheUseCase: mockGetLastUpdateCacheUseCase,
      getWeatherInfoCacheUsecase: mockGetWeatherInfoCacheUsecase,
    );
  });

  group('WeatherInfoFacadeImpl', () {
    test('| should return cached weather info if cache is valid', () async {
      final cachedWeather = [
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

      when(() => mockGetLastUpdateCacheUseCase.call()).thenAnswer(
        (_) async => DateTime.now().subtract(const Duration(minutes: 5)),
      );
      when(
        () => mockGetWeatherInfoCacheUsecase.call(),
      ).thenAnswer((_) async => cachedWeather);

      final result = await weatherInfoFacade.getWeatherInfoFromCities();

      expect(result, cachedWeather);
      verify(() => mockGetLastUpdateCacheUseCase.call()).called(1);
      verify(() => mockGetWeatherInfoCacheUsecase.call()).called(1);
      verifyNever(() => mockFetchUpdatedWeatherInfoUsecase.call());
    });

    test('| should fetch and save weather info if cache is invalid', () async {
      final updatedWeather = [
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

      when(() => mockGetLastUpdateCacheUseCase.call()).thenAnswer(
        (_) async => DateTime.now().subtract(const Duration(minutes: 15)),
      );
      when(
        () => mockFetchUpdatedWeatherInfoUsecase.call(),
      ).thenAnswer((_) async => updatedWeather);
      when(
        () => mockSaveWeatherInfoCacheUsecase.call(updatedWeather),
      ).thenAnswer((_) async {});
      when(
        () => mockSaveLastUpdateCacheUsecase.call(any()),
      ).thenAnswer((_) async {});

      final result = await weatherInfoFacade.getWeatherInfoFromCities();

      expect(result, updatedWeather);
      verify(() => mockGetLastUpdateCacheUseCase.call()).called(1);
      verify(() => mockFetchUpdatedWeatherInfoUsecase.call()).called(1);
      verify(
        () => mockSaveWeatherInfoCacheUsecase.call(updatedWeather),
      ).called(1);
      verify(() => mockSaveLastUpdateCacheUsecase.call(any())).called(1);
    });

    test('| should fetch and save weather info if no cache exists', () async {
      final updatedWeather = [
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
        () => mockGetLastUpdateCacheUseCase.call(),
      ).thenAnswer((_) async => null);
      when(
        () => mockFetchUpdatedWeatherInfoUsecase.call(),
      ).thenAnswer((_) async => updatedWeather);
      when(
        () => mockSaveWeatherInfoCacheUsecase.call(updatedWeather),
      ).thenAnswer((_) async {});
      when(
        () => mockSaveLastUpdateCacheUsecase.call(any()),
      ).thenAnswer((_) async {});

      final result = await weatherInfoFacade.getWeatherInfoFromCities();

      expect(result, updatedWeather);
      verify(() => mockGetLastUpdateCacheUseCase.call()).called(1);
      verify(() => mockFetchUpdatedWeatherInfoUsecase.call()).called(1);
      verify(
        () => mockSaveWeatherInfoCacheUsecase.call(updatedWeather),
      ).called(1);
      verify(() => mockSaveLastUpdateCacheUsecase.call(any())).called(1);
    });
  });
}
