import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/responsive_widget.dart';
import 'controller.dart';
import 'small.dart';

class SkillRatingDetailScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SkillRatingDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkillRatingDetailController>(
      init: SkillRatingDetailController(),
      builder: (controller) {
        return ResponsiveWidget(
          smallScreen: Small(
            controller: controller,
            scaffoldKey: _scaffoldKey,
          ),
        );
      },
    );
  }
}
