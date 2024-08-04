import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../features/authentication/ui/forgot_password_view.dart';
import '../../features/authentication/ui/profile_view.dart';
import '../../features/authentication/ui/register_view.dart';
import '../../features/authentication/ui/reset_password_view.dart';
import '../../features/authentication/ui/sign_in_view.dart';
import '../../features/feedback/ui/feedback/feedback_view.dart';
import '../../features/feedback/ui/new_feedback/new_feedback_view.dart';
import '../../features/home/ui/home_view.dart';
import '../../features/onboarding/ui/onboarding_view.dart';
import '../../features/settings/ui/settings_view.dart';
import '../../shared/utils/navigation/auth_guard.dart';

part 'router.gr.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: ('View,Route'))
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        //# ROUTES
        AutoRoute(page: HomeRoute.page, initial: true, guards: [AuthGuard()]),
        AutoRoute(page: OnboardingRoute.page, guards: [AuthGuard()], path: '/onboarding'),
        AutoRoute(page: SignInRoute.page, path: '/sign-in'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: ForgotPasswordRoute.page, path: '/forgot-password'),
        AutoRoute(page: ResetPasswordRoute.page, path: '/reset-password'),
        AutoRoute(page: ProfileRoute.page, path: '/profile'),
        AutoRoute(page: SettingsRoute.page, path: '/settings'),

        //* Chat *//
        // AutoRoute(page: ChatRoute.page),
        //* Chat *//

        AutoRoute(page: FeedbackRoute.page, path: '/feedback'),
        AutoRoute(page: NewFeedbackRoute.page, path: '/new-feedback'),
        // AutoRoute(page: RssRoute.page),

        // AutoRoute(page: SubscriptionRoute.page),

        // New Routes
      ];
}
