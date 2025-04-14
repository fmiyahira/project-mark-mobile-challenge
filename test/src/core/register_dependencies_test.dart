import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/src/core/plugins/local_storage/local_storage.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client.dart';
import 'package:weather_forecast/src/core/register_dependencies.dart';
import 'package:weather_forecast/src/features/home/data/datasources/weather_info_cache_datasource.dart';
import 'package:weather_forecast/src/features/home/data/datasources/weather_info_datasource.dart';
import 'package:weather_forecast/src/features/home/domain/facades/weather_info_facade.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_cache_repository.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_repository.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_updated_weather_info_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_weather_from_city_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/get_last_update_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/get_weather_info_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/save_last_update_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/save_weather_info_cache_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/treat_weather_info_usecase.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});

    Get.reset();
    await RegisterDependencies.init();
  });

  tearDown(() {
    Get.reset();
  });

  group('RegisterDependencies', () {
    test('should register RequestClient', () {
      final requestClient = Get.find<RequestClient>();
      expect(requestClient, isNotNull);
    });

    test('should register LocalStorage', () {
      final localStorage = Get.find<LocalStorage>();
      expect(localStorage, isNotNull);
    });

    test('should register WeatherInfoDatasource', () {
      final datasource = Get.find<WeatherInfoDatasource>();
      expect(datasource, isNotNull);
    });

    test('should register WeatherInfoCacheDatasource', () {
      final cacheDatasource = Get.find<WeatherInfoCacheDatasource>();
      expect(cacheDatasource, isNotNull);
    });

    test('should register WeatherInfoRepository', () {
      final repository = Get.find<WeatherInfoRepository>();
      expect(repository, isNotNull);
    });

    test('should register WeatherInfoCacheRepository', () {
      final cacheRepository = Get.find<WeatherInfoCacheRepository>();
      expect(cacheRepository, isNotNull);
    });

    test('should register FetchWeatherFromCityUsecase', () {
      final usecase = Get.find<FetchWeatherFromCityUsecase>();
      expect(usecase, isNotNull);
    });

    test('should register TreatWeatherInfoUsecase', () {
      final usecase = Get.find<TreatWeatherInfoUsecase>();
      expect(usecase, isNotNull);
    });

    test('should register FetchUpdatedWeatherInfoUsecase', () {
      final usecase = Get.find<FetchUpdatedWeatherInfoUsecase>();
      expect(usecase, isNotNull);
    });

    test('should register SaveLastUpdateCacheUsecase', () {
      final usecase = Get.find<SaveLastUpdateCacheUsecase>();
      expect(usecase, isNotNull);
    });

    test('should register SaveWeatherInfoCacheUsecase', () {
      final usecase = Get.find<SaveWeatherInfoCacheUsecase>();
      expect(usecase, isNotNull);
    });

    test('should register GetLastUpdateCacheUseCase', () {
      final usecase = Get.find<GetLastUpdateCacheUseCase>();
      expect(usecase, isNotNull);
    });

    test('should register GetWeatherInfoCacheUsecase', () {
      final usecase = Get.find<GetWeatherInfoCacheUsecase>();
      expect(usecase, isNotNull);
    });

    test('should register WeatherInfoFacade', () {
      final facade = Get.find<WeatherInfoFacade>();
      expect(facade, isNotNull);
    });

    test('should register IHomePresenter', () {
      final presenter = Get.find<IHomePresenter>();
      expect(presenter, isNotNull);
    });
  });
}
