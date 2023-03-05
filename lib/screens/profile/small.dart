import 'package:flutter/material.dart';
import 'package:skill_rate/helper/extensions.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/widgets/button.dart';
import 'package:skill_rate/widgets/text_field_container.dart';

import '../../helper/styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/rating_widget/rating_bar.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final ProfileController controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Small({Key? key, required this.controller, required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: height(context),
      color: Theme.of(context).scaffoldBackgroundColor,
      // padding: EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppMethods.DEFAULT_PADDING,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonWidget(),
                    Text(
                      "Profile",
                      style: textStyle(
                        context: context,
                        fontSize: FontSize.H2,
                        isBold: true,
                      ),
                    ),
                    MenuButtonWidget(
                      onPressed: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: AppMethods.DEFAULT_PADDING / 2,
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Theme.of(context).shadowColor.withOpacity(0.25),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppMethods.DEFAULT_PADDING / 2),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppMethods.DEFAULT_PADDING / 2,
                ),
                TextFieldContainer(
                  textEditingController: controller.nameController,
                  bgColor: Theme.of(context).scaffoldBackgroundColor,
                  borderColor: Theme.of(context).dividerColor,
                  hint: "Name",
                ),
                TextFieldContainer(
                  textEditingController: controller.emailController,
                  bgColor: Theme.of(context).scaffoldBackgroundColor,
                  borderColor: Theme.of(context).dividerColor,
                  hint: "Email",
                  textColor: Theme.of(context).splashColor,
                  readOnly: controller.isReadOnlyEmail,
                ),
                TextFieldContainer(
                  textEditingController: controller.phoneController,
                  bgColor: Theme.of(context).scaffoldBackgroundColor,
                  borderColor: Theme.of(context).dividerColor,
                  hint: "Mobile",
                  textColor: Theme.of(context).splashColor,
                  readOnly: controller.isReadOnlyMobile,
                ),
                SizedBox(
                  height: AppMethods.DEFAULT_PADDING,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppMethods.DEFAULT_PADDING),
                  child: AppButton(
                    text: "Update Profile",
                    onTap: () {
                      controller.updateProfile(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
              child: !controller.isLoading
                  ? ListView(
                      children: List.generate(
                        controller.mySkills.length,
                        (index) => Container(
                          margin: EdgeInsets.only(
                              bottom: AppMethods.DEFAULT_PADDING / 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.mySkills[index].userSkillsName
                                          ?.name ??
                                      "",
                                  style: textStyle(
                                    context: context,
                                    fontSize: FontSize.H3,
                                  ),
                                ),
                              ),
                              IgnorePointer(
                                ignoring: true,
                                child: RatingBar(
                                  itemSize: 15,
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
                                  onRatingUpdate: (double value) {},
                                  allowHalfRating: false,
                                  initialRating: double.parse(
                                      controller.mySkills[index].avgRating ??
                                          "0.0"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : ListView(
                      children: List.generate(
                        3,
                        (index) => Container(
                          margin: EdgeInsets.only(
                              bottom: AppMethods.DEFAULT_PADDING / 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "",
                                  style: textStyle(
                                    context: context,
                                    fontSize: FontSize.H3,
                                  ),
                                ),
                              ),
                              IgnorePointer(
                                ignoring: true,
                                child: RatingBar(
                                  itemSize: 15,
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
                                  onRatingUpdate: (double value) {},
                                  allowHalfRating: false,
                                  initialRating: 2,
                                ),
                              )
                            ],
                          ),
                        ).shimmer(context),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppMethods.DEFAULT_PADDING * 3 / 2),
            child: AppButton(
              text: "Add Skill",
              onTap: () {
                controller.addSkills(context);
              },
            ),
          ),
          SizedBox(
            height: AppMethods.DEFAULT_PADDING,
          ),
        ],
      ),
    ).scaffold(scaffoldKey);
  }
}
