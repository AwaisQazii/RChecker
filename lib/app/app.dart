import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/app/app_routes.dart';
import 'package:result_checker/bloc/%20home_bloc/home_cubits/cubit.dart';
import 'package:result_checker/screens/home/home.dart';
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
      ],
      child: Builder(builder: (context) {
        SizedConfig.init(context);
        return MaterialApp(
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
