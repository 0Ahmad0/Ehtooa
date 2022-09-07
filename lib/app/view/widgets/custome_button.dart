import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/style_manager.dart';

class ButtonApp extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color colorButtonText;
  final double fontSize;

  ButtonApp({super.key,
    required this.text,
    required this.onTap,
    this.colorButtonText = ColorManager.white,
    this.fontSize = 16.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: getSemiBoldStyle(
            color: colorButtonText,
            fontSize: fontSize,
          ),
        ));
  }
}