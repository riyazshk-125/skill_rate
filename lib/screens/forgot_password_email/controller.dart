import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/models/user_model.dart';

import '../../helper/validation_helper.dart';
import '../../main.dart';
import '../forgot_otp_screen/main.dart';

class ForgotPasswordEmailController extends GetxController {
  TextEditingController emailPhoneController = TextEditingController();
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> goToOTPScreen(BuildContext context) async {
    if (emailPhoneController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Enter Email or phone");
      return;
    }
    if (emailPhoneController.text.trim().startsWith("0") ||
        emailPhoneController.text.trim().startsWith("+91")) {
      Fluttertoast.showToast(msg: "Enter phone number without code");
      return;
    }
    String? phoneError =
        Validator.validatePhone(emailPhoneController.text.trim(), false);
    String? emailError =
        Validator.validateEmail(emailPhoneController.text.trim());

    if (emailError != null && phoneError != null) {
      Fluttertoast.showToast(msg: "Enter field should be email or phone");
      return;
    }
    UserModel userModel = UserModel(
      email: emailPhoneController.text.trim(),
      mobile: emailPhoneController.text.trim(),
    );

    isLoading = true;
    update();
    if (phoneError != null) {
      userModel.mobile = null;
      //Should be email

      String receiveOTP =
          await apiHolder.sendForgetEmailOTP(email: userModel.email);
      isLoading = false;
      update();
      if (receiveOTP.isNotEmpty) {
        Get.to(() => OTPForgotScreen(
              userModel: userModel,
              receiveOTP: receiveOTP,
              verificationId: "",
              resendToken: 0,
            ));
      }
    } else {
      //Should be phone
      userModel.email = null;

      firebaseHelper.verifyNumber(emailPhoneController.text.trim(),
          codeSent: (verificationId, resendToken) {
        isLoading = false;
        update();
        Get.to(() => OTPForgotScreen(
              resendToken: resendToken,
              verificationId: verificationId,
              userModel: userModel,
            ));
      });
    }
  }
}
