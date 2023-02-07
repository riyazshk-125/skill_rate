import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/models/login_response.dart';

import '../../helper/responsive_widget.dart';
import 'controller.dart';
import 'small.dart';

class OTPScreen extends StatelessWidget {
  LoginResponseModel? loginResponseModel;
  String verificationId;
  int? resendToken;
  String phone;
  OTPScreen(
      {Key? key,
      this.loginResponseModel,
      required this.resendToken,
      required this.verificationId,
      required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPController>(
      init: OTPController(),
      didChangeDependencies: (state) {
        state.controller?.verificationId = verificationId;
        state.controller?.loginResponseModel =
            loginResponseModel ?? LoginResponseModel();
        state.controller?.resendToken = resendToken;
        state.controller?.phone = phone;
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
