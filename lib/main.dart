import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_forecast/src/core/theme/app_assets.dart';
import 'package:weather_forecast/src/core/theme/app_text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(fontFamily: 'Archivo'),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather', style: AppTextStyles.headline2),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('4° C', style: AppTextStyles.headline1),
              Text(
                'Joinville / SC',
                style: AppTextStyles.bodyText1.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text('Next 7 Days', style: AppTextStyles.subtitle1),
              Text('Sunday', style: AppTextStyles.bodyText2),
              SvgPicture.asset(
                AppAssets.projectmarkLogo,
                width: 41,
                height: 41,
              ),
              SvgPicture.asset(AppAssets.sunnyIcon, width: 34, height: 34),
              SvgPicture.asset(AppAssets.cloudyIcon, width: 34, height: 34),
              SvgPicture.asset(AppAssets.rainyIcon, width: 34, height: 34),
              SvgPicture.asset(AppAssets.lightningIcon, width: 34, height: 34),
              SvgPicture.asset(
                AppAssets.sunBackground,
                width: 91.51,
                height: 89,
              ),
              SvgPicture.asset(
                AppAssets.cloudBackground,
                width: 102,
                height: 120.38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
