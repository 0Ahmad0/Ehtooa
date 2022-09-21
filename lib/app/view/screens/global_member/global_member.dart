import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';import '../../../controller/utils/firebase.dart';
import '../../../model/utils/sizer.dart';
import '../../resources/color_manager.dart';
import 'package:get/get.dart';
import '../../resources/consts_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
class GlobalMemberView extends StatefulWidget {
  const GlobalMemberView({Key? key}) : super(key: key);

  @override
  State<GlobalMemberView> createState() => _GlobalMemberViewState();
}

class _GlobalMemberViewState extends State<GlobalMemberView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.add_member)),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(AppPadding.p10),
        itemCount: 25,
        itemBuilder: (_,index)=>_buildUsers(index),
      ),
    );
  }
  Widget _buildUsers(index){
    return  Container(
      margin: EdgeInsets.symmetric(vertical: AppMargin.m4),
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p10
      ),
      decoration: BoxDecoration(
          color: ColorManager.lightGray.withOpacity(.2),
          borderRadius: BorderRadius.circular(AppSize.s14)
      ),
      child: ListTile(
        leading: CircleAvatar(),
        title: Text("اسم المريض",style: getRegularStyle(color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: Sizer.getW(context) / 24
        ),),
        trailing:            InkWell(
          onTap: (){

          },
          child: Container(
            padding: EdgeInsets.all(AppPadding.p14),
            decoration: BoxDecoration(
                color: ColorManager.success,
                borderRadius: BorderRadius.circular(AppSize.s8)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add,color :ColorManager.white),
                const SizedBox(width: AppSize.s4,),
                Text(tr(LocaleKeys.add),style: getRegularStyle(
                    color: ColorManager.white
                ),),
              ],
            ),
          ),
        ),

        // :SizedBox(),
      ),
    );
  }
}
