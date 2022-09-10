
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../resources/globals.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class ChatBox extends StatefulWidget {
   ChatBox({
    Key? key,
    required this.controller, this.text,this.onChanged
  }) : super(key: key);

  final AnimationController controller;
  final  TextEditingController? text ;
  var onChanged ;

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Globals.borderRadius),
          color: ColorManager.blackGray,
        ),
        child:  TextField(
          autofocus: true,
          onChanged: widget.onChanged,
          style: getRegularStyle(
            color: ColorManager.white,
            fontSize: Sizer.getW(context) / 24
          ),
          controller: widget.text,
          decoration: InputDecoration(
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){
                  Const.TOAST(context,textToast: "Welcome");
                }, icon: Icon(Icons.camera_alt)),
                IconButton(onPressed: (){
                  Const.TOAST(context,textToast: "Welcome");
                }, icon: Icon(Icons.attach_file)),
              ],
            ),
            hintText: tr(LocaleKeys.type_here),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppPadding.p12,

            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none
          ),
        ),
      ),
    );
  }
}
