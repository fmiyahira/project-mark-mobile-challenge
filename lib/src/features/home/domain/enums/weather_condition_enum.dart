import 'package:weather_forecast/src/core/theme/app_assets.dart';

enum WeatherConditionEnum {
  sunny(AppAssets.sunnyIcon, 'Clear'),
  lightning(AppAssets.lightningIcon, 'Thunderstorm'),
  rainy(AppAssets.rainyIcon, 'Rain'),
  cloudy(AppAssets.cloudyIcon, 'Clouds');

  final String asset;
  final String condition;
  const WeatherConditionEnum(this.asset, this.condition);

  factory WeatherConditionEnum.fromString(String condition) {
    switch (condition) {
      case 'Thunderstorm':
        return WeatherConditionEnum.lightning;
      case 'Rain':
        return WeatherConditionEnum.rainy;
      case 'Clouds':
        return WeatherConditionEnum.cloudy;
      case 'Clear':
      default:
        return WeatherConditionEnum.sunny;
    }
  }
}
