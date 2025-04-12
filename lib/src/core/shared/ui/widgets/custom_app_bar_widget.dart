import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_forecast/src/core/theme/app_assets.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const CustomAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.projectmarkLogo,
            width: AppSpacing.logoHeight,
            height: AppSpacing.logoHeight,
          ),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.headline2.copyWith(color: AppColors.primary),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: AppSpacing.logoHeight),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, AppSpacing.appBarHeight);
}
