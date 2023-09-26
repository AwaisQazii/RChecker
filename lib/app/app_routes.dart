import 'package:flutter/material.dart';
import 'package:result_checker/screens/home/home.dart';

class AppKeys {
  static final navigatorKey = GlobalKey<NavigatorState>();
}

class AppRoutes {
  static const home = '/home';

  static Map<String, Widget Function(BuildContext _)> routes = {home: (_) => const HomeScreen()};
}
