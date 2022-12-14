/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/styles.dart';
import '../main.dart';
import '../screens/document_requirement_csc/view.dart';
import '../screens/form_detail/view.dart';
import 'banner_shimmer.dart';
import 'corousal_slider/carousel_slider.dart';
import 'flutter_bounce.dart';

class BannersWidget extends StatelessWidget {
  final List<BannersModel> banners;
  String? baseUrl;

  BannersWidget({
    Key? key,
    required this.banners,
    this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerLogic>(
      init: BannerLogic(),
      builder: (logic) {
        return AspectRatio(
          aspectRatio: AppMethods.BannerAspectRatio,
          child: LayoutBuilder(builder: (context, constraint) {
            return banners.length > 1
                ? Stack(
                    children: [
                      CarouselSlider(
                        items: List.generate(
                          banners.length,
                          (index) => Bounce(
                            onPressed: () {
                              if (banners[index].type != null &&
                                  AppMethods.isLogin) {
                                if (banners[index].type == "all_forms") {
                                  if (banners[index].formId != null) {
                                    navigate(
                                        context,
                                        FormsDetailPage(
                                            banners[index].formId ?? ""));
                                  }
                                } else if (banners[index].type ==
                                    "university_forms") {
                                  if (banners[index].formId != null) {
                                    */
/*navigate(context,
                                  FormsDetailPage(banners[index].formId ?? ""));*/ /*

                                  }
                                } else if (banners[index].type ==
                                    "common_services") {
                                  if (banners[index].formId != null) {
                                    apiHolder
                                        .callCSCNyIdApi(
                                            banners[index].formId ?? "")
                                        .then((value) {
                                      navigate(
                                          context,
                                          DocumentRequirementPageCSC(
                                            cscModel: value,
                                          ));
                                    });
                                  }
                                } else if (banners[index].type == "mobile") {
                                  if (banners[index].formId != null) {
                                    launchUrl(Uri.parse(
                                        "tel://${banners[index].formId}"));
                                  }
                                } else if (banners[index].type == "library") {
                                  if (banners[index].formId != null) {
                                    */
/*CurrentAffairsPage(
                                      id: "${banners[index].formId}",
                                    );*/ /*

                                    navigate(
                                        context,
                                        CurrentAffairsPage(
                                          id: "${banners[index].formId}",
                                        ));
                                  }
                                } else if (banners[index].type ==
                                    "other_services") {
                                  if (banners[index].formId != null) {
                                    */
/*navigate(context,
                                  FormsDetailPage(banners[index].formId ?? ""));*/ /*

                                  }
                                }
                              }
                            },
                            child: Container(
                              width: width(context),
                              // height: getWidth(300, context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getWidth(30, context),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  getWidth(30, context),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${baseUrl ?? AppMethods.BANNERS_BASE_URL}${banners[index].image}",
                                  fit: BoxFit.cover,
                                  placeholder: (context, value) {
                                    return BannerShimmer();
                                  },
                                  errorWidget: (context, value, _) {
                                    return BannerShimmer();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                            height: constraint.maxHeight,
                            viewportFraction: 1,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (index, _) {
                              logic.pageIndex = index;
                              logic.update();
                            }),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            banners.length,
                            (index) => Container(
                              width: getWidth(15, context),
                              height: getWidth(15, context),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xFF9A9A9A)),
                                  color: index == logic.pageIndex
                                      ? Color(0xFF9A9A9A)
                                      : Colors.white),
                              margin: EdgeInsets.all(getWidth(10, context)),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Bounce(
                    onPressed: () {
                      if (banners[0].type != null && AppMethods.isLogin) {
                        if (banners[0].type == "all_forms") {
                          if (banners[0].formId != null) {
                            navigate(context,
                                FormsDetailPage(banners[0].formId ?? ""));
                          }
                        } else if (banners[0].type == "university_forms") {
                          if (banners[0].formId != null) {
                            */
/*navigate(context,
                                  FormsDetailPage(banners[0].formId ?? ""));*/ /*

                          }
                        } else if (banners[0].type == "common_services") {
                          if (banners[0].formId != null) {
                            apiHolder
                                .callCSCNyIdApi(banners[0].formId ?? "")
                                .then((value) {
                              navigate(
                                  context,
                                  DocumentRequirementPageCSC(
                                    cscModel: value,
                                  ));
                            });
                          }
                        } else if (banners[0].type == "mobile") {
                          if (banners[0].formId != null) {
                            launchUrl(Uri.parse("tel://${banners[0].formId}"));
                          }
                        } else if (banners[0].type == "library") {
                          if (banners[0].formId != null) {
                            */
/*navigate(context,
                                  FormsDetailPage(banners[0].formId ?? ""));*/ /*

                          }
                        } else if (banners[0].type == "other_services") {
                          if (banners[0].formId != null) {
                            */
/*navigate(context,
                                  FormsDetailPage(banners[0].formId ?? ""));*/ /*

                          }
                        }
                      }
                    },
                    child: Container(
                      width: width(context),
                      // height: getWidth(300, context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          getWidth(30, context),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          getWidth(30, context),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "${baseUrl ?? AppMethods.BANNERS_BASE_URL}${banners[0].image}",
                          fit: BoxFit.fitWidth,
                          placeholder: (context, value) {
                            return BannerShimmer();
                          },
                          errorWidget: (context, value, _) {
                            return BannerShimmer();
                          },
                        ),
                      ),
                    ),
                  );
          }),
        );
      },
    );
  }
}

class BannerLogic extends GetxController {
  int pageIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }
}
*/
