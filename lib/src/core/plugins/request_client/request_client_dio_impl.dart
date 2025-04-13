import 'package:dio/dio.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client_response.dart';

class RequestHttpDioImpl implements RequestClient {
  final Dio _dio;

  RequestHttpDioImpl()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.openweathermap.org/data/3.0/onecall',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

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
