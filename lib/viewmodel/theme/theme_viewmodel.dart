import 'package:e_commerce/repository/themeRepository/theme_repository.dart';
import 'package:e_commerce/res/components/enums/enums.dart';
import 'package:e_commerce/viewmodel/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_viewmodel.g.dart';

class ThemeState {
  ThemeState({this.currentTheme = AppThemeMode.light});
  final AppThemeMode currentTheme;

  ThemeState copyWith({AppThemeMode? currentTheme}) {
    return ThemeState(currentTheme: currentTheme ?? this.currentTheme);
  }
}

@riverpod
class ThemeViewmodel extends _$ThemeViewmodel {
  late ThemeRepository _repo;

  @override
  ThemeState build() {
    _repo = ref.watch(themeRepositoryProvider);

    final savedTheme = _repo.getThemeMode();
    final initialTheme = savedTheme.isNotEmpty
        ? getMode(savedTheme)
        : AppThemeMode.light;

    return ThemeState(currentTheme: initialTheme);
  }

  Future<void> changeTheme(AppThemeMode mode) async {
    final modeString = getModeString(mode);
    await _repo.storeThemeMode(modeString);
    state = state.copyWith(currentTheme: mode);
  }

  AppThemeMode getMode(String mode) {
    switch (mode) {
      case "0":
        return AppThemeMode.light;
      case "1":
        return AppThemeMode.dark;
      case "2":
        return AppThemeMode.system;
      default:
        return AppThemeMode.light;
    }
  }

  String getModeString(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return "0";
      case AppThemeMode.dark:
        return "1";
      case AppThemeMode.system:
        return "2";
    }
  }

  ThemeMode getCurrentThemeMode() {
    switch (state.currentTheme) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
