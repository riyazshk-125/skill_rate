import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer/view.dart';
import '../widgets/shimmer.dart';

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

  Widget shimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: this,
    );
  }

  Widget textShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
          child: this),
    );
  }
}
