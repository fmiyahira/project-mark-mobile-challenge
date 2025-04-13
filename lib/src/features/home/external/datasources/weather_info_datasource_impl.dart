import 'package:weather_forecast/src/core/plugins/request_client/request_client.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client_response.dart';
import 'package:weather_forecast/src/features/home/data/datasources/weather_info_datasource.dart';
import 'package:weather_forecast/src/features/home/domain/models/city_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

class WeatherInfoDatasourceImpl implements WeatherInfoDatasource {
  final RequestClient requestClient;

  WeatherInfoDatasourceImpl({required this.requestClient});

  @override
  Future<WeatherModel> getWeatherInfo({required CityModel cityModel}) async {
    final RequestResponse response = await requestClient.get(
      '3.0/onecall',
      queryParameters: {
        'lat': cityModel.lat,
        'lon': cityModel.long,
        'units': 'metric',
        'exclude': 'minutely,alerts',
        'appid': 'eaf4cad03ca825ba07e63b1bd4b9d7bb',
      },
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(cityModel, response.data);
    } else {
      throw Exception(response.message);
    }
  }
}
