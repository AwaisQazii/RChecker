import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:result_checker/app/app.dart';
import 'package:result_checker/app/navigation_helper.dart';
import 'package:result_checker/bloc/result_form_bloc/result_form_cubit.dart';
import 'package:result_checker/widgets/app_button.dart';
import 'package:result_checker/widgets/app_colors.dart';
import 'package:result_checker/widgets/custom_app_bar.dart';
import 'package:result_checker/widgets/custom_text_form_field.dart';
import 'package:result_checker/widgets/global_methods.dart';
import 'package:result_checker/widgets/sized_config.dart';
import 'package:result_checker/widgets/title_text.dart';

class ResultFormScreen extends StatefulWidget {
  const ResultFormScreen({super.key});

  @override
  State<ResultFormScreen> createState() => _ResultFormScreenState();
}

class _ResultFormScreenState extends State<ResultFormScreen> {
  final rollNo = TextEditingController();
  final name = TextEditingController();
  final testName = TextEditingController();

  final attempt = TextEditingController();
  final cnic = TextEditingController();
  final marks = TextEditingController();
  final year = TextEditingController();
  final district = TextEditingController();
  final college = TextEditingController();
  final coaching = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    rollNo.dispose();
    cnic.dispose();
    coaching.dispose();
    college.dispose();
    marks.dispose();
    district.dispose();
    year.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: "Result Form",
      ),
      body: SafeArea(
        child: BlocConsumer<ResultFormCubit, ResultFormState>(
          listener: (context, state) {
            final cubit = context.read<ResultFormCubit>();

            if (state == ResultFormState.loading) {
              loader(context);
            } else if (state == ResultFormState.valid) {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: TitleText(
                      title: "Result can't be edited. Pleas make sure your form is correct.",
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500,
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      Center(
                        child: AppButton(
                          widthFactor: 0.3,
                          onPressed: () {
                            pop();
                            cubit.pop();
                          },
                          child: TitleText(
                            title: "Cancel",
                          ),
                        ),
                      ),
                      Center(
                        child: AppButton(
                          widthFactor: 0.3,
                          onPressed: () async {
                            await context.read<ResultFormCubit>().submitForm(
                                  context,
                                  name: name.text,
                                  attempt: attempt.text,
                                  cnic: cnic.text.trim(),
                                  testName: testName.text,
                                  coaching: coaching.text,
                                  district: district.text,
                                  college: college.text,
                                  marks: marks.text,
                                  rollNo: rollNo.text,
                                  year: year.text,
                                );
                          },
                          child: TitleText(
                            title: "Confirm",
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (state == ResultFormState.success) {
              pop();
              responseDialog(context, "Result Submitted");
            } else if (state == ResultFormState.error) {
              pop();
              responseDialog(context, cubit.errorMessage);
            }
          },
          builder: (context, state) {
            final cubit = context.read<ResultFormCubit>();
            return Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      title: "Please Enter Your Result Details.",
                      fontSize: 16,
                    ),
                    AppSpace.vrtSpace(5),
                    TitleText(
                      title: "All fields with (*) are required",
                      fontSize: 12,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSpace.vrtSpace(20),
                                TitleText(
                                  title: "Name *",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: name,
                                  hint: "Name",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                TitleText(
                                  title: "CNIC*",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: cnic,
                                  hint: "CNIC",
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    MaskTextInputFormatter(
                                      mask: '#####-#######-#',
                                      filter: {
                                        "#": RegExp(r'[0-9]'),
                                      },
                                    ),
                                  ],
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                TitleText(
                                  title: "Test Name *",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: testName,
                                  hint: "Test Name (eg : MDCAT/ECAT)",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                TitleText(
                                  title: "Roll No/Seat No. *",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: rollNo,
                                  hint: "Roll No/Seat No",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                TitleText(
                                  title: "Marks *",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: marks,
                                  hint: "Marks",
                                  keyboardType: TextInputType.number,
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                TitleText(
                                  title: "Test Year*",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: year,
                                  hint: "Test Year",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                TitleText(
                                  title: "District *",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: district,
                                  hint: "District",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                TitleText(
                                  title: "Attempt *",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: attempt,
                                  hint: "Attempt (eg: 1 ,2, 3)",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                  keyboardType: TextInputType.number,
                                ),
                                AppSpace.vrtSpace(10),
                                TitleText(
                                  title: "Coaching/Academy Name",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: coaching,
                                  hint: "Coaching Center (eg: The Spark Center)",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                ),
                                AppSpace.vrtSpace(10),
                                TitleText(
                                  title: "College/Institute Name",
                                  fontSize: 16,
                                ),
                                AppSpace.vrtSpace(5),
                                CustomTextFormField(
                                  controller: college,
                                  hint: "College",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                ),
                                AppSpace.vrtSpace(20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: AppButton(
                        widthFactor: 0.7,
                        child: TitleText(
                          title: "Save",
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          cubit.validState();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
