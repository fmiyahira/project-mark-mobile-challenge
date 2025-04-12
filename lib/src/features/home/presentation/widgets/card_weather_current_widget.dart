import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_forecast/src/core/theme/app_assets.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';
import 'package:weather_forecast/src/features/home/presentation/strings/home_page_strings.dart';

class CardWeatherCurrentWidget extends StatelessWidget {
  const CardWeatherCurrentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 358,
      height: 194,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surfaceBlueStart, AppColors.surfaceBlueEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: SvgPicture.asset(
              AppAssets.sunBackground,
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
                  'Joinville / SC',
                  style: AppTextStyles.bodyText1.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Text(
                  '4° C',
                  style: AppTextStyles.headline1.copyWith(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.md),
                Text(
                  '${HomePageStrings.humidity}: 87%',
                  style: AppTextStyles.bodyText2.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Text(
                  '${HomePageStrings.pressure}: 1016 ${HomePageStrings.pressureUnit}',
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
