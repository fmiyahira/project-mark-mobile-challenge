import 'dart:convert';

import 'package:weather_forecast/src/core/plugins/local_storage/local_storage.dart';
import 'package:weather_forecast/src/features/home/data/datasources/weather_info_cache_datasource.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

class WeatherInfoCacheDatasourceImpl implements WeatherInfoCacheDatasource {
  final LocalStorage localStorage;
  final String keyWeatherInfo = 'weather_info_cache_key';
  final String keyLastUpdate = 'last_update_cache_key';

  const WeatherInfoCacheDatasourceImpl({required this.localStorage});

  @override
  Future<List<WeatherModel>> getWeatherInfo() async {
    String? cachedWeatherInfo = await localStorage.getString(keyWeatherInfo);
    if (cachedWeatherInfo == null) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(cachedWeatherInfo);
    return jsonList.map((json) => WeatherModel.fromJson(json)).toList();
  }

  @override
  Future<void> saveWeatherInfo(List<WeatherModel> listWeatherInfo) async {
    final List<Map<String, dynamic>> mapList =
        listWeatherInfo.map((weather) => weather.toMap()).toList();

    final String jsonString = jsonEncode(mapList);

    await localStorage.saveString(keyWeatherInfo, jsonString);
  }

  @override
  Future<DateTime?> getLastUpdate() async {
    String? lastUpdate = await localStorage.getString(keyLastUpdate);
    if (lastUpdate == null) {
      return null;
    }

    return DateTime.parse(lastUpdate);
  }

  @override
  Future<void> saveLastUpdate(DateTime dateTime) async {
    await localStorage.saveString(keyLastUpdate, dateTime.toIso8601String());
  }
}
