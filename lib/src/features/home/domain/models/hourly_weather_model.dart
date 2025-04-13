import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';

class HourlyWeatherModel {
  final double temp;
  final DateTime date;
  final WeatherConditionEnum weatherConditionEnum;

  HourlyWeatherModel({
    required this.temp,
    required this.date,
    required this.weatherConditionEnum,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      temp: (json['temp'] as num).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000).toLocal(),
      weatherConditionEnum: WeatherConditionEnum.fromString(
        json['weather'][0]['main'],
      ),
    );
  }
}
