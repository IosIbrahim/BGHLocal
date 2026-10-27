import 'package:flutter/material.dart';
import '../../feature/auth/presentation/view/login_screen.dart';
import '../../feature/emergency/presentation/view/emergency_screen.dart';
import '../../feature/home/home_screen.dart';
import '../../feature/hr/presentation/view/hr_screen.dart';
import '../../feature/inpatient_statistics/presentation/view/inpatient_statistics_screen.dart';
import '../../feature/operating/presentation/view/operating_screen.dart';
import '../../feature/revenue/presentation/view/revenue_screen.dart';
import '../../feature/outpatient/presentation/view/outpatient_screen.dart';
import '../../feature/splash/splash_screen.dart';
import '../resources/app_strings.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String homeRoute = "/home";
  static const String inpatientRoute = "/inpatient";
  static const String outpatientRoute = "/outpatient";
  static const String emergencyRoute = "/emergency";
  static const String hrRoute = "/hr";
  static const String revenueRoute = "/revenue";
  static const String operatingRoute = "/operating";
}

class RouteGenerator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.inpatientRoute:
        return MaterialPageRoute(builder: (_) => const InpatientStatisticsScreen());
      case Routes.outpatientRoute:
        return MaterialPageRoute(builder: (_) => const OutpatientScreen());
      case Routes.emergencyRoute:
        return MaterialPageRoute(builder: (_) => const EmergencyScreen());
      case Routes.hrRoute:
        return MaterialPageRoute(builder: (_) => const HrScreen());
      case Routes.revenueRoute:
        return MaterialPageRoute(builder: (_) => const RevenueScreen());
      case Routes.operatingRoute:
        return MaterialPageRoute(builder: (_) => const OperatingScreen());
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
