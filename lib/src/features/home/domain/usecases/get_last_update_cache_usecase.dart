import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';

abstract class GetLastUpdateCacheUseCase {
  Future<DateTime?> call();
}

class GetLastUpdateCacheUseCaseImpl implements GetLastUpdateCacheUseCase {
  final WeatherInfoCacheRepository repository;

  GetLastUpdateCacheUseCaseImpl({required this.repository});

  @override
  Future<DateTime?> call() => repository.getLastUpdate();
}
