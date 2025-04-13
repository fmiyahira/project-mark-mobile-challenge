import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_animation_transition_widget.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';
import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';

class ItemTileWeatherDailyWidget extends StatelessWidget {
  final DailyWeatherModel dailyWeatherModel;
  const ItemTileWeatherDailyWidget({
    super.key,
    required this.dailyWeatherModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.listTileHeight,
      margin: const EdgeInsets.only(bottom: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              DateFormat('EEEE').format(dailyWeatherModel.date),
              style: AppTextStyles.bodyText1.copyWith(
                color: AppColors.primaryLight,
              ),
            ),
          ),
          CustomAnimationTransitionWidget(
            child: SvgPicture.asset(
              key: ValueKey('asset-${dailyWeatherModel.date}'),
              dailyWeatherModel.weatherConditionEnum.asset,
              width: AppSpacing.iconWidth,
            ),
          ),
          Expanded(
            child: CustomAnimationTransitionWidget(
              child: Row(
                key: ValueKey('block-min-max-${dailyWeatherModel.date}'),
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${dailyWeatherModel.minTemp.round()}° ',
                    style: AppTextStyles.bodyText1.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                  Text(
                    '/ ${dailyWeatherModel.maxTemp.round()}°',
                    style: AppTextStyles.bodyText1.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
