import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

/// Renders the centered splash screen logo. Purely presentational.
class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(ImageAssets.bghSplash),
    );
  }
}
