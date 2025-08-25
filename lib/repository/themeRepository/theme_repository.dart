import 'package:e_commerce/data/local/local_storage_service.dart';
import 'package:e_commerce/data/local/storage_keys.dart';

class ThemeRepository {
  ThemeRepository({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  final LocalStorageService _localStorageService;

  String getThemeMode() {
    return _localStorageService.getLocalData(key: StorageKeys.themeKey);
  }

  Future storeThemeMode(String mode) async {
    await _localStorageService.addData(key: StorageKeys.themeKey, data: mode);
  }
}
