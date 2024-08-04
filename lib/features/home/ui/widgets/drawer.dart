import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/gen/assets.gen.dart';
import '../../../../app/injection/get_it.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/services/navigation_service.dart';
import '../../../../shared/ui/app_logo.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key, this.wideScreen = false});

  final bool wideScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: wideScreen ? Colors.transparent : context.background,
      elevation: 0,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Center(
                      child: Assets.images.logo.image(),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.of(context).pop();
                      sl<NavigationService>().pushNamedRoute('/profile');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Subscriptions'),
                    onTap: () {
                      Navigator.of(context).pop();
                      sl<NavigationService>().pushNamedRoute('/subscriptions');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.thumb_up),
                    title: const Text('Leave Feedback'),
                    onTap: () {
                      Navigator.of(context).pop();
                      sl<NavigationService>().pushNamedRoute('/new-feedback');
                    },
                  ),
                  if (kDebugMode)
                    ListTile(
                      leading: const Icon(Icons.visibility),
                      title: const Text('View Feedback'),
                      subtitle: const Text('Debug only'),
                      onTap: () {
                        Navigator.of(context).pop();
                        sl<NavigationService>().pushNamedRoute('/feedback');
                      },
                    ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.of(context).pop();
                      sl<NavigationService>().pushNamedRoute('/settings');
                    },
                  ),
                  //# DRAWER ROUTES
                ],
              ),
            ),
            const AboutListTile(
              applicationName: 'didur_drive_test',
              dense: true,
              applicationIcon: AppLogo(sideLength: 48),
              aboutBoxChildren: [
                Text('didur_drive_test is a Flutter application.'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(Config.privacyPolicy));
                    },
                    child: Text(
                      'Privacy Policy',
                      style: context.bodySmall,
                    ),
                  ),
                  gap8,
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(Config.termsOfService));
                    },
                    child: Text(
                      'Terms of Service',
                      style: context.bodySmall,
                    ),
                  ),
                  gap8,
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Version: ${snapshot.data!.version}',
                          style: context.bodySmall,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
