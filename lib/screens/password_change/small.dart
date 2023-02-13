import 'package:flutter/material.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/widgets/button.dart';

import '../../helper/styles.dart';
import '../../helper/validation_helper.dart';
import '../../widgets/back_button.dart';
import '../../widgets/text_field_container.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final PasswordChangeController controller;

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
                  "Create new password",
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
            "Your new password must be unique from those previously used.",
            style: textStyle(
              context: context,
              color: Theme.of(context).focusColor,
            ),
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
                  textEditingController: controller.passwordController,
                  /*onToggle: () {
                controller.togglePassword();
              },*/
                  hint: "New Password",
                  // showText: controller.showPassword,
                  isLastField: true,
                  validator: (value) => Validator.validateText(value ?? ""),
                ),
                SizedBox(
                  height: AppMethods.DEFAULT_PADDING / 2,
                ),
                TextFieldContainer(
                  textEditingController: controller.confirmPasswordController,
/*              onToggle: () {
                controller.togglePassword();
              },*/
                  hint: "Confirm Password",
                  // showText: controller.showPassword,
                  isLastField: true,
                  validator: (value) => Validator.validateText(value ?? ""),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
          AppButton(
            onTap: () {
              controller.changePassword(context);
            },
            text: "Reset Password",
            isLoading: controller.isLoading,
          ),
        ],
      ),
    );
  }
}
