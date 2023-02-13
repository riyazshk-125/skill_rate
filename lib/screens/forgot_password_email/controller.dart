import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../helper/validation_helper.dart';
import '../forgot_password_otp/main.dart';

class ForgotPasswordEmailController extends GetxController {
  TextEditingController emailController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goToOTPScreen(BuildContext context) {
    String? emailError = Validator.validateEmail(emailController.text.trim());
    if (emailError != null) {
      Fluttertoast.showToast(msg: emailError);
      return;
    }

    Get.to(() => ForgotPasswordOTPScreen(),
        arguments: {"otp": "1234", "email": emailController.text.trim()});
  }
}
