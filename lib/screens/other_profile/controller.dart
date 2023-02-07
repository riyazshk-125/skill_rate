import 'package:get/get.dart';
import 'package:skill_rate/main.dart';

import '../../helper/models/user_model.dart';

class OtherProfileController extends GetxController {
  UserModel userModel = UserModel();
  bool isLoading = false;

  @override
  void onInit() {
    int userId = Get.arguments;
    getUserData(userId);

    super.onInit();
  }

  String getUserName(UserModel user) {
    if (user.firstName != null && user.lastName != null) {
      return "${user.firstName} ${user.lastName}";
    } else if (user.firstName != null) {
      return "${user.firstName}";
    } else if (user.username != null) {
      return "${user.username}";
    } else {
      return "";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getUserData(int userId) async {
    isLoading = true;
    update();
    userModel = await apiHolder.otherUserProfile(userId);
    isLoading = false;
    update();
  }
}
