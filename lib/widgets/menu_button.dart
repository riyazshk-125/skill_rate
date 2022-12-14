import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_bounce.dart';

class MenuButtonWidget extends StatelessWidget {
  void Function() onPressed;
  MenuButtonWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: onPressed,
      child: Icon(
        Icons.more_vert_outlined,
        size: 30,
      ),
    );
  }
}
