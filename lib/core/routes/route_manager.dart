import 'package:flutter/material.dart';
import '../../feature/auth/presentation/view/login_screen.dart';
import '../../feature/contact_us/presentation/view/contact_us_screen.dart';
import '../../feature/splash/presentation/view/splash_screen.dart';
import '../resources/app_strings.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String contactUsRoute = "/contactUs";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.contactUsRoute:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
