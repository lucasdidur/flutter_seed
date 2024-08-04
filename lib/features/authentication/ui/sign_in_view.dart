import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/injection/get_it.dart';
import '../../../core/utils/config.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/theme.dart';
import '../../../shared/services/navigation_service.dart';
import '../../../shared/ui/app_logo.dart';
import '../services/authentication_service.dart';
import 'widgets/social_login_button.dart';

@RoutePage()
class SignInView extends StatefulWidget {
  const SignInView({
    super.key,
    this.email,
    this.password,
  });

  final String? email;
  final String? password;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool loading = false;
  bool obscureText = true;

  @override
  void initState() {
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
    super.initState();
  }

  Future<void> runWithLoading(Future<void> Function() future) async {
    setState(() => loading = true);

    try {
      await future();
    } catch (e) {
      rethrow;
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(24),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLogo(sideLength: 100),
                    gap16,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Config.appName,
                            style: context.headlineSmall.bold,
                          ),
                          gap8,
                          Text(
                            Config.appSubtitle,
                            style: context.bodyMedium.italic,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                gap32,
                TextField(
                  controller: emailController,
                  autofillHints: [AutofillHints.username],
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                gap16,
                TextField(
                  controller: passwordController,
                  autofillHints: [AutofillHints.password],
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                      onPressed: obscureText
                          ? () {
                              setState(() {
                                obscureText = false;
                              });
                            }
                          : () {
                              setState(() {
                                obscureText = true;
                              });
                            },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: obscureText,
                ),
                gap8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        sl<NavigationService>().pushNamedRoute('/forgot-password');
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
                gap8,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  onPressed: () async {
                    TextInput.finishAutofillContext();

                    await runWithLoading(() async {
                      try {
                        await sl<AuthenticationService>().signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }
                    });
                  },
                  child: loading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Sign In',
                          style: context.bodyLarge.bold.copyWith(color: Colors.white),
                        ),
                ),
                gap8,
                TextButton(
                  onPressed: () {
                    sl<NavigationService>().pushNamedRoute('/register');
                  },
                  child: const Text('Don\'t have an account? Sign Up'),
                ),
                //* Social Login *//
                gap24,
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: context.primary),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('or', style: context.bodyMedium),
                    ),
                    Expanded(
                      child: Divider(
                        color: context.primary,
                      ),
                    )
                  ],
                ),
                gap32,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // https://developers.google.com/identity/branding-guidelines
                    SocialLoginButton.wide(
                      image: 'assets/icons/google_on_white.png',
                      provider: 'Google',
                      onPressed: () async {
                        await runWithLoading(() async {
                          try {
                            await sl<AuthenticationService>().signInWithGoogle();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        });
                      },
                    ),
                    gap8,
                    // https://developer.apple.com/design/resources/
                    SocialLoginButton.wide(
                      image: 'assets/icons/apple_on_black.png',
                      provider: 'Apple',
                      onPressed: () async {
                        await runWithLoading(() async {
                          try {
                            await sl<AuthenticationService>().signInWithApple();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ],
                )
                //* Social Login *//
              ],
            ),
          ),
        );
      }),
    );
  }
}
