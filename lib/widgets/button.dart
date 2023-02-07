import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skill_rate/helper/styles.dart';

import 'flutter_bounce.dart';

class AppButton extends StatelessWidget {
  void Function()? onTap;
  String text;
  bool isLoading;
  IconData? icon;
  bool haveMargin;
  double? padding;
  double? iconSize;
  TextStyle? buttonTextStyle;
  double? borderRadius;
  Color? buttonBGColor;
  bool haveShadow;
  bool haveBorder;
  double? horizontalPadding;
  double? verticalPadding;
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  bool haveWidth;
  ButtonThemeStyle buttonStyle = ButtonThemeStyle.Primary;

  AppButton({
    Key? key,
    this.onTap,
    this.text = "Button",
    this.icon,
    this.padding,
    this.isLoading = false,
    this.haveMargin = true,
    this.iconSize,
    this.borderRadius,
    this.buttonBGColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.buttonTextStyle,
    this.haveShadow = false,
    this.haveBorder = false,
    this.horizontalPadding,
    this.verticalPadding,
    this.haveWidth = true,
    this.buttonStyle = ButtonThemeStyle.Primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonStyle) {
      case ButtonThemeStyle.Primary:
        return Bounce(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (!isLoading) {
              onTap!();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLoading ? "" : text,
                  style: buttonTextStyle ??
                      textStyle(
                        context: context,
                        color: Theme.of(context).cardColor,
                      ),
                ),
                if (isLoading)
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: Theme.of(context).cardColor,
                    size: 20,
                  )
              ],
            ),
          ),
        );
      case ButtonThemeStyle.Bordered:
        return Bounce(
          onPressed: () {
            if (!isLoading) {
              onTap!();
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(
                  5,
                ),
                border: Border.all(color: Theme.of(context).backgroundColor)),
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLoading ? "" : text,
                  style: textStyle(
                    context: context,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                if (isLoading)
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: Theme.of(context).backgroundColor,
                    size: 20,
                  )
              ],
            ),
          ),
        );
      case ButtonThemeStyle.Disabled:
        return Container();
    }
  }
}

enum ButtonThemeStyle {
  Primary,
  Bordered,
  Disabled,
}
