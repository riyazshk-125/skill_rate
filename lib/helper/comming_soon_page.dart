import 'package:flutter/material.dart';
import 'package:skill_rate/helper/styles.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Image.asset(
          "assets/images/coming_soon.jpeg",
          width: width(context),
          height: height(context),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
