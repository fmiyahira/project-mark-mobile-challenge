import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/get_last_update_cache_usecase.dart';

class MockWeatherInfoCacheRepository extends Mock
    implements WeatherInfoCacheRepository {}

void main() {
  late MockWeatherInfoCacheRepository mockWeatherInfoCacheRepository;
  late GetLastUpdateCacheUseCaseImpl getLastUpdateCacheUseCase;

  setUp(() {
    mockWeatherInfoCacheRepository = MockWeatherInfoCacheRepository();
    getLastUpdateCacheUseCase = GetLastUpdateCacheUseCaseImpl(
      repository: mockWeatherInfoCacheRepository,
    );
  });

  group('GetLastUpdateCacheUseCaseImpl', () {
    test('| should return the last update date from the cache', () async {
      final lastUpdateDate = DateTime(2025, 4, 13);
      when(
        () => mockWeatherInfoCacheRepository.getLastUpdate(),
      ).thenAnswer((_) async => lastUpdateDate);

      final result = await getLastUpdateCacheUseCase.call();

      expect(result, lastUpdateDate);
      verify(() => mockWeatherInfoCacheRepository.getLastUpdate()).called(1);
    });

    test(
      '| should return null if there is no last update in the cache',
      () async {
        when(
          () => mockWeatherInfoCacheRepository.getLastUpdate(),
        ).thenAnswer((_) async => null);

        final result = await getLastUpdateCacheUseCase.call();

        expect(result, isNull);
        verify(() => mockWeatherInfoCacheRepository.getLastUpdate()).called(1);
      },
    );
  });
}
