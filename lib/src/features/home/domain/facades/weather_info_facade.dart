import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_updated_weather_info_usecase.dart';

abstract class WeatherInfoFacade {
  Future<List<WeatherModel>> getWeatherInfoFromCities();
}

class WeatherInfoFacadeImpl implements WeatherInfoFacade {
  final FetchUpdatedWeatherInfoUsecase fetchUpdatedWeatherInfoUsecase;

  WeatherInfoFacadeImpl({required this.fetchUpdatedWeatherInfoUsecase});

  @override
  Future<List<WeatherModel>> getWeatherInfoFromCities() async {
    // handle cache
    // get from cache
    // get updated
    // save cache
    final List<WeatherModel> results = await fetchUpdatedWeatherInfoUsecase();

    return results;
  }
}
