import 'dart:async';

import 'package:get/get.dart';
import 'package:weather_forecast/src/features/home/domain/facades/weather_info_facade.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

class WeatherPresenter extends GetxController {
  final WeatherInfoFacade weatherInfoFacade;

  WeatherPresenter({required this.weatherInfoFacade}) {
    _fetchWeather();
    _startWeatherUpdateTimer();
  }

  Rxn<List<WeatherModel>> listWeather = Rxn<List<WeatherModel>>();
  Rxn<WeatherModel> currentCityWeather = Rxn<WeatherModel>();
  late Timer timerCheckNeedsUpdate;

  @override
  void onClose() {
    timerCheckNeedsUpdate.cancel();
    super.onClose();
  }

  void _startWeatherUpdateTimer() {
    timerCheckNeedsUpdate = Timer.periodic(
      const Duration(minutes: 1),
      (Timer timer) => _fetchWeather(),
    );
  }

  void setCurrentCityWeather(int index) {
    if (listWeather.value != null && index < listWeather.value!.length) {
      currentCityWeather.value = listWeather.value![index];
    }
  }

  Future<void> _fetchWeather() async {
    try {
      listWeather.value = await weatherInfoFacade.getWeatherInfoFromCities();
      setCurrentCityWeather(0);
    } catch (e) {
      print(e);
    } finally {}
  }
}
