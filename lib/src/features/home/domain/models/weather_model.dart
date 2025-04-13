import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/hourly_weather_model.dart';

class WeatherModel {
  final CityModel city;
  final double currentTemp;
  final int humidity;
  final int pressure;
  final List<HourlyWeatherModel> hourly;
  final List<DailyWeatherModel> daily;

  WeatherModel({
    required this.city,
    required this.currentTemp,
    required this.humidity,
    required this.pressure,
    required this.hourly,
    required this.daily,
  });

  factory WeatherModel.fromJson(
    CityModel cityModel,
    Map<String, dynamic> json,
  ) {
    return WeatherModel(
      city: cityModel,
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

  WeatherModel copyWith({
    CityModel? city,
    double? currentTemp,
    int? humidity,
    int? pressure,
    List<HourlyWeatherModel>? hourly,
    List<DailyWeatherModel>? daily,
  }) {
    return WeatherModel(
      city: city ?? this.city,
      currentTemp: currentTemp ?? this.currentTemp,
      humidity: humidity ?? this.humidity,
      pressure: pressure ?? this.pressure,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
    );
  }
}
