import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/models/user_model.dart';
import '../../helper/responsive_widget.dart';
import 'controller.dart';
import 'small.dart';

class RegisterPasswordScreen extends StatelessWidget {
  UserModel userModel;
  RegisterPasswordScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPasswordController>(
      init: RegisterPasswordController(),
      didChangeDependencies: (state) {
        state.controller?.userModel = userModel;
      },
      builder: (controller) {
        return ResponsiveWidget(
            smallScreen: Small(
          controller: controller,
        ));
      },
    );
  }
}
