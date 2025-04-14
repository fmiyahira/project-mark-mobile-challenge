import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/custom_shimmer_widget.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/card_weather_current_widget.dart';
import 'package:weather_forecast/src/features/home/presentation/widgets/carousel_card_weather_current_widget.dart';

class MockHomePresenter extends Mock implements IHomePresenter {}

void main() {
  late MockHomePresenter mockHomePresenter;
  late PageController pageController;

  setUp(() {
    mockHomePresenter = MockHomePresenter();
    pageController = PageController();
    Get.put<IHomePresenter>(mockHomePresenter);
  });

  tearDown(() {
    Get.reset();
  });

  group('CarouselCardWeatherCurrentWidget', () {
    testWidgets('| should display shimmer when weather list is empty', (
      tester,
    ) async {
      when(
        () => mockHomePresenter.listWeather,
      ).thenReturn(Rxn<List<WeatherModel>>());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselCardWeatherCurrentWidget(controller: pageController),
          ),
        ),
      );

      expect(find.byType(CustomShimmerWidget), findsOneWidget);
      expect(find.byType(CardWeatherCurrentWidget), findsNothing);
    });

    testWidgets(
      '| should display weather cards when weather list is available',
      (tester) async {
        final weatherList = [
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
            daily: [],
          ),
        ];

        final rxWeatherList = Rxn<List<WeatherModel>>();
        rxWeatherList.value = weatherList;
        when(() => mockHomePresenter.listWeather).thenReturn(rxWeatherList);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CarouselCardWeatherCurrentWidget(
                controller: pageController,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.byType(CardWeatherCurrentWidget), findsOneWidget);
        expect(find.text('Joinville / SC'), findsOneWidget);
      },
    );

    testWidgets('| should call setCurrentCityWeather on page change', (
      tester,
    ) async {
      final weatherList = [
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
          daily: [],
        ),
        WeatherModel(
          city: CityModel(
            name: 'San Francisco',
            state: 'CA',
            lat: 37.7749,
            long: -122.4194,
          ),
          currentTemp: 18.0,
          humidity: 70,
          pressure: 1015,
          hourly: [],
          daily: [],
        ),
      ];
      when(
        () => mockHomePresenter.listWeather,
      ).thenReturn(Rxn<List<WeatherModel>>(weatherList));
      when(
        () => mockHomePresenter.setCurrentCityWeather(any()),
      ).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselCardWeatherCurrentWidget(controller: pageController),
          ),
        ),
      );
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      verify(() => mockHomePresenter.setCurrentCityWeather(1)).called(1);
    });
  });
}
