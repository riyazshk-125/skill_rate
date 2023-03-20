import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skill_rate/helper/color_helper.dart';
import 'package:skill_rate/helper/styles.dart';

import 'flutter_bounce.dart';

class AppTextField extends StatelessWidget {
  TextEditingController textEditingController;
  TextInputType? keyboardType;
  bool readOnly;
  bool isLastField;
  IconData? icon;
  TextStyle? style;
  TextStyle? hintStyle;
  Function(String)? onChanged;
  String? hint;
  void Function()? onTap;
  TextAlign textAlign;
  bool? showText;
  String? Function(String?)? validator;
  Function()? onToggle;
  Widget? prefixIcon;

  AppTextField(
      {Key? key,
      required this.textEditingController,
      this.keyboardType,
      this.readOnly = false,
      this.isLastField = false,
      this.onChanged,
      this.hint,
      this.onTap,
      this.hintStyle,
      this.style,
      this.validator,
      this.textAlign = TextAlign.start,
      this.showText,
      this.onToggle,
      this.prefixIcon,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getHeight(10, context)),
      child: TextFormField(
        scrollPadding: EdgeInsets.zero,
        onTap: onTap,
        textAlign: textAlign,
        controller: textEditingController,
        style: style ??
            textStyle(
              context: context,
            ),
        keyboardType: keyboardType,
        readOnly: readOnly,
        onChanged: onChanged,
        validator: validator,
        textInputAction:
            isLastField ? TextInputAction.done : TextInputAction.next,
        obscureText: showText ?? false,
        decoration: InputDecoration(
          isDense: false,
          hintText: hint,
          hintMaxLines: 1,
          filled: true,
          fillColor: Theme.of(context).canvasColor,
          focusColor: Theme.of(context).canvasColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
          hintStyle: hintStyle ??
              textStyle(
                context: context,
                color: Theme.of(context).primaryColorLight,
              ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide:
                BorderSide(color: Theme.of(context).dividerColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
            borderSide: BorderSide(color: failTextColor),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          prefixIcon: prefixIcon,
          suffixIconColor: Theme.of(context).splashColor,
          suffixIconConstraints: BoxConstraints(maxWidth: 45, minWidth: 45),
          suffixIcon: (showText != null)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Bounce(
                    onPressed: () {
                      onToggle!();
                    },
                    child: SvgPicture.asset(
                      !showText! ? "asset/svg/hide.svg" : "asset/svg/show.svg",
                      color: Theme.of(context).splashColor,
                      width: 25,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : null,
        ),
        cursorColor: Theme.of(context).shadowColor,
      ),
    );
  }
}
