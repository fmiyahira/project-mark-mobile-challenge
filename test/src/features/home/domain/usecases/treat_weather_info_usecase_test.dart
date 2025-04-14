import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/hourly_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/treat_weather_info_usecase.dart';

void main() {
  late TreatWeatherInfoUsecaseImpl treatWeatherInfoUsecase;

  setUp(() {
    treatWeatherInfoUsecase = TreatWeatherInfoUsecaseImpl();
  });

  group('TreatWeatherInfoUsecaseImpl', () {
    test('| should filter hourly weather to include only today data', () {
      final now = DateTime.now();
      final weather = WeatherModel(
        city: CityModel(
          name: 'Joinville',
          state: 'SC',
          lat: -26.3044,
          long: -48.8456,
        ),
        currentTemp: 25.0,
        humidity: 60,
        pressure: 1013,
        hourly: [
          HourlyWeatherModel(
            date: now.subtract(const Duration(hours: 1)),
            temp: 24.0,
            weatherConditionEnum: WeatherConditionEnum.sunny,
          ),
          HourlyWeatherModel(
            date: now,
            temp: 25.0,
            weatherConditionEnum: WeatherConditionEnum.sunny,
          ),
          HourlyWeatherModel(
            date: now.add(const Duration(days: 1)),
            temp: 26.0,
            weatherConditionEnum: WeatherConditionEnum.sunny,
          ),
        ],
        daily: [],
      );

      final treatedWeather = treatWeatherInfoUsecase.call(weather);

      expect(treatedWeather.hourly.length, 2);
      expect(
        treatedWeather.hourly.every((hour) => hour.date.day == now.day),
        isTrue,
      );
    });

    test('| should filter daily weather to exclude today data', () {
      final now = DateTime.now();
      final weather = WeatherModel(
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
        daily: [
          DailyWeatherModel(
            date: now,
            minTemp: 20.0,
            maxTemp: 30.0,
            weatherConditionEnum: WeatherConditionEnum.sunny,
          ),
          DailyWeatherModel(
            date: now.add(const Duration(days: 1)),
            minTemp: 21.0,
            maxTemp: 31.0,
            weatherConditionEnum: WeatherConditionEnum.sunny,
          ),
        ],
      );

      final treatedWeather = treatWeatherInfoUsecase.call(weather);

      expect(treatedWeather.daily.length, 1);
      expect(
        treatedWeather.daily.every((day) => day.date.day != now.day),
        isTrue,
      );
    });
  });
}
