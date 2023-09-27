import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/app/app_routes.dart';
import 'package:result_checker/app/navigation_helper.dart';
import 'package:result_checker/bloc/%20home_bloc/home_cubit.dart';
import 'package:result_checker/widgets/app_loader.dart';
import 'package:result_checker/widgets/custom_app_bar.dart';
import 'package:result_checker/widgets/sized_config.dart';
import 'package:result_checker/widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "RChecker",
      ),
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (BuildContext context, HomeStates state) {},
          builder: (context, state) {
            if (state == HomeStates.loading) {
              return const AppLoader();
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => pushNamed(AppRoutes.submitResult),
                      child: SizedBox(
                        width: SizedConfig.width,
                        height: SizedConfig.height * 0.3,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TitleText(
                                title: "Submit Result",
                                fontSize: 20,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => pushNamed(AppRoutes.selectTestType),
                      child: SizedBox(
                        width: SizedConfig.width,
                        height: SizedConfig.height * 0.3,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TitleText(
                                title: "View Results",
                                fontSize: 20,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
