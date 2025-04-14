import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/src/features/home/domain/enums/weather_condition_enum.dart';

void main() {
  group('WeatherConditionEnum', () {
    test('| should return sunny for "Clear"', () {
      final result = WeatherConditionEnum.fromString('Clear');
      expect(result, WeatherConditionEnum.sunny);
      expect(result.condition, 'Clear');
    });

    test('| should return lightning for "Thunderstorm"', () {
      final result = WeatherConditionEnum.fromString('Thunderstorm');
      expect(result, WeatherConditionEnum.lightning);
      expect(result.condition, 'Thunderstorm');
    });

    test('| should return rainy for "Rain"', () {
      final result = WeatherConditionEnum.fromString('Rain');
      expect(result, WeatherConditionEnum.rainy);
      expect(result.condition, 'Rain');
    });

    test('| should return cloudy for "Clouds"', () {
      final result = WeatherConditionEnum.fromString('Clouds');
      expect(result, WeatherConditionEnum.cloudy);
      expect(result.condition, 'Clouds');
    });

    test('| should default to sunny for unknown conditions', () {
      final result = WeatherConditionEnum.fromString('Unknown');
      expect(result, WeatherConditionEnum.sunny);
      expect(result.condition, 'Clear');
    });
  });
}
