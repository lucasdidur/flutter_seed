import 'package:flutter/material.dart';

import '../../app/gen/assets.gen.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.sideLength = 100});

  final double sideLength;

  @override
  Widget build(BuildContext context) {
    return Assets.images.logo.image(
      height: sideLength,
    );
  }
}
