import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_error_widget.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/pages/home_page.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/carousel_card_weather_current_widget.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/list_card_weather_hourly_widget.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/sliver_list_item_weather_daily_widget.dart';

class MockHomePresenter extends Mock implements IHomePresenter {}

void main() {
  late MockHomePresenter mockHomePresenter;

  setUp(() {
    mockHomePresenter = MockHomePresenter();
    Get.put<IHomePresenter>(mockHomePresenter);
  });

  tearDown(() {
    Get.reset();
  });

  group('HomePage', () {
    testWidgets('| should display weather widgets when no error occurs', (
      tester,
    ) async {
      final listWeather = Rxn<List<WeatherModel>>([
        WeatherModel(
          city: CityModel(
            name: 'Joinville',
            state: 'SC',
            lat: -26.3044,
            long: -48.8456,
          ),
          currentTemp: 25.0,
          humidity: 60,
          pressure: 1013,
          hourly: [],
          daily: [
            DailyWeatherModel(
              date: DateTime.now(),
              minTemp: 15.0,
              maxTemp: 25.0,
              weatherConditionEnum: WeatherConditionEnum.sunny,
            ),
          ],
        ),
      ]);
      final currentCityWeather = Rxn<WeatherModel>(
        WeatherModel(
          city: CityModel(
            name: 'Joinville',
            state: 'SC',
            lat: -26.3044,
            long: -48.8456,
          ),
          currentTemp: 25.0,
          humidity: 60,
          pressure: 1013,
          hourly: [],
          daily: [
            DailyWeatherModel(
              date: DateTime.now(),
              minTemp: 15.0,
              maxTemp: 25.0,
              weatherConditionEnum: WeatherConditionEnum.sunny,
            ),
          ],
        ),
      );

      when(() => mockHomePresenter.hasError).thenReturn(false.obs);
      when(() => mockHomePresenter.listWeather).thenReturn(listWeather);
      when(
        () => mockHomePresenter.currentCityWeather,
      ).thenReturn(currentCityWeather);

      await tester.pumpWidget(MaterialApp(home: HomePage()));
      await tester.pumpAndSettle();

      expect(find.byType(CarouselCardWeatherCurrentWidget), findsOneWidget);
      expect(find.byType(ListCardWeatherHourlyWidget), findsOneWidget);
      expect(find.byType(CustomErrorWidget), findsNothing);
    });

    testWidgets('| should display error widget when an error occurs', (
      tester,
    ) async {
      when(() => mockHomePresenter.hasError).thenReturn(true.obs);
      when(() => mockHomePresenter.fetchWeather()).thenAnswer((_) async {});

      await tester.pumpWidget(MaterialApp(home: HomePage()));

      expect(find.byType(CustomErrorWidget), findsOneWidget);
      expect(find.byType(CarouselCardWeatherCurrentWidget), findsNothing);
      expect(find.byType(ListCardWeatherHourlyWidget), findsNothing);
      expect(find.byType(SliverListItemWeatherDailyWidget), findsNothing);
    });

    testWidgets('| should call fetchWeather when retry button is pressed', (
      tester,
    ) async {
      when(() => mockHomePresenter.hasError).thenReturn(true.obs);
      when(() => mockHomePresenter.fetchWeather()).thenAnswer((_) async {});

      await tester.pumpWidget(MaterialApp(home: HomePage()));

      final retryButton = find.text('Try Again');
      expect(retryButton, findsOneWidget);

      await tester.tap(retryButton);
      await tester.pumpAndSettle();

      verify(() => mockHomePresenter.fetchWeather()).called(1);
    });
  });
}
