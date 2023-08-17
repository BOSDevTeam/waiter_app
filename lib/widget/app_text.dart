import 'package:flutter/material.dart';

import '../value/app_color.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const AppText(
      {super.key,
      required this.text,
      this.color = AppColor.primaryDark,
      this.size = 16,
      this.textOverflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.left,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          overflow: textOverflow,
          fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }
}
