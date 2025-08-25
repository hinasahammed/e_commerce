import 'package:e_commerce/data/local/local_storage_service.dart';
import 'package:e_commerce/repository/themeRepository/theme_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Should be initialized in main.dart');
});

final localStorageServiceProvider = Provider((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(sharedPreferences: sharedPreferences);
});

final themeRepositoryProvider = Provider((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return ThemeRepository(localStorageService: localStorageService);
});