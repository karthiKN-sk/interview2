import 'package:flutter/material.dart';

import '../views/screens/bottom_nav_bar.dart';
import '../views/screens/splash_screen.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/bottom':
      return MaterialPageRoute(builder: (_) => const BottomNavBar());
    case '/splash':
      return MaterialPageRoute(builder: (_) => const SplashImageScreen());
    default:
      return MaterialPageRoute(builder: (_) => const SplashImageScreen());
  }
}
