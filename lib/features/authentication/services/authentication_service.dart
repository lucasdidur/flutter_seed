import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:universal_io/io.dart';

import '../../../app/injection/get_it.dart';
import '../../../app/router/router.dart';
import 'user_service.dart';

@LazySingleton()
class AuthenticationService {
  void onSignedIn(String userId) {
    //# AUTHENTICATION SIGN IN
    debugPrint('User signed in: $userId');
    sl<UserService>().getUser();
    sl<UserService>().updateLastLogin();
  }

  void onSignedOut() {
    //# AUTHENTICATION SIGN OUT
    debugPrint('User signed out');
  }

  SupabaseClient get _supabase => Supabase.instance.client;

  bool get loggedIn => _supabase.auth.currentSession != null;

  String? get id => _supabase.auth.currentUser?.id;

  String? get email => _supabase.auth.currentUser?.email;

  Future<void> initialize() async {
    await Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_URL'),
      anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
      debug: false,
    );

    _supabase.auth.onAuthStateChange.listen((AuthState state) {
      if (state.event == AuthChangeEvent.signedIn) {
        if (state.session?.user.id != null) {
          sl<UserService>().createUser().then(
            ((value) {
              onSignedIn(state.session!.user.id);
              sl<AppRouter>().replaceNamed('/');
            }),
          );
        }
      } else if (state.event == AuthChangeEvent.initialSession) {
        if (state.session != null) onSignedIn(state.session!.user.id);
      } else if (state.event == AuthChangeEvent.signedOut) {
        onSignedOut();
      }
    });
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) {
    return _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() {
    //# SIGN OUT
    return _supabase.auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _supabase.auth.resetPasswordForEmail(
      email,
      // TODO Change this to your reset password page
      redirectTo: 'localhost:3000/reset-password',
    );
  }

  Future<void> registerWithEmailAndPassword({required String email, required String password}) {
    return _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signInWithApple() async {
    try {
      if (Platform.isIOS) {
        final rawNonce = _supabase.auth.generateRawNonce();
        final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: hashedNonce,
        );

        final idToken = credential.identityToken;
        if (idToken == null) {
          throw const AuthException('Could not find ID Token from generated credential.');
        }

        await _supabase.auth.signInWithIdToken(
          provider: OAuthProvider.apple,
          idToken: idToken,
          nonce: rawNonce,
        );
      } else {
        const redirectTo = kIsWeb
            ? "https://xgiwtcbryqkepaaftabz.supabase.co/auth/v1/callback"
            : "com.cotr.didur_drive_test://login-callback/";

        await _supabase.auth.signInWithOAuth(
          OAuthProvider.apple,
          redirectTo: redirectTo, // 'my-scheme://login-callback',
          authScreenLaunchMode: LaunchMode.platformDefault,
        );
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      debugPrint('Error signing in with Apple: $e');
      throw e.message;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      /// Web Client ID that you registered with Google Cloud.
      const webClientId = String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');

      /// iOS Client ID that you registered with Google Cloud.
      const iosClientId = String.fromEnvironment('GOOGLE_IOS_CLIENT_ID');

      // Google sign in on Android will work without providing the Android
      // Client ID registered on Google Cloud.

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: kIsWeb ? null : iosClientId,
        serverClientId: kIsWeb ? null : webClientId,
      );

      var googleUser = kIsWeb ? await googleSignIn.signInSilently() : await googleSignIn.signIn();

      if (kIsWeb && googleUser == null) {
        googleUser = await (googleSignIn.signIn());

        if (googleUser != null) {
          debugPrint('Re-authenticating user.');
          googleUser = await googleSignIn.signInSilently(reAuthenticate: true);
        }
      }

      if (googleUser == null) {
        throw 'Google Sign In failed.';
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (!kIsWeb && accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }
      await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> signInWithPhoneNumber({required String phoneNumber}) async {
    await _supabase.auth.signInWithOtp(phone: phoneNumber);
  }

  Future<void> resetPassword({required String newPassword}) async {
    try {
      await _supabase.auth.updateUser(UserAttributes(
        password: newPassword,
      ));
    } catch (e) {
      debugPrint('Error resetting password: $e');
      rethrow;
    }
  }
}
