import 'package:flutter/material.dart';

import '../../../app/injection/get_it.dart';
import '../../services/analytics_service.dart';

class BasicObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint('Basic observer - Push: (${previousRoute?.settings.name}) ==> (${route?.settings.name})');
    if (route?.settings.name != null) {
      sl<AnalyticsService>().logEvent('view_screen', eventProperties: {
        'screen_name': route?.settings.name ?? '',
        'type': 'push',
      });
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint('Basic observer - Replace: (${oldRoute?.settings.name}) ==> (${newRoute?.settings.name})');
    sl<AnalyticsService>().logEvent('view_screen', eventProperties: {
      'screen_name': newRoute?.settings.name ?? '',
      'type': 'replace',
    });
  }

  @override
  void didRemove(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint('Basic observer - Remove: (${previousRoute?.settings.name}) <== (${route?.settings.name})');
    sl<AnalyticsService>().logEvent('view_screen', eventProperties: {
      'screen_name': previousRoute?.settings.name ?? '',
      'type': 'remove',
    });
  }

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    debugPrint('Basic observer - Pop: (${previousRoute?.settings.name}) <== (${route?.settings.name})');
    sl<AnalyticsService>().logEvent('view_screen', eventProperties: {
      'screen_name': previousRoute?.settings.name ?? '',
      'type': 'pop',
    });
  }
}
