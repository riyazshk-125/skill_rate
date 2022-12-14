import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle({
  Color? color,
  required BuildContext context,
  FontSize? fontSize,
  bool isBold = false,
  bool isItalic = false,
  bool haveUnderline = false,
  double? height,
}) {
  return GoogleFonts.urbanist(
    color: color ?? Theme.of(context).shadowColor,
    fontSize: _getFontSize(fontSize ?? FontSize.H4, context),
    fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    height: height,
    decoration: haveUnderline ? TextDecoration.underline : TextDecoration.none,
  );
}

TextStyle textStyleMenu({
  Color? color,
  required BuildContext context,
  FontSize? fontSize,
  bool isBold = false,
  bool isItalic = false,
  bool haveUnderline = false,
}) {
  return GoogleFonts.roboto(
    color: color ?? Theme.of(context).shadowColor,
    fontSize: _getFontSize(fontSize ?? FontSize.H4, context),
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    decoration: haveUnderline ? TextDecoration.underline : TextDecoration.none,
  );
}

TextStyle textStyleLogo({
  Color? color,
  required BuildContext context,
  FontSize? fontSize,
  bool isBold = true,
  bool isItalic = false,
  bool haveUnderline = false,
}) {
  return GoogleFonts.koulen(
    color: color ?? Theme.of(context).shadowColor,
    fontSize: _getFontSize(fontSize ?? FontSize.H4, context),
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    decoration: haveUnderline ? TextDecoration.underline : TextDecoration.none,
  );
}

_getFontSize(FontSize fontSize, BuildContext context) {
  switch (fontSize) {
    case FontSize.H1:
      return width(context) / 14;

    case FontSize.H2:
      return width(context) / 18;

    case FontSize.H3:
      return width(context) / 20;

    case FontSize.H4:
      return width(context) / 22;

    case FontSize.H5:
      return width(context) / 24;

    case FontSize.H6:
      return width(context) / 26;
    case FontSize.H7:
      return width(context) / 28;

    case FontSize.H8:
      return width(context) / 30;
    case FontSize.LOGO:
      return width(context) / 16;
  }
}

double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.height;

double getWidth(double size, BuildContext context) {
  double _width = MediaQuery.of(context).size.width;
  return _width * (size / 750);
}

double getHeight(double size, BuildContext context) {
  double _height = MediaQuery.of(context).size.height;
  return _height * (size / 750);
}

enum FontSize {
  H1,
  H2,
  H3,
  H4,
  H5,
  H6,
  H7,
  H8,
  LOGO,
}
