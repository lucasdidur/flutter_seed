import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../app/injection/get_it.dart';
import '../../../core/utils/config.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/theme.dart';
import '../../../shared/services/navigation_service.dart';
import '../../../shared/ui/app_logo.dart';
import '../services/authentication_service.dart';

@RoutePage()
class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key, this.email});

  final String? email;

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late TextEditingController emailController;

  bool loading = false;

  @override
  void initState() {
    emailController = TextEditingController(text: widget.email);

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
                const AppLogo(sideLength: 200),
                gap16,
                Center(
                    child: Text(
                  Config.appName,
                  style: context.headlineSmall.bold,
                )),
                gap8,
                Center(
                    child: Text(
                  Config.appSubtitle,
                  style: context.bodyMedium.italic,
                )),
                gap24,
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                gap24,
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      await sl<AuthenticationService>().sendPasswordResetEmail(emailController.text);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Password reset email sent')));
                      }
                      sl<NavigationService>().pop();
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('An unknown error occurred')));
                      }
                    } finally {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  child: loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Send password reset email'),
                ),
                gap16,
                TextButton(
                  onPressed: () {
                    sl<NavigationService>().pop();
                  },
                  child: const Text('Back to sign in'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
