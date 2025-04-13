import 'dart:async';

import 'package:get/get.dart';
import 'package:weather_forecast/src/features/home/domain/facades/weather_info_facade.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

class WeatherPresenter extends GetxController {
  final WeatherInfoFacade weatherInfoFacade;

  WeatherPresenter({required this.weatherInfoFacade});

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
    _startWeatherUpdateTimer();
  }

  Rxn<List<WeatherModel>> listWeather = Rxn<List<WeatherModel>>();
  Rxn<WeatherModel> currentCityWeather = Rxn<WeatherModel>();
  Rx<bool> hasError = false.obs;
  late Timer timerCheckNeedsUpdate;

  @override
  void onClose() {
    timerCheckNeedsUpdate.cancel();
    super.onClose();
  }

  void _startWeatherUpdateTimer() {
    timerCheckNeedsUpdate = Timer.periodic(
      const Duration(minutes: 1),
      (Timer timer) => fetchWeather(),
    );
  }

  void setCurrentCityWeather(int index) {
    if (listWeather.value != null && index < listWeather.value!.length) {
      currentCityWeather.value = listWeather.value![index];
    }
  }

  Future<void> fetchWeather() async {
    try {
      hasError.value = false;
      listWeather.value = await weatherInfoFacade.getWeatherInfoFromCities();
      setCurrentCityWeather(0);
    } catch (e) {
      hasError.value = true;
    }
  }
}
