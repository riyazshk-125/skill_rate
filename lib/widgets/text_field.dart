import 'package:flutter/material.dart';
import 'package:skill_rate/helper/styles.dart';

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
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(5, context), vertical: getHeight(10, context)),
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
          isDense: true,
          hintText: hint,
          hintMaxLines: 1,
          hintStyle: hintStyle ??
              textStyle(
                context: context,
                color: Theme.of(context).primaryColorLight,
              ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          icon: icon != null
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(10, context)),
                  child: Icon(
                    icon,
                    size: getWidth(40, context),
                    color: Theme.of(context).shadowColor,
                  ),
                )
              : null,
        ),
        cursorColor: Theme.of(context).shadowColor,
      ),
    );
  }
}
