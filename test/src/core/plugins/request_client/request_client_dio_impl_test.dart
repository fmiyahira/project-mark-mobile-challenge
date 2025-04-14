import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client_dio_impl.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client_response.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late RequestClientDioImpl requestClient;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  setUp(() {
    mockDio = MockDio();
    requestClient = RequestClientDioImpl(mockDio);

    when(() => mockDio.options).thenReturn(BaseOptions());
  });

  group('RequestClientDioImpl', () {
    group('| get', () {
      test('| should perform a GET request and return data', () async {
        const url = 'http://example.com';
        final responseData = {'key': 'value'};

        when(() => mockDio.get(url)).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: url),
          ),
        );

        final result = await requestClient.get(url);

        expect(result.data, responseData);
        verify(() => mockDio.get(url)).called(1);
      });

      test('| should throw an exception on error', () async {
        const url = 'http://example.com';

        when(() => mockDio.get(url)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: url),
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: url),
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        final result = await requestClient.get(url);

        expect(result, isA<RequestResponse>());
        verify(() => mockDio.get(url)).called(1);
      });
    });
  });
}
