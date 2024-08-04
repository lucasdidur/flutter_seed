import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/theme.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Find the flutter_fast_cli on pub.dev',
              textAlign: TextAlign.center,
              style: context.headlineSmall,
            ).animate(effects: [const FadeEffect(delay: Duration(milliseconds: 300))]),
            gap16,
            const Text('💙')
          ],
        ),
      ),
    );
  }
}
