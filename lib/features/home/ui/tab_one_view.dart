import 'package:flutter/material.dart';

import '../../../app/injection/get_it.dart';
import '../../../shared/services/navigation_service.dart';

class TabOneView extends StatelessWidget {
  const TabOneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab One View'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Go to route'),
              onPressed: () {
                sl<NavigationService>().pushNamedRoute('/chats');
              },
            ),
          ),
        ],
      ),
    );
  }
}
