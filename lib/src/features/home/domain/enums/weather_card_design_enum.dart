import 'dart:ui';

import 'package:weather_forecast/src/core/theme/app_assets.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';

enum WeatherCardDesignEnum {
  cold(
    AppColors.surfaceBlueStart,
    AppColors.surfaceBlueEnd,
    AppAssets.sunBackground,
  ),
  normal(
    AppColors.surfaceRedStart,
    AppColors.surfaceRedEnd,
    AppAssets.cloudBackground,
  ),
  hot(AppColors.surfaceOrangeStart, AppColors.surfaceOrangeEnd, null);

  final Color surfaceStart;
  final Color surfaceEnd;
  final String? backgroundAsset;

  const WeatherCardDesignEnum(
    this.surfaceStart,
    this.surfaceEnd,
    this.backgroundAsset,
  );

  factory WeatherCardDesignEnum.fromTempeture(double temperature) {
    if (temperature <= 5) {
      return WeatherCardDesignEnum.cold;
    }

    if (temperature > 5 && temperature <= 25) {
      return WeatherCardDesignEnum.normal;
    }

    return WeatherCardDesignEnum.hot;
  }
}
