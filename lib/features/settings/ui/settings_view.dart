import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../app/injection/get_it.dart';
import '../../../core/utils/theme.dart';
import '../../../shared/ui/layout.dart';
import '../services/settings_service.dart';

@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Layout(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Display',
                style: context.titleMedium.bold,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: sl<SettingsService>().themeMode,
                builder: (context, mode, child) {
                  return Column(
                    children: [
                      RadioListTile<ThemeMode>(
                        title: const Text('Light'),
                        value: ThemeMode.light,
                        groupValue: mode,
                        onChanged: (value) {
                          sl<SettingsService>().setThemeMode(value.toString());
                        },
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('Dark'),
                        value: ThemeMode.dark,
                        groupValue: mode,
                        onChanged: (value) {
                          sl<SettingsService>().setThemeMode(value.toString());
                        },
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('System'),
                        value: ThemeMode.system,
                        groupValue: mode,
                        onChanged: (value) {
                          sl<SettingsService>().setThemeMode(value.toString());
                        },
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
