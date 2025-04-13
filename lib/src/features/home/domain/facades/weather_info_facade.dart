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

  @override
  Future<List<WeatherModel>> getWeatherInfoFromCities() async {
    if (await _isLocalCacheValid()) {
      return _cachedWeather;
    }

    return await _fetchAndSaveCacheWeatherData();
  }

  Future<bool> _isLocalCacheValid() async {
    final DateTime? lastUpdate = await getLastUpdateCacheUseCase();
    if (lastUpdate == null) {
      return false;
    }

    final Duration localCacheLifeTime = DateTime.now().difference(lastUpdate);
    if (localCacheLifeTime.inMinutes > 10) {
      return false;
    }

    if (_cachedWeather.isNotEmpty) {
      return true;
    }

    _cachedWeather = await getWeatherInfoCacheUsecase();
    return _cachedWeather.isNotEmpty;
  }

  Future<List<WeatherModel>> _fetchAndSaveCacheWeatherData() async {
    final List<WeatherModel> updatedWeather =
        await fetchUpdatedWeatherInfoUsecase();

    _cachedWeather = updatedWeather;

    await saveWeatherInfoCacheUsecase(updatedWeather);
    await saveLastUpdateCacheUsecase(DateTime.now());

    return updatedWeather;
  }
}
