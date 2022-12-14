import 'package:flutter/material.dart';
import 'package:skill_rate/helper/styles.dart';

class LineTitleWidget extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final Color? dividerColor;

  const LineTitleWidget(
      {Key? key, required this.title, this.dividerColor, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: getWidth(
          15,
          context,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: dividerColor ?? Theme.of(context).focusColor,
            ),
          ),
          if (title.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(getWidth(10, context)),
              child: Text(
                title,
                style: style ??
                    textStyle(
                      context: context,
                      color: Theme.of(context).focusColor,
                    ),
              ),
            ),
          Expanded(
            child: Container(
              height: 1,
              color: dividerColor ?? Theme.of(context).focusColor,
            ),
          ),
        ],
      ),
    );
  }
}
