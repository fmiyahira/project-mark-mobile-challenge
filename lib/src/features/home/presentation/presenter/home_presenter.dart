import 'dart:async';

import 'package:get/get.dart';
import 'package:weather_forecast/src/features/home/domain/facades/weather_info_facade.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

abstract class IHomePresenter {
  Rxn<List<WeatherModel>> get listWeather;
  Rxn<WeatherModel> get currentCityWeather;
  Rx<bool> get hasError;
  Future<void> fetchWeather();
  void setCurrentCityWeather(int index);
}

class HomePresenter extends GetxController implements IHomePresenter {
  final WeatherInfoFacade weatherInfoFacade;

  HomePresenter({required this.weatherInfoFacade});

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
    _startWeatherUpdateTimer();
  }

  @override
  Rxn<List<WeatherModel>> listWeather = Rxn<List<WeatherModel>>();

  @override
  Rxn<WeatherModel> currentCityWeather = Rxn<WeatherModel>();

  @override
  Rx<bool> hasError = false.obs;

  late Timer timerCheckNeedsUpdate;
  int currentIndex = 0;

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

  @override
  void setCurrentCityWeather(int index) {
    currentIndex = index;
    if (listWeather.value != null && index < listWeather.value!.length) {
      currentCityWeather.value = listWeather.value![index];
    }
  }

  @override
  Future<void> fetchWeather() async {
    try {
      hasError.value = false;
      listWeather.value = await weatherInfoFacade.getWeatherInfoFromCities();

      setCurrentCityWeather(currentIndex);
    } catch (e) {
      hasError.value = true;
    }
  }
}
