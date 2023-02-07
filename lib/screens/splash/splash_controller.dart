import 'package:get/get.dart';
import 'package:skill_rate/main.dart';
import 'package:skill_rate/screens/main/main.dart';

class SplashController extends GetxController {
  bool show = false;
  @override
  void onInit() {
    checkUser();

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkUser() async {
    Future.delayed(Duration(seconds: 2), () async {
      var value = await prefs.getUserToken();
      Get.log(value);
      if (value.isNotEmpty) {
        Get.offAll(() => MainScreen());
      } else {
        show = true;
        update();
      }
    });
  }
}
