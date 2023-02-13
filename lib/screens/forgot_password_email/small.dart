import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/widgets/button.dart';
import 'package:skill_rate/widgets/text_field_container.dart';

import '../../helper/styles.dart';
import '../../widgets/back_button.dart';
import '../login/main.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final ForgotPasswordEmailController controller;

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: AppMethods.DEFAULT_PADDING,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [BackButtonWidget()],
              ),
            ],
          ),
          Column(
            children: [
              TextFieldContainer(
                textEditingController: controller.emailController,
                hint: "Enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: AppMethods.DEFAULT_PADDING,
              ),
              AppButton(
                onTap: () {
                  controller.goToOTPScreen(context);
                },
                text: "Send Code",
                isLoading: false,
              ),
              SizedBox(
                height: AppMethods.DEFAULT_PADDING,
              ),
              Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                style: textStyle(
                  context: context,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ],
          ),
          Column(
            children: [
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: "Remember Password? ",
                    style: textStyle(
                      context: context,
                    ),
                  ),
                  TextSpan(
                    text: 'Login',
                    style: textStyle(
                      context: context,
                      color: Theme.of(context).primaryColor,
                      isBold: true,
                      haveUnderline: true,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()),
                            ModalRoute.withName('/'));
                      },
                  ),
                ],
              )),
              SizedBox(
                height: AppMethods.DEFAULT_PADDING,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
