import 'package:weather_forecast/src/core/theme/app_assets.dart';

enum WeatherConditionEnum {
  sunny(AppAssets.sunnyIcon),
  lightning(AppAssets.lightningIcon),
  rainy(AppAssets.rainyIcon),
  cloudy(AppAssets.cloudyIcon);

  final String asset;
  const WeatherConditionEnum(this.asset);

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
