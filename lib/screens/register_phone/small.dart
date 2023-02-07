import 'package:flutter/material.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/widgets/button.dart';
import 'package:skill_rate/widgets/text_field_container.dart';

import '../../helper/styles.dart';
import '../../helper/validation_helper.dart';
import '../../widgets/back_button.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final RegisterPhoneController controller;

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
                    isLastField: true,
                    validator: (value) =>
                        Validator.validateText((value ?? " ").trim()),
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING,
                  ),
                  TextFieldContainer(
                    textEditingController: controller.phoneController,
                    hint: "Phone",
                    readOnly: true,
                    keyboardType: TextInputType.text,
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
          ],
        ),
      ),
    );
  }
}
