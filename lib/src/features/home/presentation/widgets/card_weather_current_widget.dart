import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_card_design_enum.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/strings/home_page_strings.dart';

class CardWeatherCurrentWidget extends StatelessWidget {
  final WeatherModel weather;
  const CardWeatherCurrentWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final WeatherCardDesignEnum weatherCardDesignEnum =
        WeatherCardDesignEnum.fromTempeture(weather.currentTemp);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 358,
      height: 194,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            weatherCardDesignEnum.surfaceStart,
            weatherCardDesignEnum.surfaceEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          if (weatherCardDesignEnum.backgroundAsset != null)
            Positioned(
              right: 0,
              top: 0,
              child: SvgPicture.asset(
                weatherCardDesignEnum.backgroundAsset!,
                width: 91.51,
                height: 89,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weather.city.name} / ${weather.city.state}',
                  style: AppTextStyles.bodyText1.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Text(
                  '${weather.currentTemp.round()}° C',
                  style: AppTextStyles.headline1.copyWith(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  '${HomePageStrings.humidity}: ${weather.humidity.round()}%',
                  style: AppTextStyles.bodyText2.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Text(
                  '${HomePageStrings.pressure}: ${weather.pressure.round()} ${HomePageStrings.pressureUnit}',
                  style: AppTextStyles.bodyText2.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
