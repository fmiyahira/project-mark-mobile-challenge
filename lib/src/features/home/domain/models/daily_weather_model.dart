import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';

class DailyWeatherModel {
  final double minTemp;
  final double maxTemp;
  final DateTime date;
  final WeatherConditionEnum weatherConditionEnum;

  DailyWeatherModel({
    required this.minTemp,
    required this.maxTemp,
    required this.date,
    required this.weatherConditionEnum,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      minTemp: (json['temp']['min'] as num).toDouble(),
      maxTemp: (json['temp']['max'] as num).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      weatherConditionEnum: WeatherConditionEnum.fromString(
        json['weather'][0]['main'],
      ),
    );
  }
}
