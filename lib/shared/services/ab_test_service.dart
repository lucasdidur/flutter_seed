import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart' as html;

@LazySingleton()
class AbTestService {
  final remoteConfig = FirebaseRemoteConfig.instance;

  /// Determine if a feature is enabled on web
  /// Useful for QA testing on/off features
  /// Turn a feature on manually by setting a cookie with the feature name to 'true'
  /// Turn a feature off manually by setting a cookie with the feature name to 'false'
  ///
  /// Example:
  ///   show_onboarding=true
  Future<bool> isFeatureEnabledWeb(ConfigValue feature) async {
    // get value from cookies
    if (kIsWeb) {
      final cookies = html.document.cookie?.split('; ') ?? [];
      for (var cookie in cookies) {
        final cookieParts = cookie.split('=');
        if (cookieParts.length == 2 && cookieParts[0] == feature.label) {
          if (cookieParts[1] == 'true') {
            return true;
          } else {
            return false;
          }
        }
      }
      return false;
    }

    return isFeatureEnabled(feature);
  }

  Future<void> initialize() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.setDefaults(Map.fromEntries(ConfigValue.values.map((e) => MapEntry(e.label, e.defaultValue))));
  }

  Future<bool> isFeatureEnabled(ConfigValue feature) {
    return Future.value(remoteConfig.getBool(feature.label));
  }

  Future<String> getStringValue(ConfigValue key) {
    return Future.value(remoteConfig.getString(key.label));
  }
}

enum ConfigValue {
  showOnboarding('show_onboarding', defaultValue: true),
  showNotifications('show_notifications', defaultValue: true);

  const ConfigValue(this.label, {this.defaultValue});

  final String label;
  final dynamic defaultValue;
}
