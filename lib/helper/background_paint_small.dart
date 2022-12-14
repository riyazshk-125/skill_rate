import 'package:flutter/material.dart';

class BackgroundPaintSmall extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height / 2);
    path.arcToPoint(
      Offset(width, height / 2),
      clockwise: false,
      radius: Radius.circular(width / 1.6),
    );
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
