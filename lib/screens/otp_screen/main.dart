import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/models/user_model.dart';

import '../../helper/responsive_widget.dart';
import 'controller.dart';
import 'small.dart';

class OTPScreen extends StatelessWidget {
  String verificationId;
  int? resendToken;
  UserModel userModel;
  String? receiveOTP;
  OTPScreen({
    Key? key,
    required this.resendToken,
    required this.verificationId,
    required this.userModel,
    this.receiveOTP,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPController>(
      init: OTPController(),
      didChangeDependencies: (state) {
        state.controller?.verificationId = verificationId;
        state.controller?.resendToken = resendToken;
        state.controller?.userModel = userModel;
        state.controller?.receiveOTP = receiveOTP;
      },
      builder: (controller) {
        return ResponsiveWidget(
            smallScreen: Small(
          controller: controller,
        ));
      },
    );
  }
}
