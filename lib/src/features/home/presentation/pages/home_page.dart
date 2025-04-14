import 'package:flutter/material.dart';
import 'package:get/get.dart' show Obx;
import 'package:get/instance_manager.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_app_bar_widget.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_error_widget.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/core/theme/app_spacing.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';
import 'package:weather_forecast/src/features/home/presentation/strings/home_page_strings.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/carousel_card_weather_current_widget.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/list_card_weather_hourly_widget.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/sliver_list_item_weather_daily_widget.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/subtitle_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final IHomePresenter presenter = Get.find<IHomePresenter>();

    PageController controller = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarWidget(title: HomePageStrings.appBarTitle),
      body: Obx(() {
        if (presenter.hasError.value) {
          return CustomErrorWidget(
            message: HomePageStrings.errorMessage,
            onRetry: () => presenter.fetchWeather(),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverList.list(
              children: [
                SizedBox(height: AppSpacing.lg),
                CarouselCardWeatherCurrentWidget(controller: controller),
                SizedBox(height: AppSpacing.lg),
                ListCardWeatherHourlyWidget(),
                SizedBox(height: AppSpacing.lg),
                SubtitleWidget(subtile: HomePageStrings.subtitleNextDays),
                SizedBox(height: AppSpacing.sm),
              ],
            ),
            SliverListItemWeatherDailyWidget(),
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxxl)),
          ],
        );
      }),
    );
  }
}
