import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_forecast/src/core/theme/app_assets.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';

class CardWeatherHourlyWidget extends StatelessWidget {
  const CardWeatherHourlyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      width: 87,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: AppColors.backgroundActive.withValues(alpha: .25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Now',
            style: AppTextStyles.bodyText2.copyWith(color: AppColors.secondary),
          ),
          SvgPicture.asset(
            AppAssets.sunnyIcon,
            width: AppSpacing.iconHeight,
            height: AppSpacing.iconHeight,
          ),
          Text(
            '4° C',
            style: AppTextStyles.bodyText2.copyWith(color: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}
