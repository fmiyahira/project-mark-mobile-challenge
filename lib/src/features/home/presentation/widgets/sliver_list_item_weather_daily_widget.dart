import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart'
    show Obx;
import 'package:get/instance_manager.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/item_tile_weather_daily_widget.dart';

class SliverListItemWeatherDailyWidget extends StatelessWidget {
  const SliverListItemWeatherDailyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherPresenter presenter = Get.find<WeatherPresenter>();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: 3.5,
      ),
      sliver: Obx(() {
        final WeatherModel? currentCityWeather =
            presenter.currentCityWeather.value;

        return SliverList.builder(
          itemCount: currentCityWeather?.daily.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final DailyWeatherModel dailyWeatherModel =
                currentCityWeather!.daily[index];

            return ItemTileWeatherDailyWidget(
              dailyWeatherModel: dailyWeatherModel,
            );
          },
        );
      }),
    );
  }
}
