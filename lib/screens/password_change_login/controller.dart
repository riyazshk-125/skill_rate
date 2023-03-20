import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skill_rate/main.dart';

class PasswordChangeLoginController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool showOldPassword = true;
  bool showNewPassword = true;
  bool showConfirmPassword = true;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changePassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
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

    bool isSuccess = await apiHolder.changePasswordLogin(
      oldPassword: oldPasswordController.text.trim(),
      password: passwordController.text.trim(),
    );

    isLoading = false;
    update();
    if (isSuccess) {
      Get.back();
    }
  }
}
