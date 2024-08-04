import 'package:injectable/injectable.dart';

import '../../app/injection/get_it.dart';
import '../../app/router/router.dart';

@LazySingleton()
class NavigationService {
  void navigateToHome() {
    sl<AppRouter>().navigateNamed('/');
  }

  void navigateToSignIn() {
    sl<AppRouter>().navigateNamed('/sign-in');
  }

  void pushNamedRoute(String routeName, {bool popFirst = false}) {
    if (popFirst) {
      sl<AppRouter>().maybePop();
      sl<AppRouter>().navigateNamed(routeName);
    } else {
      sl<AppRouter>().navigateNamed(routeName);
    }
  }

  void replaceNamed(String routeName) {
    sl<AppRouter>().replaceNamed(routeName);
  }

  void pop() {
    sl<AppRouter>().maybePop();
  }
}
