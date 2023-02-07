import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/extensions.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/screens/skill_rating_detail/main.dart';
import 'package:skill_rate/widgets/flutter_bounce.dart';

import '../../helper/styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/rating_widget/rating_bar.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final OtherProfileController controller;
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Profile Details",
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
          if (!controller.isLoading)
            if (controller.userModel.id != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppMethods.DEFAULT_PADDING * 3 / 2),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING / 2,
                    ),
                    Text(
                      controller.getUserName(controller.userModel),
                      style: textStyle(
                        context: context,
                        fontSize: FontSize.H2,
                      ),
                    ),
                    Text(
                      controller.userModel.email ?? "",
                      style: textStyle(
                          context: context,
                          fontSize: FontSize.H3,
                          color: Theme.of(context).splashColor),
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING * 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppMethods.DEFAULT_PADDING),
                  child: ListView(
                    children: [
                      Text(
                        "${controller.getUserName(controller.userModel)}'s Skills :",
                        style: textStyle(
                          context: context,
                          fontSize: FontSize.H3,
                        ),
                      ),
                      SizedBox(
                        height: AppMethods.DEFAULT_PADDING / 2,
                      ),
                      ...List.generate(
                        controller.userModel.userSkills?.length ?? 0,
                        (index) => Bounce(
                          onPressed: () {
                            if (controller
                                    .userModel.userSkills?[index].skillId !=
                                null) {
                              Get.to(() => SkillRatingDetailScreen(),
                                  arguments:
                                      "${controller.userModel.userSkills?[index].id ?? 0}");
                            }
                          },
                          child: Container(
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
                                    controller.userModel.userSkills?[index]
                                            .userSkillsName?.name ??
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
                                    initialRating: double.parse(controller
                                            .userModel
                                            .userSkills?[index]
                                            .avgRating ??
                                        "0.0"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              /*Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppMethods.DEFAULT_PADDING * 3 / 2),
                child: AppButton(
                  text: "Copy Details",
                  onTap: () {
                    var infoText =
                        "Name : ${controller.getUserName(controller.userModel)}\nEmail : ${controller.userModel.email ?? "None"}\nHave Skills\n";

                    for (MySkillsModel item
                        in controller.userModel.userSkills ?? []) {
                      infoText =
                          "$infoText\n${item.userSkillsName?.name ?? "NA"} (${item.avgRating} rating)";
                    }
                    infoText =
                        "$infoText\nTo contact ${controller.getUserName(controller.userModel)} please download Skill rate";
                    Clipboard.setData(ClipboardData(text: infoText));
                    Fluttertoast.showToast(msg: "Content Copied");
                  },
                ),
              ),
              SizedBox(
                height: AppMethods.DEFAULT_PADDING,
              ),*/
            ],
          if (controller.isLoading) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppMethods.DEFAULT_PADDING * 3 / 2),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING / 2,
                  ),
                  Text(
                    "Sanjeev Kumar",
                    style: textStyle(
                      context: context,
                      fontSize: FontSize.H2,
                    ),
                  ).textShimmer(context),
                  Text(
                    "sanjeevkumar",
                    style: textStyle(
                        context: context,
                        fontSize: FontSize.H3,
                        color: Theme.of(context).splashColor),
                  ).textShimmer(context),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING * 2,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sanjeev Kumar's Skills :",
                    style: textStyle(
                      context: context,
                      fontSize: FontSize.H3,
                    ),
                  ).textShimmer(context),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING / 2,
                  ),
                  ...List.generate(
                    5,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Java",
                            style: textStyle(
                              context: context,
                              fontSize: FontSize.H3,
                            ),
                          ).textShimmer(context),
                          RatingBar(
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
                            initialRating: 4,
                          ).shimmer(context)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppMethods.DEFAULT_PADDING,
            ),
          ]
        ],
      ),
    ).scaffold(scaffoldKey);
  }
}
