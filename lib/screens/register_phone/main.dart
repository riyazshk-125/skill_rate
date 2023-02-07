import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/responsive_widget.dart';
import 'controller.dart';
import 'small.dart';

class RegisterPhoneScreen extends StatelessWidget {
  String phone;
  RegisterPhoneScreen({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPhoneController>(
      init: RegisterPhoneController(),
      didChangeDependencies: (state) {
        state.controller?.phoneController.text = phone;
        state.controller?.update();
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
