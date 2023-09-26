import 'package:flutter/material.dart';
import 'package:result_checker/widgets/app_loader.dart';

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
