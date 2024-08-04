import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../app/injection/get_it.dart';
import '../../../core/utils/config.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/theme.dart';
import '../../../shared/services/navigation_service.dart';
import '../../../shared/ui/app_logo.dart';
import '../services/authentication_service.dart';

@RoutePage()
class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, this.code});

  final String? code;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool loading = false;

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
                  controller: newPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                gap16,
                TextField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                gap24,
                ElevatedButton(
                  onPressed: () async {
                    if (newPasswordController.text != confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Passwords do not match!'),
                      ));
                      return;
                    }

                    setState(() {
                      loading = true;
                    });
                    try {
                      await sl<AuthenticationService>().resetPassword(newPassword: newPasswordController.text);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Password Updated!'),
                      ));
                      sl<NavigationService>().navigateToHome();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString()),
                      ));
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
                      : const Text('Reset Password'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
