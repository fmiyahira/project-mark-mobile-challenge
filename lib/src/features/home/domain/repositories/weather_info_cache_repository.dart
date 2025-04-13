import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

abstract class WeatherInfoCacheRepository {
  Future<DateTime?> getLastUpdate();
  Future<void> saveLastUpdate(DateTime dateTime);

  Future<List<WeatherModel>> getWeatherInfo();
  Future<void> saveWeatherInfo(List<WeatherModel> listWeatherInfo);
}
