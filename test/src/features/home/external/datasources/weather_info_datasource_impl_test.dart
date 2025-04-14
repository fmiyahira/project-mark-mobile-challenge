import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client_response.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';
import 'package:weather_forecast/src/features/home/external/datasources/weather_info_datasource_impl.dart';

class MockRequestClient extends Mock implements RequestClient {}

void main() {
  late WeatherInfoDatasourceImpl datasource;
  late MockRequestClient mockRequestClient;

  setUp(() {
    mockRequestClient = MockRequestClient();
    datasource = WeatherInfoDatasourceImpl(requestClient: mockRequestClient);
  });

  group('WeatherInfoDatasourceImpl', () {
    final cityModel = CityModel(
      name: 'Test City',
      state: 'Test State',
      lat: 37.7749,
      long: -122.4194,
    );

    test('| should return WeatherModel when call is successful', () async {
      final responseData = {
        'current': {'temp': 25.0, 'humidity': 60, 'pressure': 1013},
        'hourly': [],
        'daily': [],
      };
      final expectedWeatherModel = WeatherModel(
        city: cityModel,
        currentTemp: 25.0,
        humidity: 60,
        pressure: 1013,
        hourly: [],
        daily: [],
      );

      when(
        () => mockRequestClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => RequestResponse(
          isSuccess: true,
          statusCode: 200,
          data: responseData,
        ),
      );

      final result = await datasource.getWeatherInfo(cityModel: cityModel);

      expect(result, equals(expectedWeatherModel));
      verify(
        () => mockRequestClient.get(
          '3.0/onecall',
          queryParameters: {
            'lat': cityModel.lat,
            'lon': cityModel.long,
            'units': 'metric',
            'exclude': 'minutely,alerts',
            'appid': 'eaf4cad03ca825ba07e63b1bd4b9d7bb',
          },
        ),
      ).called(1);
    });

    test('| should throw an exception when fails', () async {
      when(
        () => mockRequestClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => RequestResponse(
          isSuccess: false,
          statusCode: 404,
          message: 'Not Found',
        ),
      );

      expect(
        () => datasource.getWeatherInfo(cityModel: cityModel),
        throwsA(isA<Exception>()),
      );
      verify(
        () => mockRequestClient.get(
          '3.0/onecall',
          queryParameters: {
            'lat': cityModel.lat,
            'lon': cityModel.long,
            'units': 'metric',
            'exclude': 'minutely,alerts',
            'appid': 'eaf4cad03ca825ba07e63b1bd4b9d7bb',
          },
        ),
      ).called(1);
    });
  });
}
