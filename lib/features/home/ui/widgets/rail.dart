import 'package:flutter/material.dart';

import '../../../../app/injection/get_it.dart';
import '../../../../shared/services/navigation_service.dart';

class HomeRail extends StatefulWidget {
  const HomeRail({super.key});

  @override
  State<HomeRail> createState() => _HomeRailState();
}

class _HomeRailState extends State<HomeRail> {
  int index = 0;

  final List<Map<String, dynamic>> destinations = [
    {
      'icon': const Icon(Icons.person),
      'label': const Text('Profile'),
      'route': '/profile',
    },
    {
      'icon': const Icon(Icons.thumb_up),
      'label': const Text('Leave Feedback'),
      'route': '/new-feedback',
    },
    {
      'icon': const Icon(Icons.visibility),
      'label': const Text('View Feedback'),
      'route': '/feedback',
    },
    {
      'icon': const Icon(Icons.settings),
      'label': const Text('Settings'),
      'route': '/settings',
    },
    {
      'icon': const Icon(Icons.star),
      'label': const Text('Subscriptions'),
      'route': '/subscriptions',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations: destinations
          .map((e) => NavigationRailDestination(
                icon: e['icon'],
                label: e['label'],
              ))
          .toList(),
      selectedIndex: index,
      onDestinationSelected: (value) {
        setState(() {
          index = value;
        });

        sl<NavigationService>().pushNamedRoute(destinations[index]['route'] as String);
      },
    );
  }
}
