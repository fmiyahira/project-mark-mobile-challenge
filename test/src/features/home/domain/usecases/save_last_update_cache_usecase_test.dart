import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/save_last_update_cache_usecase.dart';

class MockWeatherInfoCacheRepository extends Mock
    implements WeatherInfoCacheRepository {}

void main() {
  late MockWeatherInfoCacheRepository mockWeatherInfoCacheRepository;
  late SaveLastUpdateCacheUsecaseImpl saveLastUpdateCacheUseCase;

  setUp(() {
    mockWeatherInfoCacheRepository = MockWeatherInfoCacheRepository();
    saveLastUpdateCacheUseCase = SaveLastUpdateCacheUsecaseImpl(
      repository: mockWeatherInfoCacheRepository,
    );
  });

  group('SaveLastUpdateCacheUsecaseImpl', () {
    test('| should save the last update date to the cache', () async {
      final lastUpdateDate = DateTime(2025, 4, 13);

      when(
        () => mockWeatherInfoCacheRepository.saveLastUpdate(lastUpdateDate),
      ).thenAnswer((_) async {});

      await saveLastUpdateCacheUseCase.call(lastUpdateDate);

      verify(
        () => mockWeatherInfoCacheRepository.saveLastUpdate(lastUpdateDate),
      ).called(1);
    });

    test(
      '| should throw an exception if saving the last update fails',
      () async {
        final lastUpdateDate = DateTime(2025, 4, 13);

        when(
          () => mockWeatherInfoCacheRepository.saveLastUpdate(lastUpdateDate),
        ).thenThrow(Exception('Failed to save last update'));

        expect(
          () => saveLastUpdateCacheUseCase.call(lastUpdateDate),
          throwsException,
        );
        verify(
          () => mockWeatherInfoCacheRepository.saveLastUpdate(lastUpdateDate),
        ).called(1);
      },
    );
  });
}
