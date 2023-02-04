import 'package:flutter/material.dart';

class SeeMoreText extends StatelessWidget {
  final String text;
  final Color textColor;
  const SeeMoreText(this.text, {super.key, this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline),
    );
  }
}
