import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/injection/get_it.dart';

@LazySingleton()
class SettingsService {
  ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(getThemeModeFromString(sl<SharedPreferences>().getString('theme_mode') ?? 'ThemeMode.system'));

  void setThemeMode(String val) {
    debugPrint('val: $val');
    sl<SharedPreferences>().setString('theme_mode', val);
    themeMode.value = getThemeModeFromString(val);
  }

  static ThemeMode getThemeModeFromString(String val) {
    return ThemeMode.values.firstWhere((e) => e.toString() == val);
  }
}
