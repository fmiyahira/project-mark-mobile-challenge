abstract class LocalStorage {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
}
