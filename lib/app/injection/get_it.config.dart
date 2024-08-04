// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/authentication/services/authentication_service.dart'
    as _i680;
import '../../features/authentication/services/user_service.dart' as _i260;
import '../../features/feedback/services/fast_feedback_service.dart' as _i648;
import '../../features/feedback/services/supabase_feedback_service.dart'
    as _i472;
import '../../features/settings/services/settings_service.dart' as _i647;
import '../../shared/services/ab_test_service.dart' as _i38;
import '../../shared/services/analytics_service.dart' as _i152;
import '../../shared/services/crash_service.dart' as _i723;
import '../../shared/services/navigation_service.dart' as _i1060;
import '../../shared/services/serialization_service.dart' as _i807;
import '../router/router.dart' as _i285;
import 'get_it.dart' as _i241;

const String _supabase = 'supabase';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPrefs,
      preResolve: true,
    );
    gh.singleton<_i285.AppRouter>(() => _i285.AppRouter());
    gh.lazySingleton<_i647.SettingsService>(() => _i647.SettingsService());
    gh.lazySingleton<_i680.AuthenticationService>(
        () => _i680.AuthenticationService());
    gh.lazySingleton<_i260.UserService>(() => _i260.UserService());
    gh.lazySingleton<_i1060.NavigationService>(
        () => _i1060.NavigationService());
    gh.lazySingleton<_i152.AnalyticsService>(() => _i152.AnalyticsService());
    gh.lazySingleton<_i807.SerializationService>(
        () => _i807.SerializationService());
    gh.lazySingleton<_i723.CrashService>(() => _i723.CrashService());
    gh.lazySingleton<_i38.AbTestService>(() => _i38.AbTestService());
    gh.lazySingleton<_i648.FastFeedbackService>(
      () => _i472.SupabaseFeedbackService(),
      registerFor: {_supabase},
    );
    return this;
  }
}

class _$RegisterModule extends _i241.RegisterModule {}
