import 'package:flutter/material.dart';
import 'package:practical/utils/primary_colors.dart';

class CustomTextStyles {
  TextStyle splashTextStyle = TextStyle(color: PrimaryColors().blackColor, fontSize: 50, fontWeight: FontWeight.bold);
  TextStyle createAccountTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
  TextStyle productTitleTextStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle snackBarTextStyle = const TextStyle(fontWeight: FontWeight.bold);
  TextStyle loaderTextStyle = TextStyle(color: PrimaryColors().whiteColor, fontSize: 16);
}
