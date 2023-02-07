import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/models/login_response.dart';
import 'package:skill_rate/screens/main/main.dart';

import '../../main.dart';

class RegisterPhoneController extends GetxController {
  bool showPassword = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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

  void togglePassword() {
    showPassword = !showPassword;
    update();
  }

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading = true;
    update();
    LoginResponseModel loginResponse = await apiHolder.register(
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        user_login_type: "6");
    isLoading = false;
    update();
    if (loginResponse.token != null) {
      await prefs.setUserToken(loginResponse.token ?? "");
      print(await prefs.getUserToken());
      Get.offAll(() => MainScreen());
    }
    print("All right");
  }
}
