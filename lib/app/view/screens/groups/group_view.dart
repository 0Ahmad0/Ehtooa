import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/screens/chat/chat_view.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
class GroupsView extends StatelessWidget {
  const GroupsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
      Container(
      decoration: BoxDecoration(
          color: ColorManager.lightGray.withOpacity(.2),
        border: Border(
          bottom: BorderSide(
              color: Theme.of(context).textTheme.bodyText1!.color!,
          ),
        )
      ),
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ChatView()));
              },
              onLongPress: (){
                Const.LOADIG(context);
              },
              leading: Transform.scale(
                scale: 1.5,
                child: CircleAvatar(
                  child: FlutterLogo(),
                ),
              ),
              title: Text(tr(LocaleKeys.anxiety_patients),
                style: getRegularStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: Sizer.getW(context)/26
                ),),
              subtitle: Text("السلام عليكم ورحمة الله",
                style: getLightStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: Sizer.getW(context)/32
                ),),
            ),
          )
        ],
      ),
    );
  }
}
