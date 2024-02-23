import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/controller/auth_controller.dart';
import 'package:practical/utils/custom_text_style.dart';

import '../utils/primary_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController userController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    Timer(const Duration(seconds: 2), () async {
      await userController.getCurrentUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColors().whiteColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Practical",
              style: CustomTextStyles().splashTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
