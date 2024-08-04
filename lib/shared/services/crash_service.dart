import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:injectable/injectable.dart';

@LazySingleton()
class CrashService {
  void fakeCrash() {
    throw Exception();
  }

  void fakeNativeCrash() {
    FirebaseCrashlytics.instance.crash();
  }
}
