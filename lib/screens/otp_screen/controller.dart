import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skill_rate/main.dart';
import 'package:skill_rate/screens/register_phone/main.dart';

import '../../helper/models/login_response.dart';
import '../main/main.dart';

class OTPController extends GetxController {
  String otpText = "";
  LoginResponseModel loginResponseModel = LoginResponseModel();
  String verificationId = "";
  int? resendToken;
  String phone = "";
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> verifyOTP(BuildContext context) async {
    if (otpText.length != 6) {
      Fluttertoast.showToast(msg: "Invalid OTP");
      return;
    }
    isLoading = true;
    update();
    var userCreds = await firebaseHelper.verifyOTP(verificationId, otpText);

    isLoading = false;
    update();
    if (userCreds.user != null) {
      if (loginResponseModel.email != null) {
        ///Old User
        if (loginResponseModel.token != null) {
          await prefs.setUserToken(loginResponseModel.token ?? "");
          print(await prefs.getUserToken());
          Get.offAll(() => MainScreen());
        }
      } else {
        ///New User
        Get.offAll(() => RegisterPhoneScreen(phone: phone));
      }
    }
  }
}
