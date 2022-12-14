import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'flutter_bounce.dart';

class SocialButton extends StatelessWidget {
  void Function() onPressed;
  Type buttonType;

  SocialButton({
    Key? key,
    required this.onPressed,
    required this.buttonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: onPressed,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          getAsset(buttonType),
          width: 30,
        ),
      ),
    );
  }

  String getAsset(Type buttonType) {
    switch (buttonType) {
      case Type.Facebook:
        return "asset/svg/facebook_ic.svg";
      case Type.Google:
        return "asset/svg/google_ic.svg";
    }
  }
}

enum Type { Facebook, Google }
