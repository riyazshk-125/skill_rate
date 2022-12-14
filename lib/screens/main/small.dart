import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skill_rate/helper/date_format_helper.dart';
import 'package:skill_rate/helper/extensions.dart';
import 'package:skill_rate/helper/shared_files.dart';

import '../../helper/color_helper.dart';
import '../../helper/styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/search_bar.dart';
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
                Column(
                  children: List.generate(
                    controller.users.length,
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
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: controller.colors[Random()
                                              .nextInt(
                                                  controller.colors.length)]),
                                      width: width(context) * 0.15,
                                      height: width(context) * 0.15,
                                    ),
                                    Positioned(
                                      top: -2,
                                      right: -2,
                                      child: CircleAvatar(
                                        radius: 8,
                                        backgroundColor: leftChatBGColor,
                                        child: Center(
                                          child: CircleAvatar(
                                            radius: 6,
                                            backgroundColor: approveColor,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.users[index].name ?? "",
                                    textAlign: TextAlign.center,
                                    style: textStyle(
                                      context: context,
                                      color: Theme.of(context).shadowColor,
                                      isBold: true,
                                    ),
                                  ),
                                  Text(
                                    controller.users[index].message ?? "",
                                    textAlign: TextAlign.center,
                                    style: textStyle(
                                      context: context,
                                      color: Theme.of(context).focusColor,
                                      fontSize: FontSize.H5,
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(
                                width: AppMethods.DEFAULT_PADDING / 2,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormatHelper.getDateFromString(
                                                    controller.users[index]
                                                            .date ??
                                                        "",
                                                    "dd/MM/yyyy")
                                                .difference(DateTime.now())
                                                .inDays ==
                                            0
                                        ? "Today"
                                        : DateFormatHelper.convertDateFromDate(
                                            DateFormatHelper.getDateFromString(
                                                controller.users[index].date ??
                                                    "",
                                                "dd/MM/yyyy"),
                                            "d/M"),
                                    textAlign: TextAlign.center,
                                    style: textStyle(
                                      context: context,
                                      color: Theme.of(context).focusColor,
                                      fontSize: FontSize.H6,
                                    ),
                                  ),
                                  if (controller.users[index].unreadCount !=
                                      null)
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Theme.of(context).shadowColor),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 1),
                                      child: Text(
                                        (controller.users[index].unreadCount ??
                                                0)
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: textStyle(
                                          context: context,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: FontSize.H6,
                                        ),
                                      ),
                                    )
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
                          color:
                              Theme.of(context).shadowColor.withOpacity(0.25),
                        ),
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
}
