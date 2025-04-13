import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/src/core/plugins/local_storage/local_storage.dart';
import 'package:weather_forecast/src/core/plugins/local_storage/local_storage_shared_preferences_impl.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client_dio_impl.dart';
import 'package:weather_forecast/src/features/home/data/datasources/weather_info_cache_datasource.dart';
import 'package:weather_forecast/src/features/home/data/datasources/weather_info_datasource.dart';
import 'package:weather_forecast/src/features/home/data/repositories/weather_info_cache_repository_impl.dart';
import 'package:weather_forecast/src/features/home/data/repositories/weather_info_repository_impl.dart';
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
import 'package:weather_forecast/src/features/home/external/datasources/weather_info_cache_datasource_impl.dart';
import 'package:weather_forecast/src/features/home/external/datasources/weather_info_datasource_impl.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';

class RegisterDependencies {
  static Future<void> init() async {
    // Plugins
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut<RequestClient>(() => RequestHttpDioImpl());
    Get.lazyPut<LocalStorage>(
      () => SharedPreferencesStorage(sharedPreferences),
    );

    // Datasources
    Get.lazyPut<WeatherInfoDatasource>(
      () => WeatherInfoDatasourceImpl(requestClient: Get.find()),
    );
    Get.lazyPut<WeatherInfoCacheDatasource>(
      () => WeatherInfoCacheDatasourceImpl(localStorage: Get.find()),
    );

    // Repositories
    Get.lazyPut<WeatherInfoRepository>(
      () => WeatherInfoRepositoryImpl(datasource: Get.find()),
    );
    Get.lazyPut<WeatherInfoCacheRepository>(
      () => WeatherInfoCacheRepositoryImpl(datasource: Get.find()),
    );

    // Usecases
    Get.lazyPut<FetchWeatherFromCityUsecase>(
      () => FetchWeatherFromCityUsecaseImpl(repository: Get.find()),
    );
    Get.lazyPut<TreatWeatherInfoUsecase>(() => TreatWeatherInfoUsecaseImpl());
    Get.lazyPut<FetchUpdatedWeatherInfoUsecase>(
      () => FetchUpdatedWeatherInfoUsecaseImpl(
        fetchWeatherFromCityUsecase: Get.find(),
        treatWeatherInfoUsecase: Get.find(),
      ),
    );
    Get.lazyPut<SaveLastUpdateCacheUsecase>(
      () => SaveLastUpdateCacheUsecaseImpl(repository: Get.find()),
    );
    Get.lazyPut<SaveWeatherInfoCacheUsecase>(
      () => SaveWeatherInfoCacheUsecaseImpl(repository: Get.find()),
    );
    Get.lazyPut<GetLastUpdateCacheUseCase>(
      () => GetLastUpdateCacheUseCaseImpl(repository: Get.find()),
    );
    Get.lazyPut<GetWeatherInfoCacheUsecase>(
      () => GetWeatherInfoCacheUsecaseImpl(repository: Get.find()),
    );

    // Facades
    Get.lazyPut<WeatherInfoFacade>(
      () => WeatherInfoFacadeImpl(
        fetchUpdatedWeatherInfoUsecase: Get.find(),
        saveLastUpdateCacheUsecase: Get.find(),
        saveWeatherInfoCacheUsecase: Get.find(),
        getLastUpdateCacheUseCase: Get.find(),
        getWeatherInfoCacheUsecase: Get.find(),
      ),
    );

    // Presenters
    Get.put<WeatherPresenter>(WeatherPresenter(weatherInfoFacade: Get.find()));
  }
}
