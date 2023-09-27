import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_checker/bloc/result_form_bloc/result_form_cubit.dart';
import 'package:result_checker/bloc/view_results_bloc/view_results_cubit.dart';
import 'package:result_checker/domain/models/form_model.dart';
import 'package:result_checker/widgets/app_loader.dart';
import 'package:result_checker/widgets/custom_app_bar.dart';
import 'package:result_checker/widgets/custom_text_form_field.dart';
import 'package:result_checker/widgets/sized_config.dart';
import 'package:result_checker/widgets/title_text.dart';

class ViewResultsScreen extends StatefulWidget {
  const ViewResultsScreen({super.key});

  @override
  State<ViewResultsScreen> createState() => _ViewResultsScreenState();
}

class _ViewResultsScreenState extends State<ViewResultsScreen> {
  final districtController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>>? resultsStream;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cubit = context.read<ViewResultsCubit>();

      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        cubit.title = args['title'];
        await cubit.getResults();

        resultsStream = cubit.resultsStream;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewResultsCubit, ResultListState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.watch<ViewResultsCubit>();
        if (state == ResultListState.loading) {
          return const AppLoader();
        }

        return Scaffold(
          appBar: CustomAppBar(
            title: cubit.title,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                children: [
                  CustomTextFormField(
                    onFieldSubmitted: (value) async {
                      context.read<ViewResultsCubit>().getSearched(value: value);
                      resultsStream = cubit.resultsStream;
                    },
                    controller: districtController,
                    hint: "Search District",
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: resultsStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const AppLoader();
                        } else if (snapshot.hasData) {
                          final results = snapshot.data?.docs.map((e) => FormModel.fromJson(e.data())).toList();

                          return ListView.builder(
                            itemCount: results?.length ?? 0,
                            itemBuilder: (context, index) {
                              final formModel = results?[index];

                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildRow('Name', formModel?.name ?? ""),
                                      AppSpace.vrtSpace(5),
                                      buildRow('Marks', formModel?.marks.toString() ?? ""),
                                      AppSpace.vrtSpace(5),
                                      buildRow('District', formModel?.district ?? ""),
                                      AppSpace.vrtSpace(5),
                                      buildRow('Test Year', formModel?.year.toString() ?? ""),
                                      AppSpace.vrtSpace(5),
                                      buildRow('Attempt', formModel?.attempt.toString() ?? ""),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return AppSpace.noSpace;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildRow(String value1, String value2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: TitleText(
            title: value1,
            weight: FontWeight.w500,
          ),
        ),
        Expanded(
          flex: 8,
          child: TitleText(
            title: value2,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
