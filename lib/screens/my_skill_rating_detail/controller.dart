import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/models/skill_detail_model.dart';
import 'package:skill_rate/main.dart';

import '../../helper/models/user_model.dart';
import '../../helper/shared_files.dart';
import '../../helper/styles.dart';
import '../../widgets/button.dart';
import '../../widgets/flutter_bounce.dart';
import '../../widgets/rating_widget/rating_bar.dart';
import '../../widgets/text_field_container.dart';

class MySkillRatingDetailController extends GetxController {
  SkillDetailModel skillDetailModel = SkillDetailModel();

  Data myGivenRating = Data();
  UserModel myProfile = UserModel();
  bool isSkillSaving = false;

  TextEditingController reviewController = TextEditingController();
  String skillId = "";
  bool isLoading = false;

  @override
  void onInit() {
    skillId = Get.arguments;

    getSkillData(skillId);
    super.onInit();
  }

  String getUserName(SkillDetailModel skillDetail) {
    UserModel user = UserModel(
      email: skillDetail.userInformation?.email,
      username: skillDetail.userInformation?.username,
      firstName: skillDetail.userInformation?.firstName,
      lastName: skillDetail.userInformation?.lastName,
    );
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

  String getReviewedUserName(UserInformation? skillDetail) {
    UserModel user = UserModel(
      email: skillDetail?.email,
      username: skillDetail?.username,
      firstName: skillDetail?.firstName,
      lastName: skillDetail?.lastName,
    );
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

  void getSkillData(String skillId) async {
    isLoading = true;
    update();
    myProfile = await prefs.getUserModel();
    skillDetailModel = await apiHolder.getSkillDetail(skillId);

    if (myProfile.id != null) {
      var filterData = skillDetailModel.userSkillRating?.data
          ?.where((element) => element.reviewedByInfo?.id == myProfile.id);
      if (filterData != null && filterData.isNotEmpty) {
        myGivenRating = filterData.first;
      }
    }
    isLoading = false;
    update();
  }

  void openAddRatingDialog(
      BuildContext context, Data? data, double value) async {
    double rating = value;
    if (data != null) {
      reviewController.text = data.review ?? "";
      rating = double.parse(data.rating ?? "0.0");
    }

    Get.dialog(Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppMethods.DEFAULT_PADDING),
          child: Card(
            child: GetBuilder<MySkillRatingDetailController>(
              init: MySkillRatingDetailController(),
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
                                  "${data?.id != null ? 'Update' : 'Give'} Rating ${data?.id != null ? 'of' : 'to'} ${getUserName(skillDetailModel)}",
                                  style: textStyle(
                                    context: context,
                                    isBold: true,
                                  ),
                                ),
                              ),
                              Bounce(
                                onPressed: () {
                                  reviewController.clear();
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
                            height: AppMethods.DEFAULT_PADDING / 2,
                          ),
                          Center(
                            child: RatingBar(
                              itemSize: 35,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star,
                                  size: 10,
                                  color: Color(0xFFDFB300),
                                ),
                                half: const Icon(
                                  Icons.star,
                                  size: 10,
                                  color: Color(0xFFDFB300),
                                ),
                                empty: const Icon(
                                  Icons.star,
                                  size: 10,
                                  color: Color(0xFF494949),
                                ),
                              ),
                              onRatingUpdate: (double value) {
                                rating = value;
                                update();
                              },
                              allowHalfRating: false,
                              initialRating: rating,
                            ),
                          ),
                          SizedBox(
                            height: AppMethods.DEFAULT_PADDING / 2,
                          ),
                          Text(
                            "Rating",
                            style: textStyle(
                              context: context,
                              isBold: false,
                            ),
                          ),
                          SizedBox(
                            height: AppMethods.DEFAULT_PADDING / 4,
                          ),
                          TextFieldContainer(
                            textEditingController: reviewController,
                            bgColor: Theme.of(context).scaffoldBackgroundColor,
                            borderColor: Theme.of(context).dividerColor,
                            hint: "Add Your Review",
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
                                reviewController.clear();
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
                                if (rating > 0) {
                                  isSkillSaving = true;
                                  update();
                                  bool isSuccess =
                                      await apiHolder.addUpdateOtherUserSkills(
                                    rating,
                                    reviewController.text,
                                    skillDetailModel.id,
                                  );
                                  isSkillSaving = false;
                                  update();
                                  if (isSuccess) {
                                    reviewController.clear();
                                    update();
                                    getSkillData(skillId);
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
    getSkillData(skillId);
  }
}
