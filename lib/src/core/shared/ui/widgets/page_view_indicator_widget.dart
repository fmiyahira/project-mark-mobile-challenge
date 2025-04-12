import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';

class PageViewIndicatorWidget extends StatelessWidget {
  final PageController controller;
  const PageViewIndicatorWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller: controller,
        count: 3,
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
