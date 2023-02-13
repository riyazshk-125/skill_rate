import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../password_change/main.dart';

class ForgotPasswordOTPController extends GetxController {
  String otpText = "";
  String receivedOTP = "";
  @override
  void onInit() {
    receivedOTP = Get.arguments["otp"];
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void verifyOTP(BuildContext context) async {
    if (otpText.length != receivedOTP.length) {
      Fluttertoast.showToast(msg: "Invalid OTP");
      return;
    }
    if (otpText != receivedOTP) {
      Fluttertoast.showToast(msg: "Incorrect OTP");
      return;
    }

    Get.to(() => PasswordChangeScreen(), arguments: Get.arguments["email"]);
  }
}
