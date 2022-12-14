import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/responsive_widget.dart';
import 'splash_controller.dart';
import 'splash_small.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return ResponsiveWidget(
            smallScreen: SplashSmall(
          controller: controller,
        ));
      },
    );
  }
}
