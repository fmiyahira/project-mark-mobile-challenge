import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_animation_transition_widget.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';
import 'package:weather_forecast/src/features/home/domain/models/hourly_weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/strings/home_page_strings.dart';

class CardWeatherHourlyWidget extends StatelessWidget {
  final HourlyWeatherModel hourlyWeatherModel;
  const CardWeatherHourlyWidget({super.key, required this.hourlyWeatherModel});

  @override
  Widget build(BuildContext context) {
    final bool isFromNow = hourlyWeatherModel.date.hour == DateTime.now().hour;
    final String formattedTime =
        DateFormat('hha').format(hourlyWeatherModel.date).toLowerCase();

    return Container(
      height: 118,
      width: 87,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color:
            isFromNow
                ? AppColors.backgroundActive.withValues(alpha: .25)
                : AppColors.backgroundInactive,
      ),
      child: CustomAnimationTransitionWidget(
        child: Column(
          key: ValueKey(
            'block-hourly-${hourlyWeatherModel.date}-${hourlyWeatherModel.temp}',
          ),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isFromNow ? HomePageStrings.now : formattedTime,
              style: AppTextStyles.bodyText2.copyWith(
                color:
                    isFromNow ? AppColors.secondary : AppColors.primaryLightest,
              ),
            ),
            SvgPicture.asset(
              hourlyWeatherModel.weatherConditionEnum.asset,
              width: AppSpacing.iconWidth,
              colorFilter: ColorFilter.mode(
                isFromNow ? AppColors.secondary : AppColors.primaryLightest,
                BlendMode.srcIn,
              ),
            ),
            Text(
              '${hourlyWeatherModel.temp.round()}° C',
              style: AppTextStyles.bodyText2.copyWith(
                color:
                    isFromNow ? AppColors.secondary : AppColors.primaryLightest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
