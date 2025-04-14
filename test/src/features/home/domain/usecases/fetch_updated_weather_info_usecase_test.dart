import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_updated_weather_info_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_weather_from_city_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/treat_weather_info_usecase.dart';

class MockFetchWeatherFromCityUsecase extends Mock
    implements FetchWeatherFromCityUsecase {}

class MockTreatWeatherInfoUsecase extends Mock
    implements TreatWeatherInfoUsecase {}

void main() {
  late MockFetchWeatherFromCityUsecase mockFetchWeatherFromCityUsecase;
  late MockTreatWeatherInfoUsecase mockTreatWeatherInfoUsecase;
  late FetchUpdatedWeatherInfoUsecaseImpl usecase;

  setUp(() {
    mockFetchWeatherFromCityUsecase = MockFetchWeatherFromCityUsecase();
    mockTreatWeatherInfoUsecase = MockTreatWeatherInfoUsecase();
    usecase = FetchUpdatedWeatherInfoUsecaseImpl(
      fetchWeatherFromCityUsecase: mockFetchWeatherFromCityUsecase,
      treatWeatherInfoUsecase: mockTreatWeatherInfoUsecase,
    );

    registerFallbackValue(CityModel(name: '', state: '', lat: 0.0, long: 0.0));
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

  group('FetchUpdatedWeatherInfoUsecaseImpl', () {
    test('| should fetch and treat weather info for all cities', () async {
      final cities = [
        CityModel(
          name: 'Joinville',
          state: 'SC',
          lat: -26.30444000,
          long: -48.84556000,
        ),
        CityModel(
          name: 'San Francisco',
          state: 'CA',
          lat: 37.77493000,
          long: -122.41942000,
        ),
        CityModel(name: 'Urubici', state: 'SC', lat: -28.0157, long: -49.5925),
      ];

      final weatherModels =
          cities.map((city) {
            return WeatherModel(
              city: city,
              currentTemp: 25.0,
              humidity: 60,
              pressure: 1013,
              hourly: [],
              daily: [],
            );
          }).toList();

      final treatedWeatherModels =
          weatherModels.map((weather) {
            return WeatherModel(
              city: weather.city,
              currentTemp: weather.currentTemp + 1.0,
              humidity: weather.humidity,
              pressure: weather.pressure,
              hourly: weather.hourly,
              daily: weather.daily,
            );
          }).toList();

      when(
        () => mockFetchWeatherFromCityUsecase.call(
          cityModel: any(named: 'cityModel'),
        ),
      ).thenAnswer((invocation) async {
        final city = invocation.namedArguments[#cityModel] as CityModel;
        return weatherModels.firstWhere((weather) => weather.city == city);
      });

      when(() => mockTreatWeatherInfoUsecase.call(any())).thenAnswer((
        invocation,
      ) {
        final weather = invocation.positionalArguments[0] as WeatherModel;
        return treatedWeatherModels.firstWhere(
          (treated) => treated.city == weather.city,
        );
      });

      final result = await usecase.call();

      expect(result, treatedWeatherModels);
      verify(
        () => mockFetchWeatherFromCityUsecase.call(
          cityModel: any(named: 'cityModel'),
        ),
      ).called(cities.length);
      verify(
        () => mockTreatWeatherInfoUsecase.call(any()),
      ).called(weatherModels.length);
    });

    test('| should throw an exception if fetching weather fails', () async {
      when(
        () => mockFetchWeatherFromCityUsecase.call(
          cityModel: any(named: 'cityModel'),
        ),
      ).thenThrow(Exception('Failed to fetch weather'));

      expect(() => usecase.call(), throwsException);
      verify(
        () => mockFetchWeatherFromCityUsecase.call(
          cityModel: any(named: 'cityModel'),
        ),
      ).called(1);
    });
  });
}
