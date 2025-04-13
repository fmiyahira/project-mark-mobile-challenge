import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';

class PageViewIndicatorWidget extends StatelessWidget {
  final PageController controller;
  const PageViewIndicatorWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final WeatherPresenter presenter = Get.find<WeatherPresenter>();

    if (presenter.listWeather.value?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

    return Center(
      child: SmoothPageIndicator(
        controller: controller,
        count: presenter.listWeather.value!.length,
        axisDirection: Axis.horizontal,
        effect: SlideEffect(
          spacing: 7.0,
          radius: 4,
          dotWidth: 9.0,
          dotHeight: 9.0,
          paintStyle: PaintingStyle.fill,
          dotColor: AppColors.surfaceRedStart,
          activeDotColor: AppColors.primary,
        ),
      ),
    );
  }
}
