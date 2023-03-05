import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/screens/login/main.dart';
import 'package:skill_rate/widgets/button.dart';
import 'package:skill_rate/widgets/text_field_container.dart';

import '../../helper/styles.dart';
import '../../helper/validation_helper.dart';
import '../../widgets/back_button.dart';
import '../../widgets/line_title.dart';
import '../../widgets/social_button.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final RegisterController controller;

  const Small({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: height(context),
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppMethods.DEFAULT_PADDING,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [BackButtonWidget()],
            ),
            SizedBox(
              height: AppMethods.DEFAULT_PADDING,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Hello! Register to get started",
                    style: textStyle(
                      context: context,
                      fontSize: FontSize.H1,
                      isBold: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.15,
                )
              ],
            ),
            SizedBox(
              height: AppMethods.DEFAULT_PADDING,
            ),
            Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldContainer(
                    textEditingController: controller.firstNameController,
                    hint: "First Name",
                    keyboardType: TextInputType.text,
                    validator: (value) => Validator.validateName(value ?? ""),
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING / 2,
                  ),
                  TextFieldContainer(
                    textEditingController: controller.lastNameController,
                    hint: "Last Name",
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        Validator.validateName((value ?? " ").trim()),
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING / 2,
                  ),
                  TextFieldContainer(
                    textEditingController: controller.usernameController,
                    hint: "Username",
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        Validator.validateText((value ?? " ").trim()),
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING / 2,
                  ),
                  TextFieldContainer(
                    textEditingController: controller.emailPhoneController,
                    hint: "Enter your email/phone (without code)",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING / 2,
                  ),
                  /*TextFieldContainer(
                    textEditingController: controller.phoneController,
                    hint: "Phone number (without code)",
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        Validator.validatePhone((value ?? " ").trim(), false),
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING / 2,
                  ),*/
                  /*TextFieldContainer(
                    textEditingController: controller.passwordController,
                    onToggle: () {
                      controller.togglePassword();
                    },
                    hint: "Password",
                    showText: controller.showPassword,
                    isLastField: true,
                    validator: (value) =>
                        Validator.validateText((value ?? " ").trim()),
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING / 2,
                  ),
                  TextFieldContainer(
                    textEditingController: controller.confirmPasswordController,
                    onToggle: () {
                      controller.toggleConfirmPassword();
                    },
                    hint: "Confirm Password",
                    showText: controller.showConfirmPassword,
                    isLastField: true,
                    validator: (value) =>
                        Validator.validateText((value ?? " ").trim()),
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING,
                  ),*/
                  AppButton(
                    onTap: () {
                      controller.register(context);
                      // controller.test();
                    },
                    text: "Send OTP",
                    isLoading: controller.isLoading,
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING,
                  ),
                ],
              ),
            ),
            const LineTitleWidget(
              title: 'Or Login with',
            ),
            SizedBox(
              height: AppMethods.DEFAULT_PADDING,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialButton(
                  onPressed: () {
                    controller.facebookLogin(context);
                  },
                  buttonType: Type.Facebook,
                  isLoading: false,
                ),
                const SizedBox(
                  width: 10,
                ),
                SocialButton(
                  onPressed: () {
                    controller.googleLogin(context);
                  },
                  buttonType: Type.Google,
                  isLoading: controller.isGLoading,
                ),
              ],
            ),
            SizedBox(
              height: AppMethods.DEFAULT_PADDING,
            ),
            /*Text(
              "Continue as a guest",
              style: textStyle(
                context: context,
                color: Theme.of(context).primaryColor,
                isBold: true,
                haveUnderline: true,
              ),
            ),
            SizedBox(
              height: AppMethods.DEFAULT_PADDING,
            ),*/
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account? ",
                    style: textStyle(
                      context: context,
                    ),
                  ),
                  TextSpan(
                    text: 'Login Now',
                    style: textStyle(
                      context: context,
                      color: Theme.of(context).primaryColor,
                      isBold: true,
                      haveUnderline: true,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Get.back();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()),
                            ModalRoute.withName('/'));
                      },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppMethods.DEFAULT_PADDING,
            ),
          ],
        ),
      ),
    );
  }
}
