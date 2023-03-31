import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_rate/main.dart';

import '../../helper/models/skill_model.dart';
import '../../helper/models/user_model.dart';
import '../../helper/shared_files.dart';
import '../../helper/styles.dart';
import '../../widgets/button.dart';
import '../../widgets/flutter_bounce.dart';
import '../../widgets/text_field_container.dart';

class OtherProfileController extends GetxController {
  UserModel userModel = UserModel();
  bool isLoading = false;
  TextEditingController searchSkillController = TextEditingController();

  List<SkillModel> skills = [];
  // List<int> selectedSkill = [];
  int selectedSkillId = -1;
  bool isSkillSaving = false;
  int userId = 0;
  List<int> responseSkill = [];

  @override
  void onInit() {
    userId = Get.arguments;
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
    if (userModel.userSkills != null && userModel.userSkills!.isNotEmpty) {
      for (var item in userModel.userSkills!) {
        responseSkill.add(item.userSkillsName?.id ?? 0);
      }
    }
    isLoading = false;
    update();
  }

  void addSkills(BuildContext context) async {
    selectedSkillId = -1;
    var dialogSkills = globalController.skills;
    searchSkillController.clear();
    if (userModel.userSkills != null && userModel.userSkills!.isNotEmpty) {
      for (var item in userModel.userSkills!) {
        Get.log("${item.skillId}");
        var filterSkill =
            skills.where((element) => "${element.id}" == "${item.skillId}");
        if (filterSkill.isNotEmpty) {
          Get.log(jsonEncode(filterSkill.first));
          dialogSkills.remove(filterSkill.first);
        }
      }
    }
    skills = List.generate(dialogSkills.length > 5 ? 5 : dialogSkills.length,
        (index) => dialogSkills[index]);

    Get.dialog(Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppMethods.DEFAULT_PADDING),
          child: Card(
            child: GetBuilder<OtherProfileController>(
              init: OtherProfileController(),
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
                                  "Add Skill to user profile",
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
                              skills.clear();
                              if (value.isNotEmpty) {
                                var filterList = dialogSkills
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
                              } else {
                                skills = List.generate(
                                    dialogSkills.length > 5
                                        ? 5
                                        : dialogSkills.length,
                                    (index) => dialogSkills[index]);
                              }

                              Get.log("${dialogSkills.length}");
                              update();
                            },
                          ),
                          skills.isNotEmpty
                              ? Wrap(
                                  spacing: AppMethods.DEFAULT_PADDING / 2,
                                  runSpacing: AppMethods.DEFAULT_PADDING / 2,
                                  children: List.generate(
                                    skills.length,
                                    (index) => Bounce(
                                      onPressed: () {
                                        selectedSkillId = skills[index].id ?? 0;
                                        update();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: selectedSkillId ==
                                                    skills[index].id
                                                ? Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                : Theme.of(context).shadowColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: selectedSkillId ==
                                                  skills[index].id
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
                                            color: selectedSkillId ==
                                                    skills[index].id
                                                ? Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                : Theme.of(context).shadowColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  "No result found!",
                                  style: textStyle(context: context),
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
                                if (selectedSkillId != -1) {
                                  isSkillSaving = true;
                                  update();
                                  bool isSuccess =
                                      await apiHolder.saveOtherUserSkills(
                                          "$selectedSkillId",
                                          userModel.id ?? 0);
                                  isSkillSaving = false;
                                  update();
                                  if (isSuccess) {
                                    searchSkillController.clear();
                                    skills.clear();
                                    update();
                                    // getMySkills();
                                    getUserData(userId);
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

  Future<void> refreshData() async {
    getUserData(userId);
  }
}
