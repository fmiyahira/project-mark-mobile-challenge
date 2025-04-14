import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_repository.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_weather_from_city_usecase.dart';

class MockWeatherInfoRepository extends Mock implements WeatherInfoRepository {}

void main() {
  late MockWeatherInfoRepository mockWeatherInfoRepository;
  late FetchWeatherFromCityUsecaseImpl fetchWeatherFromCityUsecase;

  setUp(() {
    mockWeatherInfoRepository = MockWeatherInfoRepository();
    fetchWeatherFromCityUsecase = FetchWeatherFromCityUsecaseImpl(
      repository: mockWeatherInfoRepository,
    );

    registerFallbackValue(CityModel(name: '', state: '', lat: 0.0, long: 0.0));
  });

  group('FetchWeatherFromCityUsecaseImpl', () {
    test('| should fetch weather for a given city', () async {
      final city = CityModel(
        name: 'Joinville',
        state: 'SC',
        lat: -26.30444000,
        long: -48.84556000,
      );

      final weather = WeatherModel(
        city: city,
        currentTemp: 25.0,
        humidity: 60,
        pressure: 1013,
        hourly: [],
        daily: [],
      );

      when(
        () => mockWeatherInfoRepository.getWeatherInfo(cityModel: city),
      ).thenAnswer((_) async => weather);

      final result = await fetchWeatherFromCityUsecase.call(cityModel: city);

      expect(result, weather);
      verify(
        () => mockWeatherInfoRepository.getWeatherInfo(cityModel: city),
      ).called(1);
    });

    test('| should throw an exception if fetching weather fails', () async {
      final city = CityModel(
        name: 'Joinville',
        state: 'SC',
        lat: -26.30444000,
        long: -48.84556000,
      );

      when(
        () => mockWeatherInfoRepository.getWeatherInfo(cityModel: city),
      ).thenThrow(Exception('Failed to fetch weather'));

      expect(
        () => fetchWeatherFromCityUsecase.call(cityModel: city),
        throwsException,
      );
      verify(
        () => mockWeatherInfoRepository.getWeatherInfo(cityModel: city),
      ).called(1);
    });
  });
}
