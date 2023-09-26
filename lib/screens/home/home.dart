import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/bloc/%20home_bloc/home_cubits/cubit.dart';
import 'package:result_checker/widgets/app_loader.dart';
import 'package:result_checker/widgets/custom_app_bar.dart';

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
              return const Column(
                children: [
                  Card(
                    child: Text("View Result"),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
