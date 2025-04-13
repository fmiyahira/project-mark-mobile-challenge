import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_repository.dart';

abstract class FetchWeatherFromCityUsecase {
  Future<WeatherModel> call({required CityModel cityModel});
}

class FetchWeatherFromCityUsecaseImpl implements FetchWeatherFromCityUsecase {
  final WeatherInfoRepository repository;
  FetchWeatherFromCityUsecaseImpl({required this.repository});

  @override
  Future<WeatherModel> call({required CityModel cityModel}) =>
      repository.getWeatherInfo(cityModel: cityModel);
}
