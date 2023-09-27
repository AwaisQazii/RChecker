import 'package:flutter/material.dart';
import 'package:result_checker/screens/home/home.dart';
import 'package:result_checker/screens/result_form/result_form_screen.dart';
import 'package:result_checker/screens/view_results/select_test_type.dart';
import 'package:result_checker/screens/view_results/view_results_screen.dart';

class AppKeys {
  static final navigatorKey = GlobalKey<NavigatorState>();
}

class AppRoutes {
  static const home = '/home';
  static const submitResult = '/submit_result';
  static const selectTestType = '/select_test_type';
  static const viewResults = '/view_results_screen';

  static Map<String, Widget Function(BuildContext _)> routes = {
    home: (_) => const HomeScreen(),
    submitResult: (_) => const ResultFormScreen(),
    selectTestType: (_) => const SelectTestTypeScreen(),
    viewResults: (_) => const ViewResultsScreen()
  };
}
