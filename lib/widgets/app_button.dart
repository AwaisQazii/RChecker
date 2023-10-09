import 'package:flutter/material.dart';
import 'package:result_checker/widgets/app_colors.dart';
import 'package:result_checker/widgets/title_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.widthFactor = 0.5,
    required this.onPressed,
    required this.child,
  });
  final double widthFactor;
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
