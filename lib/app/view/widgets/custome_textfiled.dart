import 'package:flutter/material.dart';
class CustomTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final int? maxLength;
  var validator;
  var onChange;
  var onSubmit;
  final IconData prefixIcon;
   var  suffixIcon;
  final String hintText;
  var onTap;
  bool validFiled;
  bool readOnly;


  CustomTextFiled({super.key,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.autoFocus = false,
    this.maxLength = 0,
    required this.validator,
    required this.onChange,
    this.onSubmit,
    required this.prefixIcon,
    required this.hintText,
    this.onTap = null,
    this.validFiled = false,
    this.readOnly = false,
    this.suffixIcon
  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap:        widget.onTap,
      readOnly: widget.readOnly,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.textInputType,
      maxLength: widget.maxLength,
      textInputAction: widget.textInputAction,
      autofocus: widget.autoFocus,
      validator: widget.validator,
      onChanged: widget.onChange,
      onFieldSubmitted: widget.onSubmit,
      decoration: InputDecoration(

        prefixIcon:
          Icon(widget.prefixIcon),
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
      ),
    );
  }
}
