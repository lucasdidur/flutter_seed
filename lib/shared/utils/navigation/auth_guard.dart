import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app/injection/get_it.dart';
import '../../../app/router/router.dart';
import '../../../features/authentication/services/authentication_service.dart';

/// The guarded screen requires an authenticated user
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (sl<AuthenticationService>().loggedIn) {
      // If the user is authenticated, continue
      debugPrint('[AuthGuard] User is authenticated');
      resolver.next(true);
    } else {
      // Otherwise, redirect to the first screen
      debugPrint('[AuthGuard] User not authenticated');
      router.replace(SignInRoute());
    }
  }
}
