import 'package:flutter/material.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';
import 'package:weather_forecast/src/features/home/presentation/strings/home_page_strings.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CustomErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 64),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText2,
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  HomePageStrings.tryAgain,
                  style: AppTextStyles.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
