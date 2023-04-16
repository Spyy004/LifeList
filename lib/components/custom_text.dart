import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CustomText({super.key, required this.text, required this.style});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
