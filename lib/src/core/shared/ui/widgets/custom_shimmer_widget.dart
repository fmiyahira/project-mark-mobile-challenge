import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double padding;
  final double height;
  final double borderRadius;

  const CustomShimmerWidget({
    super.key,
    this.padding = AppSpacing.sm,
    required this.height,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        interval: const Duration(seconds: 1),
        color: Colors.grey,
        colorOpacity: 0.3,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
