import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_forecast/src/core/shared/ui/widgets/page_view_indicator_widget.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';

class MockHomePresenter extends Mock implements IHomePresenter {}

void main() {
  late MockHomePresenter mockPresenter;
  late PageController pageController;

  setUpAll(() {
    registerFallbackValue(Rxn<List<WeatherModel>>());
  });

  setUp(() {
    mockPresenter = MockHomePresenter();
    pageController = PageController();

    when(() => mockPresenter.listWeather).thenReturn(Rxn<List<WeatherModel>>());
    when(
      () => mockPresenter.currentCityWeather,
    ).thenReturn(Rxn<WeatherModel>());
    when(() => mockPresenter.hasError).thenReturn(false.obs);

    Get.put<IHomePresenter>(mockPresenter);
  });

  tearDown(() {
    Get.reset();
  });

  group('PageViewIndicatorWidget', () {
    testWidgets('renders correctly when listWeather is not empty', (
      WidgetTester tester,
    ) async {
      final listWeather = Rxn<List<WeatherModel>>([
        WeatherModel(
          city: CityModel(
            name: 'City 1',
            state: 'State 1',
            lat: 0.0,
            long: 0.0,
          ),
          currentTemp: 25.0,
          humidity: 60,
          pressure: 1013,
          hourly: [],
          daily: [],
        ),
        WeatherModel(
          city: CityModel(
            name: 'City 2',
            state: 'State 2',
            lat: 0.0,
            long: 0.0,
          ),
          currentTemp: 26.0,
          humidity: 65,
          pressure: 1012,
          hourly: [],
          daily: [],
        ),
        WeatherModel(
          city: CityModel(
            name: 'City 3',
            state: 'State 3',
            lat: 0.0,
            long: 0.0,
          ),
          currentTemp: 27.0,
          humidity: 70,
          pressure: 1011,
          hourly: [],
          daily: [],
        ),
      ]);

      when(() => mockPresenter.listWeather).thenReturn(listWeather);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PageViewIndicatorWidget(controller: pageController),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);

      final SmoothPageIndicator indicator = tester.widget(
        find.byType(SmoothPageIndicator),
      );
      expect(indicator.count, 3);
    });

    testWidgets('| does not render when listWeather is empty', (
      WidgetTester tester,
    ) async {
      final listWeather = Rxn<List<WeatherModel>>([]);
      when(() => mockPresenter.listWeather).thenReturn(listWeather);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PageViewIndicatorWidget(controller: pageController),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget);
    });
  });
}
