import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:result_checker/widgets/app_colors.dart';
import 'package:result_checker/widgets/title_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: TitleText(
        title: title,
        fontSize: 18,
        color: AppColors.white,
        weight: FontWeight.w500,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
