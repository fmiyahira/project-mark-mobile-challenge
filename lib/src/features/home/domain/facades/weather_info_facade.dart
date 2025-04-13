import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_updated_weather_info_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/get_last_update_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/get_weather_info_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/save_last_update_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/save_weather_info_cache_usecase.dart';

abstract class WeatherInfoFacade {
  Future<List<WeatherModel>> getWeatherInfoFromCities();
}

class WeatherInfoFacadeImpl implements WeatherInfoFacade {
  final FetchUpdatedWeatherInfoUsecase fetchUpdatedWeatherInfoUsecase;
  final SaveLastUpdateCacheUsecase saveLastUpdateCacheUsecase;
  final SaveWeatherInfoCacheUsecase saveWeatherInfoCacheUsecase;
  final GetLastUpdateCacheUseCase getLastUpdateCacheUseCase;
  final GetWeatherInfoCacheUsecase getWeatherInfoCacheUsecase;

  WeatherInfoFacadeImpl({
    required this.fetchUpdatedWeatherInfoUsecase,
    required this.saveLastUpdateCacheUsecase,
    required this.saveWeatherInfoCacheUsecase,
    required this.getLastUpdateCacheUseCase,
    required this.getWeatherInfoCacheUsecase,
  });

  List<WeatherModel> _cachedWeather = [];
  DateTime? _lastMemoryCacheUpdate;

  @override
  Future<List<WeatherModel>> getWeatherInfoFromCities() async {
    if (_isMemoryCacheValid()) {
      return _cachedWeather;
    }

    if (await _isLocalCacheValid()) {
      return _cachedWeather;
    }

    return await _fetchAndSaveCacheWeatherData();
  }

  // Verifica se o cache em memória é válido
  bool _isMemoryCacheValid() {
    if (_cachedWeather.isNotEmpty && _lastMemoryCacheUpdate != null) {
      final Duration memoryCacheLifeTime = DateTime.now().difference(
        _lastMemoryCacheUpdate!,
      );

      return memoryCacheLifeTime.inMinutes < 10;
    }

    return false;
  }

  Future<bool> _isLocalCacheValid() async {
    final DateTime? lastUpdate = await getLastUpdateCacheUseCase();
    if (lastUpdate != null) {
      final Duration localCacheLifeTime = DateTime.now().difference(lastUpdate);

      if (localCacheLifeTime.inMinutes < 10) {
        _cachedWeather = await getWeatherInfoCacheUsecase();
        _lastMemoryCacheUpdate = DateTime.now();

        return _cachedWeather.isNotEmpty;
      }
    }

    return false;
  }

  Future<List<WeatherModel>> _fetchAndSaveCacheWeatherData() async {
    final List<WeatherModel> updatedWeather =
        await fetchUpdatedWeatherInfoUsecase();

    _cachedWeather = updatedWeather;
    _lastMemoryCacheUpdate = DateTime.now();

    await saveWeatherInfoCacheUsecase(updatedWeather);
    await saveLastUpdateCacheUsecase(DateTime.now());

    return updatedWeather;
  }
}
