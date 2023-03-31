import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/models/my_skills_model.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/helper/styles.dart';
import 'package:skill_rate/main.dart';
import 'package:skill_rate/widgets/button.dart';

import '../../helper/models/skill_model.dart';
import '../../helper/models/user_model.dart';
import '../../widgets/flutter_bounce.dart';
import '../../widgets/text_field_container.dart';

class ProfileController extends GetxController {
  UserModel userModel = UserModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController searchSkillController = TextEditingController();

  List<SkillModel> skills = [];
  List<int> selectedSkill = [];
  List<MySkillsModel> mySkills = [];
  bool isSkillSaving = false;
  bool isLoading = false;
  bool isUpdatingLoading = false;
  bool isReadOnlyEmail = false;
  bool isReadOnlyMobile = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    userModel = Get.arguments;
    isReadOnlyEmail = userModel.email != null && userModel.email!.isNotEmpty;
    isReadOnlyMobile = userModel.mobile != null && userModel.mobile!.isNotEmpty;
    setValues();
    getMySkills();

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setValues() {
    nameController.text = getUserName(userModel);
    emailController.text = userModel.email ?? "";
    phoneController.text = userModel.mobile ?? "";
    update();
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

  void addSkills(BuildContext context) async {
    selectedSkill.clear();
    searchSkillController.clear();
    skills = List.generate(
        globalController.skills.length > 5 ? 5 : globalController.skills.length,
        (index) => globalController.skills[index]);
    if (mySkills.isNotEmpty) {
      for (var item in mySkills) {
        selectedSkill.add(item.userSkillsName?.id ?? 0);
      }
    }

    Get.dialog(Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppMethods.DEFAULT_PADDING),
          child: Card(
            child: GetBuilder<ProfileController>(
              init: ProfileController(),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Add Skill to your profile",
                                  style: textStyle(
                                    context: context,
                                    isBold: true,
                                  ),
                                ),
                              ),
                              Bounce(
                                onPressed: () {
                                  searchSkillController.clear();
                                  skills.clear();
                                  update();
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Theme.of(context).shadowColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppMethods.DEFAULT_PADDING * 2,
                          ),
                          Text(
                            "Skill",
                            style: textStyle(
                              context: context,
                              isBold: false,
                            ),
                          ),
                          TextFieldContainer(
                            textEditingController: searchSkillController,
                            bgColor: Theme.of(context).scaffoldBackgroundColor,
                            borderColor: Theme.of(context).dividerColor,
                            hint: "Search Skill",
                            onChanged: (value) {
                              Get.log(value);
                              skills.clear();
                              var filterList = globalController.skills
                                  .where((element) =>
                                      element
                                          .getSkillCategoryName!.categoryName!
                                          .toLowerCase()
                                          .contains(value.toLowerCase()) ||
                                      element.name!
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                  .toList();
                              skills.addAll(filterList);
                              Get.log("${globalController.skills.length}");
                              update();
                            },
                          ),
                          Wrap(
                            spacing: AppMethods.DEFAULT_PADDING / 2,
                            runSpacing: AppMethods.DEFAULT_PADDING / 2,
                            children: List.generate(
                              skills.length,
                              (index) => Bounce(
                                onPressed: () {
                                  if (!selectedSkill
                                      .contains(skills[index].id ?? 0)) {
                                    selectedSkill.add(skills[index].id ?? 0);
                                  } else {
                                    selectedSkill.remove(skills[index].id ?? 0);
                                  }
                                  update();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedSkill
                                              .contains(skills[index].id ?? 0)
                                          ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                          : Theme.of(context).shadowColor,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedSkill
                                            .contains(skills[index].id ?? 0)
                                        ? Theme.of(context).shadowColor
                                        : Theme.of(context)
                                            .scaffoldBackgroundColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    skills[index].name ?? "",
                                    style: textStyle(
                                      context: context,
                                      color: selectedSkill
                                              .contains(skills[index].id ?? 0)
                                          ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                          : Theme.of(context).shadowColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).shadowColor.withOpacity(0.25),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppMethods.DEFAULT_PADDING),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: width(context) * 0.25,
                            child: AppButton(
                              text: "Cancel",
                              onTap: () {
                                searchSkillController.clear();
                                skills.clear();
                                update();
                                Get.back();
                              },
                              buttonStyle: ButtonThemeStyle.Bordered,
                              verticalPadding: 7,
                              haveMargin: false,
                            ),
                          ),
                          SizedBox(
                            width: AppMethods.DEFAULT_PADDING / 2,
                          ),
                          SizedBox(
                            width: width(context) * 0.25,
                            child: AppButton(
                              text: "Save",
                              onTap: () async {
                                if (selectedSkill.isNotEmpty) {
                                  isSkillSaving = true;
                                  update();
                                  bool isSuccess =
                                      await apiHolder.saveUserSkills(
                                          selectedSkill.join(","),
                                          mySkills.isEmpty);
                                  isSkillSaving = false;
                                  update();
                                  if (isSuccess) {
                                    searchSkillController.clear();
                                    skills.clear();
                                    update();
                                    getMySkills();
                                    Get.back();
                                  }
                                }
                              },
                              buttonStyle: ButtonThemeStyle.Primary,
                              verticalPadding: 7,
                              haveMargin: false,
                              isLoading: isSkillSaving,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ));
  }

  void getMySkills() async {
    isLoading = true;
    update();
    mySkills = await apiHolder.callMySkills();
    isLoading = false;
    update();
  }

  void updateProfile(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isUpdatingLoading = true;
    update();
    UserModel newModel = userModel;
    if (emailController.text.trim().isNotEmpty) {
      newModel.email = emailController.text.trim();
    }
    if (phoneController.text.trim().isNotEmpty) {
      newModel.mobile = phoneController.text.trim();
    }
    bool isSuccess = await apiHolder.updateProfile(userModel: newModel);
    Get.log("Is Success ----> $isSuccess");
    if (isSuccess) {
      userModel = await apiHolder.userProfile();
    } else {
      emailController.clear();
      phoneController.clear();
    }
    isReadOnlyEmail = userModel.email != null && userModel.email!.isNotEmpty;
    isReadOnlyMobile = userModel.mobile != null && userModel.mobile!.isNotEmpty;
    isUpdatingLoading = false;
    setValues();
  }

  Future<void> refreshData() async {
    getMySkills();
  }
}
