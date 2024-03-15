import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AppSizes {
  static const size12 = 12.0,
      size14 = 14.0,
      size16 = 16.0,
      size18 = 18.0,
      size22 = 22.0,
      size34 = 34.0;
}

class AppStyles {
  static normal(
      {String? title,
      Color? color = Colors.black,
      double? size,
      TextAlign align = TextAlign.left}) {
    return title!.text.size(size).color(color).align(align).make();
  }

  static bold(
      {String? title,
      Color? color = Colors.black,
      double? size,
      TextAlign align = TextAlign.left}) {
    return title!.text.size(size).color(color).align(align).make();
  }
}
