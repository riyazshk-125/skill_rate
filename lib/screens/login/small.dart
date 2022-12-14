import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/screens/main/main.dart';
import 'package:skill_rate/widgets/button.dart';
import 'package:skill_rate/widgets/text_field_container.dart';

import '../../helper/styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/flutter_bounce.dart';
import '../../widgets/line_title.dart';
import '../../widgets/social_button.dart';
import '../forgot_password_email/main.dart';
import '../register/main.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final LoginController controller;

  const Small({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: height(context),
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
      alignment: Alignment.topCenter,
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
                  "Welcome back! Glad to see you, Again!",
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
          TextFieldContainer(
            textEditingController: controller.emailController,
            hint: "Enter your email",
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING / 2,
          ),
          TextFieldContainer(
            textEditingController: controller.passwordController,
            onToggle: () {
              controller.togglePassword();
            },
            hint: "Enter your password",
            showText: controller.showPassword,
            isLastField: true,
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Bounce(
                onPressed: () {
                  Get.to(() => const ForgotPasswordEmailScreen());
                },
                child: Text(
                  "Forgot Password?",
                  style: textStyle(
                    context: context,
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
          AppButton(
            onTap: () {
              Get.to(() => MainScreen());
            },
            text: "Login",
            isLoading: false,
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
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
                onPressed: () {},
                buttonType: Type.Facebook,
              ),
              const SizedBox(
                width: 10,
              ),
              SocialButton(
                onPressed: () {},
                buttonType: Type.Google,
              ),
            ],
          ),
          Expanded(child: Container()),
          Text(
            "Continue as a guest",
            style: textStyle(
              context: context,
              color: Theme.of(context).primaryColor,
              isBold: true,
              haveUnderline: true,
            ),
          ),
          Expanded(child: Container()),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: "Don't have an account? ",
                style: textStyle(
                  context: context,
                ),
              ),
              TextSpan(
                text: 'Register Now',
                style: textStyle(
                  context: context,
                  color: Theme.of(context).primaryColor,
                  isBold: true,
                  haveUnderline: true,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(() => const RegisterScreen());
                  },
              ),
            ],
          )),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
        ],
      ),
    );
  }
}
