import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:result_checker/bloc/submit_bloc/cubit.dart';
import 'package:result_checker/widgets/app_colors.dart';
import 'package:result_checker/widgets/custom_app_bar.dart';
import 'package:result_checker/widgets/custom_text_form_field.dart';
import 'package:result_checker/widgets/global_methods.dart';
import 'package:result_checker/widgets/sized_config.dart';
import 'package:result_checker/widgets/title_text.dart';

class SubmitResultScreen extends StatefulWidget {
  const SubmitResultScreen({super.key});

  @override
  State<SubmitResultScreen> createState() => _SubmitResultScreenState();
}

class _SubmitResultScreenState extends State<SubmitResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: "Submit",
      ),
      body: SafeArea(
        child: BlocConsumer<SubmitCubit, SubmitState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<SubmitCubit>();
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSpace.vrtSpace(10),
                                CustomTextFormField(
                                  controller: cubit.name,
                                  hint: "Name",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                CustomTextFormField(
                                  controller: cubit.cnic,
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
                                CustomTextFormField(
                                  controller: cubit.rollNo,
                                  hint: "Roll No/Seat No",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                CustomTextFormField(
                                  controller: cubit.district,
                                  hint: "District",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                                AppSpace.vrtSpace(10),
                                CustomTextFormField(
                                  controller: cubit.marks,
                                  hint: "Marks",
                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                  validator: formValidate,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: SizedConfig.width * 0.5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: () async {
                            await context.read<SubmitCubit>().submitForm(context);
                          },
                          child: TitleText(
                            title: "Save",
                            color: AppColors.white,
                          ),
                        ),
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
