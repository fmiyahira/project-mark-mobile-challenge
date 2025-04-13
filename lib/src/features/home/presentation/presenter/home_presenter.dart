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
  Rxn<WeatherModel> currentCityWeather = Rxn<WeatherModel>();

  void setCurrentCityWeather(int index) {
    if (listWeather.value != null && index < listWeather.value!.length) {
      currentCityWeather.value = listWeather.value![index];
    }
  }

  Future<void> fetchWeather() async {
    try {
      isLoading.value = true;
      listWeather.value = await weatherInfoFacade.getWeatherInfoFromCities();
      setCurrentCityWeather(0);
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
