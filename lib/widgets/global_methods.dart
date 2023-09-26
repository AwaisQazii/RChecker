import 'package:flutter/material.dart';
import 'package:result_checker/app/navigation_helper.dart';
import 'package:result_checker/widgets/app_button.dart';
import 'package:result_checker/widgets/app_loader.dart';
import 'package:result_checker/widgets/title_text.dart';

String? formValidate(String? value) {
  if (value == null || value.isEmpty) {
    return "Please Enter Value";
  }
}

unfocus(BuildContext context) {
  final focus = FocusScope.of(context);
  focus.unfocus();
}

loader(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return const AlertDialog.adaptive(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLoader(),
          ],
        ),
      );
    },
  );
}

responseDialog(BuildContext context, String message, [bool? error]) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: TitleText(
          title: message,
          textAlign: TextAlign.center,
          weight: FontWeight.w500,
        ),
        actions: [
          if (error ?? false)
            AppButton(
              onPressed: () {
                pop();
              },
              content: TitleText(
                title: "OK",
              ),
            ),
        ],
      );
    },
  );
}
