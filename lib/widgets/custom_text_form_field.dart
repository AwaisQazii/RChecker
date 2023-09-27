import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:result_checker/widgets/app_colors.dart';
import 'package:result_checker/widgets/global_methods.dart';
import 'package:result_checker/widgets/title_text.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.onTap,
    this.autoValidateMode,
    this.maxLength,
    this.obscureText,
    this.onChanged,
    this.showLengthCount = false,
    this.filled,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.hint,
    this.maxLines,
    this.keyboardType,
    this.prefixIcon,
    this.validator,
  });

  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final bool? filled;
  final Function(String? value)? onFieldSubmitted;
  final String? hint;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool showLengthCount;
  final AutovalidateMode? autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap ?? () {},
      onChanged: onChanged ?? (v) {},
      validator: validator,
      onEditingComplete: () {
        final focus = FocusScope.of(context);
        focus.nextFocus();
      },
      onTapOutside: (event) {
        unfocus(context);
      },
      keyboardType: keyboardType,
      autovalidateMode: autoValidateMode,
      inputFormatters: inputFormatters,
      maxLines: obscureText == null ? maxLines ?? 1 : 1,
      maxLength: maxLength,
      buildCounter: _buildCounter,
      obscureText: obscureText ?? false,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        border: const OutlineInputBorder(),
        filled: filled,
        fillColor: AppColors.white,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        errorStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      obscuringCharacter: "•",
    );
  }

  Widget? _buildCounter(BuildContext context,
      {required int? currentLength, required int? maxLength, required bool isFocused}) {
    if (showLengthCount) {
      return TitleText(
        title: '$currentLength / $maxLength',
        style: const TextStyle(
          fontSize: 12,
        ),
      );
    } else {
      return null;
    }
  }
}
