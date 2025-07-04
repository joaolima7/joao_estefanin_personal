import 'package:flutter/material.dart';

import '../presentation/screens/home_screen.dart';

class AppRouter {
  static const String homeRoute = '/home';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final name = settings.name ?? '';

    if (name == homeRoute) {
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: settings,
      );
    }

    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: RouteSettings(name: homeRoute),
    );
  }
}
