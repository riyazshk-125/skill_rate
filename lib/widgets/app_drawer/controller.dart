import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/models/user_model.dart';
import 'package:skill_rate/main.dart';

import '../../screens/splash/splash_main.dart';

class AppDrawerController extends GetxController {
  UserModel userModel = UserModel();

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void logout() async {
    await prefs.clearUser();
    Fluttertoast.showToast(msg: "User logged out successfully");
    Get.offAll(() => SplashScreen());
  }

  void getUserData() async {
    userModel = await prefs.getUserModel();
    update();
  }
}
