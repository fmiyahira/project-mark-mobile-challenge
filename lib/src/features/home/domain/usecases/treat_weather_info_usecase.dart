import 'package:weather_forecast/src/features/home/domain/models/daily_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/hourly_weather_model.dart';
import 'package:weather_forecast/src/features/home/domain/models/weather_model.dart';

abstract class TreatWeatherInfoUsecase {
  WeatherModel call(WeatherModel weatherModel);
}

class TreatWeatherInfoUsecaseImpl implements TreatWeatherInfoUsecase {
  @override
  WeatherModel call(WeatherModel weatherModel) {
    // filter out the unnecessary data (hourly from other days)
    final List<HourlyWeatherModel> listHourlyWeather =
        weatherModel.hourly
            .where(
              (HourlyWeatherModel hourlyWeatherModel) =>
                  hourlyWeatherModel.date.day == DateTime.now().day,
            )
            .toList();

    // filter out the unnecessary data (today)
    final List<DailyWeatherModel> listDailyWeatherModel =
        weatherModel.daily
            .where(
              (DailyWeatherModel dailyWeatherModel) =>
                  dailyWeatherModel.date.day != DateTime.now().day,
            )
            .toList();

    return weatherModel.copyWith(
      hourly: listHourlyWeather,
      daily: listDailyWeatherModel,
    );
  }
}
