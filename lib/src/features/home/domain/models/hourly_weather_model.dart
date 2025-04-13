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

  factory HourlyWeatherModel.fromMap(Map<String, dynamic> map) {
    return HourlyWeatherModel(
      temp: (map['temp'] as num).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(map['dt'] * 1000).toLocal(),
      weatherConditionEnum: WeatherConditionEnum.fromString(
        map['weather'][0]['main'],
      ),
    );
  }

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      temp: json['temp'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
      weatherConditionEnum: WeatherConditionEnum.fromString(
        json['weatherConditionEnum'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temp': temp,
      'date': date.millisecondsSinceEpoch,
      'weatherConditionEnum': weatherConditionEnum.condition,
    };
  }
}
