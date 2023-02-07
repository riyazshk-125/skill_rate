import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_rate/helper/date_format_helper.dart';
import 'package:skill_rate/helper/extensions.dart';
import 'package:skill_rate/helper/models/user_model.dart';
import 'package:skill_rate/helper/shared_files.dart';

import '../../helper/color_helper.dart';
import '../../helper/styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/flutter_bounce.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/search_bar.dart';
import '../other_profile/main.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final MainController controller;
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
      child: ListView(
        controller: controller.scrollController,
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
                    const Opacity(opacity: 0, child: BackButtonWidget()),
                    Text(
                      "User's Review",
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
            padding:
                EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppMethods.DEFAULT_PADDING / 2,
                ),
                SearchBarWidget(
                  textEditingController: controller.searchController,
                  onChanged: controller.textChange,
                ),
                !controller.isLoading
                    ? Column(
                        children: List.generate(
                          controller.searchedUsers.length,
                          (index) => Bounce(
                            onPressed: () {
                              Get.to(() => OtherProfileScreen(),
                                  arguments:
                                      controller.searchedUsers[index].id);
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: AppMethods.DEFAULT_PADDING / 2,
                                ),
                                SizedBox(
                                  // height: width(context) * 0.16,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width(context) * 0.16,
                                        height: width(context) * 0.16,
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: controller
                                                      .colors[index % 5]),
                                              width: width(context) * 0.15,
                                              height: width(context) * 0.15,
                                            ),
                                            Positioned(
                                              top: -2,
                                              right: -2,
                                              child: CircleAvatar(
                                                radius: 8,
                                                backgroundColor:
                                                    leftChatBGColor,
                                                child: Center(
                                                  child: CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor:
                                                        approveColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: AppMethods.DEFAULT_PADDING / 2,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            getUserName(controller
                                                .searchedUsers[index]),
                                            textAlign: TextAlign.center,
                                            style: textStyle(
                                              context: context,
                                              color:
                                                  Theme.of(context).shadowColor,
                                              isBold: true,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            controller.searchedUsers[index]
                                                    .email ??
                                                controller.searchedUsers[index]
                                                    .username ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: textStyle(
                                              context: context,
                                              color:
                                                  Theme.of(context).focusColor,
                                              fontSize: FontSize.H5,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                        width: AppMethods.DEFAULT_PADDING / 2,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormatHelper.getDateFromString(
                                                            controller
                                                                    .searchedUsers[
                                                                        index]
                                                                    .lastLogin ??
                                                                "",
                                                            "dd/MM/yyyy")
                                                        .difference(
                                                            DateTime.now())
                                                        .inDays ==
                                                    0
                                                ? "Today"
                                                : DateFormatHelper.convertDateFromDate(
                                                    DateFormatHelper
                                                        .getDateFromString(
                                                            controller
                                                                    .searchedUsers[
                                                                        index]
                                                                    .lastLogin ??
                                                                "",
                                                            "dd/MM/yyyy"),
                                                    "d/M"),
                                            textAlign: TextAlign.center,
                                            style: textStyle(
                                              context: context,
                                              color:
                                                  Theme.of(context).focusColor,
                                              fontSize: FontSize.H6,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: AppMethods.DEFAULT_PADDING / 2,
                                ),
                                Divider(
                                  height: 1,
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(0.25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: List.generate(
                          6,
                          (index) => Column(
                            children: [
                              SizedBox(
                                height: AppMethods.DEFAULT_PADDING / 2,
                              ),
                              SizedBox(
                                height: width(context) * 0.16,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width(context) * 0.16,
                                      height: width(context) * 0.16,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.white),
                                        width: width(context) * 0.15,
                                        height: width(context) * 0.15,
                                      ).shimmer(context),
                                    ),
                                    SizedBox(
                                      width: AppMethods.DEFAULT_PADDING / 2,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sanjeev",
                                          textAlign: TextAlign.center,
                                          style: textStyle(
                                            context: context,
                                            color:
                                                Theme.of(context).shadowColor,
                                            isBold: true,
                                          ),
                                        ).textShimmer(context),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "sanjeev0810@gmail",
                                          textAlign: TextAlign.center,
                                          style: textStyle(
                                            context: context,
                                            color: Theme.of(context).focusColor,
                                            fontSize: FontSize.H5,
                                          ),
                                        ).textShimmer(context),
                                      ],
                                    )),
                                    SizedBox(
                                      width: AppMethods.DEFAULT_PADDING / 2,
                                    ),
                                    Text(
                                      "jsabghjcd",
                                      textAlign: TextAlign.center,
                                      style: textStyle(
                                        context: context,
                                        color: Theme.of(context).focusColor,
                                        fontSize: FontSize.H6,
                                      ),
                                    ).textShimmer(context),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: AppMethods.DEFAULT_PADDING / 2,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.white,
                              ).shimmer(context),
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    ).scaffold(scaffoldKey);
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
}
