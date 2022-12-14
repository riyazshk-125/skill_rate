import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer/view.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

extension WidgetExtension on Widget {
  Widget scaffold(GlobalKey<ScaffoldState> key) {
    return Scaffold(
      key: key,
      endDrawer: AppDrawerView(),
      body: this,
    );
  }
}
