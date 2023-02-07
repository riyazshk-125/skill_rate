import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/screens/login/main.dart';
import 'package:skill_rate/widgets/button.dart';
import 'package:skill_rate/widgets/text_field_container.dart';

import '../../helper/styles.dart';
import '../../helper/validation_helper.dart';
import '../../widgets/back_button.dart';
import '../../widgets/flutter_bounce.dart';
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
            Bounce(
              onPressed: () {
                controller.loginWithPassword = true;
                controller.update();
              },
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                    height: getWidth(35, context),
                    width: getWidth(35, context),
                    alignment: Alignment.center,
                    child: Visibility(
                      visible: controller.loginWithPassword,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).splashColor,
                          ),
                          color: controller.loginWithPassword
                              ? Theme.of(context).shadowColor
                              : Colors.white,
                        ),
                        height: getWidth(25, context),
                        width: getWidth(25, context),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getWidth(20, context),
                  ),
                  Text(
                    "Continue with email",
                    style: textStyle(
                      context: context,
                      color: Theme.of(context).shadowColor,
                    ),
                  )
                ],
              ),
            ),
            if (controller.loginWithPassword)
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
                      textEditingController: controller.emailController,
                      hint: "Email",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          Validator.validateEmail((value ?? " ").trim()),
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    TextFieldContainer(
                      textEditingController: controller.passwordController,
                      /*onToggle: () {
                controller.togglePassword();
              },*/
                      hint: "Password",
                      // showText: controller.showPassword,
                      isLastField: true,
                      validator: (value) =>
                          Validator.validateText((value ?? " ").trim()),
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    TextFieldContainer(
                      textEditingController:
                          controller.confirmPasswordController,
/*              onToggle: () {
                controller.togglePassword();
              },*/
                      hint: "Confirm Password",
                      // showText: controller.showPassword,
                      isLastField: true,
                      validator: (value) =>
                          Validator.validateText((value ?? " ").trim()),
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING,
                    ),
                    AppButton(
                      onTap: () {
                        controller.register(context);
                      },
                      text: "Register",
                      isLoading: controller.isLoading,
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING,
                    ),
                  ],
                ),
              ),
            Bounce(
              onPressed: () {
                controller.loginWithPassword = false;
                controller.update();
              },
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                    height: getWidth(35, context),
                    width: getWidth(35, context),
                    alignment: Alignment.center,
                    child: Visibility(
                      visible: !controller.loginWithPassword,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).splashColor,
                          ),
                          color: !controller.loginWithPassword
                              ? Theme.of(context).shadowColor
                              : Colors.white,
                        ),
                        height: getWidth(25, context),
                        width: getWidth(25, context),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getWidth(20, context),
                  ),
                  Text(
                    "Continue with phone",
                    style: textStyle(
                      context: context,
                      color: Theme.of(context).shadowColor,
                    ),
                  )
                ],
              ),
            ),
            if (!controller.loginWithPassword) ...[
              SizedBox(
                height: AppMethods.DEFAULT_PADDING,
              ),
              SizedBox(
                height: AppMethods.DEFAULT_PADDING / 2,
              ),
              TextFieldContainer(
                textEditingController: controller.phoneController,
                onToggle: () {
                  controller.togglePassword();
                },
                hint: "Registered number (without code)",
                keyboardType: TextInputType.phone,
                isLastField: true,
              ),
              SizedBox(
                height: AppMethods.DEFAULT_PADDING,
              ),
              AppButton(
                onTap: () {
                  controller.sendOTP(context);
                },
                text: "Send OTP",
                isLoading: controller.isLoading,
              ),
              SizedBox(
                height: AppMethods.DEFAULT_PADDING,
              ),
            ],
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
            Text(
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
            ),
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
