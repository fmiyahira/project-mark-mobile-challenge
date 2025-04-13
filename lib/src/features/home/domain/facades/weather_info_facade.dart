import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_weather_info_usecase.dart';

abstract class WeatherInfoFacade {
  Future<List<WeatherModel>> getWeatherInfoFromCities();
}

class WeatherInfoFacadeImpl implements WeatherInfoFacade {
  final FetchWeatherFromCityUsecase fetchWeatherFromCityUsecase;
  WeatherInfoFacadeImpl({required this.fetchWeatherFromCityUsecase});

  Future<List<WeatherModel>> _getUpdatedWeatherInfo() async {
    final List<WeatherModel> results = await Future.wait([
      fetchWeatherFromCityUsecase(
        cityModel: CityModel(
          name: 'Joinville',
          state: 'SC',
          lat: -26.30444000,
          long: -48.84556000,
        ),
      ),
      fetchWeatherFromCityUsecase(
        cityModel: CityModel(
          name: 'San Francisco',
          state: 'CA',
          lat: 37.77493000,
          long: -122.41942000,
        ),
      ),
      fetchWeatherFromCityUsecase(
        cityModel: CityModel(
          name: 'Urubici',
          state: 'SC',
          lat: -28.0157,
          long: -49.5925,
        ),
      ),
    ]);

    return results;
  }

  @override
  Future<List<WeatherModel>> getWeatherInfoFromCities() async {
    // handle cache
    // get from cache
    // get updated
    // save cache
    final List<WeatherModel> results = await _getUpdatedWeatherInfo();

    return results;
  }
}
