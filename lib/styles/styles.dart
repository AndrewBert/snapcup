import 'package:flutter/material.dart';

typedef GetStyles = TextStyle Function(TextStyles textStyles);

abstract class TextStyles {
  TextStyle get textInputHint => const TextStyle(
        fontSize: 20,
      );
  TextStyle get buttonTextStyle => const TextStyle(
        fontSize: 20,
        color: Colors.white,
      );
  //Color get snapcupPink => const Color(0xffff7da9);
}
