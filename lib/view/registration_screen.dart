import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/controller/auth_controller.dart';
import 'package:practical/utils/custom_text_style.dart';

import '../utils/app_decoration.dart';
import '../utils/primary_colors.dart';

class RegistrationScreen extends StatefulWidget {
  final bool isFromEdit;

  const RegistrationScreen({super.key, required this.isFromEdit});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final GlobalKey<FormState> registerFormKey = GlobalKey();
  AuthController authController = Get.find();
  bool isPasswordShow = false;
  bool isConfirmPasswordShow = false;
  @override
  void initState() {
    if (widget.isFromEdit) {
      emailController.text = authController.appUser?.email ?? '';
      nameController.text = authController.appUser?.name ?? '';
      phoneNumberController.text = authController.appUser?.contactNumber ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: registerFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    cursorColor: PrimaryColors().blackColor,
                    controller: emailController,
                    enabled: widget.isFromEdit ? false : true,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Email cannot be empty";
                      } else if (!emailRegex.hasMatch(val)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Email",
                        isDense: true,
                        filled: true,
                        errorMaxLines: 1,
                        enabledBorder: AppDecoration.textFieldDecoration,
                        disabledBorder: AppDecoration.textFieldDecoration,
                        focusedBorder: AppDecoration.textFieldDecoration,
                        border: AppDecoration.textFieldDecoration,
                        fillColor: PrimaryColors().whiteColor),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    cursorColor: PrimaryColors().blackColor,
                    controller: nameController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Name",
                        isDense: true,
                        filled: true,
                        errorMaxLines: 1,
                        enabledBorder: AppDecoration.textFieldDecoration,
                        disabledBorder: AppDecoration.textFieldDecoration,
                        focusedBorder: AppDecoration.textFieldDecoration,
                        border: AppDecoration.textFieldDecoration,
                        fillColor: PrimaryColors().whiteColor),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    cursorColor: PrimaryColors().blackColor,
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Contact Number cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Contact Number",
                        isDense: true,
                        filled: true,
                        errorMaxLines: 1,
                        enabledBorder: AppDecoration.textFieldDecoration,
                        disabledBorder: AppDecoration.textFieldDecoration,
                        focusedBorder: AppDecoration.textFieldDecoration,
                        border: AppDecoration.textFieldDecoration,
                        fillColor: PrimaryColors().whiteColor),
                  ),
                ),
                if (!widget.isFromEdit) ...[
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      cursorColor: PrimaryColors().blackColor,
                      controller: passwordController,
                      obscureText: isPasswordShow,

                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          isDense: true,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordShow ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isPasswordShow = !isPasswordShow;
                              });
                            },
                          ),
                          errorMaxLines: 1,
                          enabledBorder: AppDecoration.textFieldDecoration,
                          disabledBorder: AppDecoration.textFieldDecoration,
                          focusedBorder: AppDecoration.textFieldDecoration,
                          border: AppDecoration.textFieldDecoration,
                          fillColor: PrimaryColors().whiteColor),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      cursorColor: PrimaryColors().blackColor,
                      controller: confirmPasswordController,
                      obscureText: isConfirmPasswordShow,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "confirmPassword cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          isDense: true,
                          filled: true,
                          errorMaxLines: 1,
                          suffixIcon: IconButton(
                            icon: Icon(isConfirmPasswordShow ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordShow = !isConfirmPasswordShow;
                              });
                            },
                          ),
                          enabledBorder: AppDecoration.textFieldDecoration,
                          disabledBorder: AppDecoration.textFieldDecoration,
                          focusedBorder: AppDecoration.textFieldDecoration,
                          border: AppDecoration.textFieldDecoration,
                          fillColor: PrimaryColors().whiteColor),
                    ),
                  ),
                ],
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (widget.isFromEdit) {
                      if (nameController.text.trim().isNotEmpty && phoneNumberController.text.trim().isNotEmpty) {
                        authController.editProfile(context, userFullName: nameController.text.trim(), phoneNumber: phoneNumberController.text.trim());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                          backgroundColor: PrimaryColors().redColor,
                          content: Text(
                            "Please enter all details",
                            style: CustomTextStyles().snackBarTextStyle,
                          ),
                        ));
                      }
                    } else {
                      if (registerFormKey.currentState!.validate()) {
                        if (passwordController.text.trim() == confirmPasswordController.text.trim()) {
                          authController.registerUser(context,
                              userEmail: emailController.text.trim(),
                              userFullName: nameController.text.trim(),
                              userPassword: passwordController.text.trim(),
                              contactNumber: phoneNumberController.text.trim());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: PrimaryColors().redColor,
                            content: Text(
                              "Password and confirm password does not match!",
                              style: CustomTextStyles().snackBarTextStyle,
                            ),
                          ));
                        }
                      }
                    }
                  },
                  child: Text(widget.isFromEdit ? 'Update' : 'Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
