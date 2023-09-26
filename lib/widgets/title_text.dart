import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:result_checker/widgets/app_colors.dart';

class TitleText extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? textAlign;

  TitleText({
    Key? key,
    required this.title,
    this.style,
    this.fontSize,
    this.weight,
    this.color,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: style ??
          GoogleFonts.roboto(
            fontSize: fontSize ?? 14,
            fontWeight: weight ?? FontWeight.normal,
            color: color ?? AppColors.black,
          ),
    );
  }
}
