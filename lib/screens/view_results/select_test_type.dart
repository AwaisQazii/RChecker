import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/app/app_routes.dart';
import 'package:result_checker/app/navigation_helper.dart';
import 'package:result_checker/bloc/select_test_type_bloc/select_test_cubit.dart';
import 'package:result_checker/widgets/app_colors.dart';
import 'package:result_checker/widgets/app_loader.dart';
import 'package:result_checker/widgets/custom_app_bar.dart';
import 'package:result_checker/widgets/sized_config.dart';
import 'package:result_checker/widgets/title_text.dart';

class SelectTestTypeScreen extends StatefulWidget {
  const SelectTestTypeScreen({super.key});

  @override
  State<SelectTestTypeScreen> createState() => _SelectTestTypeScreenState();
}

class _SelectTestTypeScreenState extends State<SelectTestTypeScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? testTypes;
  @override
  void initState() {
    final cubit = context.read<SelectTestTypeCubit>();
    cubit.getTestTypes();

    testTypes = cubit.testTypes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Select Test Type",
      ),
      body: BlocConsumer<SelectTestTypeCubit, SelectTestTypeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state == SelectTestTypeState.loading) {
            return const AppLoader();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: testTypes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const AppLoader();
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (context, index) {
                        final tests = snapshot.data?.docs[index];
                        return InkWell(
                          onTap: () {
                            pushNamed(AppRoutes.viewResults, {
                              'title': tests?['name'].toString().toUpperCase(),
                            });
                          },
                          child: SizedBox(
                            height: SizedConfig.height * 0.1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: index % 2 == 0 ? AppColors.primaryColor : AppColors.white,
                                child: Center(
                                  child: TitleText(
                                    title: tests?['name'].toString().toUpperCase() ?? "",
                                    color: index % 2 == 0 ? AppColors.white : AppColors.black,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return AppSpace.noSpace;
                },
              )),
            ],
          );
        },
      ),
    );
  }
}
