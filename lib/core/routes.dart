import 'package:flutter/material.dart';
import '../presentation/screens/dashboard_screen.dart';
import '../presentation/screens/sensor_screen.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String sensor = '/sensor';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case sensor:
        return MaterialPageRoute(builder: (_) => const SensorScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
