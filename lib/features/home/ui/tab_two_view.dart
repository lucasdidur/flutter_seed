import 'package:flutter/material.dart';

class TabTwoView extends StatelessWidget {
  const TabTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab Two View'),
      ),
      body: Column(
        children: [
          Text('tab_two_view'),
        ],
      ),
    );
  }
}
