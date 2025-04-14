import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/src/core/plugins/local_storage/local_storage_shared_preferences_impl.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferencesStorage storage;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    storage = SharedPreferencesStorage(mockSharedPreferences);
  });

  group('SharedPreferencesStorage', () {
    test('| saveString should save a string in SharedPreferences', () async {
      const key = 'test_key';
      const value = 'test_value';

      when(
        () => mockSharedPreferences.setString(key, value),
      ).thenAnswer((_) async => true);

      await storage.saveString(key, value);

      verify(() => mockSharedPreferences.setString(key, value)).called(1);
    });

    group('| getString', () {
      test(
        '| getString should return a string from SharedPreferences',
        () async {
          const key = 'test_key';
          const value = 'test_value';

          when(() => mockSharedPreferences.getString(key)).thenReturn(value);

          final result = await storage.getString(key);

          expect(result, value);
          verify(() => mockSharedPreferences.getString(key)).called(1);
        },
      );

      test('| getString should return null if key does not exist', () async {
        const key = 'non_existent_key';

        when(() => mockSharedPreferences.getString(key)).thenReturn(null);

        final result = await storage.getString(key);

        expect(result, isNull);
        verify(() => mockSharedPreferences.getString(key)).called(1);
      });
    });
  });
}
