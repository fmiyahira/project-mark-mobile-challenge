import 'package:weather_forecast/src/features/home/data/datasources/weather_info_datasource.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_repository.dart';

class WeatherInfoRepositoryImpl implements WeatherInfoRepository {
  final WeatherInfoDatasource datasource;

  WeatherInfoRepositoryImpl({required this.datasource});

  @override
  Future<WeatherModel> getWeatherInfo({required CityModel cityModel}) =>
      datasource.getWeatherInfo(cityModel: cityModel);
}
