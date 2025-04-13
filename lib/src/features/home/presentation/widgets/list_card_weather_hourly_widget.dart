import 'package:flutter/material.dart';
import 'package:get/get.dart' show Obx;
import 'package:get/instance_manager.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/features/home/domain/models/hourly_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';
import 'package:weather_forecast/src/features/home/presentation/strings/home_page_strings.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/card_weather_hourly_widget.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/subtitle_widget.dart';

class ListCardWeatherHourlyWidget extends StatelessWidget {
  const ListCardWeatherHourlyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherPresenter presenter = Get.find<WeatherPresenter>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitleWidget(subtile: HomePageStrings.currentDay),
        SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 118,
          child: Obx(() {
            final WeatherModel? currentCityWeather =
                presenter.currentCityWeather.value;

            return ListView.builder(
              padding: const EdgeInsets.only(left: AppSpacing.lg),
              scrollDirection: Axis.horizontal,
              itemCount: currentCityWeather?.hourly.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final HourlyWeatherModel hourlyWeatherModel =
                    currentCityWeather!.hourly[index];

                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
                  child: CardWeatherHourlyWidget(
                    hourlyWeatherModel: hourlyWeatherModel,
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
