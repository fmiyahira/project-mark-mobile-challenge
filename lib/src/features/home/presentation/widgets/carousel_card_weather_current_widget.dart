import 'package:flutter/material.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/page_view_indicator_widget.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/card_weather_current_widget.dart';

class CarouselCardWeatherCurrentWidget extends StatelessWidget {
  final PageController controller;
  const CarouselCardWeatherCurrentWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 194,
          child: PageView.builder(
            itemCount: 3,
            controller: controller,
            itemBuilder: (BuildContext context, int index) {
              return CardWeatherCurrentWidget();
            },
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        PageViewIndicatorWidget(controller: controller),
      ],
    );
  }
}
