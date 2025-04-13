import 'package:weather_forecast/src/core/plugins/request_client/request_client_response.dart';

abstract class RequestClient {
  Future<RequestResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  });
}
