import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skill_rate/helper/shared_files.dart';
import 'package:skill_rate/helper/styles.dart';

import 'flutter_bounce.dart';
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: readOnly ? 0.7 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // height: 50,
          margin: EdgeInsets.only(bottom: AppMethods.DEFAULT_PADDING / 2),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
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

                    style: textStyle(
                      context: context,
                      fontSize: FontSize.H4,
                      // isBold: true,
                      color: Theme.of(context).shadowColor,
                    ),
                    hintStyle: textStyle(
                      context: context,
                      fontSize: FontSize.H4,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                ),
                if (showText != null)
                  Bounce(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
