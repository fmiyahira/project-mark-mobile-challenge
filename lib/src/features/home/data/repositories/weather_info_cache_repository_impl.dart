import 'package:weather_forecast/src/features/home/data/datasources/weather_info_cache_datasource.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';

class WeatherInfoCacheRepositoryImpl implements WeatherInfoCacheRepository {
  final WeatherInfoCacheDatasource datasource;
  WeatherInfoCacheRepositoryImpl({required this.datasource});

  @override
  Future<DateTime?> getLastUpdate() => datasource.getLastUpdate();

  @override
  Future<void> saveLastUpdate(DateTime dateTime) =>
      datasource.saveLastUpdate(dateTime);

  @override
  Future<List<WeatherModel>> getWeatherInfo() => datasource.getWeatherInfo();

  @override
  Future<void> saveWeatherInfo(List<WeatherModel> listWeatherInfo) =>
      datasource.saveWeatherInfo(listWeatherInfo);
}
