import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'app/injection/get_it.dart';
import 'features/authentication/services/authentication_service.dart';
import 'shared/services/ab_test_service.dart';
import 'shared/services/analytics_service.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

setup({
  required String environment,
  FirebaseOptions? firebaseOptions,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (firebaseOptions != null) {
    await Firebase.initializeApp(
      options: firebaseOptions,
    );

    FlutterError.onError = (errorDetails) {
      //log(details.exceptionAsString(), stackTrace: details.stack);
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  await configureDependencies();

  await sl<AuthenticationService>().initialize();
  await sl<AbTestService>().initialize();
  await sl<AnalyticsService>().initialize();
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required String environment,
  FirebaseOptions? firebaseOptions,
}) async {
  await setup(environment: environment, firebaseOptions: firebaseOptions);

  Bloc.observer = const AppBlocObserver();

  runApp(await builder());
}
