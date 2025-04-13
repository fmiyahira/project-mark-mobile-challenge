import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';

abstract class GetWeatherInfoCacheUsecase {
  Future<List<WeatherModel>> call();
}

class GetWeatherInfoCacheUsecaseImpl implements GetWeatherInfoCacheUsecase {
  final WeatherInfoCacheRepository repository;

  GetWeatherInfoCacheUsecaseImpl({required this.repository});

  @override
  Future<List<WeatherModel>> call() => repository.getWeatherInfo();
}
