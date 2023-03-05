import 'package:flutter/material.dart';
import 'package:skill_rate/widgets/text_field.dart';

import '../helper/shared_files.dart';
import '../helper/styles.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function(String)? onChanged;
  const SearchBarWidget(
      {Key? key, required this.textEditingController, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppMethods.DEFAULT_PADDING / 2),
      decoration: BoxDecoration(
        // color: Theme.of(context).canvasColor,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: AppMethods.DEFAULT_PADDING / 3,
        horizontal: AppMethods.DEFAULT_PADDING / 2,
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_outlined,
            color: Theme.of(context).splashColor,
            size: 25,
          ),
          SizedBox(
            width: AppMethods.DEFAULT_PADDING / 2,
          ),
          Expanded(
            child: AppTextField(
              textEditingController: textEditingController,
              // icon: icon,
              isLastField: true,
              key: key,
              onChanged: onChanged,
              keyboardType: TextInputType.text,
              hint: "Search by Name / Email / Phone",

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
          )
        ],
      ),
    );
  }
}
