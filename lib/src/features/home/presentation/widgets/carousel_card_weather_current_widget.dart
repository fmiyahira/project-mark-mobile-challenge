import 'package:flutter/material.dart';
import 'package:get/get.dart' show Obx;
import 'package:get/instance_manager.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_shimmer_widget.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/page_view_indicator_widget.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/card_weather_current_widget.dart';

class CarouselCardWeatherCurrentWidget extends StatelessWidget {
  final PageController controller;
  const CarouselCardWeatherCurrentWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final WeatherPresenter presenter = Get.find<WeatherPresenter>();

    return Obx(() {
      final List<WeatherModel>? listWeather = presenter.listWeather.value;

      if (listWeather == null || listWeather.isEmpty) {
        return CustomShimmerWidget(height: 224);
      }

      return Column(
        children: [
          SizedBox(
            height: 194,
            child: PageView.builder(
              itemCount: listWeather.length,
              controller: controller,
              onPageChanged: presenter.setCurrentCityWeather,
              itemBuilder: (BuildContext context, int index) {
                final WeatherModel weather = listWeather[index];
                return CardWeatherCurrentWidget(weather: weather);
              },
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          PageViewIndicatorWidget(controller: controller),
        ],
      );
    });
  }
}
