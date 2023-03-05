import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/models/user_model.dart';

import '../../helper/models/login_response.dart';
import '../../main.dart';
import '../main/main.dart';

class RegisterPasswordController extends GetxController {
  bool showPassword = true;
  bool showConfirmPassword = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserModel userModel = UserModel();

  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void togglePassword() {
    showPassword = !showPassword;
    update();
  }

  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      Fluttertoast.showToast(msg: "Password and confirm password should same");
      return;
    }
    isLoading = true;
    update();
    LoginResponseModel loginResponse = await apiHolder.register(
        password: passwordController.text.trim(),
        email: userModel.email,
        username: userModel.username,
        firstName: userModel.firstName,
        lastName: userModel.lastName,
        phone: userModel.mobile,
        user_login_type: "1");
    isLoading = false;
    update();
    if (loginResponse.token != null) {
      await prefs.setUserToken(loginResponse.token ?? "");
      print(await prefs.getUserToken());
      Fluttertoast.showToast(msg: "User registered successfully");
      Get.offAll(() => MainScreen());
    }

    isLoading = false;
    update();
  }
}
