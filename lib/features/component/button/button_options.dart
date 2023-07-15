import 'package:flutter/widgets.dart';

enum ButtonSizeType {
  normal(48, 16, FontWeight.w600, 24),
  mini(36, 14, FontWeight.w600, 18),
  tiny(32, 12, FontWeight.w600, 18),
  smallText(36, 14, FontWeight.w300, 0),
  ;

  const ButtonSizeType(
      this.buttonHeight, this.fontSize, this.fontWeight, this.buttonRadius);

  final double buttonHeight;

  final double fontSize;

  final FontWeight fontWeight;

  final double buttonRadius;
}

enum IconPosition {
  right,
  left,
}
