import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/core.dart';
import '../widgets/splash_logo.dart';

/// Splash Screen — orchestration only.
///
/// Responsibilities (per Constitution §2):
///  1. Start the splash delay timer
///  2. Check login state and navigate to the correct route
///  3. Compose SplashLogo sub-widget for rendering
///
/// This file never contains Image.asset or layout padding logic.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() {
    _timer = Timer(
      const Duration(seconds: AppConstants.splashDelay),
      _goNext,
    );
  }

  Future<void> _goNext() async {
    final isLoggedIn = await _appPreferences.isUserLoggedIn();
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      isLoggedIn ? Routes.loginRoute : Routes.loginRoute,
      // TODO: replace first loginRoute with homeRoute when Home is implemented
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorManager.colorGrayF3,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.colorGrayF3,
        body: const SafeArea(
          child: SplashLogo(),
        ),
      ),
    );
  }
}
