import 'package:equatable/equatable.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';

class DailyWeatherModel extends Equatable {
  final double minTemp;
  final double maxTemp;
  final DateTime date;
  final WeatherConditionEnum weatherConditionEnum;

  const DailyWeatherModel({
    required this.minTemp,
    required this.maxTemp,
    required this.date,
    required this.weatherConditionEnum,
  });

  factory DailyWeatherModel.fromMap(Map<String, dynamic> map) {
    return DailyWeatherModel(
      minTemp: (map['temp']['min'] as num).toDouble(),
      maxTemp: (map['temp']['max'] as num).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(map['dt'] * 1000).toLocal(),
      weatherConditionEnum: WeatherConditionEnum.fromString(
        map['weather'][0]['main'],
      ),
    );
  }

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      minTemp: json['minTemp'] as double,
      maxTemp: json['maxTemp'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
      weatherConditionEnum: WeatherConditionEnum.fromString(
        json['weatherConditionEnum'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'minTemp': minTemp,
      'maxTemp': maxTemp,
      'date': date.millisecondsSinceEpoch,
      'weatherConditionEnum': weatherConditionEnum.condition,
    };
  }

  @override
  List<Object?> get props => [minTemp, maxTemp, date, weatherConditionEnum];
}
