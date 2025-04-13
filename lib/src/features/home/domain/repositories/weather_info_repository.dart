import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

abstract class WeatherInfoRepository {
  Future<WeatherModel> getWeatherInfo({required CityModel cityModel});
}
