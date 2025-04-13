import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/hourly_weather_model.dart';

class WeatherModel {
  final double currentTemp;
  final int humidity;
  final int pressure;
  final List<HourlyWeatherModel> hourly;
  final List<DailyWeatherModel> daily;

  WeatherModel({
    required this.currentTemp,
    required this.humidity,
    required this.pressure,
    required this.hourly,
    required this.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      currentTemp: (json['current']['temp'] as num).toDouble(),
      humidity: json['current']['humidity'],
      pressure: json['current']['pressure'],
      hourly:
          List.from(
            json['hourly'] as List,
          ).map((hour) => HourlyWeatherModel.fromJson(hour)).toList(),
      daily:
          List.from(
            json['daily'] as List,
          ).map((day) => DailyWeatherModel.fromJson(day)).toList(),
    );
  }
}
