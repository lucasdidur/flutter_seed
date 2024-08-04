import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../features/settings/services/settings_service.dart';
import '../../shared/utils/navigation/basic_observer.dart';
import '../injection/get_it.dart';
import '../router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sl<SettingsService>().themeMode,
      builder: (context, mode, child) {
        return MaterialApp.router(
          routerConfig: sl<AppRouter>().config(
            navigatorObservers: () => [
              BasicObserver(),
            ],
          ),
          title: 'Flutter Demo Home Page',
          theme: FlexColorScheme.light(scheme: FlexScheme.dellGenoa).toTheme,
          darkTheme: FlexColorScheme.dark(scheme: FlexScheme.dellGenoa).toTheme,
          themeMode: mode,
          //# MATERIALAPP
        );
      },
    );
  }
}
