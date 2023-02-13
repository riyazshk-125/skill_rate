import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skill_rate/main.dart';
import 'package:skill_rate/screens/login/main.dart';

class PasswordChangeController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changePassword(BuildContext context) async {
    if (passwordController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Enter password");
      return;
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Enter confirm password");
      return;
    }
    if (confirmPasswordController.text.trim() !=
        passwordController.text.trim()) {
      Fluttertoast.showToast(
          msg: "Password and confirm password should be same");
      return;
    }
    isLoading = true;
    update();

    bool isSuccess = await apiHolder.changePassword(
        email: Get.arguments, password: passwordController.text.trim());

    isLoading = false;
    update();
    if (isSuccess) {
      Get.offAll(() => const LoginScreen());
    }
  }
}
