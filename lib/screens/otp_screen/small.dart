import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/widgets/button.dart';
import 'package:skill_rate/widgets/otp_widgets/otp_field.dart';
import 'package:skill_rate/widgets/otp_widgets/otp_field_style.dart';
import 'package:skill_rate/widgets/otp_widgets/style.dart';

import '../../helper/styles.dart';
import '../../widgets/back_button.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final OTPController controller;

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
        children: [
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [BackButtonWidget()],
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING * 2,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "OTP Verification",
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
          Text(
            "Enter the verification code we just sent on your ${controller.userModel.email != null ? 'email' : 'phone number'}.",
            style: textStyle(
              context: context,
              color: Theme.of(context).focusColor,
            ),
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
          OTPTextField(
            width: width(context),
            keyboardType: TextInputType.number,
            contentPadding: EdgeInsets.zero,
            fieldStyle: FieldStyle.box,
            length: 6,
            margin: EdgeInsets.zero,
            style: textStyle(
              context: context,
              fontSize: FontSize.H4,
              isBold: true,
              color: Theme.of(context).primaryColor,
            ),
            fieldWidth: width(context) * 0.14,
            otpFieldStyle: OtpFieldStyle(
              enabledBorderColor: Theme.of(context).primaryColor,
              focusBorderColor: Theme.of(context).primaryColor,
            ),
            onChanged: (value) {
              controller.otpText = value;
            },
            onCompleted: (value) {
              controller.otpText = value;
            },
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
          AppButton(
            onTap: () {
              controller.verifyOTP(context);
            },
            text: "Verify",
            isLoading: controller.isLoading,
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
          controller.timerText > 0
              ? RichText(
                  text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Please Wait ",
                      style: textStyle(
                        context: context,
                      ),
                    ),
                    TextSpan(
                      text: '${controller.timerText}',
                      style: textStyle(
                        context: context,
                        color: Theme.of(context).primaryColor,
                        isBold: true,
                        haveUnderline: true,
                      ),
                    ),
                  ],
                ))
              : RichText(
                  text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Didn't received code? ",
                      style: textStyle(
                        context: context,
                      ),
                    ),
                    TextSpan(
                      text: 'Resend',
                      style: textStyle(
                        context: context,
                        color: Theme.of(context).primaryColor,
                        isBold: true,
                        haveUnderline: true,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.resendOTP(context);
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
