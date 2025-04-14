import 'package:dio/dio.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client_response.dart';

class RequestClientDioImpl implements RequestClient {
  final Dio _dio;
  RequestClientDioImpl(this._dio);

  @override
  Future<RequestResponse> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return RequestResponse.success(
        response.data,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return RequestResponse.error(
        e.message ?? 'Unexpected error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return RequestResponse.error('Unexpected error: $e');
    }
  }
}
