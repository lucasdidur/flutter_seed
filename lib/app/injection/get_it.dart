import 'get_it.config.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:injectable/injectable.dart';

const firebase = Environment('firebase');
const supabase = Environment('supabase');
const appwrite = Environment('appwrite');
const pocketbase = Environment('pocketbase');
const amplitude = Environment('amplitude');
const posthog = Environment('posthog');
const fanalytics = Environment('fanalytics');

final getIt = GetIt.instance;
final sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async => await getIt.init(
      environmentFilter: NoEnvOrContainsAny(
        {
          // firebase, supabase, pocketbase, appwrite
          const String.fromEnvironment('PAAS', defaultValue: 'supabase'),
          // amplitude, posthog, fanalytics
          const String.fromEnvironment('analytics', defaultValue: 'fanalytics'),
        },
      ),
    );

// https://pub.dev/packages/injectable#pre-resolving-futures
@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get sharedPrefs => SharedPreferences.getInstance();
}
