import 'package:e_commerce/res/components/constants/theme/app_theme.dart';
import 'package:e_commerce/res/components/enums/enums.dart';
import 'package:e_commerce/res/components/router/app_router.dart';
import 'package:e_commerce/viewmodel/provider/providers.dart';
import 'package:e_commerce/viewmodel/theme/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(pref)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentTheme = ref.watch(
          themeViewmodelProvider.select((value) => value.currentTheme),
        );
        return MaterialApp.router(
          title: 'Fresh Cart',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: switch (currentTheme) {
            AppThemeMode.light => ThemeMode.light,
            AppThemeMode.dark => ThemeMode.dark,
            AppThemeMode.system => ThemeMode.system,
          },
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
