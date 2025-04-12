import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_forecast/src/core/theme/app_assets.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';

class ItemTileWeatherDailyWidget extends StatelessWidget {
  const ItemTileWeatherDailyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Sunday',
            style: AppTextStyles.bodyText1.copyWith(
              color: AppColors.primaryLight,
            ),
          ),
          SvgPicture.asset(
            AppAssets.sunnyIcon,
            width: AppSpacing.iconHeight,
            height: AppSpacing.iconHeight,
          ),
          Row(
            children: [
              Text(
                '4° ',
                style: AppTextStyles.bodyText1.copyWith(
                  color: AppColors.primaryLight,
                ),
              ),
              Text(
                '/ 27°',
                style: AppTextStyles.bodyText1.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
