import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/core/theme/app_colors.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_card_design_enum.dart';

void main() {
  group('WeatherCardDesignEnum', () {
    test('| should have correct values', () {
      expect(WeatherCardDesignEnum.values.length, 3);
      expect(
        WeatherCardDesignEnum.values,
        contains(WeatherCardDesignEnum.cold),
      );
      expect(
        WeatherCardDesignEnum.values,
        contains(WeatherCardDesignEnum.normal),
      );
      expect(WeatherCardDesignEnum.values, contains(WeatherCardDesignEnum.hot));
    });

    test('| should return correct properties for each enum value', () {
      expect(
        WeatherCardDesignEnum.cold.surfaceStart,
        AppColors.surfaceBlueStart,
      );
      expect(WeatherCardDesignEnum.cold.surfaceEnd, AppColors.surfaceBlueEnd);
      expect(WeatherCardDesignEnum.cold.backgroundAsset, isNotNull);

      expect(
        WeatherCardDesignEnum.normal.surfaceStart,
        AppColors.surfaceRedStart,
      );
      expect(WeatherCardDesignEnum.normal.surfaceEnd, AppColors.surfaceRedEnd);
      expect(WeatherCardDesignEnum.normal.backgroundAsset, isNotNull);

      expect(
        WeatherCardDesignEnum.hot.surfaceStart,
        AppColors.surfaceOrangeStart,
      );
      expect(WeatherCardDesignEnum.hot.surfaceEnd, AppColors.surfaceOrangeEnd);
      expect(WeatherCardDesignEnum.hot.backgroundAsset, isNull);
    });

    test(
      '| should map temperature to correct enum value using fromTempeture',
      () {
        expect(
          WeatherCardDesignEnum.fromTempeture(0),
          WeatherCardDesignEnum.cold,
        );
        expect(
          WeatherCardDesignEnum.fromTempeture(10),
          WeatherCardDesignEnum.normal,
        );
        expect(
          WeatherCardDesignEnum.fromTempeture(30),
          WeatherCardDesignEnum.hot,
        );
      },
    );
  });
}
