import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/widgets/button.dart';

import '../../helper/styles.dart';
import '../login/main.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final PasswordChangeSuccessController controller;

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "asset/svg/success_bg.svg",
                width: width(context) * 0.266,
                fit: BoxFit.contain,
              ),
              Icon(
                Icons.check_rounded,
                color: Theme.of(context).scaffoldBackgroundColor,
                size: width(context) * 0.12,
              )
            ],
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING * 2,
          ),
          Text(
            "Password Changed!",
            style: textStyle(
              context: context,
              fontSize: FontSize.H1,
              isBold: true,
            ),
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING / 2,
          ),
          Text(
            "Your password has been changed successfully.",
            textAlign: TextAlign.center,
            style: textStyle(
              context: context,
              color: Theme.of(context).focusColor,
            ),
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING * 2,
          ),
          AppButton(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()),
                  ModalRoute.withName('/'));
            },
            text: "Back to Login",
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
