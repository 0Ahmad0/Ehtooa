import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/style_manager.dart';

class ButtonApp extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color colorButtonText;
  final double fontSize;
   double bottomMargin;
  Color? backColor;
  ButtonApp({super.key,
    required this.text,
    required this.onTap,
    this.colorButtonText = ColorManager.white,
    this.fontSize = 16.0,
    this.backColor,
     this.bottomMargin =0.0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backColor==null? Theme.of(context).primaryColor : backColor,
        ),
          onPressed: onTap,
          child: Text(
            text,
            style: getSemiBoldStyle(
              color: colorButtonText,
              fontSize: fontSize,
            ),
          )),
    );
  }
}