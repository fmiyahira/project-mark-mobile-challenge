import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_weather_info_usecase.dart';

abstract class FetchUpdatedWeatherInfoUsecase {
  Future<List<WeatherModel>> call();
}

class FetchUpdatedWeatherInfoUsecaseImpl
    implements FetchUpdatedWeatherInfoUsecase {
  final FetchWeatherFromCityUsecase fetchWeatherFromCityUsecase;

  FetchUpdatedWeatherInfoUsecaseImpl({
    required this.fetchWeatherFromCityUsecase,
  });

  @override
  Future<List<WeatherModel>> call() async {
    final List<CityModel> cities = [
      CityModel(
        name: 'Joinville',
        state: 'SC',
        lat: -26.30444000,
        long: -48.84556000,
      ),
      CityModel(
        name: 'San Francisco',
        state: 'CA',
        lat: 37.77493000,
        long: -122.41942000,
      ),
      CityModel(name: 'Urubici', state: 'SC', lat: -28.0157, long: -49.5925),
    ];

    return await Future.wait([
      ...cities.map((city) {
        return fetchWeatherFromCityUsecase(cityModel: city);
      }),
    ]);
  }
}
