import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  bool isDarkMode = false;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), () {
      _goNext();
    });
  }

  Future<void> _goNext() async {
    bool isUserLoggedIn = await _appPreferences.isUserLoggedIn();
    if (!mounted) return;
    final route = isUserLoggedIn ? Routes.homeRoute : Routes.loginRoute;
    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
  }

  _loadDarkMode() async {
    final dark = await _appPreferences.isDarkMode();
    if (mounted) setState(() => isDarkMode = dark);
  }

  @override
  void initState() {
    super.initState();
    _loadDarkMode();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.grayBg,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: colorDarkOrLightMode(isDarkMode , AppColors.darkMode , AppColors.grayBg),
          body: SafeArea(
            child: Center(
              child: Image.asset(ImageAssets.splashLogo),
            ),
          ),
        )
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
