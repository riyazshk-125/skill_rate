import 'package:flutter/material.dart';
import 'package:skill_rate/helper/extensions.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/widgets/rating_widget/rating_bar.dart';

import '../../helper/styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/menu_button.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final MySkillRatingDetailController controller;
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
      // alignment: Alignment.topCenter,
      child: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppMethods.DEFAULT_PADDING),
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
                            "Skill Details",
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
                  if (controller.skillDetailModel.id != null) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppMethods.DEFAULT_PADDING * 0.5),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppMethods.DEFAULT_PADDING / 2,
                          ),
                          Container(
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
                            width: width(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                      .getUserName(controller.skillDetailModel),
                                  style: textStyle(
                                    context: context,
                                    fontSize: FontSize.H2,
                                  ),
                                ),
                                Text(
                                  controller.skillDetailModel.userInformation
                                          ?.email ??
                                      "",
                                  style: textStyle(
                                      context: context,
                                      fontSize: FontSize.H3,
                                      color: Theme.of(context).splashColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppMethods.DEFAULT_PADDING,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppMethods.DEFAULT_PADDING * 3 / 2),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.skillDetailModel.userSkillsName
                                              ?.name ??
                                          "",
                                      style: textStyle(
                                        context: context,
                                        fontSize: FontSize.H2,
                                      ),
                                    ),
                                    Text(
                                      controller
                                              .skillDetailModel
                                              .userSkillsName
                                              ?.getSkillCategoryName
                                              ?.categoryName ??
                                          "",
                                      style: textStyle(
                                          context: context,
                                          fontSize: FontSize.H3,
                                          color: Theme.of(context).splashColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: AppMethods.DEFAULT_PADDING,
                              ),
                              Column(
                                children: [
                                  Text(
                                    double.parse(controller
                                                .skillDetailModel.avgRating ??
                                            "0.0")
                                        .toStringAsFixed(1),
                                    style: textStyle(
                                      context: context,
                                      fontSize: FontSize.H4,
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
                                              .skillDetailModel.avgRating ??
                                          "0.0"),
                                    ),
                                  ),
                                  Text(
                                    "(${controller.skillDetailModel.userSkillRating?.data?.length ?? 0})",
                                    style: textStyle(
                                      context: context,
                                      fontSize: FontSize.H6,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: AppMethods.DEFAULT_PADDING,
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
                            ...[
                              ...List.generate(
                                controller.skillDetailModel.userSkillRating
                                        ?.data?.length ??
                                    0,
                                (index) => Container(
                                  margin: EdgeInsets.only(
                                      bottom: AppMethods.DEFAULT_PADDING / 2),
                                  child: Stack(
                                    children: [
                                      Container(
                                        /*margin: EdgeInsets.only(
                                        bottom: AppMethods.DEFAULT_PADDING / 2),*/
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          border: Border.all(
                                            color:
                                                Theme.of(context).dividerColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    controller
                                                        .getReviewedUserName(
                                                            controller
                                                                .skillDetailModel
                                                                .userSkillRating
                                                                ?.data?[index]
                                                                .reviewedByInfo),
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
                                                        color:
                                                            Color(0xFFDFB300),
                                                      ),
                                                      half: const Icon(
                                                        Icons.star,
                                                        size: 10,
                                                        color:
                                                            Color(0xFFDFB300),
                                                      ),
                                                      empty: const Icon(
                                                        Icons.star,
                                                        size: 10,
                                                        color:
                                                            Color(0xFF494949),
                                                      ),
                                                    ),
                                                    onRatingUpdate:
                                                        (double value) {},
                                                    allowHalfRating: false,
                                                    initialRating: double.parse(
                                                        controller
                                                                .skillDetailModel
                                                                .userSkillRating
                                                                ?.data?[index]
                                                                .rating ??
                                                            "0.0"),
                                                  ),
                                                )
                                              ],
                                            ),
                                            if (controller
                                                    .skillDetailModel
                                                    .userSkillRating
                                                    ?.data?[index]
                                                    .review !=
                                                null) ...[
                                              SizedBox(
                                                height:
                                                    AppMethods.DEFAULT_PADDING,
                                              ),
                                              if (controller
                                                      .skillDetailModel
                                                      .userSkillRating
                                                      ?.data?[index]
                                                      .review
                                                      ?.isNotEmpty ??
                                                  false)
                                                Text(
                                                  '"${controller.skillDetailModel.userSkillRating?.data?[index].review}"',
                                                  style: textStyle(
                                                    context: context,
                                                    fontSize: FontSize.H5,
                                                    color: Theme.of(context)
                                                        .primaryColorDark,
                                                    isItalic: true,
                                                  ),
                                                ),
                                              /*if (controller.myGivenRating.id ==
                                                  controller
                                                      .skillDetailModel
                                                      .userSkillRating
                                                      ?.data?[index]
                                                      .id)
                                                Opacity(
                                                  opacity: 0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .dividerColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 6,
                                                      horizontal: 10,
                                                    ),
                                                    child: Icon(
                                                      Icons.edit_outlined,
                                                      color: Theme.of(context)
                                                          .backgroundColor,
                                                      size: AppMethods
                                                          .DEFAULT_PADDING,
                                                    ),
                                                  ),
                                                )*/
                                            ],
                                          ],
                                        ),
                                      ),
                                      if (controller
                                              .skillDetailModel
                                              .userSkillRating
                                              ?.data?[index]
                                              .isApproved ==
                                          "0")
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFFF8C0),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 6,
                                              horizontal: 10,
                                            ),
                                            child: Text(
                                              "Approval Pending",
                                              style: textStyle(
                                                  context: context,
                                                  fontSize: FontSize.P2,
                                                  color: Color(0xFFCCA300)),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              )
                            ],

                            /*Center(
                                child: Bounce(
                                  onPressed: () {
                                    controller.openAddRatingDialog(context, null);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).backgroundColor,
                                      ),
                                      borderRadius: BorderRadius.circular(1000),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppMethods.DEFAULT_PADDING,
                                        vertical: AppMethods.DEFAULT_PADDING / 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.edit_outlined,
                                          color:
                                              Theme.of(context).backgroundColor,
                                          size: width(context) / 18,
                                        ),
                                        SizedBox(
                                          width: AppMethods.DEFAULT_PADDING / 4,
                                        ),
                                        Text(
                                          "Write a review",
                                          style: textStyle(
                                            context: context,
                                            color:
                                                Theme.of(context).backgroundColor,
                                            fontSize: FontSize.H6,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),*/
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppMethods.DEFAULT_PADDING,
                    ),
                  ],
                if (controller.isLoading) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppMethods.DEFAULT_PADDING * 0.5),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppMethods.DEFAULT_PADDING / 2,
                        ),
                        Container(
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
                          width: width(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sanjeev Kumar",
                                style: textStyle(
                                  context: context,
                                  fontSize: FontSize.H2,
                                ),
                              ),
                              Text(
                                "",
                                style: textStyle(
                                    context: context,
                                    fontSize: FontSize.H3,
                                    color: Theme.of(context).splashColor),
                              ),
                            ],
                          ),
                        ).shimmer(context),
                        SizedBox(
                          height: AppMethods.DEFAULT_PADDING,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppMethods.DEFAULT_PADDING * 3 / 2),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "sadnjsda",
                                    style: textStyle(
                                      context: context,
                                      fontSize: FontSize.H2,
                                    ),
                                  ).textShimmer(context),
                                  Text(
                                    "jhsaasdsdsads",
                                    style: textStyle(
                                        context: context,
                                        fontSize: FontSize.H3,
                                        color: Theme.of(context).splashColor),
                                  ).textShimmer(context),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: AppMethods.DEFAULT_PADDING,
                            ),
                            IgnorePointer(
                              ignoring: true,
                              child: RatingBar(
                                itemSize: 25,
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
                              ).shimmer(context),
                            )
                          ],
                        ),
                        SizedBox(
                          height: AppMethods.DEFAULT_PADDING,
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
                          ...List.generate(
                            3,
                            (index) => Container(
                              margin: EdgeInsets.only(
                                  bottom: AppMethods.DEFAULT_PADDING / 2),
                              child: Stack(
                                children: [
                                  Container(
                                    /*margin: EdgeInsets.only(
                                        bottom: AppMethods.DEFAULT_PADDING / 2),*/
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
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
                                                onRatingUpdate:
                                                    (double value) {},
                                                allowHalfRating: false,
                                                initialRating: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                        ...[
                                          SizedBox(
                                            height: AppMethods.DEFAULT_PADDING,
                                          ),
                                          Text(
                                            '"sddds"',
                                            style: textStyle(
                                              context: context,
                                              fontSize: FontSize.H5,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              isItalic: true,
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .dividerColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  8,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 6,
                                                horizontal: 10,
                                              ),
                                              child: Icon(
                                                Icons.edit_outlined,
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                size:
                                                    AppMethods.DEFAULT_PADDING,
                                              ),
                                            ),
                                          )
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ).shimmer(context),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppMethods.DEFAULT_PADDING,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    ).scaffold(scaffoldKey);
  }
}
