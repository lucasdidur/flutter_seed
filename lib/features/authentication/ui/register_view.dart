import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../app/injection/get_it.dart';
import '../../../core/utils/config.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/theme.dart';
import '../../../shared/services/navigation_service.dart';
import '../../../shared/ui/app_logo.dart';
import '../services/authentication_service.dart';
import 'widgets/social_login_button.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
    this.email,
    this.password,
  });

  final String? email;
  final String? password;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool loading = false;

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
  void initState() {
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
    super.initState();
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
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                gap16,
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                gap24,
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      await sl<AuthenticationService>().registerWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('An error occurred: ${e.toString()}')));
                      }
                    } finally {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  child: loading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Register'),
                ),
                TextButton(
                  onPressed: () async {
                    sl<NavigationService>().navigateToSignIn();
                  },
                  child: const Text('Already have an account? Sign In'),
                ),
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
                    SocialLoginButton.wide(
                      image: 'assets/google_on_white.png',
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
                    SocialLoginButton.wide(
                      image: 'assets/apple_on_black.png',
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
              ],
            ),
          ),
        );
      }),
    );
  }
}
