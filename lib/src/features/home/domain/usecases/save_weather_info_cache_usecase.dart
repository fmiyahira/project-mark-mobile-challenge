import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';

abstract class SaveWeatherInfoCacheUsecase {
  Future<void> call(List<WeatherModel> listWeatherInfo);
}

class SaveWeatherInfoCacheUsecaseImpl implements SaveWeatherInfoCacheUsecase {
  final WeatherInfoCacheRepository repository;

  SaveWeatherInfoCacheUsecaseImpl({required this.repository});

  @override
  Future<void> call(List<WeatherModel> listWeatherInfo) =>
      repository.saveWeatherInfo(listWeatherInfo);
}
