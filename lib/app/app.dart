import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/app/app_routes.dart';
import 'package:result_checker/bloc/%20home_bloc/home_cubit.dart';
import 'package:result_checker/bloc/result_form_bloc/result_form_cubit.dart';
import 'package:result_checker/bloc/select_test_type_bloc/select_test_cubit.dart';
import 'package:result_checker/bloc/view_results_bloc/view_results_cubit.dart';

import 'package:result_checker/screens/home/home.dart';
import 'package:result_checker/widgets/no_glow_behaviour.dart';
import 'package:result_checker/widgets/sized_config.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<ResultFormCubit>(
          create: (context) => ResultFormCubit(),
        ),
        BlocProvider<SelectTestTypeCubit>(
          create: (context) => SelectTestTypeCubit(),
        ),
        BlocProvider<ViewResultsCubit>(
          create: (context) => ViewResultsCubit(),
        )
      ],
      child: Builder(builder: (context) {
        SizedConfig.init(context);
        return MaterialApp(
          scrollBehavior: NoGlowBehavior(),
          debugShowCheckedModeBanner: false,
          navigatorKey: AppKeys.navigatorKey,
          navigatorObservers: [
            NavigatorObserver(),
          ],
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.home,
          builder: (context, child) {
            return child!;
          },
        );
      }),
    );
  }
}
