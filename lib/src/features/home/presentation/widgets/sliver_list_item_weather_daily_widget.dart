import 'package:flutter/material.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/item_tile_weather_daily_widget.dart';

class SliverListItemWeatherDailyWidget extends StatelessWidget {
  const SliverListItemWeatherDailyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: 3.5,
      ),
      sliver: SliverList.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return ItemTileWeatherDailyWidget();
        },
      ),
    );
  }
}
