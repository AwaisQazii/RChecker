import 'package:flutter/cupertino.dart';

class SizedConfig {
  static double width = 0.0;
  static double height = 0.0;

  static init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    width = size.width;
    height = size.height;
  }
}

class AppSpace {
  static const noSpace = SizedBox.shrink();

  static vrtSpace(double height) => SizedBox(
        height: height,
      );

  static hrtSpace(double width) => SizedBox(
        width: width,
      );
  static const spacer = Spacer();
}
