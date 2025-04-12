import 'package:flutter/material.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/features/home/presentation/strings/home_page_strings.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/card_weather_hourly_widget.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/subtitle_widget.dart';

class ListCardWeatherHourlyWidget extends StatelessWidget {
  const ListCardWeatherHourlyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitleWidget(subtile: HomePageStrings.currentDay),
        SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 118,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: AppSpacing.lg),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
                child: CardWeatherHourlyWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}
