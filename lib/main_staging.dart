import 'app/app.dart';
import 'bootstrap.dart';

import 'app/firebase/firebase_options_development.dart';

void main() {
  bootstrap(
    () => const App(),
    environment: 'supabase',
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
}
