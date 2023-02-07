import 'package:get/get.dart';
import 'package:skill_rate/main.dart';

import 'models/skill_model.dart';

class GlobalController extends GetxController {
  List<SkillModel> skills = [];

  @override
  void onInit() {
    getSkills();
    super.onInit();
  }

  void getSkills() async {
    skills = await apiHolder.callSkills();
    update();
  }
}
