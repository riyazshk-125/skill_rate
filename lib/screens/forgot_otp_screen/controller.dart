import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skill_rate/main.dart';

import '../../helper/models/user_model.dart';
import '../password_change/main.dart';

class OTPForgotController extends GetxController {
  String otpText = "";
  String verificationId = "";
  int? resendToken;
  UserModel userModel = UserModel();
  bool isLoading = false;
  String? receiveOTP;
  bool isResendLoading = false;
  int timerText = 30;

  @override
  void onInit() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerText > 0) {
        timerText--;
        update();
      }
    });
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
    if (userModel.mobile != null) {
      var userCreds = await firebaseHelper.verifyOTP(verificationId, otpText);

      isLoading = false;
      update();
      if (userCreds.user != null) {
        Get.off(() => PasswordChangeScreen(), arguments: userModel.mobile);
      }
    } else {
      if (otpText != receiveOTP) {
        isLoading = false;
        update();
        Fluttertoast.showToast(msg: "Invalid OTP");
        return;
      }
      Get.off(() => PasswordChangeScreen(), arguments: userModel.email);
    }
  }

  void resendOTP(BuildContext context) async {
    timerText = 30;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerText > 0) {
        timerText--;
        update();
      }
    });
    Fluttertoast.showToast(msg: "Please wait...");
    isResendLoading = true;
    update();
    if (userModel.mobile == null) {
      userModel.mobile = null;
      //Should be email

      String receiveOTP = await apiHolder.sendEmailOTP(
          firstName: userModel.firstName,
          lastName: userModel.lastName,
          email: userModel.email);
      isResendLoading = false;
      update();
      if (receiveOTP.isNotEmpty) {
        //
        this.receiveOTP = receiveOTP;
        Fluttertoast.showToast(msg: "OTP has been sent to your email");
      }
    } else {
      //Should be phone
      userModel.email = null;
      firebaseHelper.verifyNumber(userModel.mobile ?? "",
          resendingToken: resendToken, codeSent: (verificationId, resendToken) {
        Get.log(verificationId);
        Fluttertoast.showToast(msg: "OTP has been sent to your phone");
        this.resendToken = resendToken;
        this.verificationId = verificationId;
        isResendLoading = false;
        update();
        //
      });
    }
  }
}
