import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/data/datasources/weather_info_datasource.dart';
import 'package:weather_forecast/src/features/home/data/repositories/weather_info_repository_impl.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

class MockWeatherInfoDatasource extends Mock implements WeatherInfoDatasource {}

void main() {
  late WeatherInfoRepositoryImpl repository;
  late MockWeatherInfoDatasource mockDatasource;

  const cityModel = CityModel(
    name: 'Test City',
    state: 'Test State',
    lat: 37.7749,
    long: -122.4194,
  );

  setUpAll(() {
    registerFallbackValue(cityModel);
  });

  setUp(() {
    mockDatasource = MockWeatherInfoDatasource();
    repository = WeatherInfoRepositoryImpl(datasource: mockDatasource);
  });

  group('WeatherInfoRepositoryImpl', () {
    final testWeatherModel = WeatherModel(
      city: cityModel,
      currentTemp: 25.0,
      humidity: 60,
      pressure: 1013,
      hourly: [],
      daily: [],
    );

    test(
      '| should return WeatherModel when datasource call is successful',
      () async {
        when(
          () =>
              mockDatasource.getWeatherInfo(cityModel: any(named: 'cityModel')),
        ).thenAnswer((_) async => testWeatherModel);

        final result = await repository.getWeatherInfo(cityModel: cityModel);

        expect(result, equals(testWeatherModel));
        verify(
          () => mockDatasource.getWeatherInfo(cityModel: cityModel),
        ).called(1);
      },
    );

    test('| should throw an exception when datasource call fails', () async {
      when(
        () => mockDatasource.getWeatherInfo(cityModel: any(named: 'cityModel')),
      ).thenThrow(Exception('Failed to fetch weather info'));

      expect(
        () => repository.getWeatherInfo(cityModel: cityModel),
        throwsA(isA<Exception>()),
      );
      verify(
        () => mockDatasource.getWeatherInfo(cityModel: cityModel),
      ).called(1);
    });
  });
}
