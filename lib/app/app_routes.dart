import 'package:flutter/material.dart';
import 'package:result_checker/screens/home/home.dart';
import 'package:result_checker/screens/submit_result/submit_result_screen.dart';

class AppKeys {
  static final navigatorKey = GlobalKey<NavigatorState>();
}

class AppRoutes {
  static const home = '/home';
  static const submitResult = '/submit_result';

  static Map<String, Widget Function(BuildContext _)> routes = {
    home: (_) => const HomeScreen(),
    submitResult: (_) => const SubmitResultScreen()
  };
}
