import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/controller/auth_controller.dart';
import 'package:practical/utils/app_decoration.dart';
import 'package:practical/utils/custom_text_style.dart';
import 'package:practical/utils/primary_colors.dart';
import 'package:practical/view/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.find();
  final GlobalKey<FormState> loginFormKey = GlobalKey();
  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .07),
                  const Center(
                      child: Text(
                    "Login",
                  )),
                  const SizedBox(height: 5),
                  const Center(
                      child: Text(
                    "Please sign in to continue",
                  )),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      cursorColor: PrimaryColors().blackColor,
                      controller: emailController,
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
                  const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: PrimaryColors().blackColor,
                  controller: passwordController,
                  obscureText: _isObscure,
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
                    errorMaxLines: 1,
                    enabledBorder: AppDecoration.textFieldDecoration,
                    disabledBorder: AppDecoration.textFieldDecoration,
                    focusedBorder: AppDecoration.textFieldDecoration,
                    border: AppDecoration.textFieldDecoration,
                    fillColor: PrimaryColors().whiteColor,
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
              ),
                  const Expanded(child: SizedBox(height: 15)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (loginFormKey.currentState!.validate()) {
                            if (emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {
                              authController.loginUser(context, emailController.text.trim(), passwordController.text.trim());
                            }
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log in",
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const RegistrationScreen(
                              isFromEdit: false,
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have account? "),
                          Text("Create account",
                              style: CustomTextStyles().createAccountTextStyle),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .08)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
