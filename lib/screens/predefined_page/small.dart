import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:skill_rate/helper/extensions.dart';
import 'package:skill_rate/helper/shared_files.dart';

import '../../helper/styles.dart';
import '../../widgets/back_button.dart';
import '../../widgets/menu_button.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  final PredefinedPageController controller;

  const Small({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: height(context),
      color: Theme.of(context).scaffoldBackgroundColor,
      // padding: EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
      padding: EdgeInsets.symmetric(horizontal: AppMethods.DEFAULT_PADDING),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Column(
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
                    controller.title,
                    style: textStyle(
                      context: context,
                      fontSize: FontSize.H2,
                      isBold: true,
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: MenuButtonWidget(
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              SizedBox(
                height: AppMethods.DEFAULT_PADDING / 2,
              ),
            ],
          ),
          if (!controller.isLoading)
            Expanded(
              child: SingleChildScrollView(
                child: html.Html(
                  data: controller.htmlText,
                ),
              ),
            ),
          if (controller.isLoading)
            Text("<h2>Privacy Policy</h2> <p> Babarusi Cristian built the Key Code Generator app as an Ad Supported app. This SERVICE is provided by Babarusi Cristian at no cost and is intended for use as is. </p> <p> This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service. </p> <p> If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy. </p> <p> The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Key Code Generator unless otherwise defined in this Privacy Policy. </p> <p><strong>Information Collection and Use</strong></p> <p> For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way. </p> <p> The app does use third party services that may collect information used to identify you. </p> <div><p> Link to privacy policy of third party service providers used by the app </p> <ul><li><a href=\"https://www.google.com/policies/privacy/\" target=\"_blank\">Google Play Services</a></li><li><a href=\"https://support.google.com/admob/answer/6128543?hl=en\" target=\"_blank\">AdMob</a>")
                .textShimmer(context),
          /*Divider(
            height: 1,
            color: Theme.of(context).shadowColor.withOpacity(0.25),
          ),*/
        ],
      ),
    );
  }
}
