import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/shared_files.dart';
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
          if (controller.loginWithPassword) ...[
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
                controller.login(context);
              },
              text: "Login",
              isLoading: controller.isLoading,
            ),
            SizedBox(
              height: AppMethods.DEFAULT_PADDING,
            ),
          ],
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
          ],
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
