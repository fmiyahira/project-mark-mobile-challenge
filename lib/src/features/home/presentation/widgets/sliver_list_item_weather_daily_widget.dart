import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart'
    show Obx;
import 'package:get/instance_manager.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_shimmer_widget.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/item_tile_weather_daily_widget.dart';

class SliverListItemWeatherDailyWidget extends StatelessWidget {
  const SliverListItemWeatherDailyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final IHomePresenter presenter = Get.find<IHomePresenter>();

    return Obx(() {
      final WeatherModel? currentCityWeather =
          presenter.currentCityWeather.value;

      if (currentCityWeather == null) {
        return SliverToBoxAdapter(child: CustomShimmerWidget(height: 118));
      }

      return SliverPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 3.5,
        ),
        sliver: SliverList.builder(
          itemCount: currentCityWeather.daily.length,
          itemBuilder: (BuildContext context, int index) {
            final DailyWeatherModel dailyWeatherModel =
                currentCityWeather.daily[index];

            return ItemTileWeatherDailyWidget(
              dailyWeatherModel: dailyWeatherModel,
            );
          },
        ),
      );
    });
  }
}
