import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../model/models.dart';
import '../../../model/utils/sizer.dart';
import '../../resources/color_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';

import '../../resources/style_manager.dart';
class ListOfMemberView extends StatelessWidget {
  final List<User> users;

  const ListOfMemberView({super.key, required this.users});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memmbers"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(AppPadding.p10),
        itemCount: users.length + 3,
        itemBuilder: (_,index){
          return Container(
            margin: EdgeInsets.symmetric(vertical: AppMargin.m4),
            padding: EdgeInsets.symmetric(
              vertical: AppPadding.p10
            ),
            decoration: BoxDecoration(
              color: ColorManager.lightGray.withOpacity(.2),
              borderRadius: BorderRadius.circular(AppSize.s14)
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: AppSize.s30,
              ),
              title: Text("users[index].name"),
              subtitle: Text("users[index].name"),
              trailing: InkWell(
                  onTap: (){
                    Get.defaultDialog(
                      confirm: Row(
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                  Theme.of(context).primaryColor),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                tr(LocaleKeys.yes),
                                style: getLightStyle(
                                    color: ColorManager.white,
                                    fontSize: Sizer.getW(context) / 26),
                              )),
                          const SizedBox(
                            width: AppSize.s8,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  primary: ColorManager.error,
                                  backgroundColor: ColorManager.error),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                tr(LocaleKeys.no),
                                style: getLightStyle(
                                    color: ColorManager.white,
                                    fontSize: Sizer.getW(context) / 26),
                              )),
                        ],
                      ),
                      titleStyle: getBoldStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color,
                          fontSize: Sizer.getW(context) / 22),
                      title: tr(LocaleKeys.are_you_sure),
                      content: Text(
                        tr(LocaleKeys.confirm_delete),
                        style: getRegularStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color,
                            fontSize: Sizer.getW(context) / 24),
                      ),
                      radius: AppSize.s14,
                    );

                  },
                  child: Container(
                    padding: EdgeInsets.all(AppPadding.p14),
                    decoration: BoxDecoration(
                        color: ColorManager.error,
                        borderRadius: BorderRadius.circular(AppSize.s8)
                    ),
                    child: Text(tr(LocaleKeys.delete),style: getRegularStyle(
                        color: ColorManager.white
                    ),),
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}
