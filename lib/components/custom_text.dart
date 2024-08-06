import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String text;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const CustomText({super.key, required this.text, this.fontSize = 14, this.color = Colors.black, this.textAlign = TextAlign.left, this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight
      ),
    );
  }
}
