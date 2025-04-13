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

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      city: CityModel.fromMap(map['city']),
      currentTemp: (map['current']['temp'] as num).toDouble(),
      humidity: map['current']['humidity'],
      pressure: map['current']['pressure'],
      hourly:
          List.from(
            map['hourly'] as List,
          ).map((hour) => HourlyWeatherModel.fromMap(hour)).toList(),
      daily:
          List.from(
            map['daily'] as List,
          ).map((day) => DailyWeatherModel.fromMap(day)).toList(),
    );
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: CityModel.fromJson(json['city'] as Map<String, dynamic>),
      currentTemp: json['currentTemp'] as double,
      humidity: json['humidity'] as int,
      pressure: json['pressure'] as int,
      hourly: List<HourlyWeatherModel>.from(
        (json['hourly'] as List).map<HourlyWeatherModel>(
          (x) => HourlyWeatherModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      daily: List<DailyWeatherModel>.from(
        (json['daily'] as List).map<DailyWeatherModel>(
          (x) => DailyWeatherModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city.toMap(),
      'currentTemp': currentTemp,
      'humidity': humidity,
      'pressure': pressure,
      'hourly': hourly.map((x) => x.toMap()).toList(),
      'daily': daily.map((x) => x.toMap()).toList(),
    };
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
