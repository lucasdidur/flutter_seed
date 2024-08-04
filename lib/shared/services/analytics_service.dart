import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:injectable/injectable.dart';

import '../utils/recase.dart';

@LazySingleton()
class AnalyticsService {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> initialize() {
    return Future.value();
  }

  void logEvent(String eventName, {Map<String, dynamic>? eventProperties}) {
    analytics.logEvent(name: ReCase(eventName).snakeCase, parameters: eventProperties);
  }

  void updateUserId(String? userId) {
    analytics.setUserId(id: userId);
  }

  void updateUserProperties(
    Map<String, dynamic> userProperties, {
    bool setOnce = false,
    String? userId,
  }) {
    if (userId == null) {
      //# AUTHENTICATION USER ID
    }
    userProperties.forEach((key, value) {
      analytics.setUserProperty(name: key, value: value);
    });
  }

  void updateVersionId(String? versionId, {String? userId}) {
    if (userId == null) {
      //# AUTHENTICATION USER ID
    }
    analytics.setUserProperty(name: 'app_version', value: versionId);
  }
}
