import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';

abstract class SaveLastUpdateCacheUsecase {
  Future<void> call(DateTime dateTime);
}

class SaveLastUpdateCacheUsecaseImpl implements SaveLastUpdateCacheUsecase {
  final WeatherInfoCacheRepository repository;

  SaveLastUpdateCacheUsecaseImpl({required this.repository});

  @override
  Future<void> call(DateTime dateTime) => repository.saveLastUpdate(dateTime);
}
