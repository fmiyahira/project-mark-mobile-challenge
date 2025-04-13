import 'package:get/get.dart';
import 'package:weather_forecast/src/features/home/domain/facades/weather_info_facade.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

class WeatherPresenter extends GetxController {
  final WeatherInfoFacade weatherInfoFacade;

  WeatherPresenter({required this.weatherInfoFacade}) {
    fetchWeather();
  }

  var isLoading = false.obs;
  Rxn<List<WeatherModel>> listWeather = Rxn<List<WeatherModel>>();

  Future<void> fetchWeather() async {
    try {
      isLoading.value = true;
      listWeather.value = await weatherInfoFacade.getWeatherInfoFromCities();
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
