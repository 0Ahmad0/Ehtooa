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
    this.readOnly = false
  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        prefixIcon: IconButton(
          icon: Icon(widget.prefixIcon),
          onPressed: widget.onTap,
        ),
        suffixIcon: widget.validFiled
            ? IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            widget.controller.clear();
            widget.validFiled = false;
            setState(() {});
          },
        )
            : null,
        hintText: widget.hintText,
      ),
    );
  }
}
