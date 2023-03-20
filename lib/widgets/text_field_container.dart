import 'package:flutter/material.dart';
import 'package:skill_rate/helper/styles.dart';

import 'text_field.dart';

class TextFieldContainer extends StatelessWidget {
  TextEditingController textEditingController;
  TextInputType? keyboardType;
  bool readOnly;
  bool isLastField;
  IconData? icon;
  String? hint;
  void Function()? onTap;
  Function(String)? onChanged;
  Function()? onToggle;
  bool? showText;
  String? Function(String?)? validator;
  Color? bgColor;
  Color? borderColor;
  Color? textColor;

  TextFieldContainer({
    Key? key,
    required this.textEditingController,
    this.keyboardType,
    this.readOnly = false,
    this.isLastField = false,
    this.hint,
    this.onChanged,
    this.onTap,
    this.icon,
    this.onToggle,
    this.validator,
    this.showText,
    this.bgColor,
    this.borderColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: readOnly ? 0.7 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // height: 50,
          // margin: EdgeInsets.only(bottom: AppMethods.DEFAULT_PADDING / 2),
          /*decoration: BoxDecoration(
            color: bgColor ?? Theme.of(context).canvasColor,
            border: Border.all(
              color: borderColor ?? Theme.of(context).dividerColor,
            ),
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),*/
          child: IgnorePointer(
            ignoring: onTap != null,
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    textEditingController: textEditingController,
                    // icon: icon,
                    isLastField: isLastField,
                    key: key,
                    onChanged: onChanged,
                    onTap: onTap,
                    keyboardType: keyboardType,
                    hint: hint,
                    readOnly: readOnly,
                    showText: showText,
                    validator: validator,
                    onToggle: onToggle,
                    style: textStyle(
                      context: context,
                      fontSize: FontSize.H4,
                      // isBold: true,
                      color: textColor ?? Theme.of(context).shadowColor,
                    ),
                    hintStyle: textStyle(
                      context: context,
                      fontSize: FontSize.H4,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
