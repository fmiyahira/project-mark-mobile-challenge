import 'package:get/instance_manager.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client.dart';
import 'package:weather_forecast/src/core/plugins/request_client/request_client_dio_impl.dart';
import 'package:weather_forecast/src/features/home/data/datasources/weather_info_datasource.dart';
import 'package:weather_forecast/src/features/home/data/repositories/weather_info_repository_impl.dart';
import 'package:weather_forecast/src/features/home/domain/facades/weather_info_facade.dart';
import 'package:weather_forecast/src/features/home/domain/repositories/weather_info_repository.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_updated_weather_info_usecase.dart';
import 'package:weather_forecast/src/features/home/domain/usecases/fetch_weather_info_usecase.dart';
import 'package:weather_forecast/src/features/home/external/datasources/weather_info_datasource_impl.dart';
import 'package:weather_forecast/src/features/home/presentation/presenter/home_presenter.dart';

class RegisterDependencies {
  static void init() {
    // Plugins
    Get.lazyPut<RequestClient>(() => RequestHttpDioImpl());

    // Datasources
    Get.lazyPut<WeatherInfoDatasource>(
      () => WeatherInfoDatasourceImpl(requestClient: Get.find()),
    );

    // Repositories
    Get.lazyPut<WeatherInfoRepository>(
      () => WeatherInfoRepositoryImpl(datasource: Get.find()),
    );

    // Usecases
    Get.lazyPut<FetchWeatherFromCityUsecase>(
      () => FetchWeatherFromCityUsecaseImpl(repository: Get.find()),
    );
    Get.lazyPut<FetchUpdatedWeatherInfoUsecase>(
      () => FetchUpdatedWeatherInfoUsecaseImpl(
        fetchWeatherFromCityUsecase: Get.find(),
      ),
    );

    // Facades
    Get.lazyPut<WeatherInfoFacade>(
      () => WeatherInfoFacadeImpl(fetchUpdatedWeatherInfoUsecase: Get.find()),
    );

    // Presenters
    Get.lazyPut<WeatherPresenter>(
      () => WeatherPresenter(weatherInfoFacade: Get.find()),
    );
  }
}
