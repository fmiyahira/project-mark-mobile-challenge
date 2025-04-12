import 'package:flutter/material.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';

class SubtitleWidget extends StatelessWidget {
  final String subtile;
  const SubtitleWidget({super.key, required this.subtile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Text(
        subtile,
        style: AppTextStyles.subtitle1.copyWith(color: AppColors.primary),
      ),
    );
  }
}
