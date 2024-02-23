import 'package:flutter/material.dart';
import 'package:practical/utils/primary_colors.dart';

class AppDecoration {
  static OutlineInputBorder get textFieldDecoration => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: PrimaryColors().blackColor, width: 1.0),
      );

  static Decoration get boxShadowDecoration => BoxDecoration(
    color: PrimaryColors().whiteColor,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: PrimaryColors().black26Color,
        spreadRadius: -0.1,
        blurRadius: 2,
        offset: const Offset(3, 3),
      ),
    ],
  );

  static Decoration get favIconDecoration => BoxDecoration(
    color: PrimaryColors().whiteColor,
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: PrimaryColors().black26Color,
        spreadRadius: -0.1,
        blurRadius: 2,
        offset: const Offset(1, 5),
      ),
    ],
  );
}
