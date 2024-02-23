import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/model/AppUser.dart';
import 'package:practical/utils/Dialogs.dart';
import 'package:practical/utils/custom_text_style.dart';
import 'package:practical/view/login_screen.dart';
import 'package:practical/view/product_listing_screen.dart';

import '../utils/primary_colors.dart';

class AuthController extends GetxController {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  AppUser? appUser;

  loginUser(BuildContext context, String userEmail, String userPassword) async {
    Dialogs.showLoadingDialog(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPassword);
      User? currentUser = FirebaseAuth.instance.currentUser;
      AppUser tempUser = AppUser.fromJson((await fireStore.collection("users").doc(currentUser!.uid).get()).data()!);
      appUser = tempUser;
      Get.back();
      Get.offAll(() => ProductListingScreen(isFavorite: false));
    } on FirebaseAuthException catch (e) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: PrimaryColors().redColor,
        content: Text(e.message ?? '', style: CustomTextStyles().snackBarTextStyle),
      ));
    }
  }

  registerUser(BuildContext context, {String? userEmail, String? userFullName, String? contactNumber, String? userPassword}) async {
    try {
      Dialogs.showLoadingDialog(context);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail!, password: userPassword!);
      User? currentUser = FirebaseAuth.instance.currentUser;
      appUser = AppUser(userId: currentUser!.uid, email: currentUser.email, name: userFullName, contactNumber: contactNumber);
      await fireStore.collection("users").doc(appUser!.userId).set(appUser!.toJson());
      Get.back();
      Get.offAll(() => ProductListingScreen(isFavorite: false));
    } on FirebaseAuthException catch (e) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: PrimaryColors().redColor,
        content: Text(e.message ?? '', style: CustomTextStyles().snackBarTextStyle),
      ));
    }
  }

  getCurrentUser(BuildContext context) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        appUser = AppUser.fromJson((await fireStore.collection("users").doc(currentUser.uid).get()).data()!);
        Get.offAll(() => ProductListingScreen(isFavorite: false));
      } else {
        Get.offAll(() => const LoginScreen());
      }
    } catch (error) {
      Get.offAll(() => const LoginScreen());
    }
  }

  editProfile(BuildContext context, {String? userFullName, String? phoneNumber}) async {
    Dialogs.showLoadingDialog(context);
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      appUser = AppUser(userId: currentUser!.uid, email: currentUser.email, name: userFullName, contactNumber: phoneNumber);
      await fireStore.collection("users").doc(appUser!.userId).set(appUser!.toJson());
      Get.back();
      Get.back();
    } catch (e) {
      Get.back();
    }
  }
}
